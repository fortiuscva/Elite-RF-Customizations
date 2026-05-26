pageextension 52141 "ERF Pstd Sales Shipment Update" extends "Posted Sales Shipment - Update"
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
