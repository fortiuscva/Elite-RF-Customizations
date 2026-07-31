report 52120 "ERF Employee Badge"
{
    ApplicationArea = All;
    Caption = 'Employee Badge ';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/ERFEmployeeBarcode.rdl';
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", "Search Name";
            column(No; "No.")
            {
            }
            column(SearchName; "Search Name")
            {
            }
            column(EmpBarCodeCaption; EmpBarcodeCaptionLbl)
            { }
            column(CompanyName; CompanyName)
            { }
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
    var
        EmpBarcodeCaptionLbl: Label 'Employee Barcode';

}
