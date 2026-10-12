table 52115 "ERF SFTT Setup"
{
    Caption = 'Shop Floor Time Tracking Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Journal Template Name" <> xRec."Journal Template Name" then
                    Validate("Journal Batch Name", '');
            end;
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
