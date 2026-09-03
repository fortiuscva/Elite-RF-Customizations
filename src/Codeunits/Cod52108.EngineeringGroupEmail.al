codeunit 52108 "ERF Engineering Group Email"
{
    procedure OpenEmailEditor(EngineeringGroup: Record "ERF Engineering Group")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EngineeringGroupLine: Record "ERF Engineering Group Line";
        Body: Text;
        Subject: Text;
    begin
        Subject := StrSubstNo('Engineering Group - %1', EngineeringGroup.Code);

        Body := StrSubstNo('Engineering Group: %1', EngineeringGroup.Code);

        Body += '<br>';

        Body += StrSubstNo('Description: %1', EngineeringGroup.Description);
        Body += '<br><br>';
        Body += '<b>Engineering Group Lines:</b><br><br>';
        Body += '<table style="border-collapse:collapse; width:100%;">';
        Body += '<tr>';
        Body += '<th style="text-align:left; padding:4px 0;">Notes</th>';
        Body += '</tr>';

        EngineeringGroupLine.SetRange(
            "Engineering Group Code",
            EngineeringGroup.Code);

        if EngineeringGroupLine.FindSet() then
            repeat
                Body += '<tr>';
                Body += StrSubstNo('<td style="text-align:left; padding:4px 0;">%1</td>', EngineeringGroupLine.Notes);
                Body += '</tr>';
            until EngineeringGroupLine.Next() = 0;

        Body += '</table>';

        Body += '<br><br>';
        Body += '<b>Thanks and Regards,</b><br>';
        Body += UserId;
        EmailMessage.Create('', Subject, Body, true);

        Email.OpenInEditorModally(EmailMessage);
    end;
}
