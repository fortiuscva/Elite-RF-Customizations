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

    var
        ReservedFromStock: Enum "Reservation From Stock";
}
