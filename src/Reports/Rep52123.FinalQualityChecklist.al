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
            // Sales Line Comments
            dataitem(SalesCommentLine; "Sales Comment Line")
            {
                DataItemLink =
                    "Document Type" = field("Document Type"),
                    "No." = field("Document No."),
                    "Document Line No." = field("Line No.");

                DataItemTableView = sorting(
                    "Document Type", "No.",
                    "Document Line No.", "Line No.");

                column(LineComment; '• ' + SalesCommentLine.Comment)
                { }
                column(LineCommentDate; Date) { }
                column(CommentLineNo; "Line No.") { }
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
            column(Qty_to_Ship; "Qty. to Ship")
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
        LineCommentCaptionLbl = 'Critical Check Points:';
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
        SerialNoList: Text;
    begin
        ReservationEntry.Reset();
        ReservationEntry.SetRange("Source Type", Database::"Sales Line");
        ReservationEntry.SetRange("Source ID", SalesLineRec."Document No.");
        ReservationEntry.SetRange("Source Ref. No.", SalesLineRec."Line No.");
        ReservationEntry.SetRange("Reservation Status", ReservationEntry."Reservation Status"::Surplus, ReservationEntry."Reservation Status"::Prospect);

        if ReservationEntry.FindSet() then
            repeat
                if ReservationEntry."Serial No." <> '' then begin
                    if SerialNoList <> '' then
                        SerialNoList += ', ';

                    SerialNoList += ReservationEntry."Serial No.";
                end;
            until ReservationEntry.Next() = 0;

        exit(SerialNoList);

        exit('');
    end;

    var
        CompanyInformation: Record "Company Information";
        SerialNo: Code[50];
        CheckedBy: Code[50];
        CheckDate: Date;
}