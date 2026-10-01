report 52122 "ERF Refresh Prod. Order Line"
{
    ApplicationArea = All;
    Caption = 'Refresh Prod. Order Line';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ProdOrderLine; "Prod. Order Line")
        {
            DataItemTableView = sorting(Status, "Prod. Order No.", "Line No.");

            RequestFilterFields = Status, "Prod. Order No.", "Line No.";

            trigger OnAfterGetRecord()
            begin
                RefreshRPOline(ProdOrderLine);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(Direction; Direction)
                    {
                        ApplicationArea = All;
                        Caption = 'Scheduling Direction';
                        ToolTip = 'Specifies the scheduling direction used when refreshing the production order line.';
                    }

                    field(CalcRouting; CalcRouting)
                    {
                        ApplicationArea = All;
                        Caption = 'Calculate Routing';
                        ToolTip = 'Specifies whether the routing should be recalculated.';
                    }

                    field(CalcComponents; CalcComponents)
                    {
                        ApplicationArea = All;
                        Caption = 'Calculate Components';
                        ToolTip = 'Specifies whether the components should be recalculated.';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            Direction := Direction::Backward;
            CalcRouting := true;
            CalcComponents := true;
        end;
    }

    trigger OnPreReport()
    begin
        if not ProdOrderLine.FindFirst() then
            Error('No Released Production Order Lines were selected.');
    end;

    var
        Direction: Option Forward,Backward;
        CalcRouting: Boolean;
        CalcComponents: Boolean;

        RefreshingLineLbl: Label 'Refreshing Production Order %1, Line %2...';
        CapacityLedgerEntryErr: Label
            'Production Order %1, Line %2 cannot be refreshed because Capacity Ledger Entries already exist for this line. Existing routing lines cannot be deleted.';
        ReservationErr: Label
            'Production Order %1, Line %2 cannot be refreshed because the line has reserved quantity.';
        RoutingMustBeCalculatedErr: Label
            'Routing must be calculated when refreshing the production order line.';
        ComponentNeedMustBeCalculatedErr: Label
            'Component Need must be calculated when refreshing the production order line.';


    procedure RefreshRPOline(var ProdOrderLine: Record "Prod. Order Line")
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        ProdOrderComponent: Record "Prod. Order Component";
        CalculateProdOrder: Codeunit "Calculate Prod. Order";
    begin
        ProdOrderLine.TestField(Status, ProdOrderLine.Status::Released);
        ProdOrderLine.TestField("Prod. Order No.");
        ProdOrderLine.TestField("Line No.");
        CheckReservation(ProdOrderLine);
        if CalcRouting then
            CheckCapacityLedgerEntries(ProdOrderLine);
        if CalcRouting then begin

            ProdOrderRoutingLine.Reset();

            ProdOrderRoutingLine.SetRange(Status, ProdOrderLine.Status);

            ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");

            ProdOrderRoutingLine.SetRange("Routing Reference No.", ProdOrderLine."Routing Reference No.");

            ProdOrderRoutingLine.SetRange("Routing No.", ProdOrderLine."Routing No.");

            if ProdOrderRoutingLine.FindSet(true) then
                repeat
                    ProdOrderRoutingLine.SetSkipUpdateOfCompBinCodes(true);
                    ProdOrderRoutingLine.Delete(true);
                until ProdOrderRoutingLine.Next() = 0;
        end;
        if CalcComponents then begin

            ProdOrderComponent.Reset();

            ProdOrderComponent.SetRange(Status, ProdOrderLine.Status);

            ProdOrderComponent.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");

            ProdOrderComponent.SetRange("Prod. Order Line No.", ProdOrderLine."Line No.");

            ProdOrderComponent.DeleteAll(true);
        end;

        if CalcComponents then
            CheckProductionBOMStatus(ProdOrderLine."Production BOM No.", ProdOrderLine."Production BOM Version Code");

        if CalcRouting then
            CheckRoutingStatus(ProdOrderLine."Routing No.", ProdOrderLine."Routing Version Code");

        CalculateProdOrder.Calculate(ProdOrderLine, Direction, CalcRouting, CalcComponents, false, false);

        ProdOrderLine.Modify(true);
    end;


    local procedure CheckCapacityLedgerEntries(ProdOrderLine: Record "Prod. Order Line")
    var
        CapacityLedgerEntry: Record "Capacity Ledger Entry";
    begin
        CapacityLedgerEntry.Reset();

        CapacityLedgerEntry.SetRange("Order Type", CapacityLedgerEntry."Order Type"::Production);

        CapacityLedgerEntry.SetRange("Order No.", ProdOrderLine."Prod. Order No.");

        CapacityLedgerEntry.SetRange("Order Line No.", ProdOrderLine."Line No.");

        if not CapacityLedgerEntry.IsEmpty() then
            Error(CapacityLedgerEntryErr, ProdOrderLine."Prod. Order No.", ProdOrderLine."Line No.");
    end;


    local procedure CheckReservation(ProdOrderLine: Record "Prod. Order Line")
    var
        ProdOrderComponent: Record "Prod. Order Component";
    begin
        // Check reservation on Production Order Line
        ProdOrderLine.CalcFields("Reserved Qty. (Base)");

        if ProdOrderLine."Reserved Qty. (Base)" <> 0 then
            Error(ReservationErr, ProdOrderLine."Prod. Order No.", ProdOrderLine."Line No.");

        ProdOrderComponent.Reset();

        ProdOrderComponent.SetRange(Status, ProdOrderLine.Status);

        ProdOrderComponent.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");

        ProdOrderComponent.SetRange("Prod. Order Line No.", ProdOrderLine."Line No.");

        ProdOrderComponent.SetAutoCalcFields("Reserved Qty. (Base)");

        if ProdOrderComponent.FindSet() then
            repeat
                if ProdOrderComponent."Reserved Qty. (Base)" <> 0 then
                    Error(ReservationErr, ProdOrderLine."Prod. Order No.", ProdOrderLine."Line No.");
            until ProdOrderComponent.Next() = 0;
    end;


    local procedure CheckProductionBOMStatus(ProductionBOMNo: Code[20]; ProductionBOMVersionNo: Code[20])
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


    local procedure CheckRoutingStatus(RoutingNo: Code[20]; RoutingVersionNo: Code[20])
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
}