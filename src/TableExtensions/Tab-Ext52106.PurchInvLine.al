tableextension 52106 "ERF Purch. Inv. Line" extends "Purch. Inv. Line"
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
