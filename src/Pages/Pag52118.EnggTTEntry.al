page 52118 "ERF Engg. TT Entry"
{
    ApplicationArea = All;
    Caption = 'Enggineering Time Tracking Entry';
    PageType = Card;
    SourceTable = "ERF Engg. TT Entries";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Specifies the value of the Project No. field.', Comment = '%';
                }
                field("Project Task No."; Rec."Project Task No.")
                {
                    ToolTip = 'Specifies the value of the Project Task No. field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
                }
                field("Duration in Minutes"; Rec."Duration in Minutes")
                {
                    ToolTip = 'Specifies the value of the Duration in Minutes field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(StartTask)
            {
                Caption = 'Satrt Task';
                trigger OnAction()
                begin
                    EnggEntries."Start Time" := CurrentDateTime();
                    EnggEntries.Status := EnggEntries.Status::"In Progress";
                    EnggEntries.Modify(true);
                end;
            }
            action(StopTask)
            {
                Caption = 'Stop Task';
                trigger OnAction()
                begin
                    IF EnggEntries.Status <> EnggEntries.Status::"In Progress" then
                        Error('Only an In Progressed Task can be stopped');
                    EnggEntries.TestField("Start Time");
                    EnggEntries."End Time" := CurrentDateTime();
                    EnggEntries."Duration In Minutes" := Round((EnggEntries."End Time" - EnggEntries."Start Time") / 60000, 1, '=');
                end;



            }
        }
    }
    var
        EnggEntries: Record "ERF Engg. TT Entries";
}
