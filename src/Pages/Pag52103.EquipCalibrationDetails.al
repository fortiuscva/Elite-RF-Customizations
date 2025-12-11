page 52103 "ERF Equip. Calibration Details"
{
    ApplicationArea = All;
    Caption = 'Equipment Calibration Interface';
    PageType = List;
    SourceTable = "ERF Equipment Calibration ";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Equipment ID"; Rec."Equipment ID")
                {
                    ToolTip = 'Specifies the value of the Equipment ID field.', Comment = '%';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
                field("Model No."; Rec."Model No.")
                {
                    ToolTip = 'Specifies the value of the Model No. field.', Comment = '%';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ToolTip = 'Specifies the value of the Manufacturer field.', Comment = '%';
                }
                field("Last Calibrated"; Rec."Last Calibrated")
                {
                    ToolTip = 'Specifies the value of the Last Calibrated field.', Comment = '%';
                }
                field("Calibration Frequency"; Rec."Calibration Frequency")
                {
                    ToolTip = 'Specifies the value of the Calibration Frequency field.', Comment = '%';
                }
                field("Calibration Due Date"; Rec."Calibration Due Date")
                {
                    ToolTip = 'Specifies the value of the Calibration Due Date field.', Comment = '%';
                }
                field("Calibration Provider"; Rec."Calibration Provider")
                {
                    ToolTip = 'Specifies the value of the Third Party Calibration Provider field.', Comment = '%';
                }
                field("Calibration Provider Name"; Rec."Calibration Provider Name")
                {
                    ToolTip = 'Specifies the value of the Third Party Calibration Provider Name field.', Comment = '%';
                }
                field("Verify Calibration Certificate"; Rec."Verify Calibration Certificate")
                {
                    ToolTip = 'Specifies the value of the Verified Calibration Certificate? field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
            }
        }
    }
}
