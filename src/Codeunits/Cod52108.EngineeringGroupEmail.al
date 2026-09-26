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

        EngineeringGroupLine.Reset();
        EngineeringGroupLine.SetRange("Engineering Group Code", EngineeringGroup.Code);
        EngineeringGroupLine.SetRange(Selected, true);
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

        EngineeringGroupLine.Reset();
        EngineeringGroupLine.SetRange("Engineering Group Code", EngineeringGroup.Code);
        EngineeringGroupLine.SetRange(Selected, true);
        if EngineeringGroupLine.FindSet() then
            repeat
                AddLineAttachments(EmailMessage, EngineeringGroupLine);
            until EngineeringGroupLine.Next() = 0;

        Email.OpenInEditorModally(EmailMessage);
    end;

    local procedure AddLineAttachments(var EmailMessage: Codeunit "Email Message"; EngineeringGroupLine: Record "ERF Engineering Group Line")
    var
        DocumentAttachment: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        OutStream: OutStream;
        AttachmentBase64: Text;
        ContentType: Text;
    begin
        DocumentAttachment.Reset();

        DocumentAttachment.SetRange("Table ID", Database::"ERF Engineering Group Line");
        DocumentAttachment.SetRange("No.", EngineeringGroupLine."Attachment No.");
        if DocumentAttachment.FindSet() then
            repeat
                Clear(TempBlob);
                Clear(AttachmentBase64);

                TempBlob.CreateOutStream(OutStream);

                DocumentAttachment.ExportToStream(OutStream);
                TempBlob.CreateInStream(InStream);

                AttachmentBase64 := Base64Convert.ToBase64(InStream);

                ContentType := GetContentType(DocumentAttachment."File Name");

                EmailMessage.AddAttachment(DocumentAttachment."File Name", ContentType, AttachmentBase64);

            until DocumentAttachment.Next() = 0;
    end;


    local procedure GetContentType(FileName: Text): Text
    var
        FileManagement: Codeunit "File Management";
        Extension: Text;
    begin
        Extension := LowerCase(FileManagement.GetExtension(FileName));

        case Extension of
            'pdf':
                exit('application/pdf');

            'doc':
                exit('application/msword');

            'docx':
                exit('application/vnd.openxmlformats-officedocument.wordprocessingml.document');

            'xls':
                exit('application/vnd.ms-excel');

            'xlsx':
                exit(
                    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

            'ppt':
                exit('application/vnd.ms-powerpoint');

            'pptx':
                exit('application/vnd.openxmlformats-officedocument.presentationml.presentation');

            'txt':
                exit('text/plain');

            'csv':
                exit('text/csv');

            'xml':
                exit('application/xml');

            'json':
                exit('application/json');

            'png':
                exit('image/png');

            'jpg', 'jpeg':
                exit('image/jpeg');

            'gif':
                exit('image/gif');

            'bmp':
                exit('image/bmp');

            'zip':
                exit('application/zip');

            else
                exit('application/octet-stream');
        end;
    end;
}