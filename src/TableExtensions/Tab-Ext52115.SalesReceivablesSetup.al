tableextension 52115 "ERF Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(52100; "ERF Shipping Resource No."; Code[20])
        {
            Caption = 'Shipping Resource No.';
            TableRelation = Resource;
            DataClassification = ToBeClassified;
        }
        field(52101; "ERF ItemTrackingCode Neg.Batch"; Code[10])
        {
            Caption = 'Item Tracking Code Negative Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch" where("Journal Template Name" = const('ITEM'));
        }
        field(52102; "ERF ItemTrackingCode Pos.Batch"; Code[10])
        {
            Caption = 'Item Tracking Code Positive Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch" where("Journal Template Name" = const('ITEM'));
        }
    }
}
