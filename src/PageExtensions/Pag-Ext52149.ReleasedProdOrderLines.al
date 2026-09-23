pageextension 52149 "ERF Released Prod. Order Lines" extends "Released Prod. Order Lines"
{
    actions
    {
        addlast("&Line")
        {
            action("ERF Comments")
            {
                Caption = 'Comments';
                ApplicationArea = All;
                Image = Comment;

                trigger OnAction()
                var
                    RPOCommentLine: Record "Prod. Order Line Comment Line";
                begin
                    RPOCommentLine.Reset();
                    RPOCommentLine.SetRange(Status, Rec.Status);
                    RPOCommentLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
                    RPOCommentLine.SetRange("Prod. Order Line No.", Rec."Line No.");

                    Page.Run(Page::"Prod. Order Line Comment Sheet", RPOCommentLine);
                end;
            }
            action("ERF Create Inventory Pick")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Create Inventory Pick';
                Image = CreateWarehousePick;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Create and print an inventory pick for the selected production order line.';

                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                begin
                    CurrPage.SaveRecord();
                    CreateInventoryPick(Rec);
                end;
            }

        }
    }
    procedure CreateInventoryPick(var ProdOrderLine: Record "Prod. Order Line")
    var
        WhseRequest: Record "Warehouse Request";
        CreateInvtPutAwayPick: Report "Create Invt Put-away/Pick/Mvmt";
        SingleInstanceCU: Codeunit "ERF Single Instance";
    begin
        ValidateProdOrderLine(ProdOrderLine);

        WhseRequest.Reset();
        WhseRequest.SetCurrentKey("Source Document", "Source No.");
        WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Prod. Consumption");
        WhseRequest.SetRange("Source No.", ProdOrderLine."Prod. Order No.");

        if WhseRequest.IsEmpty() then
            Error('No Warehouse Request exists for Production Order %1.', ProdOrderLine."Prod. Order No.");

        SingleInstanceCU.SetSelectedProdOrderLine(ProdOrderLine);
        CreateInvtPutAwayPick.SetTableView(WhseRequest);
        CreateInvtPutAwayPick.InitializeRequest(false, true, false, true, true);

        // CreateInvtPutAwayPick.UseRequestPage(false);

        CreateInvtPutAwayPick.RunModal();
        SingleInstanceCU.ClearSelectedProdOrderLine();
    end;


    procedure ValidateProdOrderLine(ProdOrderLine: Record "Prod. Order Line")
    begin
        if ProdOrderLine.Status <> ProdOrderLine.Status::Released then
            Error('Inventory Pick can only be created for a Released Production Order.');

        ProdOrderLine.TestField("Prod. Order No.");
        ProdOrderLine.TestField("Line No.");
        ProdOrderLine.TestField("Item No.");
        ProdOrderLine.TestField("Location Code");

        if ProdOrderLine."Remaining Quantity" <= 0 then
            Error('There is no remaining quantity for Production Order %1, Line %2.', ProdOrderLine."Prod. Order No.", ProdOrderLine."Line No.");
    end;

}