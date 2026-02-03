pageextension 52124 "ERF Vendor List" extends "Vendor List"
{
    layout
    {
        addlast(Control1)
        {
            field("ERF QMS End Date"; Rec."ERF QMS End Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the QMS End Date field.', Comment = '%';
            }
        }
    }
}
