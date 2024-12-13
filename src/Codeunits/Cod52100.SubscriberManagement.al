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

    var
        NotEnoughInventoryLbl: Label 'Pick Lines cannot create due to inventory';
        AlredyExistsPickLines: Label 'Pick Lines Already Exists';
}
