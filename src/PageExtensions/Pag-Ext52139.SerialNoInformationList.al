pageextension 52139 "Serial No. Information List" extends "Serial No. Information List"
{
    layout
    {
        addlast(Control1)
        {
            field("ERF Serial No. Notes"; Rec."ERF Serial No. Notes Exists")
            {
                ApplicationArea = All;
                Caption = 'Serial No. Notes';
                ToolTip = 'Specifies the value of the Serial No. Notes field.', Comment = '%';
            }
        }
    }
}
