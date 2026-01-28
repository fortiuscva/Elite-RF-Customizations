codeunit 52100 "ERF Subscriber Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", 'OnAfterProdOrderCompFilter', '', false, false)]

    local procedure OnAfterProdOrderCompFilter(var ProdOrderComp: Record "Prod. Order Component"; ProdBOMLine: Record "Production BOM Line")
    var
        ManufacturingSetup: Record "Manufacturing Setup";
    begin
        ManufacturingSetup.Get();
        if ManufacturingSetup."ERF Skip Prod. BOM Grouping" then
            ProdOrderComp.SetRange("ERF Grouping", true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", 'OnBeforeCreatePickOrMoveLineFromProductionLoop', '', false, false)]
    local procedure OnBeforeCreatePickOrMoveLineFromProductionLoop(var WarehouseActivityHeader: Record "Warehouse Activity Header"; ProductionOrder: Record "Production Order"; var IsHandled: Boolean; ProdOrderComponent: Record "Prod. Order Component")
    var
        NewWarehouseActivityLine: Record "Warehouse Activity Line";
        ProdOrderComponent2: Record "Prod. Order Component";
        singleInstance: Codeunit "ERF Single Instance";
    begin
        if IsHandled then
            exit;
        ProdOrderComponent2 := ProdOrderComponent;
        if not ProdOrderComponent2.CheckIfProdOrderCompMeetsReservedFromStockSetting(Abs(ProdOrderComponent."Remaining Qty. (Base)"), singleInstance.GetReservedFroMStock()) then begin
            ProdOrderComponent2."ERF Error Text" := NotEnoughInventoryLbl;
            ProdOrderComponent2.Modify();
            exit;
        end;
        if NewWarehouseActivityLine.ActivityExists(Database::"Prod. Order Component", ProdOrderComponent.Status.AsInteger(), ProdOrderComponent."Prod. Order No.", ProdOrderComponent."Prod. Order Line No.", ProdOrderComponent."Line No.", 0) then begin
            ProdOrderComponent2."ERF Error Text" := AlredyExistsPickLines;
            ProdOrderComponent2.Modify();
            exit;
        end;



    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", OnAfterConfirmPost, '', false, false)]
    local procedure "Sales-Post (Yes/No)_OnAfterConfirmPost"(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Posting Date" <> WorkDate() then
            SalesHeader."Posting Date" := WorkDate();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", OnAfterTransferBOMComponent, '', false, false)]
    local procedure "Calculate Prod. Order_OnAfterTransferBOMComponent"(var ProdOrderLine: Record "Prod. Order Line"; var ProductionBOMLine: Record "Production BOM Line"; var ProdOrderComponent: Record "Prod. Order Component"; LineQtyPerUOM: Decimal; ItemQtyPerUOM: Decimal)
    begin
        ProdOrderComponent."ERF Production BOM No." := ProductionBOMLine."Production BOM No.";
        ProdOrderComponent."ERF Production BOM Line No." := ProductionBOMLine."Line No.";
        ProdOrderComponent."ERF Version Code" := ProductionBOMLine."Version Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", OnBeforeNewWhseActivLineInsertFromComp, '', false, false)]
    local procedure "Create Inventory Pick/Movement_OnBeforeNewWhseActivLineInsertFromComp"(var WarehouseActivityLine: Record "Warehouse Activity Line"; var ProdOrderComp: Record "Prod. Order Component"; var WarehouseActivityHeader: Record "Warehouse Activity Header"; var RemQtyToPickBase: Decimal)
    begin
        WarehouseActivityLine."ERF Production BOM No." := ProdOrderComp."ERF Production BOM No.";
        WarehouseActivityLine."ERF Production BOM Line No." := ProdOrderComp."ERF Production BOM Line No.";
        WarehouseActivityLine."ERF Version Code" := ProdOrderComp."ERF Version Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterGetRefTable, '', false, false)]
    local procedure "Document Attachment Mgmt_OnAfterGetRefTable"(var RecRef: RecordRef; DocumentAttachment: Record "Document Attachment")
    var
        EquipCalibrationRec: Record "ERF Equipment Calibration";
    begin
        case DocumentAttachment."Table ID" of
            Database::"ERF Equipment Calibration":
                begin
                    RecRef.Open(Database::"ERF Equipment Calibration");
                    if EquipCalibrationRec.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(EquipCalibrationRec);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterTableHasNumberFieldPrimaryKey, '', false, false)]
    local procedure "Document Attachment Mgmt_OnAfterTableHasNumberFieldPrimaryKey"(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        case TableNo of
            Database::"ERF Equipment Calibration":
                begin
                    FieldNo := 1;
                    Result := true;
                end;
        end;
    end;

    var
        NotEnoughInventoryLbl: Label 'Pick Lines cannot create due to inventory';
        AlredyExistsPickLines: Label 'Pick Lines Already Exists';
}
