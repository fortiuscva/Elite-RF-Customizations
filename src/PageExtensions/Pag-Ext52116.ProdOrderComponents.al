pageextension 52116 "ERF Prod. Order Components" extends "Prod. Order Components"
{
    layout
    {
        addlast(Control1)
        {
            field("ERF Error Text"; Rec."ERF Error Text")
            {
                ToolTip = 'Error Text';
                ApplicationArea = all;
            }
        }
    }
}
