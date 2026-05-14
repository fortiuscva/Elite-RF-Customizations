pageextension 52132 "ERF Posted Purchase Receipt" extends "Posted Purchase Receipt"
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
