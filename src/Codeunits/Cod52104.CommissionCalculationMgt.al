codeunit 52104 "ERF Commission Calculation Mgt"
{
    procedure BuildCommissionBuffer(
        FromDate: Date;
        ToDate: Date;
        CustomerNo: Code[20];
        SalespersonCode: Code[20];
        var Buffer: Record "ERF Commission Buffer" temporary)
    var
        SIH: Record "Sales Invoice Header";
    begin
        Buffer.DeleteAll();

        SIH.Reset();
        SIH.SetRange("Posting Date", FromDate, ToDate);
        SIH.SetFilter("Order No.", '<>%1', '');

        if CustomerNo <> '' then
            SIH.SetRange("Sell-to Customer No.", CustomerNo);

        if SalespersonCode <> '' then
            SIH.SetRange("Salesperson Code", SalespersonCode);

        if SIH.FindSet() then
            repeat
                ProcessOrder(
                    SIH."Order No.",
                    SIH."Salesperson Code",
                    Buffer);
            until SIH.Next() = 0;
    end;

    local procedure ProcessOrder(
        OrderNo: Code[20];
        SalespersonCode: Code[20];
        var Buffer: Record "ERF Commission Buffer" temporary)
    var
        SP: Record "Salesperson/Purchaser";
        Basis: Decimal;
    begin
        if Buffer.Get(OrderNo, SalespersonCode) then
            exit;

        if not IsOrderFullyPaid(OrderNo) then
            exit;

        Basis := CalcCommissionBasis(OrderNo);

        if Basis = 0 then
            exit;

        if not SP.Get(SalespersonCode) then
            exit;

        Buffer.Init();
        Buffer."Order No." := OrderNo;
        Buffer."Salesperson Code" := SalespersonCode;
        Buffer."Commission Basis" := Basis;
        Buffer."Commission %" := SP."Commission %";
        Buffer."Commission Amount" :=
            Round(Basis * SP."Commission %" / 100, 0.01);

        Buffer.Insert();
    end;

    local procedure IsOrderFullyPaid(OrderNo: Code[20]): Boolean
    var
        CLE: Record "Cust. Ledger Entry";
    begin
        CLE.Reset();
        CLE.SetRange("Document No.", OrderNo);
        CLE.SetRange(Open, true);

        exit(not CLE.FindFirst());
    end;

    local procedure CalcCommissionBasis(OrderNo: Code[20]): Decimal
    var
        SIL: Record "Sales Invoice Line";
        SalesSetup: Record "Sales & Receivables Setup";
        ShippingResNo: Code[20];
        Total: Decimal;
    begin
        SalesSetup.Get();
        ShippingResNo := SalesSetup."ERF Shipping Resource No.";

        SIL.Reset();
        SIL.SetRange("Order No.", OrderNo);

        if SIL.FindSet() then
            repeat
                if not (
                    (SIL.Type = SIL.Type::Resource) and
                    (SIL."No." = ShippingResNo)
                ) then
                    Total += SIL."Line Amount";

            until SIL.Next() = 0;

        exit(Total);
    end;

}
