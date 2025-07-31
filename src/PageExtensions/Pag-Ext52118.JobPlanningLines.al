pageextension 52118 "ERF Job Planning Lines" extends "Job Planning Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("ERF Production Order No."; Rec."ERF Production Order No.")
            {
                ApplicationArea = All;
            }
            field("ERF Qty. to Assemble"; Rec."ERF Qty. to Assemble")
            {
                ApplicationArea = All;
            }
            field("ERF Purchased"; Rec."ERF Purchased")
            {
                ApplicationArea = All;
            }
            field("ERF Assembled Qty."; Rec."ERF Assembled Qty.")
            {
                ApplicationArea = All;
            }
            field("ERF TEST"; Rec."ERF TEST")
            {
                ApplicationArea = All;
            }
            field("ERF Notes"; Rec."ERF Notes")
            {
                ApplicationArea = All;
            }
        }
    }
}
