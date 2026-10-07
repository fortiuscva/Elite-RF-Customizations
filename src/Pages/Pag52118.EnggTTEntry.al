page 52118 "ERF Engg. TT Entry"
{
    ApplicationArea = All;
    Caption = 'Enggineering Time Tracking Entry';
    PageType = Card;
    SourceTable = "ERF Engg. TT Entries";
    RefreshOnActivate = true;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                field("Project No."; Rec."Project No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project No. field.', Comment = '%';
                }
                field("Project Task No."; Rec."Project Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Task No. field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                }
                field("Duration in Minutes"; Rec."Duration in Minutes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration in Minutes field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                ApplicationArea = All;
                Caption = 'Start Task';
                Ellipsis = true;
                Enabled = Rec.Status = Rec.Status::" ";
                Image = Start;
                trigger OnAction()
                begin
                    Rec."Start Time" := CurrentDateTime();
                    Rec.Status := Rec.Status::"In Progress";
                    Rec.Modify(true);
                end;
            }
            action(StopTask)
            {
                ApplicationArea = All;
                Caption = 'Stop Task';
                Ellipsis = true;
                Enabled = Rec.Status = Rec.Status::"In Progress";
                Image = Stop;
                trigger OnAction()
                begin
                    Rec."End Time" := CurrentDateTime();
                    Rec."Duration In Minutes" := Round((CurrentDateTime() - Rec."Start Time") / 60000, 1, '=');
                    TimeDurationGbl := CurrentDateTime() - Rec."Start Time";
                    Rec.Duration := Format(TimeDurationGbl);
                    Rec.Status := Rec.Status::Completed;
                    Rec.Modify(true);
                end;
            }
        }
    }
    var
        TimeDurationGbl: Duration;
}
