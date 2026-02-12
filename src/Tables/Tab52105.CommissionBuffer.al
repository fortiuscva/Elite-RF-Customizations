table 52105 "ERF Commission Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Order No."; Code[20]) { }
        field(2; "Salesperson Code"; Code[20]) { }
        field(3; "Commission Basis"; Decimal) { }
        field(4; "Commission %"; Decimal) { }
        field(5; "Commission Amount"; Decimal) { }
    }

    keys
    {
        key(PK; "Order No.", "Salesperson Code")
        {
            Clustered = true;
        }
    }
}
