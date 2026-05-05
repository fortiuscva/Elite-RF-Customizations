pageextension 52129 "ERF User Task Card" extends "User Task Card"
{
    actions
    {
        addlast(Processing)
        {
            action("ERF ViewEmailLogs")
            {
                Caption = 'Email Logs';
                ToolTip = 'View the history of email notifications sent for user tasks.';
                ApplicationArea = All;
                Image = Log;

                trigger OnAction()
                begin
                    Page.Run(Page::"ERF User Task Email Log List");
                end;
            }
        }
    }
}
