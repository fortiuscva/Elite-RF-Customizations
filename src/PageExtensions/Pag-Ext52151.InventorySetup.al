pageextension 52151 "ERF Inventory Setup" extends "Inventory Setup"
{
    layout
    {
        addlast(General)
        {
            field("ERF Low Stock Item Email To"; Rec."ERF Low Stock Item Email To")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Low Stock Item Email To field.';

            }
            field("ERF Low Stock Item Email CC To"; Rec."ERF Low Stock Item Email CC To")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Low Stock Item Email CC To field.';
            }
        }
    }
}
