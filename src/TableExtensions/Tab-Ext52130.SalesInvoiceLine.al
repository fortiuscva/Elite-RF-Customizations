tableextension 52130 "ERF Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(52100; "ERF On Time Shipment"; Enum "ERF On Time Shipment")
        {
            Caption = 'On Time Shipment';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."ERF On Time Shipment" where("No." = field("Document No.")));
            Editable = false;
        }
    }
}
