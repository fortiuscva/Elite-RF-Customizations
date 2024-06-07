tableextension 52108 "ERF Purch. Cr. Memo Line" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(52100; "ERF Job Id"; Code[20])
        {
            Caption = 'Job Id';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." where("Document Type" = filter(order));
        }
    }
}
