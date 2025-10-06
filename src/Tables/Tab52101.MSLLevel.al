table 52101 "ERF MSL Level"
{
    Caption = 'MSL Level';
    DataClassification = CustomerContent;
    LookupPageId = "ERF MSL Level";
    DrillDownPageId = "ERF MSL Level";

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
