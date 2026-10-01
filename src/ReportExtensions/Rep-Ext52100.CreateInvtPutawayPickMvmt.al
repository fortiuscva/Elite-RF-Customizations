reportextension 52100 "Create Invt Put-away/Pick/Mvmt" extends "Create Invt Put-away/Pick/Mvmt"
{
    requestpage
    {
        layout
        {
            modify("Reserved From Stock")
            {
                trigger OnAfterValidate()
                var
                    SingleInstance: Codeunit "ERF Single Instance";
                begin
                    SingleInstance.SetReservedFroMStock(ReservedFromStock);
                end;
            }
            addlast(content)
            {
                group(ERFProductionOrder)
                {
                    Caption = 'Production Order Line';
                    field("ERF Prod. Order Line No."; ERFRPOLineNo)
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Prod. Order Line No.';
                        ToolTip = 'Specifies the released production order line number for which the inventory pick will be created.';
                    }
                }
            }
        }
        trigger OnOpenPage()
        var
            SingleInstanceCU: Codeunit "ERF Single Instance";
        begin
            ERFRPOLineNo := SingleInstanceCU.GetSelectedProdOrderLineNo();
        end;
    }
    var
        ERFRPOLineNo: Integer;
}
