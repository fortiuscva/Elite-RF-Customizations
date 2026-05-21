tableextension 52132 "ERF Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
        field(52100; "ERF On Time Shipment"; Enum "ERF On Time Shipment")
        {
            Caption = 'On Time Shipment';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header Archive"."ERF On Time Shipment" where("No." = field("Document No.")));
            Editable = false;
        }
    }
}
