tableextension 52122 "ERF Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        field(52101; "ERF On Time Shipment"; Enum "ERF On Time Shipment")
        {
            Caption = 'On Time Shipment';
            DataClassification = CustomerContent;
        }
    }
}
