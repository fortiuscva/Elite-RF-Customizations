tableextension 52112 "ERF Warehouse Activity Line" extends "Warehouse Activity Line"
{
    fields
    {
        field(52100; "ERF Pick Code"; Text[500])
        {
            Caption = 'Pick Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Production BOM Line"."ERF Pick Code" where(Type = const(Item), "No." = field("Item No.")));
        }
    }
}
