pageextension 52101 "ERF Released Production Order" extends "Released Production Order"
{
    actions
    {
        addafter("&Update Unit Cost")
        {
            action("ERF Consumption Journal")
            {
                Caption = 'Consumption Journal';
                ApplicationArea = Basic, Suite;
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Post consumption released production order(s).';
                RunObject = page "Consumption Journal";
                RunPageView = where("Journal Template Name" = const('CONSUMPTIO'), "Journal Batch Name" = const('Default'));
            }
        }
    }
}