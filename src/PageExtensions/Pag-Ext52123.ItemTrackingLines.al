pageextension 52123 "ERF Item Tracking Lines" extends "Item Tracking Lines"
{
    layout
    {
        modify(Description)
        {
            Visible = false;
        }
        addafter(Description)
        {
            field("ERF Description"; Rec."ERF Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description field.', Comment = '%';
            }
        }
    }
}
