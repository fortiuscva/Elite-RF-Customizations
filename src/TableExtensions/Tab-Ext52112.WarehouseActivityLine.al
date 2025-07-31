tableextension 52112 "ERF Warehouse Activity Line" extends "Warehouse Activity Line"
{
    fields
    {
        field(52100; "ERF Pick Code"; Text[500])
        {
            Caption = 'Pick Code';
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                ProdBOMLine: Record "Production BOM Line";
            begin
                if "Item No." <> '' then begin
                    ProdBOMLine.SetRange(Type, ProdBOMLine.Type::Item);
                    ProdBOMLine.SetRange("No.", "Item No.");
                    if ProdBOMLine.FindFirst() then
                        Rec."ERF Pick Code" := ProdBOMLine."ERF Pick Code";
                end;
            end;
        }
    }
}
