pageextension 52110 "Posted Purch. Cr. Memo Subform" extends "Posted Purch. Cr. Memo Subform"
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
