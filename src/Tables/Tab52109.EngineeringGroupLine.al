table 52109 "ERF Engineering Group Line"
{
    Caption = 'Engineering Group Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Engineering Group Code"; Code[20])
        {
            Caption = 'Engineering Group';
            DataClassification = CustomerContent;

            TableRelation = "ERF Engineering Group".Code;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }

        field(3; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Engineering Group Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
