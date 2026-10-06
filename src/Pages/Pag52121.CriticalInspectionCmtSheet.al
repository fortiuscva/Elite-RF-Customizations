page 52121 "Critical Inspection Cmt. Sheet"
{
    ApplicationArea = All;
    Caption = 'Critical Inspection Comment Sheet';
    PageType = List;
    SourceTable = "Critical Inspection Comment";
    UsageCategory = Lists;
    AutoSplitKey = true;

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
        CriticalInspeCommentLine: Record "Critical Inspection Comment";
        NextLineNo: Integer;
    begin
        if SelectedTemplateCode = '' then
            exit;

        // Get all Critical Steps having the selected Code
        CriticalStepsTemplate.Reset();
        CriticalStepsTemplate.SetRange(Code, SelectedTemplateCode);
        if not CriticalStepsTemplate.FindSet() then
            exit;

        // Get next comment line number
        NextLineNo := GetNextLineNo();

        repeat
            CriticalInspeCommentLine.Init();
            CriticalInspeCommentLine.Status := Rec.Status;
            CriticalInspeCommentLine."Prod. Order No." := Rec."Prod. Order No.";
            CriticalInspeCommentLine."Prod. Order Line No." := Rec."Prod. Order Line No.";
            CriticalInspeCommentLine."Line No." := NextLineNo;
            CriticalInspeCommentLine.Date := WorkDate();
            CriticalInspeCommentLine."Template Code" := CriticalStepsTemplate.Code;
            CriticalInspeCommentLine.Comment := CriticalStepsTemplate.Description;

            CriticalInspeCommentLine.Insert();

            NextLineNo += 10000;

        until CriticalStepsTemplate.Next() = 0;

    end;

    local procedure GetNextLineNo(): Integer
    var
        CriticalInspeCommentLine: Record "Critical Inspection Comment";
    begin
        CriticalInspeCommentLine.Reset();

        CriticalInspeCommentLine.SetRange(Status, Rec.Status);
        CriticalInspeCommentLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        CriticalInspeCommentLine.SetRange("Prod. Order Line No.", Rec."Prod. Order Line No.");
        if CriticalInspeCommentLine.FindLast() then
            exit(CriticalInspeCommentLine."Line No." + 10000);

        exit(10000);
    end;

    var
        SelectedTemplateCode: Code[20];
}