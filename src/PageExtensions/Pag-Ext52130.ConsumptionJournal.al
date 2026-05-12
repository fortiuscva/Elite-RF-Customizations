pageextension 52130 "ERF Consumption Journal" extends "Consumption Journal"
{
    layout
    {
        addafter(Quantity)
        {
            field("ERF Prod. Ord. Comp. Rem. Qty"; Rec."ERF Prod. Ord. Comp. Rem. Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prod. Order. Comp. Rem. Qty field.';
            }
        }
    }
}
