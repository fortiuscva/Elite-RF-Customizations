page 52114 "ERF Engineering Group Subpage"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "ERF Engineering Group Line";
    Caption = 'Lines';

    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
