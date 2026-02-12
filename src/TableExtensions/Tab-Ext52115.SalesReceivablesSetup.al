tableextension 52115 "ERF Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(52100; "ERF Shipping Resource No."; Code[20])
        {
            Caption = 'Shipping Resource No.';
            TableRelation = Resource;
            DataClassification = ToBeClassified;
        }
    }
}
