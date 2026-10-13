page 52127 "ERF SFTT Entry"
{
    ApplicationArea = All;
    Caption = 'Shop Floor Time Tracking Entry';
    PageType = Card;
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
                }
                field("Line No."; LineNoVarGbl)
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Operation No."; OperationNoVarGbl)
                {
                    ApplicationArea = All;
                    Caption = 'Operation No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Operation No. field.', Comment = '%';
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
                begin
                    SFTTFunctions.ValidateStartOperation();
                    SFTTFunctions.CreateShopFloorTimeTrackingEntry(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl);
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
                begin
                    SFTTFunctions.UpdateShopFloorTimeTrackingEntry(ProdOrderNoVarGbl, LineNoVarGbl, OperationNoVarGbl, OutputQtyVarGbl, SerialNoVarGbl);
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
