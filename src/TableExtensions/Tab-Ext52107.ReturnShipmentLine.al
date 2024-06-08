tableextension 52107 "ERF Return Shipment Line" extends "Return Shipment Line"
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
