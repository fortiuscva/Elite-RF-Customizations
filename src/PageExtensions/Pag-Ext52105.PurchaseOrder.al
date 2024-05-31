pageextension 52105 "ERF Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("ERF CoC Required"; Rec."ERF CoC Required")
            {
                ApplicationArea = All;
                ToolTip = 'Specify the COC Required value to display in the Purchase Order report.';
            }
        }
    }
}
