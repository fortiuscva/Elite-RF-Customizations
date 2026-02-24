codeunit 52105 "ERF ItemTrackingConversionCU"
{

    var
        SalesReceivablesRec: Record "Sales & Receivables Setup";
        TempEntryCounter: Integer;


    procedure PrepareConversion(var Item: Record Item)
    var
        InputPage: Page "ERF TrackingCodeInputDialog";
        NewTrackingCode: Code[10];
        TempBuffer: Record "Warehouse Entry" temporary;
    begin

        if InputPage.RunModal() <> Action::OK then
            exit;

        NewTrackingCode := InputPage.GetTrackingCode();

        if NewTrackingCode = '' then
            Error('Tracking Code cannot be blank.');

        if Item."Item Tracking Code" = NewTrackingCode then
            Error('Item already has this tracking code.');

        SalesReceivablesRec.get();
        ValidateItem(Item);

        PreventDuplicateJournals(Item);

        Item."ERF Conv Old Tracking Code" := Item."Item Tracking Code";
        Item."ERF Conv New Tracking Code" := NewTrackingCode;
        Item.Modify(true);

        TempEntryCounter := 0;

        BuildWarehouseBuffer(Item, TempBuffer);

        if TempBuffer.IsEmpty then
            Error('No warehouse inventory found to convert.');


        CreateJournalLines(TempBuffer, SalesReceivablesRec."ERF ItemTrackingCode Neg.Batch", false);
        CreateJournalLines(TempBuffer, SalesReceivablesRec."ERF ItemTrackingCode Pos.Batch", true);

        Message(StrSubstNo(
            'Conversion journals created successfully.\' +
            'Post %1 journal first, then run Complete Conversion.', SalesReceivablesRec."ERF ItemTrackingCode Neg.Batch"));

    end;

    procedure CompleteConversion(var Item: Record Item)
    begin

        if Item."ERF Conv New Tracking Code" = '' then
            Error('Prepare Conversion must be completed first.');
        SalesReceivablesRec.Get();
        ValidateInventoryIsZero(Item);

        Item."Item Tracking Code" := Item."ERF Conv New Tracking Code";
        Item.Modify(true);

        OpenPositiveJournal();

        Message(
            StrSubstNo('Tracking Code updated successfully.\' +
            'Assign Lot/Serial Numbers and post %1 journal.', SalesReceivablesRec."ERF ItemTrackingCode Pos.Batch"));

    end;

    local procedure ValidateItem(Item: Record Item)
    begin

        ValidateNoOpenWarehouseEntries(Item);

        ValidateNoReservations(Item);

    end;

    local procedure ValidateNoOpenWarehouseEntries(Item: Record Item)
    var
        WhseActivityLine: Record "Warehouse Activity Line";
    begin

        WhseActivityLine.SetRange("Item No.", Item."No.");

        if WhseActivityLine.FindFirst() then
            Error(
                'Open Warehouse Activities exist for Item %1. Complete or delete them before conversion.',
                Item."No.");

    end;

    local procedure ValidateNoReservations(Item: Record Item)
    var
        ReservationEntry: Record "Reservation Entry";
    begin

        ReservationEntry.SetRange("Item No.", Item."No.");

        if ReservationEntry.FindFirst() then
            Error(
                'Reservations exist for Item %1. Remove reservations before conversion.',
                Item."No.");

    end;

    local procedure ValidateInventoryIsZero(Item: Record Item)
    begin

        Item.CalcFields(Inventory);

        if Item.Inventory <> 0 then
            Error(StrSubstNo(
                'Inventory must be zero before completing conversion.\' +
                'Post the %1 journal first.', SalesReceivablesRec."ERF ItemTrackingCode Neg.Batch"));

    end;



    local procedure PreventDuplicateJournals(Item: Record Item)
    var
        ItemJournalLine: Record "Item Journal Line";
    begin

        ItemJournalLine.SetRange("Item No.", Item."No.");
        ItemJournalLine.SetRange("Journal Template Name", 'ITEM');
        ItemJournalLine.SetFilter("Journal Batch Name", '%1|%2', SalesReceivablesRec."ERF ItemTrackingCode Neg.Batch", SalesReceivablesRec."ERF ItemTrackingCode Pos.Batch");

        if ItemJournalLine.FindFirst() then
            Error(
                'Conversion journals already exist for Item %1.',
                Item."No.");

    end;



    local procedure BuildWarehouseBuffer(
        Item: Record Item;
        var TempBuffer: Record "Warehouse Entry" temporary)
    var
        WhseEntry: Record "Warehouse Entry";
    begin

        WhseEntry.SetRange("Item No.", Item."No.");
        //WhseEntry.SetFilter(Quantity, '>%1', 0);

        if WhseEntry.FindSet() then
            repeat
                InsertBuffer(WhseEntry, TempBuffer);
            until WhseEntry.Next() = 0;

    end;

    local procedure InsertBuffer(
        SourceEntry: Record "Warehouse Entry";
        var TempBuffer: Record "Warehouse Entry" temporary)
    begin

        TempBuffer.Reset();

        TempBuffer.SetRange("Item No.", SourceEntry."Item No.");
        TempBuffer.SetRange("Location Code", SourceEntry."Location Code");
        TempBuffer.SetRange("Bin Code", SourceEntry."Bin Code");
        TempBuffer.SetRange("Variant Code", SourceEntry."Variant Code");

        if TempBuffer.FindFirst() then begin

            TempBuffer.Quantity += SourceEntry.Quantity;
            TempBuffer.Modify();

        end
        else begin

            TempEntryCounter += 1;

            TempBuffer.Init();
            TempBuffer."Entry No." := TempEntryCounter;
            TempBuffer."Item No." := SourceEntry."Item No.";
            TempBuffer."Location Code" := SourceEntry."Location Code";
            TempBuffer."Bin Code" := SourceEntry."Bin Code";
            TempBuffer."Variant Code" := SourceEntry."Variant Code";
            TempBuffer.Quantity := SourceEntry.Quantity;
            TempBuffer.Insert();

        end;
        TempBuffer.Reset();
    end;

    local procedure CreateJournalLines(
        var TempBuffer: Record "Warehouse Entry" temporary;
        BatchName: Code[10];
        Positive: Boolean)
    var
        ItemJournalLine: Record "Item Journal Line";
        LineNo: Integer;
    begin

        LineNo := GetNextLineNo(BatchName);
        TempBuffer.Reset();
        if TempBuffer.FindSet() then
            repeat
                ItemJournalLine.Init();
                ItemJournalLine.Validate("Journal Template Name", 'ITEM');
                ItemJournalLine.Validate("Journal Batch Name", BatchName);
                ItemJournalLine."Line No." := LineNo;
                if Positive then
                    ItemJournalLine.Validate(
                        "Entry Type",
                        ItemJournalLine."Entry Type"::"Positive Adjmt.")
                else
                    ItemJournalLine.Validate(
                        "Entry Type",
                        ItemJournalLine."Entry Type"::"Negative Adjmt.");

                ItemJournalLine.Validate("Posting Date", Today());
                ItemJournalLine.Validate("Item No.", TempBuffer."Item No.");
                ItemJournalLine.Validate("Location Code", TempBuffer."Location Code");
                ItemJournalLine.Validate("Variant Code", TempBuffer."Variant Code");
                ItemJournalLine.Validate("Bin Code", TempBuffer."Bin Code");
                ItemJournalLine.Validate(Quantity, TempBuffer.Quantity);
                ItemJournalLine.Insert(true);

                LineNo += 10000;

            until TempBuffer.Next() = 0;

    end;

    local procedure GetNextLineNo(BatchName: Code[10]): Integer
    var
        ItemJournalLine: Record "Item Journal Line";
    begin

        ItemJournalLine.SetRange("Journal Template Name", 'ITEM');
        ItemJournalLine.SetRange("Journal Batch Name", BatchName);

        if ItemJournalLine.FindLast() then
            exit(ItemJournalLine."Line No." + 10000)
        else
            exit(10000);

    end;

    local procedure OpenPositiveJournal()
    var
        ItemJournalLine: Record "Item Journal Line";
    begin

        ItemJournalLine.SetRange("Journal Template Name", 'ITEM');
        ItemJournalLine.SetRange("Journal Batch Name", SalesReceivablesRec."ERF ItemTrackingCode Pos.Batch");
        if ItemJournalLine.FindSet() then
            Page.Run(Page::"Item Journal", ItemJournalLine);

    end;

}
