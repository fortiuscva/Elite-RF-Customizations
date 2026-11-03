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
            field("ERF Allow Edit REV B"; Rec."ERF Allow Edit REV B")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Edit REV B field.', Comment = '%';
            }
        }
    }
}