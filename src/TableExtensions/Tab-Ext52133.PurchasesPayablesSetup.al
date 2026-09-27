tableextension 52133 "ERF Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(52100; "ERF Supplier Grace Period"; Integer)
        {
            Caption = 'Supplier Grace Period';
            DataClassification = ToBeClassified;
        }
        field(52101; "ERF PO Over Due Email To"; Text[100])
        {
            Caption = 'PO Over Due Report Email To';
            DataClassification = CustomerContent;
        }
        field(52102; "ERF PO Over Due Email CC To"; Text[100])
        {
            Caption = 'PO Over Due Report Email CC To';
            DataClassification = CustomerContent;
        }
    }
}
