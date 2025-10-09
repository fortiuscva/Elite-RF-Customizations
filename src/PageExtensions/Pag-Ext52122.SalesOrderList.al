pageextension 52122 "ERF Sales Order List" extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {

            field("ERF Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.';
            }
        }
    }
}
