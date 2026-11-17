tableextension 52134 "ERF User Setup" extends "User Setup"
{
    fields
    {
        field(52100; "ERF Allow Edit Supplier OTD"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Edit Supplier OTD';
        }
        field(52109; "ERF Allow Edit REV B"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Edit REV B';
        }
    }
}