tableextension 52121 "ERF Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(52100; "ERF On Time Shipment"; Enum "ERF On Time Shipment")
        {
            Caption = 'On Time Shipment';
            DataClassification = CustomerContent;
        }
    }
}
