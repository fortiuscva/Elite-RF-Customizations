table 52103 "ERF Calibration History"
{
    Caption = 'Calibration History';
    DrillDownPageId = "ERF Calibration History Detail";
    LookupPageId = "ERF Calibration History Detail";
    DataCaptionFields = "Equipment Id", "Equipment Type";
    Permissions = Tabledata "ERF Calibration History" = rimd;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(5; "Equipment Id"; Code[20])
        {
            Caption = 'Equipment Id';
            DataClassification = CustomerContent;
        }
        field(10; "Equipment Type"; Text[100])
        {
            Caption = 'Equipment Type';
            DataClassification = CustomerContent;
        }
        field(16; "Calibrated Date"; Date)
        {
            Caption = 'Last Calibrated Date';
        }
        field(19; "Calibration Frequency"; Integer)
        {
            Caption = 'Calibration Frequency (Months)';
            DataClassification = CustomerContent;
        }
        field(22; "Calibration Due Date"; Date)
        {
            Caption = 'Calibration Due Date';
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
