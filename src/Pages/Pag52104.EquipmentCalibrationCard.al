page 52104 "ERF Equipment Calibration Card"
{
    Caption = 'Equipment Calibration Details';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "ERF Equipment Calibration";
    SourceTableView = sorting("Equipment ID");
    DelayedInsert = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Equipment ID"; Rec."Equipment ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Equipment ID field.', Comment = '%';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
                field("Model No."; Rec."Model No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Model No. field.', Comment = '%';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Manufacturer field.', Comment = '%';
                }
                field("Last Calibrated"; Rec."Last Calibrated")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Last Calibrated field.', Comment = '%';
                }
                field("Calibration Frequency"; Rec."Calibration Frequency")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Calibration Frequency field.', Comment = '%';
                }
                field("Calibration Due Date"; Rec."Calibration Due Date")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the value of the Third Party Calibration Provider field.', Comment = '%';
                // }
                field("Calibration Provider Name"; Rec."Calibration Provider Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Third Party Calibration Provider Name field.', Comment = '%';
                }
                field("Verify Calibration Certificate"; Rec."Verify Calibration Certificate")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Verified Calibration Certificate? field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                // field("Checked by Employee No."; Rec."Checked by Employee No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Checked by Employee No. field.', Comment = '%';
                // }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Checked by Employee Name field.', Comment = '%';
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
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
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Clear(EquipCalibrationMgmt);
        if Confirm('Do you want to save your changes to the Log?', false) then
            EquipCalibrationMgmt.CreateCalibrationHistoricalEntry(Rec);
        exit(true);
    end;

    var
        CalibrationHistory: Record "ERF Calibration History";
        EquipCalibrationMgmt: Codeunit "ERF Equip. Calibration Mgmt.";
}
