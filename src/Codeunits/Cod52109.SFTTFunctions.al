codeunit 52109 "ERF SFTT Functions"
{
    trigger OnRun()
    var
        SFTTEntry: Record "ERF SFTT Entry";
        ItemJnlLine: Record "Item Journal Line";
        SFTTSetup: Record "ERF SFTT Setup";
    begin
        SFTTSetup.Get();
        SFTTEntry.Reset;
        SFTTEntry.SetRange(Status, SFTTEntry.Status::Completed);
        IF SFTTEntry.FindSet() then begin
            repeat
                CreateOutputJournal(SFTTEntry, SFTTSetup);
            until SFTTEntry.Next() = 0;
            ItemJnlLine.RESET();
            ItemJnlLine.SetRange("Journal Template Name", SFTTSetup."Journal Template Name");
            ItemJnlLine.SetRange("Journal Batch Name", SFTTSetup."Journal Batch Name");
            Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);
        end;
    end;

    procedure CreateOutputJournal(var SFTTEntry: Record "ERF SFTT Entry"; SFTTSetup: Record "ERF SFTT Setup")
    var
        ItemJnlLine2: Record "Item Journal Line";
    begin
        SFTTSetup.Get();
        ItemJnlLine2.Init();
        ItemJnlLine2."Journal Template Name" := SFTTSetup."Journal Template Name";
        ItemJnlLine2."Journal Batch Name" := SFTTSetup."Journal Batch Name";
        ItemJnlLine2."Line No." := GetLineNo(SFTTSetup);
        ItemJnlLine2.Insert(true);
        ItemJnlLine2.Validate("Posting Date", Today);
        ItemJnlLine2.Validate("Entry Type", ItemJnlLine2."Entry Type"::Output);
        ItemJnlLine2.Validate("Order Type", ItemJnlLine2."Order Type"::Production);
        ItemJnlLine2.Validate("Order No.", SFTTEntry."Prod Order No.");
        ItemJnlLine2.Validate("Item No.", GetRPOItemNo(SFTTEntry));
        ItemJnlLine2.Validate("Order Line No.", SFTTEntry."Line No.");
        ItemJnlLine2.Validate("Operation No.", SFTTEntry."Operation No.");
        ItemJnlLine2.Validate("Document No.", 'SFTT' + format(SFTTEntry."Entry No."));
        ItemJnlLine2.Validate("Routing No.", GetRoutingNo(SFTTEntry."Prod Order No.", SFTTEntry."Line No.", SFTTEntry."Operation No."));
        ItemJnlLine2.Validate("Routing Reference No.", SFTTEntry."Line No.");
        ItemJnlLine2.Validate("Run Time", SFTTEntry."Duration in Minutes");
        ItemJnlLine2.Validate("Output Quantity", SFTTEntry."Output Quantity");
        ItemJnlLine2.Validate("Item No.", GetRPOItemNo(SFTTEntry));
        ItemJnlLine2.Validate("Cap. Unit of Measure Code", 'MINUTES');
        ItemJnlLine2.Modify(true);
        SFTTEntry.Validate(Status, SFTTEntry.Status::Processed);
        SFTTEntry.Modify(true);
    end;

    procedure CreateShopFloorTimeTrackingEntry(RPONo: Code[20]; LineNo: Integer; OperationNo: Code[10])
    var
        SFTTEntry: Record "ERF SFTT Entry";
        EmpUserIDMapping: Record "ERF User ID Mapping";
    begin
        SFTTEntry.Init();
        SFTTEntry."Entry No." := GetNextEntryNo();
        SFTTEntry.Insert(true);
        SFTTEntry.Validate("Employee No.", GetEmployeeNo());
        SFTTEntry.Validate("Prod Order No.", RPONo);
        SFTTEntry.Validate("Line No.", LineNo);
        SFTTEntry.Validate("Operation No.", OperationNo);
        SFTTEntry.Validate("Start Time", CurrentDateTime);
        SFTTEntry.Validate(Status, SFTTEntry.Status::"In Progress");
        SFTTEntry.Modify(true);
        Message('Operation Started');
    end;

    procedure UpdateShopFloorTimeTrackingEntry(RPONo: Code[20]; LineNo: Integer; OperationNo: Code[10]; OutputQty: Decimal; SerialNo: Code[50])
    var
        SFTTEntry: Record "ERF SFTT Entry";
        EmpUserIDMapping: Record "ERF User ID Mapping";
    begin
        SFTTEntry.Reset();
        SFTTEntry.SetRange("Employee No.", GetEmployeeNo());
        SFTTEntry.SetRange("Prod Order No.", RPONo);
        SFTTEntry.SetRange("Line No.", LineNo);
        SFTTEntry.SetRange("Operation No.", OperationNo);
        SFTTEntry.SetRange(Status, SFTTEntry.Status::"In Progress");
        if not SFTTEntry.FindLast() then
            Error('The operation cannot be stopped because it has not been started yet.');
        SFTTEntry.Validate("Output Quantity", OutputQty);
        SFTTEntry.Validate("Serial No.", SerialNo);
        SFTTEntry.Validate("End Time", CurrentDateTime);
        SFTTEntry.Validate("Duration in Minutes", Round((SFTTEntry."End Time" - SFTTEntry."Start Time") / 60000, 1, '='));
        SFTTEntry.Validate(Status, SFTTEntry.Status::Completed);
        SFTTEntry.Modify(true);
        Message('Operation Stopped');
    end;

    procedure ValidateStartOperation(RPONo: Code[20]; LineNo: Integer; OperationNo: Code[10])
    var
        SFTTEntry: Record "ERF SFTT Entry";
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        RoutingNo: Code[20];
        LogoutErrLbl: Label 'Please log out of the active Production Order (No. %1, Routing Step %2) before scanning a new Production Order.';
        RPONoBlankErrLbl: Label 'Released Production Order No. cannot be blank.';
        LineNoErrLbl: Label 'Line No. cannot be zero.';
        OperationNoBlankErrLbl: Label 'Routing Operation No. cannot be blank.';
    begin
        if RPONo = '' then
            Error(RPONoBlankErrLbl);

        if LineNo = 0 then
            Error(LineNoErrLbl);

        if OperationNo = '' then
            Error(OperationNoBlankErrLbl);

        ProductionOrder.Reset();
        ProductionOrder.Get(ProductionOrder.Status::Released, RPONo);

        ProdOrderLine.Reset();
        ProdOrderLine.Get(ProdOrderLine.Status::Released, RPONo, LineNo);

        RoutingNo := GetRoutingNo(RPONo, LineNo, OperationNo);

        ProdOrderRoutingLine.Reset();
        ProdOrderRoutingLine.Get(ProdOrderRoutingLine.Status::Released, RPONo, LineNo, RoutingNo, OperationNo);

        SFTTEntry.Reset();
        SFTTEntry.SetRange("Employee No.", GetEmployeeNo());
        SFTTEntry.SetRange(Status, SFTTEntry.Status::"In Progress");
        if SFTTEntry.FindLast() then
            Error(StrSubstNo(LogoutErrLbl, SFTTEntry."Prod Order No.", SFTTEntry."Operation Description"));
    end;

    local procedure GetNextEntryNo(): Integer
    var
        SFTTEntry: Record "ERF SFTT Entry";
    begin
        SFTTEntry.Reset();
        if SFTTEntry.FindLast() then
            exit(SFTTEntry."Entry No." + 1)
        else
            exit(1);
    end;

    local procedure GetEmployeeNo(): Code[20]
    var
        EmpUserIDMapping: Record "ERF User ID Mapping";
    begin
        EmpUserIDMapping.Reset();
        EmpUserIDMapping.Get(UserId);
        exit(EmpUserIDMapping."Employee No.");
    end;

    local procedure GetLineNo(SFTTSetup: Record "ERF SFTT Setup"): Integer
    var
        ItemJnlLineLcl: Record "Item Journal Line";
    begin
        ItemJnlLineLcl.Reset;
        ItemJnlLineLcl.SetRange("Journal Template Name", SFTTSetup."Journal Template Name");
        ItemJnlLineLcl.SetRange("Journal Batch Name", SFTTSetup."Journal Batch Name");
        if ItemJnlLineLcl.FindLast() then
            exit(ItemJnlLineLcl."Line No." + 10000)
        else
            exit(10000);
    end;

    local procedure GetRPOItemNo(var SFTTEntry: Record "ERF SFTT Entry"): Code[20]
    var
        ProductionOrder: Record "Production Order";
    begin
        ProductionOrder.Reset();
        IF ProductionOrder.GET(ProductionOrder.Status::Released, SFTTEntry."Prod Order No.") then
            IF ProductionOrder."Source Type" = ProductionOrder."Source Type"::Item then
                exit(ProductionOrder."Source No.");
    end;

    procedure GetRoutingNo(ProdOrderNo: Code[20]; RoutingRefNo: Integer; OperationNo: Code[10]): Code[20]
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        ProdOrderRoutingLine.Reset();
        ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderNo);
        ProdOrderRoutingLine.SetRange("Routing Reference No.", RoutingRefNo);
        ProdOrderRoutingLine.SetRange("Operation No.", OperationNo);
        If ProdOrderRoutingLine.FindFirst() then
            exit(ProdOrderRoutingLine."Routing No.");
    end;

}
