codeunit 52106 "ERF User Task Email Handler"
{
    procedure SendTaskEmail(UserTask: Record "User Task")
    var
        UserRec: Record User;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        LogRec: Record "ERF User Task Email Log";
    begin
        if not UserRec.Get(UserTask."Assigned To") then
            exit;

        if UserRec."Contact Email" = '' then
            exit;

        EmailMessage.Create(
            UserRec."Contact Email",
            'New BC Task Assigned',
            'Please find your new BC task in BC under user tasks. Thanks, Elite RF Team',
            true
        );

        Email.Send(EmailMessage);

        LogRec.Init();
        LogRec."User Task ID" := Format(UserTask."ID");
        LogRec."Task Subject" := UserTask.Title;
        LogRec."Assigned To" := UserTask."Assigned To";
        LogRec."Email" := UserRec."Contact Email";
        LogRec."Sent DateTime" := CurrentDateTime();
        LogRec.Insert();
    end;
}
