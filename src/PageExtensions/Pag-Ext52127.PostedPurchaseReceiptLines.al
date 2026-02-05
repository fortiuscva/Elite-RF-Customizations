pageextension 52127 "Posted Purchase Receipt Lines" extends "Posted Purchase Receipt Lines"
{
    layout
    {
        addlast(Control1)
        {

            field("ERF Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
            }
            field("ERF Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
            }
        }
        modify("Expected Receipt Date")
        {
            Visible = true;
        }
    }
}
