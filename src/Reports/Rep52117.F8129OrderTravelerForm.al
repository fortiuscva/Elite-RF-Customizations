report 52117 "F-812-9 Order Traveler Form"
{
    ApplicationArea = All;
    Caption = 'F-812-9 Order Traveler Form';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/F8129OrderTravelerForm.rdl';

    dataset
    {
        dataitem(ProductionOrder; "Production Order")
        {
            RequestFilterFields = "No.";
            column(ProductionOrderNo; "No.") { }
            column(AssignedTo; "Assigned User ID") { }
            column(ItemPartNumber; "Source No.") { }
            column(Quantity; Quantity) { }
            column(ReservationEntry_SerialNo; ReservationEntry."Serial No.") { }
            column(Picture; CompanyInformation.Picture) { }
            column(ProdOrderLine_LineNo; ProdOrderLine."Line No.") { }
            column(ProdOrderRoutingLine_OperationNo; ProdOrderRoutingLine."Operation No.") { }

            dataitem(ProdOrderCommentLine; "Prod. Order Comment Line")
            {
                DataItemLinkReference = ProductionOrder;
                DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.");
                column(Comment; Comment)
                { }
                column(LineNo; "Line No.")
                { }
            }
            trigger OnAfterGetRecord()
            begin
                ReservationEntry.SetRange("Source type", Database::"Prod. Order Line");
                ReservationEntry.SetRange("Source ID", ProductionOrder."No.");
                if ReservationEntry.FindFirst() then;

                ProdOrderLine.SetRange(Status, ProductionOrder.Status);
                ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                if ProdOrderLine.FindFirst() then;

                ProdOrderRoutingLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                ProdOrderRoutingLine.SetRange(Status, ProductionOrder.Status);
                ProdOrderRoutingLine.SetRange("Routing Reference No.", ProdOrderLine."Line No.");
                if ProdOrderRoutingLine.FindFirst() then;
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
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
}
