pageextension 52120 "ERF Prod. BOM Version List" extends "Prod. BOM Version List"
{
    layout
    {
        addfirst(Control1)
        {
            field("ERF Production BOM No."; Rec."Production BOM No.")
            {
                ApplicationArea = all;
            }
        }
    }
}

