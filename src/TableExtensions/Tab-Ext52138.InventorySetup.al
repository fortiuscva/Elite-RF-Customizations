tableextension 52138 "ERF Inventory Setup" extends "Inventory Setup"
{
    fields
    {
        field(52100; "ERF Low Stock Item Email To"; Text[100])
        {
            Caption = 'Low Stock Item Report Email To';
            DataClassification = CustomerContent;
        }
        field(52101; "ERF Low Stock Item Email CC To"; Text[100])
        {
            Caption = 'Low Stock Item Report Email CC To';
            DataClassification = CustomerContent;
        }

    }
}
