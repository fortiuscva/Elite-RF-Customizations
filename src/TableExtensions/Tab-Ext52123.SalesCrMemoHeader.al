tableextension 52123 "ERF Sales Cr. Memo Header" extends "Sales Cr.Memo Header"
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
