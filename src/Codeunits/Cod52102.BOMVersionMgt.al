codeunit 52102 "ERF BOM Version Mgt"
{

    procedure CopyBOMVersion(TargetVersion: Record "Production BOM Version")
    var
        SourceVersion: Record "Production BOM Version";
        SourceBOMVersionLine: Record "Production BOM Line";
        TargetBOMVersionLine: Record "Production BOM Line";
        Item: Record Item;
        ActionChoice: Integer;
        NextLineNo: Integer;
    begin
        if not (TargetVersion.Status in [TargetVersion.Status::New, TargetVersion.Status::"Under Development"]) then
            Error('Target version %1 must be New or Under Development.', TargetVersion."Version Code");

        SourceVersion.Reset();
        //SourceVersion.SetFilter(Status, '%1|%2', SourceVersion.Status::New, SourceVersion.Status::"Under Development");
        if Page.RunModal(Page::"Prod. BOM Version List", SourceVersion) <> Action::LookupOK then
            exit;

        // if not (SourceVersion.Status in [SourceVersion.Status::New, SourceVersion.Status::"Under Development"]) then
        //     Error('Source version %1 must be New or Under Development.', SourceVersion."Version Code");

        if Item.Get(SourceVersion."Production BOM No.") then
            if Item.Blocked then
                Error('Source item %1 is not active.', Item."No.");

        TargetBOMVersionLine.Reset();
        TargetBOMVersionLine.SetRange("Production BOM No.", TargetVersion."Production BOM No.");
        TargetBOMVersionLine.SetRange("Version Code", TargetVersion."Version Code");
        if not TargetBOMVersionLine.IsEmpty() then begin
            ActionChoice := Dialog.STRMENU(
                'Replace existing lines,Append to existing lines,Cancel',
                1,
                'Target version already contains component lines. Choose an action:');
            case ActionChoice of
                1:
                    DeleteExistingLines(TargetVersion);
                2:
                    ;
                else
                    exit;
            end;
        end;

        SourceBOMVersionLine.SetRange("Production BOM No.", SourceVersion."Production BOM No.");
        SourceBOMVersionLine.SetRange("Version Code", SourceVersion."Version Code");

        if SourceBOMVersionLine.FindSet() then begin
            NextLineNo := GetNextLineNo(TargetVersion);
            repeat
                TargetBOMVersionLine.Init();
                TargetBOMVersionLine.TransferFields(SourceBOMVersionLine);
                TargetBOMVersionLine."Production BOM No." := TargetVersion."Production BOM No.";
                TargetBOMVersionLine."Version Code" := TargetVersion."Version Code";
                TargetBOMVersionLine."Line No." := NextLineNo;
                TargetBOMVersionLine.Insert();
                NextLineNo += 10000;
            until SourceBOMVersionLine.Next() = 0;
        end;
    end;

    local procedure DeleteExistingLines(TargetVersion: Record "Production BOM Version")
    var
        TargetBOMVersionLine: Record "Production BOM Line";
    begin
        TargetBOMVersionLine.SetRange("Production BOM No.", TargetVersion."Production BOM No.");
        TargetBOMVersionLine.SetRange("Version Code", TargetVersion."Version Code");
        if TargetBOMVersionLine.FindSet() then
            TargetBOMVersionLine.DeleteAll();
    end;

    local procedure GetNextLineNo(TargetVersion: Record "Production BOM Version"): Integer
    var
        TargetBOMVersionLine: Record "Production BOM Line";
    begin
        TargetBOMVersionLine.SetRange("Production BOM No.", TargetVersion."Production BOM No.");
        TargetBOMVersionLine.SetRange("Version Code", TargetVersion."Version Code");
        if TargetBOMVersionLine.FindLast() then
            exit(TargetBOMVersionLine."Line No." + 10000)
        else
            exit(10000);
    end;
}
