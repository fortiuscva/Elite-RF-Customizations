tableextension 52137 "ERF Job" extends Job
{
    fields
    {
        field(52100; "ERF Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
        }
    }
}
