pageextension 52112 "ERF Purch. Cr. Memo Subform" extends "Purch. Cr. Memo Subform"
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
