pageextension 52115 "ERF Manufacturing Setup" extends "Manufacturing Setup"
{
    layout
    {
        addafter("Cost Incl. Setup")
        {
            field("ERF Skip Prod. BOM Grouping"; Rec."ERF Skip Prod. BOM Grouping")
            {
                ToolTip = 'Skip Item Grouping after Refresh Prod. Order';
                ApplicationArea = all;
            }
        }
    }
}
