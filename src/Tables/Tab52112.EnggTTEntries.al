table 52112 "ERF Engg. TT Entries"
{
    Caption = 'Engineering Time Tracking Entries';
    LookupPageId = "ERF Engg. TT Entries";
    DrillDownPageId = "ERF Engg. TT Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = True;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
            TableRelation = Employee;
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if ("Employee No." <> xRec."Employee No.") and ("Employee No." <> '') then begin
                    Employee.Get("Employee No.");
                    Validate("Employee Name", Employee.FullName());
                end else
                    Validate("Employee Name", '');
            end;
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
            begin
                if (("Project No." <> xRec."Project No.") or ("Project No." = '')) then
                    "Project Task No." := '';
            end;
        }
        field(5; "Project Task No."; Code[20])
        {
            Caption = 'Project Task No.';
            DataClassification = CustomerContent;
            TableRelation = "Job Task"."Job Task No." Where("Job No." = Field("Project No."));
        }
        field(6; "Start Time"; DateTime)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }
        field(7; "End Time"; DateTime)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }
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
        fieldgroup(DropDown; "Employee No.", "Employee Name", "Project No.", "Project Task No.")
        {
        }
        fieldgroup(Brick; "Employee No.", "Employee Name", "Project No.", "Project Task No.")
        {
        }
    }
}
