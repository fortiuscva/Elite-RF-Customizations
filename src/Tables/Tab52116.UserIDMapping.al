table 52116 "ERF User ID Mapping"
{
    Caption = 'User ID Mapping';
    LookupPageId = "ERF User ID Mappings";
    DrillDownPageId = "ERF User ID Mappings";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
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
                Employee.Reset();
                Employee.Get("Employee No.");
                "Employee Name" := Employee.FullName();
            end;
        }
        field(3; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "User ID", "Employee No.", "Employee Name")
        {
        }
        fieldgroup(Brick; "User ID", "Employee No.", "Employee Name")
        {
        }
    }
}