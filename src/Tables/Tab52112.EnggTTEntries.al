table 52112 "ERF Engg. TT Entries"
{
    Caption = 'Engineering Time Tracking Entries';
    DataCaptionFields = "Employee Name", "Project Description", "Task Notes";
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
            TableRelation = "ERC PMS Project";
            trigger OnValidate()
            var
                PMSProject: Record "ERC PMS Project";
            begin
                if (("Project No." <> xRec."Project No.") or ("Project No." = '')) then
                    "Phase No." := '';
                if (("Project No." <> xRec."Project No.") and ("Project No." <> '')) then begin
                    PMSProject.Get("Project No.");
                    Validate("Project Name", PMSProject."Project Name");
                    Validate("Project Description", PMSProject."Project Description");

                end;
            end;
        }
        field(15; "Project Name"; text[50])
        {
            Caption = 'Project Name';
            DataClassification = CustomerContent;
        }
        field(5; "Phase No."; Code[20])
        {
            Caption = 'Phase No..';
            DataClassification = CustomerContent;
            TableRelation = "ERC PMS Project Phases";
            trigger OnValidate()
            var
                PMSPhase: Record "ERC PMS Project Phases";
            begin
                if (("Phase No." <> xRec."Phase No.") and ("Phase No." <> '')) then begin
                    PMSPhase.Get("Project No.", "Phase No.");
                    Validate("Phase Name", PMSPhase."Phase Name");
                    Validate("Phase Description", PMSPhase."Phase Description");
                end;
            end;
        }
        field(16; "Phase Name"; Text[50])
        {
            caption = 'Phase Name';
            DataClassification = CustomerContent;
        }
        field(8; "Duration in Minutes"; Integer)
        {
            Caption = 'Duration in Minutes';
            DataClassification = CustomerContent;
        }
        field(11; "Project Description"; Text[2048])
        {
            Caption = 'Project Description';
            DataClassification = CustomerContent;
        }
        field(12; "Phase Description"; Text[2048])
        {
            Caption = 'Phase Description';
            DataClassification = CustomerContent;
        }
        field(14; "Project Task No."; Code[20])
        {
            Caption = 'Project Task No.';
            DataClassification = CustomerContent;
            TableRelation = "ERC PMS Project Tasks";
            trigger OnValidate()
            var
                PMSProjectTasks: Record "ERC PMS Project Tasks";
            begin
                if (("Project Task No." <> xRec."Project Task No.") and ("Project Task No." <> '')) then begin
                    PMSProjectTasks.Get("Project No.", "Phase No.", "Project Task No.");
                    Validate("Task Name", PMSProjectTasks."Task Name");
                    Validate("Task Notes", PMSProjectTasks."Task Notes");
                end;
            end;
        }
        field(17; "Task Name"; Text[50])
        {
            caption = 'Task Name';
            DataClassification = CustomerContent;
        }
        field(18; "Task Notes"; Text[2048])
        {
            Caption = 'Task Notes';
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
        fieldgroup(DropDown; "Employee Name", "Project Description", "Task Notes")
        {
        }
        fieldgroup(Brick; "Employee Name", "Project Description", "Task Notes")
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
