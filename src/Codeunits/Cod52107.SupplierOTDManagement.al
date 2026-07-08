codeunit 52107 "ERF Supplier OTD Management"
{
    Permissions = tabledata "Purch. Rcpt. Line" = rmid;

    procedure UpdateSupplierOTD(var PurchRcptLine: Record "Purch. Rcpt. Line"; SupplierOTD: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            exit;
        if not UserSetup."ERF Allow Edit Supplier OTD" then
            exit;

        if PurchRcptLine.FindSet() then
            repeat
                PurchRcptLine.Validate("ERF Supplier Late Delivery", SupplierOTD);
                PurchRcptLine.Modify(true);
            until PurchRcptLine.Next() = 0;
    end;
}
