table 52114 "ERF SFTT Entry"
{
    Caption = 'Shop Floor Time Tracking Entry';
    DrillDownPageId = "ERF SFTT Entries";
    LookupPageId = "ERF SFTT Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            // AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                Employee.Reset();
                Employee.Get("Employee No.");
                Validate("Employee Name", Employee.FullName());
            end;
        }
        field(4; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(5; "Prod Order No."; Code[20])
        {
            Caption = 'Production Order No.';
            TableRelation = "Production Order"."No." where(Status = const(Released));
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ProductionOrder: Record "Production Order";
            begin
                ProductionOrder.Reset();
                ProductionOrder.Get(ProductionOrder.Status::Released, "Prod Order No.");
                Validate("Item Description", ProductionOrder.Description);
            end;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(7; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ProdOrderRoutingLine: Record "Prod. Order Routing Line";
                RoutingNo: Code[20];
            begin
                RoutingNo := GetRoutingNo("Prod Order No.", "Line No.", "Operation No.");

                ProdOrderRoutingLine.Reset();
                if ProdOrderRoutingLine.Get(ProdOrderRoutingLine.Status::Released, "Prod Order No.", "Line No.", RoutingNo, "Operation No.") then
                    Validate("Operation Description", ProdOrderRoutingLine.Description);
            end;
        }
        field(8; "Start Time"; DateTime)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }
        field(9; "End Time"; DateTime)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }
        field(10; "Duration in Minutes"; Integer)
        {
            Caption = 'Duration in Minutes';
            DataClassification = CustomerContent;
        }
        field(11; Status; enum "ERF SFTT Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }

        field(12; "Output Quantity"; Decimal)
        {
            Caption = 'Output Quantity';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }
        field(13; "Serial No."; Code[250])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(14; "Item Description"; Text[100])
        {
            Caption = 'RPO Header Item Description';
            DataClassification = CustomerContent;
        }
        field(15; "Operation Description"; Text[100])
        {
            Caption = 'Routing Line Operation Description';
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
        fieldgroup(DropDown; "Entry No.", "Employee Name", "Prod Order No.", "Line No.", "Operation No.")
        {
        }
        fieldgroup(Brick; "Entry No.", "Employee Name", "Prod Order No.", "Line No.", "Operation No.")
        {
        }
    }
    procedure GetRoutingNo(ProdOrderNo: Code[20]; RoutingRefNo: Integer; OperationNo: Code[10]): Code[20]
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        ProdOrderRoutingLine.Reset();
        ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderNo);
        ProdOrderRoutingLine.SetRange("Routing Reference No.", RoutingRefNo);
        ProdOrderRoutingLine.SetRange("Operation No.", OperationNo);
        If ProdOrderRoutingLine.FindFirst() then
            exit(ProdOrderRoutingLine."Routing No.");
    end;
}
