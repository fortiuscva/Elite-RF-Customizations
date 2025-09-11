report 52110 "ERF Update Prod BOM Pick Code"
{
    Caption = 'Update Prod BOM Pick Code';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(ProdOrderComp; "Prod. Order Component")
        {
            DataItemTableView = sorting("Prod. Order No.", "Line No.");
            RequestFilterFields = "Prod. Order No.";

            trigger OnAfterGetRecord()
            var
                ProdOrderLine: Record "Prod. Order Line";
                ProdBOMLine: Record "Production BOM Line";
            begin
                if ProdOrderLine.Get(ProdOrderLine.Status::Released, "Prod. Order No.", "Prod. Order Line No.") then begin
                    ProdOrderComp."ERF Production BOM No." := ProdOrderLine."Production BOM No.";

                    if ProdBOMLine.Get(ProdOrderLine."Production BOM No.", ProdOrderLine."Production BOM Version Code", "Line No.") then begin
                        ProdOrderComp."ERF Production BOM Line No." := ProdBOMLine."Line No.";
                        ProdOrderComp."ERF Version Code" := ProdBOMLine."Version Code";
                    end;

                    ProdOrderComp.Modify();
                end;
            end;
        }

        dataitem(WHSActLine; "Warehouse Activity Line")
        {
            DataItemTableView = sorting("Activity Type", "No.", "Line No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                ProdOrderComp: Record "Prod. Order Component";
            begin
                if ProdOrderComp.Get(ProdOrderComp.Status::Released, WHSActLine."Source No.", WHSActLine."Source Line No.", WHSActLine."Source Subline No.") then begin
                    WHSActLine."ERF Production BOM No." := ProdOrderComp."ERF Production BOM No.";
                    WHSActLine."ERF Production BOM Line No." := ProdOrderComp."ERF Production BOM Line No.";
                    WHSActLine."ERF Version Code" := ProdOrderComp."ERF Version Code";
                    WHSActLine.Modify();
                end;
            end;
        }
    }
}
