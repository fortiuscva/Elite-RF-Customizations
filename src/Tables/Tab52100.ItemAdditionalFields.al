table 52100 "ERF Item Additional Fields"
{
    Caption = 'Item Additional Fields';
    DataClassification = CustomerContent;
    LookupPageId = "ERF Item Additional Fields";
    DrillDownPageId = "ERF Item Additional Fields";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
            Editable = false;
        }
        field(2; "Extended Description"; Text[500])
        {
            Caption = 'Extended Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }
}