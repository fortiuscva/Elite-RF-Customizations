page 52118 "ERF Engg. TT Entry"
{
    ApplicationArea = All;
    Caption = 'Engineering Daily Duration Entry';
    // DeleteAllowed = false;
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
                // group(Employee)
                // {
                //     Caption = 'Employee';
                // field("Employee No."; Rec."Employee No.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'No.';
                //     ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                // }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                // }
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
                group(TimeDuration)
                {
                    Caption = 'Time Tracking';
                    field("Duration in Minutes"; Rec."Duration in Minutes")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Duration in Minutes field.', Comment = '%';
                    }
                }
                group(Comments)
                {
                    Caption = 'Task Description';
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
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {
                Caption = 'Notes';
                ApplicationArea = Notes;
            }
        }
    }
    var
        TimeDurationGbl: Duration;
        CommentGbl: Text;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        EmployeeUserIDMapping: Record "ERF User ID Mapping";
    begin
        EmployeeUserIDMapping.Reset();
        if EmployeeUserIDMapping.Get(UserId) then
            Rec."Employee Name" := EmployeeUserIDMapping."Employee Name";
    end;

    trigger OnAfterGetRecord()
    begin
        CommentGbl := Rec.GetComments();
    end;
}
