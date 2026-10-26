report 52124 "Non Conforming Material Form"
{
    ApplicationArea = All;
    Caption = 'Non-Conforming Material Form';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/NCMForm.rdl';
    dataset
    {
        dataitem(SalesLine; "Sales Line")
        {
            DataItemTableView = where("Document Type" = const("Return Order"));
            RequestFilterFields = "Document Type", "Document No.", "Line No.", Type, "No.";
            column(PartNo; "No.")
            { }
            column(Qty; Quantity)
            { }
            column(Picture; CompanyInformation.Picture)
            { }
            column(CustomerName; CustomerName)
            { }

            column(ExternalDocNo; ExternalDocNo)
            { }
            trigger OnAfterGetRecord()

            begin
                if SalesHeader."No." = SalesLine."Document No." then
                    exit;

                SalesHeader.Reset();
                if SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then begin
                    CustomerName := SalesHeader."Sell-to Customer Name";
                    ExternalDocNo := SalesHeader."External Document No.";
                end;
            end;
        }
    }
    labels
    {
        NCMCaptionLbl = 'Nonconforming Material (NCM)';
        FormNoCaptionLbl = 'Form Number';
        FormRevCaptionLbl = 'Form Rev';
        PageCaptionLbl = 'Page';
        InitiatedByCaptionLbl = 'Initiated By:';
        DateCaptionLbl = 'Date:';
        CustomerNameCaptionLbl = 'Customer Name:';
        NCMNoCaptionLbl = 'NCM No.:';
        PartPOCaptionLbl = 'Part/PO #:';
        RevCaptionLbl = 'Rev.';
        TravelerJobCaptionLbl = 'Traveler/Job#:';
        QtyCaptionLbl = 'Qty:';
        WhereFoundCaptionLbl = 'Where Found:';
        RMACaptionLbl = 'RMA#(If applicable):';
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get('');
        CompanyInformation.CalcFields(Picture);
    end;

    var
        SalesHeader: Record "Sales Header";
        CompanyInformation: Record "Company Information";
        CustomerName: Text;
        ExternalDocNo: Code[35];
}
