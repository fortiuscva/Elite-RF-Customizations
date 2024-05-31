tableextension 52103 "ERF Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(52100; "ERF CoC Required"; Boolean)
        {
            Caption = 'COC Required';
            DataClassification = CustomerContent;
        }
    }

    trigger OnInsert()
    begin
        "ERF CoC Required" := true;
    end;
}
