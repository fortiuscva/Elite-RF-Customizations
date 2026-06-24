report 52116 "ERF On Time Delivery Report"
{
    ApplicationArea = All;
    Caption = 'On Time Delivery Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/OnTimeDeliveryReport.rdl';

    dataset
    {
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
        {
            RequestFilterFields = "Posting Date", "Sell-to Customer No.", "No.";

            column(PostingDate; "Posting Date") { }
            column(ShipmentNo; "No.") { }
            column(CustomerNo; "Sell-to Customer No.") { }
            column(CustomerName; "Sell-to Customer Name") { }
            column(OnTimeShipment; "ERF On Time Shipment") { }
            column(CompanyName; CompanyName) { }
            column(Filters; SalesShipmentHeader.GetFilters) { }

            dataitem(SalesShipmentLine; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = sorting("Document No.", "Line No.") WHERE(Type = CONST(Item));

                column(SalesOrderNo; "Order No.") { }
                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(SalesOrderLineNo; "Order Line No.") { }
                column(ShipmentQty; Quantity) { }
                column(ShipmentLineAmount; ShipmentLineAmount) { }
                column(PrepaymentAmount; PrepaymentAmount) { }
                column(TotalShipValue; TotalShipValue) { }

                trigger OnAfterGetRecord()
                begin
                    CalculateAmounts();
                end;
            }
        }
    }

    requestpage
    { }

    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        ShipmentLineAmount: Decimal;
        PrepaymentAmount: Decimal;
        TotalShipValue: Decimal;

    local procedure CalculateAmounts()
    var
        PostedSalesShipmentLine: Record "Sales Shipment Line";
    begin
        ShipmentLineAmount := 0;
        PrepaymentAmount := 0;

        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Order No.", SalesShipmentLine."Order No.");
        SalesInvoiceLine.SetRange("Order Line No.", SalesShipmentLine."Order Line No.");
        if SalesInvoiceLine.FindSet() then
            repeat
                ShipmentLineAmount += SalesInvoiceLine.Amount;
            until SalesInvoiceLine.Next() = 0;

        PostedSalesShipmentLine.Reset();
        PostedSalesShipmentLine.SetRange("Document No.", SalesShipmentLine."Document No.");
        PostedSalesShipmentLine.SetRange(Type, PostedSalesShipmentLine.Type::Resource);
        PostedSalesShipmentLine.SetRange("No.", 'PREPAY');
        if PostedSalesShipmentLine.FindFirst() then begin
            SalesInvoiceLine.Reset();
            SalesInvoiceLine.SetRange("Order No.", PostedSalesShipmentLine."Order No.");
            SalesInvoiceLine.SetRange("Order Line No.", PostedSalesShipmentLine."Order Line No.");
            SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Resource);
            SalesInvoiceLine.SetRange("No.", 'PREPAY');
            if SalesInvoiceLine.FindSet() then
                repeat
                    PrepaymentAmount += SalesInvoiceLine.Amount;
                until SalesInvoiceLine.Next() = 0;
        end;

        TotalShipValue := ShipmentLineAmount + PrepaymentAmount;
    end;
}