tableextension 52102 "ERF Purchase Line Archive" extends "Purchase Line Archive"
{
    LookupPageId = "ERF Purchase Lines Archive";
    DrillDownPageId = "ERF Purchase Lines Archive";
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
