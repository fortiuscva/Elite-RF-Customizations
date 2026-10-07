page 52119 "ERF Engg. TT Entries"
{
    ApplicationArea = All;
    Caption = 'Engineering Daily Duration Entries';
    CardPageId = "ERF Engg. TT Entry";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "ERF Engg. TT Entries";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                field("Project Description"; Rec."Project Description")
                {
                    ToolTip = 'Specifies the value of the Project Description field.', Comment = '%';
                }
                field("Project Task No."; Rec."Project Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Task No. field.', Comment = '%';
                }
                field("Project Task Description"; Rec."Project Task Description")
                {
                    ToolTip = 'Specifies the value of the Project Task Description field.', Comment = '%';
                }
                field("Duration in Minutes"; Rec."Duration in Minutes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration in Minutes field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                Caption = 'Notes';
                ApplicationArea = Notes;
            }
        }
    }
}
