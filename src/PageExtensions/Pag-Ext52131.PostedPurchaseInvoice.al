pageextension 52131 "ERF Posted Purchase Invoice" extends "Posted Purchase Invoice"
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