pageextension 52138 "ERF Posted Sales Shipments" extends "Posted Sales Shipments"
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
        }
    }
}
