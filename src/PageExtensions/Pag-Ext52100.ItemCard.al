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
        }
    }
}
