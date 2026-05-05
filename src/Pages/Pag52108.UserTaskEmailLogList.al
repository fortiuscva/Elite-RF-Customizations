page 52108 "ERF User Task Email Log List"
{
    Caption = 'User Task Email Logs';
    PageType = List;
    SourceTable = "ERF User Task Email Log";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the unique log entry number.';
                }

                field("User Task ID"; Rec."User Task ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the related user task ID.';
                }

                field("Task Subject"; Rec."Task Subject")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the subject of the task.';
                }

                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the user assigned to the task.';
                }

                field(Email; Rec."Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays the email address used for notification.';
                }

                field("Sent DateTime"; Rec."Sent DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Displays when the email was sent.';
                }
            }
        }
    }
}
