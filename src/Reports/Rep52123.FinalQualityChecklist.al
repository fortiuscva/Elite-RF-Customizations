report 52123 "ERF Final Quality Checklist"
{
    ApplicationArea = All;
    Caption = 'Final Quality Checklist';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Reports/Layouts/FinalQualityChecklist.rdl';

    dataset
    {
        dataitem(SalesLine; "Sales Line")
        {
            DataItemTableView = where("Document Type" = const(Order), Type = const(Item));
            RequestFilterFields = "Document Type", "Document No.", "Line No.", Type, "No.";
            dataitem(SalesHeader; "Sales Header")
            {
                DataItemLink = "Document Type" = field("Document Type"), "No." = field("Document No.");

                column(SalesOrderNo; "No.")
                { }
                column(Picture; CompanyInformation.Picture)
                { }
            }

            column(ItemNo; SalesLine."No.")
            { }
            column(LineNo; SalesLine."Line No.")
            { }
            column(SerialNo; SerialNo)
            { }
            column(CheckedBy; CheckedBy)
            { }
            column(CheckDate; CheckDate)
            { }

            trigger OnAfterGetRecord()
            begin
                SerialNo := GetSerialNo(SalesLine);
                CheckedBy := UserId;
                CheckDate := Today;
            end;
        }
    }

    labels
    {
        PartCaptionLbl = 'Part:';
        SNCaptionLbl = 'SN:';
        DateCaptionLbl = 'Date:';
        SOCaptionLbl = 'SO:';
        CheckedByCaptionLbl = 'Checked By:';
        NoOfUnitsCaptionLbl = 'No. Of Units:';
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get('');
        CompanyInformation.CalcFields(Picture);

        Clear(SerialNo);
        Clear(CheckedBy);
        Clear(CheckDate);
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