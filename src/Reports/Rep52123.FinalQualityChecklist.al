report 52123 "ERF Final Quality Checklist"
{
    ApplicationArea = All;
    Caption = 'Final Quality Checklist';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Reports/Layouts/FinalQualityChecklist.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = where("Document Type" = const(Order));

            // RequestFilterFields = "No.", "Sell-to Customer No.", "Order Date";

            column(SalesOrderNo; "No.")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(CustomerNo; "Sell-to Customer No.")
            {
            }
            column(CustomerName; "Sell-to Customer Name")
            {
            }
            column(Picture; CompanyInformation.Picture) { }

            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                DataItemTableView = where(Type = const(Item), Quantity = filter(> 0));

                column(ItemNo; "No.")
                {
                }
                column(ItemDescription; Description)
                {
                }
                column(SerialNo; SerialNo)
                {
                }

                column(CheckedBy; CheckedBy)
                {
                }

                column(CheckDate; CheckDate)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    SerialNo := GetSerialNo(SalesLine);

                    CheckedBy := UserId;

                    CheckDate := Today;
                end;
            }
        }
    }
    labels
    {
        PartCaptionLbl = 'Part:';
        SNCaptionLbl = 'SN:';
        DateCaptionLbl = 'Date:';
        SOCaptionLbl = 'SO:';
        CheckedByCaptionLbl = 'Checked By:';
        NoOfUnitsCaptionLbl = 'No. Of Units';
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get('');
        CompanyInformation.CalcFields(Picture);
    end;

    procedure GetSerialNo(SalesLineRec: Record "Sales Line"): Code[50]
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        ReservationEntry.Reset();
        ReservationEntry.SetRange("Source Type", Database::"Sales Line");
        ReservationEntry.SetRange("Source ID", SalesLineRec."Document No.");
        ReservationEntry.SetRange("Source Ref. No.", SalesLineRec."Line No.");

        if ReservationEntry.FindFirst() then
            exit(ReservationEntry."Serial No.");

        exit('');
    end;

    var
        CompanyInformation: Record "Company Information";
        SerialNo: Code[50];
        CheckedBy: Code[50];
        CheckDate: Date;
}
