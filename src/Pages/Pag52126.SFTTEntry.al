page 52126 "ERF SFTT Entry"
{
    ApplicationArea = All;
    Caption = 'Shop Floor Time Tracking Entry';
    PageType = Card;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;
    UsageCategory = Tasks;
    layout
    {
        area(Content)
        {
            grid(MainLayout)
            {
                GridLayout = Columns;
                group(ScannerGroup)
                {
                    ShowCaption = false;
                    usercontrol(Scanner; "ERF SFTT Scanner")
                    {
                        ApplicationArea = All;
                        trigger ControlAddInReady()
                        begin
                        end;

                        trigger BarcodeScanned(Barcode: Text)
                        var
                            Parts: List of [Text];
                        begin
                            if Barcode = '' then
                                exit;

                            Parts := Barcode.Split('-');

                            if Parts.Count() <> 3 then
                                Error('Invalid operation barcode. Expected ProductionOrder-LineNo-OperationNo.');

                            ProdOrderNoVarGbl := CopyStr(Parts.Get(1), 1, 20);

                            if not Evaluate(LineNoVarGbl, Parts.Get(2)) then
                                Error('Invalid line number in barcode.');

                            OperationNoVarGbl := CopyStr(Parts.Get(3), 1, 10);

                            if ProductionOrder.Get(ProductionOrder.Status::Released, ProdOrderNoVarGbl) then
                                RPOItemDescription := ProductionOrder.Description;

                            RoutingNoVarGbl := SFTTFunctions.GetRoutingNo(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl);
                            if ProdOrderRoutingLine.Get(ProdOrderRoutingLine.Status::Released, ProdOrderNoVarGbl, LineNoVarGbl, RoutingNoVarGbl, OperationNoVarGbl) then
                                RoutingLineOperationDescriptionVarGbl := ProdOrderRoutingLine.Description;

                            UserIDMapping.Reset();
                            UserIDMapping.Get(UserId);
                            SFTTEntry.Reset();
                            SFTTEntry.SetRange("Employee No.", UserIDMapping."Employee No.");
                            SFTTEntry.SetRange("Prod Order No.", ProdOrderNoVarGbl);
                            SFTTEntry.SetRange("Line No.", LineNoVarGbl);
                            SFTTEntry.SetRange("Operation No.", OperationNoVarGbl);
                            SFTTEntry.SetRange(Status, SFTTEntry.Status::"In Progress");
                            if SFTTEntry.FindLast() then
                                Status := 'Operation is in progress'
                            else
                                Status := 'Operation not started';

                            CurrPage.Update(false);
                        end;

                    }
                }

                group(Fields)
                {
                    ShowCaption = false;

                    field("Prod Order No."; ProdOrderNoVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'RPO No.';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Released Production Order No. field.', Comment = '%';
                        trigger OnDrillDown()
                        var
                            ProductionOrder: Record "Production Order";
                        begin
                            ProductionOrder.Reset();
                            if ProductionOrder.Get(ProductionOrder.Status::Released, ProdOrderNoVarGbl) then
                                Page.Run(Page::"Released Production Order", ProductionOrder);
                        end;
                    }
                    field("Line No."; LineNoVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Line No.';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                        trigger OnDrillDown()
                        var
                            ProdOrderLine: Record "Prod. Order Line";
                        begin
                            ProdOrderLine.Reset();
                            if ProdOrderLine.Get(ProdOrderLine.Status::Released, ProdOrderNoVarGbl, LineNoVarGbl) then
                                Page.Run(Page::"Prod. Order Line List", ProdOrderLine);
                        end;
                    }
                    field("Operation No."; OperationNoVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Operation No.';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Operation No. field.', Comment = '%';
                        trigger OnDrillDown()
                        begin
                            RoutingNoVarGbl := SFTTFunctions.GetRoutingNo(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl);
                            ProdOrderRoutingLine.Reset();
                            if ProdOrderRoutingLine.Get(ProdOrderRoutingLine.Status::Released, ProdOrderNoVarGbl, LineNoVarGbl, RoutingNoVarGbl, OperationNoVarGbl) then
                                Page.Run(Page::"Prod. Order Routing Lines", ProdOrderRoutingLine);
                        end;
                    }
                    field("RPO Header Item Description"; RPOItemDescription)
                    {
                        ApplicationArea = All;
                        Caption = 'RPO Header Item Description';
                        Editable = false;
                        Importance = Additional;
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the RPO Header Item Description field.', Comment = '%';
                    }

                    field("Routing Line Operation Description"; RoutingLineOperationDescriptionVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Routing Line Operation Description';
                        Editable = false;
                        Importance = Additional;
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the Routing Line Operation Description field.', Comment = '%';
                    }
                    field(Status; Status)
                    {
                        ApplicationArea = All;
                        Caption = 'Status';
                        Editable = false;
                        Style = Favorable;
                        StyleExpr = true;
                        ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    }
                    field("Output Quantity"; OutputQtyVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Output Quantity';
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Output Quantity field.', Comment = '%';
                    }
                    field("Serial No."; SerialNoVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Serial No.';
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(StartOperation)
            {
                ApplicationArea = All;
                Caption = 'Start Operation';
                Ellipsis = true;
                Image = Start;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SFTTFunctions: Codeunit "ERF SFTT Functions";
                    StartOperationConfirmQst: Label 'Do you want to start the operation?';
                begin
                    if Confirm(StartOperationConfirmQst, false) then begin
                        SFTTFunctions.ValidateStartOperation(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl);
                        SFTTFunctions.CreateShopFloorTimeTrackingEntry(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl);
                        Status := 'Operation is in progress';
                        CurrPage.Update(false);
                    end;
                end;
            }

            action(StopOperation)
            {
                ApplicationArea = All;
                Caption = 'Stop Operation';
                Ellipsis = true;
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SFTTFunctions: Codeunit "ERF SFTT Functions";
                    StopOperationConfirmQst: Label 'Do you want to stop the operation?';
                begin
                    if Confirm(StopOperationConfirmQst, false) then begin
                        if OutputQtyVarGbl = 'N/A' then
                            OutputQuantity := 0
                        else
                            if not Evaluate(OutputQuantity, OutputQtyVarGbl) then
                                Error('Output Quantity must be a valid number or N/A.');

                        if SerialNoVarGbl = '' then
                            Error('Serial No. must have a value.');

                        SFTTFunctions.UpdateShopFloorTimeTrackingEntry(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl, OutputQuantity, SerialNoVarGbl);

                        Clear(ScanOperationCodeVarGbl);
                        Clear(ProdOrderNoVarGbl);
                        Clear(LineNoVarGbl);
                        Clear(OperationNoVarGbl);
                        Clear(RPOItemDescription);
                        Clear(RoutingLineOperationDescriptionVarGbl);
                        Clear(OutputQtyVarGbl);
                        Clear(SerialNoVarGbl);
                        Clear(Status);

                        CurrPage.Scanner.ClearInputs();
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }

    var
        ProductionOrder: Record "Production Order";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        UserIDMapping: Record "ERF User ID Mapping";
        SFTTEntry: Record "ERF SFTT Entry";
        SFTTFunctions: Codeunit "ERF SFTT Functions";
        ScanOperationCodeVarGbl: Text;
        ProdOrderNoVarGbl: Code[20];
        LineNoVarGbl: Integer;
        OperationNoVarGbl: Code[10];
        OutputQtyVarGbl: Text;
        OutputQuantity: Decimal;
        SerialNoVarGbl: Code[50];
        RoutingNoVarGbl: Code[20];
        RPOItemDescription: Text;
        RoutingLineOperationDescriptionVarGbl: Text;
        Status: Text;
}
