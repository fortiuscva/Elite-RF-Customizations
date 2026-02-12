pageextension 52128 "ERF Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("ERF Shipping Resource No."; Rec."ERF Shipping Resource No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
