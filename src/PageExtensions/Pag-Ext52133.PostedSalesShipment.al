pageextension 52133 "ERF Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Package Tracking No.")
        {
            field("ERF On Time Shipment"; Rec."ERF On Time Shipment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the On Time Shipment field.', Comment = '%';
            }
        }
    }
}
