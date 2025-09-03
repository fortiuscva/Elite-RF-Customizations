pageextension 52121 "ERF Production BOM Lines" extends "Production BOM Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("ERF Pick Code"; Rec."ERF Pick Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
