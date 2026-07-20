report 52118 "F-812-7 Quality Insp. Check"
{
    ApplicationArea = All;
    Caption = 'F-812-7 Quality Inspectio Checklist';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/F8127QualityInspectionCheckList.rdl';

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
            trigger OnAfterGetRecord()
            begin
                ReservationEntry.SetRange("Source type", Database::"Prod. Order Line");
                ReservationEntry.SetRange("Source ID", ProductionOrder."No.");
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
}