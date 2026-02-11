report 52112 "ERF Commission Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Commission Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/CommissionReport.rdl';

    dataset
    {
        dataitem(Buffer; "ERF Commission Buffer")
        {
            column(OrderNo; "Order No.") { }
            column(SalespersonCode; "Salesperson Code") { }
            column(CommissionBasis; "Commission Basis") { }
            column(CommissionPercent; "Commission %") { }
            column(CommissionAmount; "Commission Amount") { }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(FromDate; FromDate)
                    {
                        ApplicationArea = All;
                    }
                    field(ToDate; ToDate)
                    {
                        ApplicationArea = All;
                    }
                    field(CustomerNo; CustomerNo)
                    {
                        ApplicationArea = All;
                        TableRelation = Customer;
                    }
                    field(SalespersonCode; SalespersonCode)
                    {
                        ApplicationArea = All;
                        TableRelation = "Salesperson/Purchaser";
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        CalcMgt: Codeunit "ERF Commission Calculation Mgt";
    begin
        CalcMgt.BuildCommissionBuffer(
            FromDate,
            ToDate,
            CustomerNo,
            SalespersonCode,
            Buffer);
    end;

    var
        FromDate: Date;
        ToDate: Date;
        CustomerNo: Code[20];
        SalespersonCode: Code[20];
        BufferRec: Record "ERF Commission Buffer" temporary;
}
