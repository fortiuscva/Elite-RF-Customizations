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
            CalcFormula = lookup("Production BOM Line"."ERF Pick Code" where("Production BOM No." = field("ERF Production BOM No."), "Line No." = field("ERF Production BOM Line No."), "Version Code" = field("ERF Version Code")));
        }
        field(52103; "ERF Production BOM No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Production BOM No.';
            Editable = false;
        }
        field(52104; "ERF Production BOM Line No."; Integer)
        {
            Caption = 'Production BOM Line No.';
            Editable = false;
        }
        field(52105; "ERF Version Code"; Code[20])
        {
            Caption = 'Version Code';
            TableRelation = "Production BOM Version"."Version Code" where("Production BOM No." = field("ERF Production BOM No."));
            Editable = false;
        }
    }
}
