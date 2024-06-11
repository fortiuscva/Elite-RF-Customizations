pageextension 52108 "ERF Posted Purchase Rcpt. Subf" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter("No.")
        {
            field("ERF Job Id"; Rec."ERF Job Id")
            {
                ApplicationArea = all;
                ToolTip = 'Job Id';
            }
        }
    }
}
