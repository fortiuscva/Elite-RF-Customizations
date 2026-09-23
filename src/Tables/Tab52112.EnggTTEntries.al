table 52112 "ERF Engg. TT Entries"
{
    Caption = 'Engineering Time Tracking Entries';
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
                If Employee.Get("Employee No.") then
                    "Employee Name" := Employee.FullName()
                else
                    Clear("Employee Name")
            end;

        }
        field(3; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(4; "Project No."; Code[20])
        {
            Caption = 'Project No.';
            DataClassification = CustomerContent;
            TableRelation = Job;
            trigger OnValidate()
            begin
                if Xrec."Project No." <> Rec."Project No." Then
                    Clear("Project Task No.");
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
            DataClassification = ToBeClassified;
        }
        field(7; "End Time"; DateTime)
        {
            Caption = 'End Time';
            DataClassification = ToBeClassified;
        }
        field(8; "Duration in Minutes"; Integer)
        {
            Caption = 'Duration in Minutes';
            DataClassification = ToBeClassified;
        }
        field(9; Status; Enum "ERF Engg. TT Entries Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
