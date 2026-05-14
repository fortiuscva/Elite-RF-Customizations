tableextension 52121 "ERF Purch. Cr. Memo Hdr." extends "Purch. Cr. Memo Hdr."
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
