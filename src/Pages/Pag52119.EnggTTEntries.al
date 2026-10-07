page 52119 "ERF Engg. TT Entries"
{
    ApplicationArea = All;
    Caption = 'Engineering Time Tracking Entries';
    CardPageId = "ERF Engg. TT Entry";
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
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
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
                    if UpdateEnggEntry.RunModal() = Action::OK then begin
                        Rec.Validate("Start Time", UpdateEnggEntry.GetStartTime());
                        Rec.Validate("End Time", UpdateEnggEntry.GetEndTime());
                        Rec.Modify(true);
                        CurrPage.Update(false);
                    end
                end;
            }
        }
    }
}
