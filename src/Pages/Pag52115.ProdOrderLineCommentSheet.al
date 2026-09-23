page 52115 "Prod. Order Line Comment Sheet"
{
    ApplicationArea = All;
    Caption = 'Prod. Order Line Comment Sheet';
    PageType = List;
    SourceTable = "Prod. Order Line Comment Line";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(Template)
            {
                Caption = 'Critical Steps';

                field(SelectedTemplateCode; SelectedTemplateCode)
                {
                    Caption = 'Template Code';
                    ApplicationArea = All;
                    TableRelation = "ERF Critical Steps Template"."Code";

                    trigger OnValidate()
                    begin
                        CopyCriticalSteps();
                        CurrPage.Update(false);
                    end;
                }
            }
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Template Code"; Rec."Template Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Template Code field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Rec.SetUpNewLine();
        Rec.Status := Rec.GetRangeMin(Status);
        Rec."Prod. Order No." := Rec.GetRangeMin("Prod. Order No.");
        Rec."Prod. Order Line No." := Rec.GetRangeMin("Prod. Order Line No.");
        Rec.Date := WorkDate();
        Rec."Line No." := GetNextLineNo();
    end;

    local procedure CopyCriticalSteps()
    var
        CriticalStepsTemplate: Record "ERF Critical Steps Template";
        RPOLineCommentLine: Record "Prod. Order Line Comment Line";
        NextLineNo: Integer;
    begin
        if SelectedTemplateCode = '' then
            exit;

        // Get all Critical Steps having the selected Code
        CriticalStepsTemplate.Reset();
        CriticalStepsTemplate.SetRange(
            Code,
            SelectedTemplateCode);

        if not CriticalStepsTemplate.FindSet() then
            exit;

        // Get next comment line number
        NextLineNo := GetNextLineNo();

        repeat
            RPOLineCommentLine.Init();

            RPOLineCommentLine.Status :=
                Rec.Status;

            RPOLineCommentLine."Prod. Order No." :=
                Rec."Prod. Order No.";

            RPOLineCommentLine."Prod. Order Line No." :=
                Rec."Prod. Order Line No.";

            RPOLineCommentLine."Line No." :=
                NextLineNo;

            RPOLineCommentLine.Date :=
                WorkDate();

            RPOLineCommentLine."Template Code" :=
                CriticalStepsTemplate.Code;

            RPOLineCommentLine.Comment :=
                CriticalStepsTemplate.Description;

            RPOLineCommentLine.Insert();

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
        SelectedTemplateCode: Code[20];
}
