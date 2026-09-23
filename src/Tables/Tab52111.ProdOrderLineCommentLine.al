table 52111 "Prod. Order Line Comment Line"
{
    Caption = 'Prod. Order Line Comment Line';
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
            trigger OnValidate()
            begin
                //  CopyCriticalSteps(Rec);
            end;
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
        ProdOrderLineCmntLine: Record "Prod. Order Line Comment Line";
    begin
        ProdOrderLineCmntLine.SetRange(Status, Status);
        ProdOrderLineCmntLine.SetRange("Prod. Order No.", "Prod. Order No.");
        ProdOrderLineCmntLine.SetRange(Date, WorkDate());
        if not ProdOrderLineCmntLine.FindFirst() then
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

    procedure CopyCriticalSteps(Var RPOLineCmt: Record "Prod. Order Line Comment Line")
    var
        CriticalStepsTemplate: Record "ERF Critical Steps Template";
        RPOLineCmntLine: Record "Prod. Order Line Comment Line";
        NextLineNo: Integer;
        FirstLine: Boolean;
    begin
        if RPOLineCmt."Template Code" = '' then
            exit;
        NextLineNo := 10000;
        CriticalStepsTemplate.Reset();
        CriticalStepsTemplate.SetRange("Code", RPOLineCmt."Template Code");

        if not CriticalStepsTemplate.FindSet() then
            exit;

        RPOLineCmntLine.Reset();
        RPOLineCmntLine.SetRange(Status, RPOLineCmt.Status);
        RPOLineCmntLine.SetRange("Prod. Order No.", RPOLineCmt."Prod. Order No.");
        RPOLineCmntLine.SetRange("Prod. Order Line No.", RPOLineCmt."Prod. Order Line No.");

        if RPOLineCmntLine.FindFirst() then begin
            RPOLineCmntLine."Line No." += 10000;
            RPOLineCmntLine.Date := WorkDate();
            RPOLineCmntLine.Comment := CriticalStepsTemplate.Description;
            RPOLineCmntLine.Modify();
        end;
        RPOLineCmntLine.Reset();
        RPOLineCmntLine.SetRange(Status, RPOLineCmt.Status);
        RPOLineCmntLine.SetRange("Prod. Order No.", RPOLineCmt."Prod. Order No.");
        RPOLineCmntLine.SetRange("Prod. Order Line No.", RPOLineCmt."Prod. Order Line No.");

        if RPOLineCmntLine.FindLast() then
            NextLineNo := RPOLineCmntLine."Line No." + 10000;
        // else begin
        //     NextLineNo := 10000;
        FirstLine := true;
        // end;
        repeat
        // if FirstLine then begin
        //     RPOLineCmntLine."Line No." := NextLineNo;

        //     //RPOLineCmntLine.Insert();
        //     FirstLine := false;
        // end
        // else
        begin
            RPOLineCmntLine.Init();
            RPOLineCmntLine.Status := RPOLineCmt.Status;
            RPOLineCmntLine."Prod. Order No." := RPOLineCmt."Prod. Order No.";
            RPOLineCmntLine."Prod. Order Line No." := RPOLineCmt."Prod. Order Line No.";
            RPOLineCmntLine."Line No." := NextLineNo;
            RPOLineCmntLine."Template Code" := RPOLineCmt."Template Code";
            RPOLineCmntLine.Comment := CriticalStepsTemplate.Description;
            RPOLineCmntLine.Insert();
        end;
        NextLineNo += 10000;
        until CriticalStepsTemplate.Next() = 0;
    end;


    local procedure GetNextLineNo(): Integer
    var
        RPOLineCommentLine: Record "Prod. Order Line Comment Line";
    begin
        RPOLineCommentLine.Reset();

        RPOLineCommentLine.SetRange(
            Status,
            Rec.Status);

        RPOLineCommentLine.SetRange(
            "Prod. Order No.",
            Rec."Prod. Order No.");

        RPOLineCommentLine.SetRange(
            "Prod. Order Line No.",
            Rec."Prod. Order Line No.");

        if RPOLineCommentLine.FindLast() then
            exit(RPOLineCommentLine."Line No." + 10000);

        exit(10000);
    end;

    var
        Text000: Label 'A %1 %2 cannot be inserted, modified, or deleted.';
}
