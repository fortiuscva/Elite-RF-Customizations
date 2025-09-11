tableextension 52109 "ERF Prod. Order Component" extends "Prod. Order Component"
{
    fields
    {
        field(52100; "ERF Grouping"; Boolean)
        {
            Caption = 'Grouping';
            DataClassification = ToBeClassified;
        }
        field(52101; "ERF Error Text"; Text[250])
        {
            Caption = 'Error Text';
            DataClassification = ToBeClassified;
        }
        field(52102; "ERF Pick Code"; Text[500])
        {
            Caption = 'Pick Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Production BOM Line"."ERF Pick Code" where(Type = const(Item), "No." = field("Item No."), "Line No." = field("Line No.")));
        }
    }
}
