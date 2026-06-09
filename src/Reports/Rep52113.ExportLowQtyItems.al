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
            var

            begin
                Clear(TempExcelBufferRecGbl);
                TempExcelBufferRecGbl.DeleteAll();

                TempExcelBufferRecGbl.AddColumn('Item No.', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Item Name', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Current Stock', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.AddColumn('Safety Stock', false, '', true, false, false, '', TempExcelBufferRecGbl."Cell Type"::Text);
                TempExcelBufferRecGbl.NewRow();
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
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
    trigger OnPostReport()
    begin
        if LowStockFound then
            SendEmail();
    end;

    procedure SendEmail()
    begin
        FileName := 'LowStockItems.xlsx';

        TempExcelBufferRecGbl.CreateNewBook('Items With Qty Less than Safety Stock');
        TempExcelBufferRecGbl.WriteSheet('Items With Qty Less than Safety Stock', CompanyName, UserId);
        TempExcelBufferRecGbl.CloseBook();

        TempExcelBufferRecGbl.SetFriendlyFilename('Items With Qty Less than Safety Stock');

        TempBlob.CreateOutStream(OutStr);
        TempExcelBufferRecGbl.SaveToStream(OutStr, true);
        TempBlob.CreateInStream(InStr);
        EmailMsg.Create('purchasing@eliterf.com',
           'Weekly Low Stock Report',
           'Please find attached the weekly low stock items report.', true);

        EmailMsg.AddAttachment(FileName,
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', InStr);

        Email.Send(EmailMsg);
    end;

    var
        TempExcelBufferRecGbl: Record "Excel Buffer" temporary;
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        FileName: Text;
        InStr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        LowStockFound: Boolean;
}
