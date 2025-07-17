tableextension 52111 "ERF Job Planning Line" extends "Job Planning Line"
{
    fields
    {
        field(52100; "ERF Production Order No."; Code[20])
        {
            Caption = 'Production Order Number';
            DataClassification = ToBeClassified;
        }
        field(52101; "ERF Qty. to Assemble"; Text[20])
        {
            Caption = 'ERF Qty. to Assemble';
            DataClassification = ToBeClassified;
        }
        field(52102; "ERF Purchased"; Text[20])
        {
            Caption = 'Purchased';
            DataClassification = ToBeClassified;
        }
        field(52103; "ERF Assembled Qty."; Text[20])
        {
            Caption = 'ERF Assembled Qty.';
            DataClassification = ToBeClassified;
        }
        field(52104; "ERF TEST"; Text[20])
        {
            Caption = 'TEST';
            DataClassification = ToBeClassified;
        }
        field(52105; "ERF Notes"; Text[250])
        {
            Caption = 'ERF Notes';
            DataClassification = ToBeClassified;
        }
    }
}
