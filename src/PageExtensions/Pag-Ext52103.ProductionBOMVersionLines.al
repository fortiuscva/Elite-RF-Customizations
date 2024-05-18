pageextension 52103 "Production BOM Version Lines" extends "Production BOM Version Lines"
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
