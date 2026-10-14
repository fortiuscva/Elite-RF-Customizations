page 52127 "ERF SFTT Entry"
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
            group(General)
            {
                Caption = 'General';
                field("Scan Operation Barcode"; ScanOperationCodeVarGbl)
                {
                    ApplicationArea = All;
                    Caption = 'Scan Operation Code';
                    ExtendedDatatype = Barcode;
                    ToolTip = 'Specifies the value of the Operation Barcode field.', Comment = '%';
                    trigger OnValidate()
                    var
                        Parts: List of [Text];
                    begin
                        Parts := ScanOperationCodeVarGbl.Split('-');
                        ProdOrderNoVarGbl := Parts.Get(1);
                        Evaluate(LineNoVarGbl, Parts.Get(2));
                        OperationNoVarGbl := Parts.Get(3);
                    end;
                }
                field("Prod Order No."; ProdOrderNoVarGbl)
                {
                    ApplicationArea = All;
                    Caption = 'RPO No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Production Order No. field.', Comment = '%';
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
                    var
                        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
                        SFTTFunctions: Codeunit "ERF SFTT Functions";
                        RoutingNo: Code[20];
                    begin
                        RoutingNo := SFTTFunctions.GetRoutingNo(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl);
                        ProdOrderRoutingLine.Reset();
                        if ProdOrderRoutingLine.Get(ProdOrderRoutingLine.Status::Released, ProdOrderNoVarGbl, LineNoVarGbl, RoutingNo, OperationNoVarGbl) then
                            Page.Run(Page::"Prod. Order Routing Lines", ProdOrderRoutingLine);
                    end;
                }
                field("Output Quantity"; OutputQtyVarGbl)
                {
                    ApplicationArea = All;
                    Caption = 'Output Quantity';
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Specifies the value of the Output Quantity field.', Comment = '%';
                }
                field("Serial No."; SerialNoVarGbl)
                {
                    ApplicationArea = All;
                    Caption = 'Serial No.';
                    ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
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
                    if Confirm(StrSubstNo(StartOperationConfirmQst, false)) then begin
                        SFTTFunctions.ValidateStartOperation(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl);
                        SFTTFunctions.CreateShopFloorTimeTrackingEntry(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl);
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
                    if Confirm(StrSubstNo(StopOperationConfirmQst, false)) then begin
                        SFTTFunctions.UpdateShopFloorTimeTrackingEntry(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl, OutputQtyVarGbl, SerialNoVarGbl);
                        Clear(ScanOperationCodeVarGbl);
                        Clear(ProdOrderNoVarGbl);
                        Clear(LineNoVarGbl);
                        Clear(OperationNoVarGbl);
                        Clear(OutputQtyVarGbl);
                        Clear(SerialNoVarGbl);
                    end;
                end;
            }
        }
    }
    var
        ScanOperationCodeVarGbl: Text;
        ProdOrderNoVarGbl: Code[20];
        LineNoVarGbl: Integer;
        OperationNoVarGbl: Code[10];
        OutputQtyVarGbl: Decimal;
        SerialNoVarGbl: Code[50];
}
