pageextension 52143 "ERF User Setup" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("ERF Allow Edit Supplier OTD"; Rec."ERF Allow Edit Supplier OTD")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Edit Supplier OTD field.', Comment = '%';
            }
            field("ERF Allow Delete SFTT Entries"; Rec."ERF Allow Delete SFTT Entries")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Deletion of SFTT Entries field.', Comment = '%';
                Visible = false;
            }
            field("ERF Allow Update SFTT Entries"; Rec."ERF Allow Update SFTT Entries")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Modification of SFTT Entries field.', Comment = '%';
                Visible = false;
            }
        }

    }
}