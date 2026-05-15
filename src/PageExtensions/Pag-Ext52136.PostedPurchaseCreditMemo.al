pageextension 52136 "Posted Purchase Credit Memo" extends "Posted Purchase Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field("ERF Job ID"; Rec."ERF Job ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job ID field.';
            }
        }
    }
}