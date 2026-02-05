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
        }
        field(8; "Assembled/Build By"; Code[20])
        {
            Caption = 'Assembled/Build By';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
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
        field(18; "Closed by"; Code[20])
        {
            Caption = 'Closed by';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
        }
        field(19; Status; Enum "Prod. TestFailureLog Status")
        {
            Caption = 'Status';
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
    trigger OnInsert()
    begin
        if "Issue Date" = 0D then
            "Issue Date" := Today;
    end;
}
