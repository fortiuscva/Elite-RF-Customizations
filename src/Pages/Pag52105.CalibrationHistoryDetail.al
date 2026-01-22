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
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Equipment Id"; Rec."Equipment Id")
                {
                    ToolTip = 'Specifies the value of the Equipment Id field.', Comment = '%';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
                field("Calibrated Date"; Rec."Calibrated Date")
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
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'Created At';
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'Modified At';
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
            }
        }
    }
}
