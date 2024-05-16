page 52100 "ERF Item Additional Fields"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Item Additional Fields';
    PageType = Card;
    SourceTable = "ERF Item Additional Fields";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Extended Description"; Rec."Extended Description")
                {
                    ToolTip = 'Specifies the value of the Extended Description field.';
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
            }
        }
    }
}
