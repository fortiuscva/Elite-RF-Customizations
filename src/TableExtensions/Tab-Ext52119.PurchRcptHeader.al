tableextension 52119 "ERF Purch. Rcpt. Header" extends "Purch. Rcpt. Header"
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
