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
            column(PNCaption; PNCaptionLbl)
            {

            }
            column(PickCodeCaption; PickCodeCaptionLbl)
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
            column(PickCode; "ERF Pick Code")
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
        PNCaptionLbl: Label 'P/N: ';
        PickCodeCaptionLbl: Label 'Pick Code: ';
        QtyReqCaptionLbl: Label 'Qty. Required: ';
        ProdOrderNoValue: Code[20];

}
