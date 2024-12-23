tableextension 52109 "ERF Prod. Order Component" extends "Prod. Order Component"
{
    fields
    {
        field(52100; "ERF Grouping"; Boolean)
        {
            Caption = 'Grouping';
            DataClassification = ToBeClassified;
        }
        field(52101; "ERF Error Text"; Text[250])
        {
            Caption = 'Error Text';
            DataClassification = ToBeClassified;
        }
    }
}
