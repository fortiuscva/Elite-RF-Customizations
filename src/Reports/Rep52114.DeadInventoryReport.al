report 52114 "ERF Dead Inventory Report"
{
    ApplicationArea = All;
    Caption = 'Dead Inventory Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/DeadInventory.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            DataItemTableView = where(Type = const(Inventory));

            column(ItemNo; "No.")
            {
            }
            column(ItemDescription; Description)
            {
            }
            column(SumOfQty; Inventory)
            { }
            column(AvgCost; AvgCost)
            {
            }

            column(TotalCost; TotalCost)
            {
            }

            trigger OnAfterGetRecord()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                CalcFields(Inventory);

                if Inventory <= 0 then
                    CurrReport.Skip();

                ItemLedgEntry.Reset();
                ItemLedgEntry.SetRange("Item No.", "No.");
                ItemLedgEntry.SetFilter("Posting Date", '>%1', SelectedDate);

                if ItemLedgEntry.FindFirst() then
                    CurrReport.Skip();
                AvgCost := "Unit Cost";

                TotalCost := Inventory * AvgCost;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(SelectedDate; SelectedDate)
                    {
                        Caption = 'Date Filter';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    labels
    {
        ItemNoCaption = 'Item No.';
        DescCaption = 'Description';
        SumofQtyCaption = 'Sum of Quantity';
        AvgCostCaption = 'Avg. Cost';
        TotalCostCaption = 'Total Cost';
    }
    var
        SelectedDate: Date;
        AvgCost: Decimal;
        TotalCost: Decimal;
}
