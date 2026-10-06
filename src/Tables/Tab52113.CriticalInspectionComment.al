table 52113 "Critical Inspection Comment"
{
    Caption = 'Critical Inspection Comment';
    DrillDownPageID = "Prod. Order Comment List";
    LookupPageID = "Prod. Order Comment List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            ToolTip = 'Specifies the number of the related production order.';
            NotBlank = true;
            TableRelation = "Production Order"."No." where(Status = field(Status));
        }
        field(3; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            TableRelation = "Prod. Order Line"."Line No." where(Status = field(Status),
                                                                 "Prod. Order No." = field("Prod. Order No."));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies a date.';
        }
        field(7; Comment; Text[80])
        {
            Caption = 'Comment';
            ToolTip = 'Specifies the comment.';
        }
        field(8; "Template Code"; Code[20])
        {
            Caption = 'Template Code';
            TableRelation = "ERF Critical Steps Template"."Code";
            Editable = false;
        }
    }
    keys
    {
        key(PK; Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    begin
        CheckFinishedOrder();
    end;

    trigger OnInsert()
    begin
        CheckFinishedOrder();
    end;

    trigger OnModify()
    begin
        CheckFinishedOrder();
    end;

    procedure SetupNewLine()
    var
        CriticalInspeComment: Record "Critical Inspection Comment";
    begin
        CriticalInspeComment.SetRange(Status, Status);
        CriticalInspeComment.SetRange("Prod. Order No.", "Prod. Order No.");
        CriticalInspeComment.SetRange(Date, WorkDate());
        if not CriticalInspeComment.FindFirst() then
            Date := WorkDate();
    end;

    procedure CheckFinishedOrder()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if Status = Status::Finished then
            Error(Text000, Status, TableCaption);
    end;

    local procedure GetNextLineNo(): Integer
    var
        CriticalInspeComment: Record "Critical Inspection Comment";
    begin
        CriticalInspeComment.Reset();
        CriticalInspeComment.SetRange(Status, Rec.Status);
        CriticalInspeComment.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        CriticalInspeComment.SetRange("Prod. Order Line No.", Rec."Prod. Order Line No.");
        if CriticalInspeComment.FindLast() then
            exit(CriticalInspeComment."Line No." + 10000);

        exit(10000);
    end;

    var
        Text000: Label 'A %1 %2 cannot be inserted, modified, or deleted.';
}