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
            field("ERF ItemTrackingCode Neg.Batch"; Rec."ERF ItemTrackingCode Neg.Batch")
            {
                ApplicationArea = all;
            }
            field("ERF ItemTrackingCode Pos.Batch"; Rec."ERF ItemTrackingCode Pos.Batch")
            {
                ApplicationArea = all;
            }
        }
    }
}
