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

    local procedure GetPurchInvLineDocNo() InvoiceDocNo: Code[20]
    var
        TempPurchInvLine: Record "Purch. Inv. Line" temporary;
        InvFound: Boolean;
    begin
        Clear(InvFound);
        PurchRcptLine.Reset();
        PurchRcptLine.SetRange("Document No.", Rec."No.");
        PurchRcptLine.SetFilter("No.", '<>%1', '');
        if PurchRcptLine.FindSet() then begin
            repeat
                Clear(TempPurchInvLine);
                TempPurchInvLine.DeleteAll();
                PurchRcptLine.GetPurchInvLines(TempPurchInvLine);
                if TempPurchInvLine.FindFirst() then begin
                    InvoiceDocNo := TempPurchInvLine."Document No.";
                    InvFound := true;
                end;
            until (PurchRcptLine.Next() = 0) or InvFound;
        end;
    end;

    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
}