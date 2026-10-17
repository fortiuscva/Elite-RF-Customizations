page 52127 "ERF SFTT Entry"
{
    ApplicationArea = All;
    Caption = 'Shop Floor Time Tracking Entry';
    PageType = Card;
    SourceTable = "ERF SFTT Entry";

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
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                    Visible = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                field("Scan Operation Barcode"; Rec."Scan Operation Barcode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Operation Barcode field.', Comment = '%';
                }
                field("Prod Order No."; Rec."Prod Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Production Order No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Operation No. field.', Comment = '%';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Routing Header Item Description field.', Comment = '%';
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Routing Line Operation Description field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("Output Quantity"; Rec."Output Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Output Quantity field.', Comment = '%';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
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
            action(StartOperation)
            {
                ApplicationArea = All;
                Caption = 'Start Operation';
                Ellipsis = true;
                Image = Start;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec."Start Time" := CurrentDateTime;
                    Rec.Status := 'In Progress';
                    Rec.Modify(true);
                end;
            }
            action(StopOperation)
            {
                ApplicationArea = All;
                Caption = 'Stop Operation';
                Ellipsis = true;
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec."End Time" := CurrentDateTime;
                    Rec.Status := 'Completed';
                    Rec.Modify(true);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        EmpUserIDMapping: Record "ERF User ID Mapping";
    begin
        Rec.Validate("User ID", UserId);
        EmpUserIDMapping.Reset();
        EmpUserIDMapping.Get(UserId);
        Rec.Validate("Employee No.", EmpUserIDMapping."Employee No.");
        Rec.Validate("Employee Name", EmpUserIDMapping."Employee Name");
    end;
}
