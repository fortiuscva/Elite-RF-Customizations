page 52109 "ERF F-830-4 ECN Log Rev A List"
{
    ApplicationArea = All;
    Caption = 'F-830-4 ECN Log Rev A List';
    PageType = List;
    SourceTable = "ERF F-830-4 ECN Log Rev A";
    UsageCategory = Lists;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("ECN Number"; Rec."ECN Number")
                {
                    ToolTip = 'Specifies the value of the ECN Number field.', Comment = '%';
                }
                field("Date Opened"; Rec."Date Opened")
                {
                    ToolTip = 'Specifies the value of the Date Opened field.', Comment = '%';
                }
                field("Date Signed"; Rec."Date Signed")
                {
                    ToolTip = 'Specifies the value of the Date Signed field.', Comment = '%';
                }
                field("Product P/N"; Rec."Product P/N")
                {
                    ToolTip = 'Specifies the value of the Product P/N field.';
                }
                field("Old Rev"; Rec."Old Rev")
                {
                    ToolTip = 'Specifies the value of the Old Rev field.', Comment = '%';
                }
                field("New Rev"; Rec."New Rev")
                {
                    ToolTip = 'Specifies the value of the New Rev field.', Comment = '%';
                }
                field("Part/Product Description"; Rec."Part/Product Description")
                {
                    ToolTip = 'Specifies the value of the Part/Product Description field.', Comment = '%';
                }
                field("Description of Change"; Rec."Description of Change")
                {
                    ToolTip = 'Specifies the value of the Description of Change field.', Comment = '%';
                }
                field("Reason for Change"; Rec."Reason for Change")
                {
                    ToolTip = 'Specifies the value of the Reason for Change field.', Comment = '%';
                }
                field("ECO Effects On"; Rec."ECO Effects On")
                {
                    ToolTip = 'Specifies the value of the ECO Effects On field.', Comment = '%';
                }
                field(Impact; Rec.Impact)
                {
                    ToolTip = 'Specifies the value of the Impact field.', Comment = '%';
                }
                field("WIP/FG"; Rec."WIP/FG")
                {
                    ToolTip = 'Specifies the value of the WIP/FG field.', Comment = '%';
                }
            }
        }
    }
}
