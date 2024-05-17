pageextension 52100 "ERF Item Card" extends "Item Card"
{
    layout
    {
        addafter("Qty. on Purch. Order")
        {
            field("ERF Qty. on Purch. Quote"; Rec."ERF Qty. on Purch. Quote")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item are inbound on purchase quotes, meaning listed on outstanding purchase quote lines.';
            }
            field("ERF Qty. on Archive Purch. Quote"; Rec."ERF Qty. Archive Purch. Quote")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item are inbound on archive purchase quotes, meaning listed on outstanding archive purchase quote lines.';
            }
        }
        addafter(Description)
        {
            field("ERF Additional Information"; Rec.GetExtendedDescription())
            {
                ApplicationArea = Suite;
                Caption = 'Extended Description';
                Editable = false;
                ToolTip = 'Specifies extended description for the item.';

                trigger OnDrillDown()
                var
                    ItemAdditionalFields: Record "ERF Item Additional Fields";
                begin
                    if ItemAdditionalFields.Get(Rec."No.") then
                        Page.RunModal(Page::"ERF Item Additional Fields", ItemAdditionalFields);
                end;
            }
        }
    }
    actions
    {
        addafter(ApplyTemplate)
        {
            action("ERF AdditionalInfo")
            {
                Caption = 'Additional Information';
                ApplicationArea = All;
                Image = DataEntry;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Shows the Additional Item Information.';
                RunObject = page "ERF Item Additional Fields";
                RunPageLink = "Item No." = field("No.");
                RunPageMode = Edit;

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
        }
    }
}
