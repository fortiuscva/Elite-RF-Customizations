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
            field("ERF Job ID"; Rec."ERF Job ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job ID field.';
            }
        }
        addafter(Description)
        {
            field("ERF Supplier OTD"; Rec."ERF Supplier OTD")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier OTD field.', Comment = '%';
            }
        }
        modify("Expected Receipt Date")
        {
            Visible = true;
        }
    }
}
