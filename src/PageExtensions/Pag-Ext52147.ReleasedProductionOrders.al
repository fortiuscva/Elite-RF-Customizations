pageextension 52147 "ERF Released Production Orders" extends "Released Production Orders"
{
    actions
    {
        addlast(reporting)
        {
            action("ERF RPORoutingBarCode")
            {
                ApplicationArea = All;
                Caption = 'RPO Routing Bar Code';
                Ellipsis = true;
                Image = BarCode;
                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                begin
                    CurrPage.SetSelectionFilter(ProductionOrder);
                    Report.RunModal(Report::"ERF RPO Routing Barcode", true, false, ProductionOrder);
                end;
            }
        }
        addafter("Production Order Statistics_Promoted")
        {
            actionref("RPORoutingBarCode"; "ERF RPORoutingBarCode")
            { }
        }
    }
}
