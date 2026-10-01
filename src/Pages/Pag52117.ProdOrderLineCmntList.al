page 52117 "ERF Prod. Order Line Cmnt List"
{
    Caption = 'Prod. Order Line Comment List';
    DataCaptionFields = Status, "Prod. Order No.";
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Prod. Order Line Comment Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order No. field.', Comment = '%';
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Line No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Template Code"; Rec."Template Code")
                {
                    ToolTip = 'Specifies the value of the Template Code field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
    }
}
