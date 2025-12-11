table 52102 "ERF Equipment Calibration "
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
        }
        field(6; "Equipment Type"; Text[100])
        {
            Caption = 'Equipment Type';
        }
        field(9; "Model No."; Code[20])
        {
            Caption = 'Model #';
        }
        field(11; "Serial No."; Code[20])
        {
            Caption = 'Serial #';
        }
        field(15; Manufacturer; Text[100])
        {
            Caption = 'Manufacturer';
        }
        field(19; "Last Calibrated"; Date)
        {
            Caption = 'Last Calibrated';
        }
        field(23; "Calibration Frequency"; DateFormula)
        {
            Caption = 'Calibration Frequency';
        }
        field(27; "Calibration Due Date"; Date)
        {
            Caption = 'Calibration Due Date';
        }
        field(31; "Calibration Provider"; Code[20])
        {
            Caption = 'Third Party Calibration Provider';
            TableRelation = Vendor;
            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                if (Rec."Calibration Provider" <> xRec."Calibration Provider") then begin
                    if Rec."Calibration Provider" <> '' then begin
                        if VendorRec.Get(Rec."Calibration Provider") then
                            Rec.Validate("Calibration Provider Name", VendorRec.Name)
                    end else
                        Rec.Validate("Calibration Provider Name", '');
                end;
            end;
        }
        field(35; "Calibration Provider Name"; Text[100])
        {
            Caption = 'Third Party Calibration Provider Name';
            Editable = false;
        }
        field(39; "Verify Calibration Certificate"; Boolean)
        {
            Caption = 'Verified Calibration Certificate?';
        }
        field(43; Status; Enum "ERF Equip. Calibration Status")
        {
            Caption = 'Status';
        }
        field(49; Location; Text[100])
        {
            Caption = 'Location';
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
}
