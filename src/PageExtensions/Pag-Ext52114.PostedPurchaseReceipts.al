pageextension 52114 "ERF Posted Purchase Receipts" extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Location Code")
        {
            field("ERF Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order No. field.';
            }
            field("ERF GetPurchInvLineDocNo"; GetPurchInvLineDocNo())
            {
                Caption = 'Invoice No.';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice No. field.';
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        GetPurchInvLineDocNo();
    end;

    local procedure GetPurchInvLineDocNo(): Code[20]
    var
        TempPurchInvLine: Record "Purch. Inv. Line" temporary;
    begin
        PurchRcptLine.SetRange("Document No.", Rec."No.");
        if PurchRcptLine.FindFirst() then begin
            PurchRcptLine.GetPurchInvLines(TempPurchInvLine);
            if TempPurchInvLine.FindFirst() then
                exit(TempPurchInvLine."Document No.");
        end;
    end;

    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
}
