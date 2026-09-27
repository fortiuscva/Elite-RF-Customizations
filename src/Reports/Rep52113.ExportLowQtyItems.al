report 52113 "ERF Export Low Qty Items"
{
    ApplicationArea = All;
    Caption = 'Export Low Quantity Items';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnPreDataItem()
            begin
                if SendByEmail then begin
                    InventorySetup.Get();
                    InventorySetup.TestField("ERF Low Stock Item Email To");
                end;
                Clear(TempExcelBufferRecGbl);
                TempExcelBufferRecGbl.DeleteAll();

                TempExcelBufferRecGbl.AddColumn('Item No.', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Item Name', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Current Stock', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Safety Stock', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.NewRow();
            end;

            trigger OnAfterGetRecord()
            begin
                CalcFields(Inventory);
                if Inventory < "Safety Stock Quantity" then begin
                    LowStockFound := true;
                    TempExcelBufferRecGbl.AddColumn("No.", false, '', false, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                    TempExcelBufferRecGbl.AddColumn(Description, false, '', false, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                    TempExcelBufferRecGbl.AddColumn(Inventory, false, '', false, false, false, '', TempExcelBufferRecGbl."Cell Type"::Number);
                    TempExcelBufferRecGbl.AddColumn("Safety Stock Quantity", false, '', false, false, false, '', TempExcelBufferRecGbl."Cell Type"::Number);
                    TempExcelBufferRecGbl.NewRow();
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(SendByEmail; SendByEmail)
                    {
                        ApplicationArea = All;
                        Caption = 'Send by Email';
                        ToolTip = 'Specifies whether the generated Excel file should be sent by email.';
                    }
                }
            }
        }
    }
    trigger OnPostReport()
    begin
        if not LowStockFound then
            exit;

        if SendByEmail then
            SendEmail()
        else
            DownloadExcel();
    end;

    local procedure CreateExcelFile()
    begin
        FileName := 'LowStockItems.xlsx';
        Clear(TempExcelBufferRecGbl);

        TempExcelBufferRecGbl.CreateNewBook('Items With Qty Less than Safety Stock');
        TempExcelBufferRecGbl.WriteSheet('Items With Qty Less than Safety Stock', CompanyName, UserId);
        TempExcelBufferRecGbl.CloseBook();

        TempBlob.CreateOutStream(OutStr);
        TempExcelBufferRecGbl.SaveToStream(OutStr, true);
    end;

    local procedure DownloadExcel()
    begin
        CreateExcelFile();

        TempBlob.CreateInStream(InStr);

        DownloadFromStream(InStr, 'Download Excel', '', 'Excel Files (*.xlsx)|*.xlsx', FileName);
    end;

    local procedure SendEmail()
    var
        EmailTo: Text;
        EmailCCTo: Text;
        EmailSubject: Text;
        EnvironmentInformation: Codeunit "Environment Information";
        EnvironmentName: Text;
    begin
        EmailTo := InventorySetup."ERF Low Stock Item Email To";
        if InventorySetup."ERF Low Stock Item Email CC To" <> '' then
            EmailCCTo := InventorySetup."ERF Low Stock Item Email CC To";

        EnvironmentName := EnvironmentInformation.GetEnvironmentName();
        EmailSubject := StrSubstNo('[%1] Weekly Low Stock Report', EnvironmentName);

        CreateExcelFile();
        TempBlob.CreateInStream(InStr);

        Clear(EmailMsg);

        EmailMsg.Create(EmailTo, EmailSubject, 'Please find attached the weekly low stock items report.', true);
        /*
        EmailMsg.AddRecipient("Email Recipient Type"::Cc, 'clopez@eliterf.com');
        EmailMsg.AddRecipient("Email Recipient Type"::Cc, 'gwen@eliterf.com');
        EmailMsg.AddRecipient("Email Recipient Type"::Cc, 'het@eliterf.com');
        EmailMsg.AddRecipient("Email Recipient Type"::Cc, 'parthb@eliterf.com');
        */
        If EmailCCTo <> '' then
            AddCCRecipients(EmailMsg, EmailCCTo);
        EmailMsg.AddAttachment(FileName, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', InStr);
        Email.Send(EmailMsg);
    end;

    var
        TempExcelBufferRecGbl: Record "Excel Buffer" temporary;
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        InStr: InStream;
        OutStr: OutStream;
        LowStockFound: Boolean;
        SendByEmail: Boolean;

        InventorySetup: Record "Inventory Setup";


    local procedure AddCCRecipients(var EmailMsg: Codeunit "Email Message"; CCList: Text)
    var
        EmailAddress: Text;
    begin
        foreach EmailAddress in CCList.Split(';') do begin
            EmailAddress := DelChr(EmailAddress, '<>', ' ');
            if EmailAddress <> '' then
                EmailMsg.AddRecipient(
                Enum::"Email Recipient Type"::Cc,
                EmailAddress);
        end;
    end;

}
