codeunit 52103 "ERF Equip. Calibration Mgmt."
{
    procedure CreateCalibrationHistoricalEntry(EquipCalibration: Record "ERF Equipment Calibration")
    var
        CalibrationHistory: Record "ERF Calibration History";
        EntryNo: Integer;
    begin
        CalibrationHistory.Reset();
        If CalibrationHistory.FindLast() then
            EntryNo := CalibrationHistory."Entry No." + 1
        else
            EntryNo := 1;

        CalibrationHistory.Init();
        CalibrationHistory."Entry No." := EntryNo;
        CalibrationHistory.Insert(true);
        CalibrationHistory.TransferFields(EquipCalibration);
        CalibrationHistory.Modify(true);
    end;
}
