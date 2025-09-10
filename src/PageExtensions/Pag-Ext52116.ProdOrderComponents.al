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
            field("ERF Pick Code"; Rec."ERF Pick Code")
            {
                ApplicationArea = all;
            }
            field("ERF Production BOM No."; Rec."ERF Production BOM No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production BOM No. field.', Comment = '%';
            }
            field("ERF Production BOM Line No."; Rec."ERF Production BOM Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production BOM Line No. field.', Comment = '%';
            }
        }
    }
}
