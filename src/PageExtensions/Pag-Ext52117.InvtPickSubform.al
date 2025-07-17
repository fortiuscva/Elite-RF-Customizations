pageextension 52117 "ERF Invt. Pick Subform" extends "Invt. Pick Subform"
{
    actions
    {
        addlast(processing)
        {
            action("ERF PrintLabel")
            {

                ApplicationArea = All;
                Caption = 'Print Label';
                Image = Print;
                trigger OnAction()
                var
                    WarehouseActivityLine: Record "Warehouse Activity Line";
                begin
                    CurrPage.SetSelectionFilter(WarehouseActivityLine);
                    Report.RunModal(Report::"Inventory Pick Label Printing", true, false, WarehouseActivityLine);
                end;
            }
        }
    }
}
