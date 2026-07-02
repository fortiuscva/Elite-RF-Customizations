report 52115 "ERF PO Overdue Report"
{
    ApplicationArea = All;
    Caption = 'ERF PO Overdue Report';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(PurchaseLine; "Purchase Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.")
                                where("Document Type" = const(Order));
            trigger OnPreDataItem()
            begin
                SetFilter("Outstanding Quantity", '>0');
                SetFilter("Expected Receipt Date", '<%1', Today);

                TempExcelBufferRecGbl.NewRow();

                TempExcelBufferRecGbl.AddColumn('PO No.', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Vendor No.', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Item No.', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Description', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Outstanding Qty', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Expected Receipt Date', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);

            end;

            trigger OnAfterGetRecord()
            begin
                TempExcelBufferRecGbl.NewRow();

                TempExcelBufferRecGbl.AddColumn("Document No.", false, '', false, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn("Buy-from Vendor No.", false, '', false, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn("No.", false, '', false, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn(Description, false, '', false, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn("Outstanding Quantity", false, '', false, false, false, '', TempExcelBufferRecGbl."Cell Type"::Number);
                TempExcelBufferRecGbl.AddColumn("Expected Receipt Date", false, '', false, false, false, '', TempExcelBufferRecGbl."Cell Type"::Date);
            end;

        }
    }
    trigger OnPostReport()
    begin
        FileName := 'PO Overdue Report.xlsx';
        TempExcelBufferRecGbl.CreateNewBook('PO Overdue Report');
        TempExcelBufferRecGbl.WriteSheet('PO Overdue Report', CompanyName, UserId);
        TempExcelBufferRecGbl.CloseBook();


        TempBlob.CreateOutStream(OutStr);
        TempExcelBufferRecGbl.SaveToStream(OutStr, true);
        TempBlob.CreateInStream(InStr);
        DownloadFromStream(InStr, 'Download Excel', '', 'Excel Files (*.xlsx)|*.xlsx', FileName);

        SendEmail();
    end;

    local procedure SendEmail()
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
    begin
        TempBlob.CreateInStream(InStr);

        EmailMessage.Create(
            'purchasing@eliterf.com',
            'PO Overdue Report',
            'Please find attached the weekly PO Overdue Report.',
            true);

        EmailMessage.AddAttachment(
            'PO Overdue Report.xlsx',
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            InStr);

        Email.Send(EmailMessage);
    end;

    var
        TempExcelBufferRecGbl: Record "Excel Buffer" temporary;
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        FileName: Text;
        InStr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
}
