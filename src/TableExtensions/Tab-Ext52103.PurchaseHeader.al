tableextension 52103 "ERF Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(52100; "ERF CoC Required"; Boolean)
        {
            Caption = 'CoC Required';
            DataClassification = CustomerContent;
        }
    }
}
