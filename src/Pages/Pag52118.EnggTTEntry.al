page 52118 "ERF Engg. TT Entry"
{
    ApplicationArea = All;
    Caption = 'Engineering Time Tracking Entry';
    DeleteAllowed = false;
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
                    Visible = false;
                }
                group(Employee)
                {
                    Caption = 'Employee';
                    field("Employee No."; Rec."Employee No.")
                    {
                        ApplicationArea = All;
                        Caption = 'No.';
                        ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                    }
                    field("Employee Name"; Rec."Employee Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Name';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                    }
                }
                group(Project)
                {
                    Caption = 'Project';
                    field("Project No."; Rec."Project No.")
                    {
                        ApplicationArea = All;
                        Caption = 'No.';
                        ToolTip = 'Specifies the value of the Project No. field.', Comment = '%';
                    }
                    field("Project Description"; Rec."Project Description")
                    {
                        ApplicationArea = All;
                        Caption = 'Description';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Project Description field.', Comment = '%';
                    }
                }
                group(ProjectTask)
                {
                    Caption = 'Project Task';
                    field("Project Task No."; Rec."Project Task No.")
                    {
                        ApplicationArea = All;
                        Caption = 'No.';
                        ToolTip = 'Specifies the value of the Project Task No. field.', Comment = '%';
                    }
                    field("Project Task Description"; Rec."Project Task Description")
                    {
                        ApplicationArea = All;
                        Caption = 'Decription';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Project Task Description field.', Comment = '%';
                    }
                }
                group(TimeTracking)
                {
                    Caption = 'Time Tracking';
                    field("Start Time"; Rec."Start Time")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                    }
                    field("End Time"; Rec."End Time")
                    {
                        ApplicationArea = All;
                        Editable = false;
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
                        Editable = false;
                        ToolTip = 'Specifies the value of the Duration in Minutes field.', Comment = '%';
                    }
                    field(Status; Rec.Status)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    }
                }
                group(Comments)
                {
                    Caption = 'Comments';
                    field(Comment; CommentGbl)
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                        trigger OnValidate()
                        begin
                            Rec.SetComments(CommentGbl);
                        end;
                    }
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
                Promoted = true;
                PromotedCategory = Process;
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
                Promoted = true;
                PromotedCategory = Process;
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
            action(UpdateEntry)
            {
                ApplicationArea = all;
                Caption = 'Update Entry';
                Ellipsis = true;
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    UpdateEnggEntry: Page "ERF Update Engg Entry";
                begin
                    UpdateEnggEntry.SetStartTime(Rec."Start Time");
                    UpdateEnggEntry.SetEndTime(Rec."End Time");
                    UpdateEnggEntry.SetComments(Rec.GetComments());
                    if UpdateEnggEntry.RunModal() = Action::OK then begin
                        Rec.Validate("Start Time", UpdateEnggEntry.GetStartTime());
                        Rec.Validate("End Time", UpdateEnggEntry.GetEndTime());
                        Rec.SetComments(UpdateEnggEntry.GetComments());
                        Rec.Modify(true);
                        CurrPage.Update(false);
                    end
                end;
            }
        }
    }
    var
        TimeDurationGbl: Duration;
        CommentGbl: Text;

    trigger OnAfterGetRecord()
    begin
        CommentGbl := Rec.GetComments();
    end;
}
