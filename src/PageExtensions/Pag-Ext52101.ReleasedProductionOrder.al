pageextension 52101 "ERF Released Production Order" extends "Released Production Order"
{
    actions
    {
        addafter("&Update Unit Cost")
        {
            action("ERF Consumption Journal")
            {
                Caption = 'Consumption Journal';
                ApplicationArea = All;
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Post consumption released production order(s).';

                trigger OnAction()
                var
                    ItemJnlLine: Record "Item Journal Line";
                    ConsumptionJnl: Page "Consumption Journal";
                begin
                    Rec.CreateConsumptionLines();

                    ItemJnlLine.SetRange("Journal Template Name", 'CONSUMPTIO');
                    ItemJnlLine.SetRange("Journal Batch Name", 'DEFAULT');
                    ItemJnlLine.SetRange("Order Type", ItemJnlLine."Order Type"::Production);
                    ItemJnlLine.SetRange("Order No.", Rec."No.");
                    ConsumptionJnl.SetTableView(ItemJnlLine);
                    ConsumptionJnl.Run();
                end;
            }
        }
    }
}