pageextension 52126 "ERF Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("ERF Prepayment Invoice"; Rec."Prepayment Invoice")
            {
                ApplicationArea = All;
            }
        }
    }
}
