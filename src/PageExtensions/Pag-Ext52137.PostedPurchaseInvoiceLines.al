pageextension 52137 "Posted Purchase Invoice Lines" extends "Posted Purchase Invoice Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("ERF Job ID"; Rec."ERF Job ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job ID field.';
            }
        }
    }
}