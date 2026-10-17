page 52124 "ERF SFTT Setup"
{
    ApplicationArea = All;
    Caption = 'Shop Floor Time Tracking Setup';
    PageType = Card;
    SourceTable = "ERF SFTT Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Journal Template Name field.', Comment = '%';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Journal Batch Name field.', Comment = '%';
                }
            }
        }
    }
}
