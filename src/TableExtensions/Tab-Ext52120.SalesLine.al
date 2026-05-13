tableextension 52120 "ERF Sales Line" extends "Sales Line"
{
    fields
    {
        field(52100; "ERF On Time Shipment"; Enum "ERF On Time Shipment")
        {
            Caption = 'On Time Shipment';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."ERF On Time Shipment" where("Document Type" = field("Document Type"),
                                                          "No." = field("Document No.")));
        }
    }
}
