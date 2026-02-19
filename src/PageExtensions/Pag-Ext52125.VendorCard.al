pageextension 52125 "ERF Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {

            field("ERF QMS End Date"; Rec."ERF QMS End Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the QMS End Date field.', Comment = '%';
            }
        }
    }
}
