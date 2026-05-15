tableextension 52119 "ERF Sales Header" extends "Sales Header"
{
    fields
    {
        field(52100; "ERF On Time Shipment"; enum "ERF On Time Shipment")
        {
            Caption = 'On Time Shipment';
            DataClassification = ToBeClassified;
        }
    }
}
