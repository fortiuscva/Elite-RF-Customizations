table 52103 "ERF Calibration History"
{
    Caption = 'Calibration History';
    DrillDownPageId = "ERF Calibration History Detail";
    LookupPageId = "ERF Calibration History Detail";
    Permissions = Tabledata "ERF Calibration History" = rimd;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Equipment Id"; Code[20])
        {
            Caption = 'Equipment Id';
            TableRelation = "ERF Equipment Calibration";
            DataClassification = CustomerContent;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
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
            Caption = 'Last Calibrated Date';
            DataClassification = CustomerContent;
        }
        field(23; "Calibration Frequency"; Integer)
        {
            Caption = 'Calibration Frequency (Months)';
            DataClassification = CustomerContent;
        }
        field(27; "Calibration Due Date"; Date)
        {
            Caption = 'Calibration Due Date';
            DataClassification = CustomerContent;
        }
        field(31; "Calibration Provider"; Code[20])
        {
            Caption = 'Third Party Calibration Provider';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(35; "Calibration Provider Name"; Text[100])
        {
            Caption = 'Third Party Calibration Provider Name';
            DataClassification = CustomerContent;
        }
        field(39; "Verify Calibration Certificate"; Boolean)
        {
            Caption = 'Verified Calibration Certificate?';
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
        field(52; "Checked by Employee No."; Code[20])
        {
            Caption = 'Checked by Employee No.';
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }
        field(54; "Checked by Employee Name"; Text[100])
        {
            Caption = 'Checked by Employee Name';
            DataClassification = CustomerContent;
        }
        field(57; "Checked Date"; Date)
        {
            Caption = 'Checked Date';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Equipment Id")
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Equipment Id")
        {

        }
    }
}
