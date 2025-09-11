tableextension 52112 "ERF Warehouse Activity Line" extends "Warehouse Activity Line"
{
    fields
    {
        field(52100; "ERF Pick Code"; Text[500])
        {
            Caption = 'Pick Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Production BOM Line"."ERF Pick Code" where("Production BOM No." = field("ERF Production BOM No."), "Line No." = field("ERF Production BOM Line No."), "Version Code" = field("ERF Version Code")));
        }
        field(52101; "ERF Production BOM No."; Code[20])
        {
            Caption = 'Production BOM No.';
            Editable = false;
        }
        field(52102; "ERF Production BOM Line No."; Integer)
        {
            Caption = 'Production BOM Line No.';
            Editable = false;
        }
        field(52103; "ERF Version Code"; Code[20])
        {
            Caption = 'Version Code';
            TableRelation = "Production BOM Version"."Version Code" where("Production BOM No." = field("ERF Production BOM No."));
            Editable = false;
        }
    }
}
