page 52122 "Critical Inspection Cmt. List"
{
    Caption = 'Critical Inspection Comment List';
    DataCaptionFields = Status, "Prod. Order No.";
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Critical Inspection Comment";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. Order No. field.', Comment = '%';
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. Order Line No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Template Code"; Rec."Template Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Code field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
    }
}
