tableextension 52116 "User Task" extends "User Task"
{
    fields
    {
        modify("Assigned To")
        {
            trigger OnAfterValidate()
            var
                ConfirmSend: Boolean;
                EmailHandler: Codeunit "ERF User Task Email Handler";
            begin
                if Rec."Assigned To" = xRec."Assigned To" then
                    exit;

                if IsNullGuid(Rec."Assigned To") then
                    exit;

                if not GuiAllowed then
                    exit;

                ConfirmSend := Confirm(
                    'Do you want to send an email notification to the assigned user?',
                    false
                );

                if not ConfirmSend then
                    exit;

                EmailHandler.SendTaskEmail(Rec);
            end;
        }
    }
}
