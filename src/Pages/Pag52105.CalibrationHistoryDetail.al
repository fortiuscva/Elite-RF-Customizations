page 52105 "ERF Calibration History Detail"
{
    AdditionalSearchTerms = 'Calibration History';
    ApplicationArea = All;
    Caption = 'Calibration History Details';
    Editable = false;
    PageType = List;
    SourceTable = "ERF Calibration History";
    SourceTableView = sorting("Entry No.")
                      order(descending);
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Equipment Id"; Rec."Equipment Id")
                {
                    ToolTip = 'Specifies the value of the Equipment Id field.', Comment = '%';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
                field("Model No."; Rec."Model No.")
                {
                    ToolTip = 'Specifies the value of the Model # field.', Comment = '%';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial # field.', Comment = '%';
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ToolTip = 'Specifies the value of the Manufacturer field.', Comment = '%';
                }
                field("Calibrated Date"; Rec."Last Calibrated")
                {
                    ToolTip = 'Specifies the value of the Last Calibrated Date field.', Comment = '%';
                }
                field("Calibration Frequency"; Rec."Calibration Frequency")
                {
                    ToolTip = 'Specifies the value of the Calibration Frequency (Months) field.', Comment = '%';
                }
                field("Calibration Due Date"; Rec."Calibration Due Date")
                {
                    ToolTip = 'Specifies the value of the Calibration Due Date field.', Comment = '%';
                }
                // field("Calibration Provider"; Rec."Calibration Provider")
                // {
                //     ToolTip = 'Specifies the value of the Third Party Calibration Provider field.', Comment = '%';
                // }
                field("Calibration Provider Name"; Rec."Calibration Provider Name")
                {
                    ToolTip = 'Specifies the value of the Third Party Calibration Provider Name field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                // field("Checked by Employee No."; Rec."Checked by Employee No.")
                // {
                //     ToolTip = 'Specifies the value of the Checked by Employee No. field.', Comment = '%';
                // }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Checked by Employee Name field.', Comment = '%';
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ToolTip = 'Specifies the value of the Checked Date field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'Entry Date & Time';
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }

            }
        }
    }
}
