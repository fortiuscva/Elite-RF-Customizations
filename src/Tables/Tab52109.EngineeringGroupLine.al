table 52109 "ERF Engineering Group Line"
{
    Caption = 'Engineering Group Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Engineering Group Code"; Code[20])
        {
            Caption = 'Engineering Group';
            DataClassification = CustomerContent;

            TableRelation = "ERF Engineering Group".Code;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }

        field(3; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = CustomerContent;
        }
        field(4; Selected; Boolean)
        {
            Caption = 'Selected';
            DataClassification = CustomerContent;
        }
        field(5; "Attachment No."; Code[20])
        {
            Caption = 'Attachment No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Engineering Group Code", "Line No.")
        {
            Clustered = true;
        }
        key(AttachmentKey; "Attachment No.")
        {
        }
    }
    trigger OnInsert()
    begin
        if "Line No." = 0 then
            "Line No." := GetNextLineNo();

        SetAttachmentNo();
    end;

    local procedure GetNextLineNo(): Integer
    var
        EngineeringGroupLine: Record "ERF Engineering Group Line";
    begin
        EngineeringGroupLine.SetRange("Engineering Group Code", "Engineering Group Code");
        if EngineeringGroupLine.FindLast() then
            exit(EngineeringGroupLine."Line No." + 10000);

        exit(10000);
    end;

    local procedure SetAttachmentNo()
    var
        GuidText: Text;
    begin
        if "Attachment No." <> '' then
            exit;

        GuidText := DelChr(Format(CreateGuid()), '=', '{}-');

        "Attachment No." := CopyStr(GuidText, 1, MaxStrLen("Attachment No."));
    end;
}