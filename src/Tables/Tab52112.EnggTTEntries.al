table 52112 "ERF Engg. TT Entries"
{
    Caption = 'Engineering Time Tracking Entries';
    DataCaptionFields = "Employee Name", "Project Description", "Project Task Description";
    DrillDownPageId = "ERF Engg. TT Entries";
    LookupPageId = "ERF Engg. TT Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = True;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(3; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(4; "Project No."; Code[20])
        {
            Caption = 'Project No.';
            DataClassification = CustomerContent;
            TableRelation = Job;
            trigger OnValidate()
            var
                Job: Record Job;
            begin
                if (("Project No." <> xRec."Project No.") or ("Project No." = '')) then
                    "Project Task No." := '';
                if (("Project No." <> xRec."Project No.") and ("Project No." <> '')) then begin
                    Job.Get("Project No.");
                    Validate("Project Description", Job.Description);
                end;
            end;
        }
        field(5; "Project Task No."; Code[20])
        {
            Caption = 'Project Task No.';
            DataClassification = CustomerContent;
            TableRelation = "Job Task"."Job Task No." Where("Job No." = Field("Project No."));
            trigger OnValidate()
            var
                JobTask: Record "Job Task";
            begin
                if (("Project Task No." <> xRec."Project Task No.") and ("Project Task No." <> '')) then begin
                    JobTask.Get("Project No.", "Project Task No.");
                    Validate("Project Task Description", JobTask.Description);
                end
            end;
        }
        field(8; "Duration in Minutes"; Integer)
        {
            Caption = 'Duration in Minutes';
            DataClassification = CustomerContent;
        }
        field(11; "Project Description"; Text[100])
        {
            Caption = 'Project Description';
            DataClassification = CustomerContent;
        }
        field(12; "Project Task Description"; Text[100])
        {
            Caption = 'Project Task Description';
            DataClassification = CustomerContent;
        }
        field(13; Comments; BLOB)
        {
            Caption = 'Task Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Employee Name", "Project Description", "Project Task Description")
        {
        }
        fieldgroup(Brick; "Employee Name", "Project Description", "Project Task Description")
        {
        }
    }

    procedure SetComments(NewComments: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Comments);
        Comments.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewComments);
        Modify();
    end;

    procedure GetComments() Comment: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields(Comments);
        Comments.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName(Comments)));
    end;
}
