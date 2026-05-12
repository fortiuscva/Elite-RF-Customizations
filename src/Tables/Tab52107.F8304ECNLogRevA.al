table 52107 "ERF F-830-4 ECN Log Rev A"
{
    Caption = 'F-830-4 ECN Log Rev A';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ECN Number"; Integer)
        {
            Caption = 'ECN Number';
        }
        field(2; "Date Opened"; Date)
        {
            Caption = 'Date Opened';
        }
        field(3; "Date Signed"; Date)
        {
            Caption = 'Date Signed';
        }
        field(4; "Product P/N"; Text[50])
        {
            Caption = 'Product P/N';
        }
        field(5; "Old Rev"; Text[20])
        {
            Caption = 'Old Rev';
        }
        field(6; "New Rev"; Text[20])
        {
            Caption = 'New Rev';
        }
        field(7; "Part/Product Description"; Text[50])
        {
            Caption = 'Part/Product Description';
        }
        field(8; "Description of Change"; Text[100])
        {
            Caption = 'Description of Change';
        }
        field(9; "Reason for Change"; Text[250])
        {
            Caption = 'Reason for Change';
        }
        field(10; "ECO Effects On"; Text[250])
        {
            Caption = 'ECO Effects On';
        }
        field(11; Impact; Boolean)
        {
            Caption = 'Impact';
        }
        field(12; "WIP/FG"; Text[250])
        {
            Caption = 'WIP/FG';
        }

    }
    keys
    {
        key(PK; "ECN Number")
        {
            Clustered = true;
        }
    }
}
