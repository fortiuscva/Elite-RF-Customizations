tableextension 52105 "ERF Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(52100; "ERF Job Id"; Code[20])
        {
            Caption = 'Job Id';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." where("Document Type" = filter(order));
        }
        field(52101; "ERF Supplier Late Delivery"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Late Delivery';
        }
    }
}
