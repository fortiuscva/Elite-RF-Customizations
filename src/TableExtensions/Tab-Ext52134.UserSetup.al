tableextension 52134 "ERF User Setup" extends "User Setup"
{
    fields
    {
        field(52100; "ERF Allow Edit Supplier OTD"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Edit Supplier OTD';
        }
        field(52101; "ERF Allow Delete SFTT Entries"; Boolean)
        {
            Caption = 'Allow Deletion of SFTT Entries';
            DataClassification = CustomerContent;
        }
        field(52102; "ERF Allow Update SFTT Entries"; Boolean)
        {
            Caption = 'Allow Modification of SFTT Entries';
            DataClassification = CustomerContent;
        }
    }
}