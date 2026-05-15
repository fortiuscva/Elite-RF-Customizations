tableextension 52120 "ERF Sales Invoice Header" extends "Sales Invoice Header"
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
