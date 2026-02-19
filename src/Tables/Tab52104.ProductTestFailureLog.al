table 52104 "ERF Product Test Failure Log"
{
    Caption = 'Product Test Failure Log';
    DataClassification = CustomerContent;
    LookupPageId = "ERF Product Test Failure Log";
    DrillDownPageId = "ERF Product Test Failure Log";
    DataCaptionFields = "Production Order No.", "Model No./Part No.";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(5; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
            DataClassification = CustomerContent;
        }
        field(6; "Production Order No."; Code[20])
        {
            Caption = 'Production Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Production Order"."No." where(Status = const(Released));
            trigger OnValidate()
            var
                ProdOrder: Record "Production Order";
            begin
                Clear("Model No./Part No.");
                if "Production Order No." <> '' then begin
                    ProdOrder.Get(ProdOrder.Status::Released, "Production Order No.");
                    Validate("Model No./Part No.", ProdOrder."Source No.");
                end;
            end;
        }
        field(7; "Report Issued By"; Code[20])
        {
            Caption = 'Report Issued By';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                EmployeeRec: Record Employee;
            begin
                if "Report Issued By" <> '' then begin
                    EmployeeRec.Get("Report Issued By");
                    "Report Issued By Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                end else
                    "Report Issued By Name" := '';
            end;
        }
        field(8; "Assembled/Build By"; Code[20])
        {
            Caption = 'Assembled/Build By';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                EmployeeRec: Record Employee;
            begin
                if "Assembled/Build By" <> '' then begin
                    EmployeeRec.Get("Assembled/Build By");
                    "Assembled/Build By Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                end else
                    "Assembled/Build By Name" := '';
            end;
        }
        field(9; "Model No./Part No."; Code[20])
        {
            Caption = 'Model No./Part No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Quantity of Parts under Test"; Integer)
        {
            Caption = 'Quantity of Parts under Test';
            DataClassification = CustomerContent;
        }
        field(11; "Tested By"; Code[20])
        {
            Caption = 'Tested By';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                EmployeeRec: Record Employee;
            begin
                if "Tested By" <> '' then begin
                    EmployeeRec.Get("Tested By");
                    "Tested By Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                end else
                    "Tested By Name" := '';
            end;
        }
        field(12; "Test Date"; Date)
        {
            Caption = 'Test Date';
            DataClassification = CustomerContent;
        }
        field(13; "Item Type"; Enum "Prod. TestFailureLog ItemType")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
        field(14; "Serial Number (Failed)"; Code[50])
        {
            Caption = 'Serial Number (Failed)';
            DataClassification = CustomerContent;
        }
        field(15; "Issue Found"; Text[250])
        {
            Caption = 'Issue Found';
            DataClassification = CustomerContent;
        }
        field(16; "Corrective Action Taken"; Text[250])
        {
            Caption = 'Corrective Action Taken';
            DataClassification = CustomerContent;
        }
        field(17; "Preventive Action Taken"; Text[250])
        {
            Caption = 'Preventive Action Taken';
            DataClassification = CustomerContent;
        }
        field(18; "Approved By"; Code[20])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                EmployeeRec: Record Employee;
            begin
                if "Approved By" <> '' then begin
                    EmployeeRec.Get("Approved By");
                    "Approved By Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                end else
                    "Approved By Name" := '';
            end;
        }
        field(19; Status; Enum "Prod. TestFailureLog Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(20; "Report Issued By Name"; Text[250])
        {
            Caption = 'Report Issued By Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Assembled/Build By Name"; Text[250])
        {
            Caption = 'Assembled/Build By Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Tested By Name"; Text[250])
        {
            Caption = 'Tested By Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Approved By Name"; Text[250])
        {
            Caption = 'Approved By Name';
            DataClassification = CustomerContent;
            Editable = false;
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
