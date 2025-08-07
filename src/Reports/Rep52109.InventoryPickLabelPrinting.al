report 52109 "Inventory Pick Label Printing"
{
    ApplicationArea = All;
    Caption = 'Inventory Pick Label Printing';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Reports/Layouts/ERFInventoryPickLabelPrinting.rdl';
    dataset
    {
        dataitem(WarehouseActivityLine; "Warehouse Activity Line")
        {
            column(PickCodeCaption; PickCodeCaptionLbl)
            {

            }
            column(ProdOrderNoCaption; ProdOrderNoCaptionLbl)
            {
            }
            column(BinCodeCaption; FieldCaption("Bin Code"))
            {
            }
            column(QtyReqCaption; QtyReqCaptionLbl)
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(BinCode; "Bin Code")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(ProdOrderNo; ProdOrderNoValue)
            {
            }

            trigger OnAfterGetRecord()
            var
                ProdOrder: Record "Production Order";
            begin
                if WarehouseActivityLine."Source Document" = WarehouseActivityLine."Source Document"::"Prod. Consumption" then begin
                    ProdOrder.SetRange("No.", WarehouseActivityLine."Source No.");
                    if ProdOrder.FindFirst() then
                        ProdOrderNoValue := ProdOrder."No.";
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
    }
    var
        PickCodeCaptionLbl: Label 'P/N: ';
        ProdOrderNoCaptionLbl: Label 'Prod. No.: ';
        QtyReqCaptionLbl: Label 'Qty. Required: ';
        ProdOrderNoValue: Code[20];

}
