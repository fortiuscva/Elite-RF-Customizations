tableextension 52117 "ERF Production order" extends "Production order"
{
    procedure CreateConsumptionLines()
    var
        ProdOrderComp: Record "Prod. Order Component";
        ItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;
    begin
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", 'CONSUMPTIO');
        ItemJnlLine.SetRange("Journal Batch Name", 'DEFAULT');
        ItemJnlLine.SetRange("Order Type", ItemJnlLine."Order Type"::Production);
        ItemJnlLine.SetRange("Order No.", Rec."No.");
        if ItemJnlLine.FindSet() then
            ItemJnlLine.DeleteAll();

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", 'CONSUMPTIO');
        ItemJnlLine.SetRange("Journal Batch Name", 'DEFAULT');
        if ItemJnlLine.FindLast() then
            LineNo := ItemJnlLine."Line No."
        else
            LineNo := 0;

        ProdOrderComp.Reset();
        ProdOrderComp.SetRange(Status, Rec.Status);
        ProdOrderComp.SetRange("Prod. Order No.", Rec."No.");
        if ProdOrderComp.FindSet() then begin
            repeat
                LineNo += 10000;

                ItemJnlLine.Init();
                ItemJnlLine.Validate("Journal Template Name", 'CONSUMPTIO');
                ItemJnlLine.Validate("Journal Batch Name", 'DEFAULT');
                ItemJnlLine."Line No." := LineNo;
                ItemJnlLine.Insert(true);
                ItemJnlLine.Validate("Posting Date", Today);
                ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::Consumption);
                ItemJnlLine.Validate("Document No.", Rec."No.");
                ItemJnlLine.Validate("Item No.", ProdOrderComp."Item No.");
                ItemJnlLine.Validate("Location Code", ProdOrderComp."Location Code");
                ItemJnlLine.Validate("Bin Code", ProdOrderComp."Bin Code");
                ItemJnlLine.Validate("Order Type", ItemJnlLine."Order Type"::Production);
                ItemJnlLine.Validate("Order No.", ProdOrderComp."Prod. Order No.");
                ItemJnlLine.Validate("Order Line No.", ProdOrderComp."Prod. Order Line No.");
                ItemJnlLine.Validate("Prod. Order Comp. Line No.", ProdOrderComp."Line No.");
                ItemJnlLine.Validate("Unit of Measure Code", ProdOrderComp."Unit of Measure Code");
                ItemJnlLine.Validate(Quantity, 0);
                ItemJnlLine.Validate("Unit Cost", ProdOrderComp."Unit Cost");
                ItemJnlLine."ERF Prod. Ord. Comp. Rem. Qty" := ProdOrderComp."Remaining Quantity";
                ItemJnlLine."Source Code" := 'CONSUMPJNL';
                ItemJnlLine."Source Type" := ItemJnlLine."Source Type"::Item;
                ItemJnlLine.Modify();
            until ProdOrderComp.Next() = 0;
        end;
    end;
}
