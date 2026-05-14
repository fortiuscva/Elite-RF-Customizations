pageextension 52131 "ERF Sales Order" extends "Sales Order"
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
