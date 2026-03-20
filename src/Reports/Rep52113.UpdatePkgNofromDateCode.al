report 52113 "Update Pkg. No from Date Code"
{
    ApplicationArea = All;
    Caption = 'Update Package No. from Date Code';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    trigger OnPreReport()
    var
        ReservEntry: Record "Reservation Entry";
        UpdatedCount: Integer;
    begin
        UpdatedCount := 0;
        ReservEntry.LockTable();

        if ReservEntry.FindSet() then begin
            repeat
                if (ReservEntry.Description <> '') and (ReservEntry."Package No." = '') then begin
                    ReservEntry."Package No." := ReservEntry.Description;
                    ReservEntry.Modify(true);
                    UpdatedCount += 1;
                end;
            until ReservEntry.Next() = 0;
        end;

        Message('%1 records updated successfully.', UpdatedCount);
    end;
}
