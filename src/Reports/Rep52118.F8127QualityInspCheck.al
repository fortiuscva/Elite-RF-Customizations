report 52118 "F-812-7 Quality Insp. Check"
{
    ApplicationArea = All;
    Caption = 'F-812-7 Quality Inspectio Checklist';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/F8127QualityInspectionCheckList.rdl';

    dataset
    {
        dataitem(ProdOrderLine; "Prod. Order Line")
        {
            DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.") WHERE(Status = FILTER(Released));
            RequestFilterFields = "Prod. Order No.", "Line No.", Status;
            column(ProductionOrderNo; ProdOrderLine."Prod. Order No.") { }
            column(AssignedTo; ProductionOrder."Assigned User ID") { }
            column(ItemPartNumber; ProdOrderLine."Item No.") { }
            column(Quantity; Quantity) { }
            column(ReservationEntry_SerialNo; ReservationEntry."Serial No.") { }
            column(Picture; CompanyInformation.Picture) { }
            dataitem(ProdOrderCommentLine; "Critical Inspection Comment")
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
        ProductionOrder: Record "Production Order";
}