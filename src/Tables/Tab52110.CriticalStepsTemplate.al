table 52110 "ERF Critical Steps Template"
{
    Caption = 'Critical Steps Template';
    DrillDownPageId = "ERF Critical Steps Templates";
    LookupPageId = "ERF Critical Steps Templates";
    DataCaptionFields = Code, Description;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Entry No.", Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Dropdown; Code, Description)
        {

        }
    }
}
