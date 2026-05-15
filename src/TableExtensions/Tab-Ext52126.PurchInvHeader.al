tableextension 52126 "ERF Purch. Inv. Header" extends "Purch. Inv. Header"
{
    fields
    {
        field(52101; "ERF Job ID"; Code[20])
        {
            Caption = 'Job ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
