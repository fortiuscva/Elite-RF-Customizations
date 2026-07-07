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
        }

    }
}