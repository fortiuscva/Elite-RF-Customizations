page 52103 "ERF Equip. Calibration Details"
{
    ApplicationArea = All;
    Caption = 'Equipment Calibration Interface';
    CardPageId = "ERF Equipment Calibration Card";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "ERF Equipment Calibration";
    SourceTableView = sorting("Equipment ID");
    UsageCategory = Lists;
    DelayedInsert = false;

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
                    trigger OnDrillDown()
                    begin
                        CalibrationHistory.Reset();
                        CalibrationHistory.SetRange("Equipment Id", Rec."Equipment ID");
                        Page.RunModal(Page::"ERF Calibration History Detail", CalibrationHistory);
                    end;
                }
                // field("Calibration Provider"; Rec."Calibration Provider")
                // {
                //     ToolTip = 'Specifies the value of the Third Party Calibration Provider field.', Comment = '%';
                // }
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
                // field("Checked by Employee No."; Rec."Checked by Employee No.")
                // {
                //     ToolTip = 'Specifies the value of the Checked by Employee No. field.', Comment = '%';
                // }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Checked by Employee Name field.', Comment = '%';
                }
                field("Checked Date"; Rec."Approved Date")
                {
                    ToolTip = 'Specifies the value of the Checked Date field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"ERF Equipment Calibration"),
                              "No." = field("Equipment ID");
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(CalibrationHistory)
            {
                ApplicationArea = all;
                Caption = 'Calibration History';
                Image = History;
                trigger OnAction()
                begin
                    CalibrationHistory.Reset();
                    CalibrationHistory.SetRange("Equipment Id", Rec."Equipment ID");
                    Page.RunModal(Page::"ERF Calibration History Detail", CalibrationHistory);
                end;
            }
        }

    }
    var
        CalibrationHistory: Record "ERF Calibration History";
}
