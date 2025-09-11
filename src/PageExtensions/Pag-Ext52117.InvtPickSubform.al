pageextension 52117 "ERF Invt. Pick Subform" extends "Invt. Pick Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("ERF Pick Code"; Rec."ERF Pick Code")
            {
                ApplicationArea = all;
                Caption = 'Pick Code';
                Editable = false;
            }
            field("ERF Production BOM No."; Rec."ERF Production BOM No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production BOM No. field.', Comment = '%';
            }
            field("ERF Production BOM Line No."; Rec."ERF Production BOM Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production BOM Line No. field.', Comment = '%';
            }
        }
    }
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
