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
        if SalesHeader."Posting Date" <> Today then
            SalesHeader."Posting Date" := Today;
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterInsertInvoiceHeader, '', false, false)]
    local procedure "Sales-Post_OnAfterInsertInvoiceHeader"(var SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    var
        SalesLine: Record "Sales Line";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Resource);
        SalesLine.SetFilter("Qty. to Invoice", '<>0');
        if SalesLine.FindFirst() then
            if SalesLine."No." = 'PREPAY' then
                SalesInvHeader."Prepayment Invoice" := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterRecreatePurchLine, '', false, false)]
    local procedure OnAfterRecreatePurchLine(var PurchLine: Record "Purchase Line"; var TempPurchLine: Record "Purchase Line" temporary; var PurchaseHeader: Record "Purchase Header")
    begin
        PurchLine."ERF Job Id" := PurchaseHeader."ERF Job ID";
        if PurchLine."Expected Receipt Date" < PurchaseHeader."Posting Date" then
            PurchLine."ERF Supplier OTD" := true
        else
            PurchLine."ERF Supplier OTD" := false;
        PurchLine.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterInsertShipmentHeader, '', false, false)]
    local procedure "Sales-Post_OnAfterInsertShipmentHeader"(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        SalesHeader."ERF On Time Shipment" := SalesHeader."ERF On Time Shipment"::" ";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipment - Update", OnAfterRecordChanged, '', false, false)]
    local procedure "Posted Sales Shipment - Update_OnAfterRecordChanged"(var SalesShipmentHeader: Record "Sales Shipment Header"; xSalesShipmentHeader: Record "Sales Shipment Header"; var IsChanged: Boolean)
    begin
        IsChanged := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", OnBeforeSalesShptHeaderModify, '', false, false)]
    local procedure "Shipment Header - Edit_OnBeforeSalesShptHeaderModify"(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header")
    begin
        SalesShptHeader."ERF On Time Shipment" := FromSalesShptHeader."ERF On Time Shipment";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterInitRecord, '', false, false)]
    local procedure SalesHeader_OnAfterInitRecord(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            if SalesHeader."Posting Date" <> Today then
                SalesHeader.Validate("Posting Date", Today);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterInitRecord, '', false, false)]
    local procedure PurchaseHeader_OnAfterInitRecord(var PurchHeader: Record "Purchase Header")
    begin
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then
            if PurchHeader."Posting Date" <> Today then
                PurchHeader.Validate("Posting Date", Today);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Header", OnAfterInsertEvent, '', false, false)]
    local procedure WarehouseActivityHeader_OnAfterInsertEvent(var Rec: Record "Warehouse Activity Header"; RunTrigger: Boolean)
    begin
        if Rec."Posting Date" <> Today then
            Rec.Validate("Posting Date", Today);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterSetupNewLine, '', false, false)]
    local procedure OnAfterSetupNewLine(var ItemJournalLine: Record "Item Journal Line"; var LastItemJournalLine: Record "Item Journal Line"; ItemJournalTemplate: Record "Item Journal Template"; ItemJnlBatch: Record "Item Journal Batch")
    begin
        if ItemJournalLine."Posting Date" <> Today then
            ItemJournalLine.Validate("Posting Date", Today);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", OnBeforeCode, '', false, false)]
    local procedure OnBeforeCode(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    begin
        if ItemJournalLine."Posting Date" <> Today then begin
            ItemJournalLine."Posting Date" := Today;
            ItemJournalLine.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", OnAfterConfirmPost, '', false, false)]
    local procedure PurchPost_OnAfterConfirmPost(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        if PurchaseHeader."Posting Date" <> Today then
            PurchaseHeader."Posting Date" := Today;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Inventory Pick", OnBeforePostPickYesNo, '', false, false)]
    local procedure OnBeforePostPickYesNo(var WarehouseActivityHeader: Record "Warehouse Activity Header")
    begin
        if WarehouseActivityHeader."Posting Date" <> Today then
            WarehouseActivityHeader."Posting Date" := Today;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePurchRcptLineInsert, '', false, false)]
    local procedure "Purch.-Post_OnBeforePurchRcptLineInsert"(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var IsHandled: Boolean; ItemLedgShptEntryNo: Integer)
    begin
        if PurchRcptLine."Expected Receipt Date" < PurchRcptLine."Posting Date" then
            PurchRcptLine."ERF Supplier OTD" := true
        else
            PurchRcptLine."ERF Supplier OTD" := false;
    end;



    var
        NotEnoughInventoryLbl: Label 'Pick Lines cannot create due to inventory';
        AlredyExistsPickLines: Label 'Pick Lines Already Exists';
}
