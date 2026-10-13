pageextension 52101 "ERF Released Production Order" extends "Released Production Order"
{
    actions
    {
        addafter("Job Card")
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
        addafter("&Update Unit Cost")
        {
            action("ERF Consumption Journal")
            {
                Caption = 'Consumption Journal';
                ApplicationArea = All;
                Image = Journal;
                ToolTip = 'Post consumption released production order(s).';
                RunObject = page "Consumption Journal";
                RunPageView = where("Journal Template Name" = const('CONSUMPTIO'), "Journal Batch Name" = const('Default'));
            }
        }
        addafter("Job Card_Promoted")
        {
            actionref("RPO Routing Barcode"; "ERF RPORoutingBarCode")
            { }
        }
        addlast(Category_Process)
        {
            actionref("ERF Consumption Journal_Promoted"; "ERF Consumption Journal")
            {
            }
        }
    }
}