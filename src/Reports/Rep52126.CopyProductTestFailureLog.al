report 52126 "Copy Product Test Failure Log "
{
    ApplicationArea = All;
    Caption = 'Copy Product Test Failure Log RevB to RevC';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(RevB; "ERF Product Test Failure Log")
        {
            DataItemTableView = sorting("Entry No.");

            trigger OnAfterGetRecord()
            begin
                if not RevC.Get(RevB."Entry No.") then begin
                    RevC.Init();
                    RevC.TransferFields(RevB);
                    RevC.Insert(true);

                    CopiedCount += 1;
                end;
            end;
        }
    }

    trigger OnPostReport()
    begin
        if CopiedCount > 0 then
            Message('%1 records copied successfully from Rev B to Rev C.', CopiedCount)
        else
            Message('No new records to copy. All records already exist in Rev C or Rev B is empty.');
    end;

    var
        RevC: Record "Product Test Failure Log Rev C";
        CopiedCount: Integer;
}
