pageextension 52149 "ERF Released Prod. Order Lines" extends "Released Prod. Order Lines"
{
    actions
    {
        addlast("&Line")
        {
            action("ERF Comments")
            {
                Caption = 'Comments';
                ApplicationArea = All;
                Image = Comment;

                trigger OnAction()
                var
                    RPOCommentLine: Record "Prod. Order Line Comment Line";
                begin
                    RPOCommentLine.Reset();
                    RPOCommentLine.SetRange(Status, Rec.Status);
                    RPOCommentLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
                    RPOCommentLine.SetRange("Prod. Order Line No.", Rec."Line No.");

                    Page.Run(Page::"Prod. Order Line Comment Sheet", RPOCommentLine);
                end;
            }
            action("ERF Critical Inspection Comments")
            {
                Caption = 'Critical Inspection Comments';
                ApplicationArea = All;
                Image = Comment;

                trigger OnAction()
                var
                    CriticalInspecComment: Record "Critical Inspection Comment";
                begin
                    CriticalInspecComment.Reset();
                    CriticalInspecComment.SetRange(Status, Rec.Status);
                    CriticalInspecComment.SetRange("Prod. Order No.", Rec."Prod. Order No.");
                    CriticalInspecComment.SetRange("Prod. Order Line No.", Rec."Line No.");

                    Page.Run(Page::"Critical Inspection Cmt. Sheet", CriticalInspecComment);
                end;
            }
            action("ERF Create Inventory Pick")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Create Inventory Pick';
                Image = CreateWarehousePick;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Create and print an inventory pick for the selected production order line.';

                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                begin
                    CurrPage.SaveRecord();
                    CreateInventoryPick(Rec);
                end;
            }
            action("ERF OrderTravellerForm")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Order Traveller Form';
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ProdOrderLine: Record "Prod. Order Line";
                begin
                    CurrPage.SetSelectionFilter(ProdOrderLine);
                    Report.RunModal(Report::"F-812-9 Order Traveler Form", true, false, ProdOrderLine);
                end;
            }
            action("ERF SubQualityInspectionChecklist")
            {
                ApplicationArea = Manufacturing;
                Caption = 'SUBA Quality Inspection Checklist';
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ProdOrderLine: Record "Prod. Order Line";
                begin
                    CurrPage.SetSelectionFilter(ProdOrderLine);
                    Report.RunModal(Report::"F-812-7 Quality Insp. Check", true, false, ProdOrderLine);
                end;
            }
            action("ERF PCBAQualityInspectionChecklist")
            {
                ApplicationArea = Manufacturing;
                Caption = 'PCBA Quality Inspection Checklist';
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ProdOrderLine: Record "Prod. Order Line";
                begin
                    CurrPage.SetSelectionFilter(ProdOrderLine);
                    Report.RunModal(Report::"ERF F-812-7 Quality Insp. PCBA", true, false, ProdOrderLine);
                end;
            }
            action("ERF RefreshRPOLine")
            {
                Caption = 'Refresh Released Production Order Line';
                ApplicationArea = All;
                Image = RefreshLines;
                ToolTip = 'Refresh the selected released production order line without refreshing the entire production order.';

                trigger OnAction()
                var
                    ProdOrderLine: Record "Prod. Order Line";
                begin
                    CurrPage.SetSelectionFilter(ProdOrderLine);

                    if ProdOrderLine.IsEmpty() then
                        Error('Please select at least one production order line.');

                    Report.RunModal(Report::"ERF Refresh Prod. Order Line", true, false, ProdOrderLine);

                    CurrPage.Update(false);
                end;
            }

        }
    }
    procedure RefreshRPOline(var ProdOrderLine: Record "Prod. Order Line")
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        ProdOrderComponent: Record "Prod. Order Component";
        CalculateProdOrder: Codeunit "Calculate Prod. Order";
        Direction: Option Forward,Backward;
        IsHandled: Boolean;
    begin
        ProdOrderLine.TestField(Status, ProdOrderLine.Status::Released);

        ProdOrderLine.TestField("Prod. Order No.");
        ProdOrderLine.TestField("Line No.");

        Direction := Direction::Backward;

        ProdOrderRoutingLine.SetRange(Status, ProdOrderLine.Status);

        ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");

        ProdOrderRoutingLine.SetRange("Routing Reference No.", ProdOrderLine."Routing Reference No.");

        ProdOrderRoutingLine.SetRange("Routing No.", ProdOrderLine."Routing No.");

        if ProdOrderRoutingLine.FindSet(true) then
            repeat
                ProdOrderRoutingLine.SetSkipUpdateOfCompBinCodes(true);
                ProdOrderRoutingLine.Delete(true);
            until ProdOrderRoutingLine.Next() = 0;

        ProdOrderComponent.SetRange(Status, ProdOrderLine.Status);

        ProdOrderComponent.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");

        ProdOrderComponent.SetRange("Prod. Order Line No.", ProdOrderLine."Line No.");

        ProdOrderComponent.DeleteAll(true);

        CheckProductionBOMStatus(ProdOrderLine."Production BOM No.", ProdOrderLine."Production BOM Version Code");
        CheckRoutingStatus(ProdOrderLine."Routing No.", ProdOrderLine."Routing Version Code");

        ProdOrderLine."Due Date" := ProdOrderLine."Due Date";

        CalculateProdOrder.Calculate(ProdOrderLine, Direction, true, true, false, false);

        ProdOrderLine.Modify(true);

    end;


    procedure CheckProductionBOMStatus(ProductionBOMNo: Code[20]; ProductionBOMVersionNo: Code[20])
    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMVersion: Record "Production BOM Version";
    begin
        if ProductionBOMNo = '' then
            exit;

        if ProductionBOMVersionNo = '' then begin
            ProductionBOMHeader.SetLoadFields(Status);
            ProductionBOMHeader.Get(ProductionBOMNo);
            ProductionBOMHeader.TestField(Status, ProductionBOMHeader.Status::Certified);
        end else begin
            ProductionBOMVersion.SetLoadFields(Status);
            ProductionBOMVersion.Get(ProductionBOMNo, ProductionBOMVersionNo);

            ProductionBOMVersion.TestField(Status, ProductionBOMVersion.Status::Certified);
        end;
    end;


    procedure CheckRoutingStatus(RoutingNo: Code[20]; RoutingVersionNo: Code[20])
    var
        RoutingHeader: Record "Routing Header";
        RoutingVersion: Record "Routing Version";
    begin
        if RoutingNo = '' then
            exit;

        if RoutingVersionNo = '' then begin
            RoutingHeader.SetLoadFields(Status);
            RoutingHeader.Get(RoutingNo);
            RoutingHeader.TestField(Status, RoutingHeader.Status::Certified);
        end else begin
            RoutingVersion.SetLoadFields(Status);
            RoutingVersion.Get(RoutingNo, RoutingVersionNo);

            RoutingVersion.TestField(Status, RoutingVersion.Status::Certified);
        end;
    end;

    procedure CreateInventoryPick(var ProdOrderLine: Record "Prod. Order Line")
    var
        WhseRequest: Record "Warehouse Request";
        CreateInvtPutAwayPick: Report "Create Invt Put-away/Pick/Mvmt";
        SingleInstanceCU: Codeunit "ERF Single Instance";
    begin
        ValidateProdOrderLine(ProdOrderLine);

        WhseRequest.Reset();
        WhseRequest.SetCurrentKey("Source Document", "Source No.");
        WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Prod. Consumption");
        WhseRequest.SetRange("Source No.", ProdOrderLine."Prod. Order No.");

        if WhseRequest.IsEmpty() then
            Error('No Warehouse Request exists for Production Order %1.', ProdOrderLine."Prod. Order No.");

        SingleInstanceCU.SetSelectedProdOrderLine(ProdOrderLine);
        CreateInvtPutAwayPick.SetTableView(WhseRequest);
        CreateInvtPutAwayPick.InitializeRequest(false, true, false, true, true);

        // CreateInvtPutAwayPick.UseRequestPage(false);

        CreateInvtPutAwayPick.RunModal();
        SingleInstanceCU.ClearSelectedProdOrderLine();
    end;


    procedure ValidateProdOrderLine(ProdOrderLine: Record "Prod. Order Line")
    begin
        if ProdOrderLine.Status <> ProdOrderLine.Status::Released then
            Error('Inventory Pick can only be created for a Released Production Order.');

        ProdOrderLine.TestField("Prod. Order No.");
        ProdOrderLine.TestField("Line No.");
        ProdOrderLine.TestField("Item No.");
        ProdOrderLine.TestField("Location Code");

        if ProdOrderLine."Remaining Quantity" <= 0 then
            Error('There is no remaining quantity for Production Order %1, Line %2.', ProdOrderLine."Prod. Order No.", ProdOrderLine."Line No.");
    end;

}