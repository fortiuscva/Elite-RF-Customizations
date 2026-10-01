codeunit 52101 "ERF Single Instance"
{
    SingleInstance = true;
    procedure SetReservedFroMStock(ReservedFromStockVar: Enum "Reservation From Stock")
    begin
        ReservedFromStock := ReservedFromStockVar;
    end;

    procedure GetReservedFroMStock(): Enum "Reservation From Stock"
    begin
        exit(ReservedFromStock);
    end;

    procedure SetSelectedProdOrderLine(ProdOrderLine: Record "Prod. Order Line")
    begin
        SelectedStatus := ProdOrderLine.Status;
        SelectedProdOrderNo := ProdOrderLine."Prod. Order No.";
        SelectedProdOrderLineNo := ProdOrderLine."Line No.";
        IsLineFilterActive := true;
    end;

    procedure IsSelectedProdOrderLineActive(): Boolean
    begin
        exit(IsLineFilterActive);
    end;

    procedure GetSelectedStatus(): Enum "Production Order Status"
    begin
        exit(SelectedStatus);
    end;

    procedure GetSelectedProdOrderNo(): Code[20]
    begin
        exit(SelectedProdOrderNo);
    end;

    procedure GetSelectedProdOrderLineNo(): Integer
    begin
        exit(SelectedProdOrderLineNo);
    end;

    procedure ClearSelectedProdOrderLine()
    begin
        Clear(SelectedStatus);
        SelectedProdOrderNo := '';
        SelectedProdOrderLineNo := 0;
        IsLineFilterActive := false;
    end;

    var
        ReservedFromStock: Enum "Reservation From Stock";
        SelectedStatus: Enum "Production Order Status";
        SelectedProdOrderNo: Code[20];
        SelectedProdOrderLineNo: Integer;
        IsLineFilterActive: Boolean;
}
