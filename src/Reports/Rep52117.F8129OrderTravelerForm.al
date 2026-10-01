report 52117 "F-812-9 Order Traveler Form"
{
    ApplicationArea = All;
    Caption = 'F-812-9 Order Traveler Form';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/F8129OrderTravelerForm.rdl';

    dataset
    {
        dataitem(ProdOrderLine; "Prod. Order Line")
        {
            DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.") WHERE(Status = FILTER(Released));
            RequestFilterFields = "Prod. Order No.", "Line No.", Status;
            column(ProductionOrderNo; ProductionOrder."No.") { }
            column(AssignedTo; ProductionOrder."Assigned User ID") { }
            column(ItemPartNumber; ProdOrderLine."Item No.") { }
            column(Quantity; ProdOrderLine.Quantity) { }
            column(ReservationEntry_SerialNo; ReservationEntry."Serial No.") { }
            column(Picture; CompanyInformation.Picture) { }
            column(ProdOrderLine_LineNo; ProdOrderLine."Line No.") { }
            column(ProdOrderRoutingLine_OperationNo; ProdOrderRoutingLine."Operation No.") { }
            dataitem(ProdOrderCommentLine; "Prod. Order Line Comment Line")
            {
                DataItemLinkReference = ProdOrderLine;
                DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("Prod. Order No."), "Prod. Order Line No." = FIELD("Line No.");
                DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                column(Comment; Comment)
                { }
                column(LineNo; "Line No.")
                { }
                column(ProdOrderLineNo; "Prod. Order Line No.")
                { }
            }
            trigger OnAfterGetRecord()
            begin
                if ProductionOrder.Get(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.") then;

                ReservationEntry.SetRange("Source type", Database::"Prod. Order Line");
                ReservationEntry.SetRange("Source ID", ProductionOrder."No.");
                ReservationEntry.SetRange("Source Prod. Order Line", "Line No.");
                if ReservationEntry.FindFirst() then;

                ProdOrderRoutingLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                ProdOrderRoutingLine.SetRange(Status, ProductionOrder.Status);
                ProdOrderRoutingLine.SetRange("Routing Reference No.", ProdOrderLine."Line No.");
                if ProdOrderRoutingLine.FindLast() then;
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get('');
        CompanyInformation.CalcFields(Picture);
    end;

    var
        ReservationEntry: Record "Reservation Entry";
        CompanyInformation: Record "Company Information";
        ProdOrderLineRec: Record "Prod. Order Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        ProductionOrder: Record "Production Order";
}
