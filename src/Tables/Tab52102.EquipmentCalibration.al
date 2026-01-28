table 52102 "ERF Equipment Calibration"
{
    Caption = 'Equipment Calibration';
    LookupPageId = "ERF Equip. Calibration Details";
    DrillDownPageId = "ERF Equip. Calibration Details";
    DataCaptionFields = "Equipment ID", "Equipment Type";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Equipment ID"; Code[20])
        {
            Caption = 'Equipment ID';
            DataClassification = CustomerContent;
        }
        field(6; "Equipment Type"; Text[100])
        {
            Caption = 'Equipment Type';
            DataClassification = CustomerContent;
        }
        field(9; "Model No."; Code[20])
        {
            Caption = 'Model #';
            DataClassification = CustomerContent;
        }
        field(11; "Serial No."; Code[20])
        {
            Caption = 'Serial #';
            DataClassification = CustomerContent;
        }
        field(15; Manufacturer; Text[100])
        {
            Caption = 'Manufacturer';
            DataClassification = CustomerContent;
        }
        field(19; "Last Calibrated"; Date)
        {
            Caption = 'Last Calibrated';
            DataClassification = CustomerContent;
            // trigger OnValidate()
            // begin
            //     if ("Last Calibrated" <> 0D) and ("Calibration Frequency" <> 0) then begin
            //         MonthDateFormula := ConvertToDateFormulaInMonths("Calibration Frequency");
            //         Validate("Calibration Due Date", CalcDate(MonthDateFormula, "Last Calibrated"));
            //     end;
            //     if "Last Calibrated" = 0D then
            //         Validate("Calibration Due Date", 0D);
            // end;
        }
        field(23; "Calibration Frequency"; Integer)
        {
            Caption = 'Calibration Frequency';
            DataClassification = CustomerContent;
            // trigger OnValidate()
            // begin
            //     if ("Last Calibrated" <> 0D) and ("Calibration Frequency" <> 0) then begin
            //         MonthDateFormula := ConvertToDateFormulaInMonths("Calibration Frequency");
            //         Validate("Calibration Due Date", CalcDate(MonthDateFormula, "Last Calibrated"));
            //     end;
            //     if "Calibration Frequency" = 0 then
            //         Validate("Calibration Due Date", 0D);
            // end;
        }
        field(27; "Calibration Due Date"; Date)
        {
            Caption = 'Calibration Due Date';
            DataClassification = CustomerContent;
        }
        // field(31; "Calibration Provider"; Code[20])
        // {
        //     Caption = 'Third Party Calibration Provider';
        //     TableRelation = Vendor;
        //     DataClassification = CustomerContent;
        //     trigger OnValidate()
        //     var
        //         VendorRec: Record Vendor;
        //     begin
        //         if (Rec."Calibration Provider" <> xRec."Calibration Provider") then begin
        //             if Rec."Calibration Provider" <> '' then begin
        //                 VendorRec.Get(Rec."Calibration Provider");
        //                 Rec.Validate("Calibration Provider Name", VendorRec.Name);
        //             end else
        //                 Rec.Validate("Calibration Provider Name", '');
        //         end;
        //     end;
        // }
        field(35; "Calibration Provider Name"; Text[100])
        {
            Caption = 'Third Party Calibration Provider';
            // Editable = false;
            DataClassification = CustomerContent;
        }
        field(39; "Verify Calibration Certificate"; Boolean)
        {
            Caption = 'Verified Calibration Certificate?';
            DataClassification = CustomerContent;
        }
        field(43; Status; Enum "ERF Equip. Calibration Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(49; Location; Text[100])
        {
            Caption = 'Location';
            DataClassification = CustomerContent;
        }
        // field(52; "Checked by Employee No."; Code[20])
        // {
        //     Caption = 'Checked by Employee No.';
        //     TableRelation = Employee;
        //     DataClassification = CustomerContent;
        //     trigger OnValidate()
        //     var
        //         EmployeeRec: Record Employee;
        //     begin
        //         if Rec."Checked by Employee No." <> xRec."Checked by Employee No." then begin
        //             if "Checked by Employee No." <> '' then begin
        //                 EmployeeRec.Get("Checked by Employee No.");
        //                 Validate("Checked by Employee Name", EmployeeRec.FullName());
        //             end else
        //                 Validate("Checked by Employee Name", '');
        //         end;
        //     end;
        // }
        field(54; "Approved By"; Text[100])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
        }
        field(57; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Equipment ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Equip; "Equipment ID", "Equipment Type")
        {

        }
    }
    procedure ConvertToDateFormulaInMonths(Months: Integer): DateFormula
    var
        DateFormulaInMonths: DateFormula;
        MonthsFormatText: Text;
    begin
        MonthsFormatText := Format(Months) + 'M';
        Evaluate(DateFormulaInMonths, MonthsFormatText);
        exit(DateFormulaInMonths);
    end;

    var
        CalibrationHistory: Record "ERF Calibration History";
        MonthDateFormula: DateFormula;
}
