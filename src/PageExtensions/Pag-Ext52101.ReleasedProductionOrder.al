pageextension 52101 "ERF Released Production Order" extends "Released Production Order"
{
    actions
    {
        addafter("Job Card")
        {
            action("ERF OrderTravellerForm")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Order Traveller Form';
                Ellipsis = true;
                Image = "Report";

                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                begin
                    CurrPage.SetSelectionFilter(ProductionOrder);
                    Report.RunModal(Report::"F-812-9 Order Traveler Form", true, false, ProductionOrder);
                end;
            }
            action("ERF QualityInspectionChecklist")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Quality Inspection Checklist';
                Ellipsis = true;
                Image = "Report";

                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                begin
                    CurrPage.SetSelectionFilter(ProductionOrder);
                    Report.RunModal(Report::"F-812-7 Quality Insp. Check", true, false, ProductionOrder);
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
            actionref("ERF OrderTravellerForm_Promoted"; "ERF OrderTravellerForm")
            {
            }
            actionref("F-812-7 Quality Insp. Check"; "ERF QualityInspectionChecklist")
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