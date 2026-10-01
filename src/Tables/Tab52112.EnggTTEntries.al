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
        // field(2; "Employee No."; Code[20])
        // {
        //     Caption = 'Employee No.';
        //     DataClassification = CustomerContent;
        //     TableRelation = Employee;
        //     trigger OnValidate()
        //     var
        //         Employee: Record Employee;
        //     begin
        //         if ("Employee No." <> xRec."Employee No.") and ("Employee No." <> '') then begin
        //             Employee.Get("Employee No.");
        //             Validate("Employee Name", Employee.FullName());
        //         end else
        //             Validate("Employee Name", '');
        //     end;
        // }
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
        // field(6; "Start Time"; DateTime)
        // {
        //     Caption = 'Start Time';
        //     DataClassification = CustomerContent;
        //     trigger OnValidate()
        //     begin
        //         if ((Rec."Start Time" <> xRec."Start Time") and (Rec."Start Time" <> 0DT) and (Rec."End Time" <> 0DT)) then
        //             CalculateDuration();
        //     end;
        // }
        // field(7; "End Time"; DateTime)
        // {
        //     Caption = 'End Time';
        //     DataClassification = CustomerContent;
        //     trigger OnValidate()
        //     begin
        //         if ((Rec."End Time" <> xRec."End Time") and (Rec."Start Time" <> 0DT) and (Rec."End Time" <> 0DT)) then
        //             CalculateDuration();
        //     end;
        // }
        field(8; "Duration in Minutes"; Integer)
        {
            Caption = 'Duration in Minutes';
            DataClassification = CustomerContent;
        }
        field(9; Status; Enum "ERF Engg. TT Entries Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(10; "Duration"; Text[250])
        {
            Caption = 'Duration';
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
            Caption = 'Comments';
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

    // local procedure CalculateDuration()
    // var
    //     TimeDurationLcl: Duration;
    // begin
    //     "Duration In Minutes" := Round(("End Time" - "Start Time") / 60000, 1, '=');
    //     TimeDurationLcl := "End Time" - "Start Time";
    //     "Duration" := Format(TimeDurationLcl);
    // end;

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
