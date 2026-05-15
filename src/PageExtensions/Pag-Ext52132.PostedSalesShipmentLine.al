pageextension 52132 "ERF Posted Sales Shipment Line" extends "Posted Sales Shipment Lines"
{
    layout
    {
        addafter("Location Code")
        {
            field("ERF On Time Shipment"; Rec."ERF On Time Shipment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the On Time Shipment field.', Comment = '%';
            }
            field("ERF External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.';
            }
        }
    }
}
