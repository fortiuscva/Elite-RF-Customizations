report 52125 "F-812-10 Incoming Quality IC"
{
    ApplicationArea = All;
    Caption = 'F-812-10 Incoming Quality Inspection Checklist';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/F81210QualityInspectionCheckList.rdl';
    dataset
    {
        dataitem(PurchaseLine; "Purchase Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

            RequestFilterFields = "Document No.", "Line No.", Type, "No.";
            column(Picture; CompanyInformation.Picture)
            { }
            column(PONo; "Document No.")
            { }
            column(PartNo; "No.")
            { }
        }
    }
    labels
    {
        PONoLblCaption = 'Purchase Order:';
        PartNoLblCaption = 'Part Number:';
        ReceivedQuantitiesLotLblCaption = 'Received Quantities (Lot):';
        InspectedQunatitiesLotLblCaption = 'Inspected Quantities (Lot):';

    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
}