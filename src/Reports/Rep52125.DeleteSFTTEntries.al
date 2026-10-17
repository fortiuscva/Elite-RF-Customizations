report 52125 "ERF Delete SFTT Entries"
{
    ApplicationArea = All;
    Caption = 'Delete SFTT Entries';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SFTTEntry; "ERF SFTT Entry")
        {
            RequestFilterFields = "Entry No.";
            trigger OnAfterGetRecord()
            begin
                SFTTEntry.Delete(true);
            end;
        }
    }
}
