pageextension 52150 "ERF Job Card" extends "Job Card"
{
    layout
    {
        addlast(General)
        {

            field("ERF Sales Order No."; Rec."ERF Sales Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Order No. field.', Comment = '%';
            }
        }
    }
}
