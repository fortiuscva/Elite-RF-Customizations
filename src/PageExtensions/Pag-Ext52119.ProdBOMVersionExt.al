pageextension 52119 "ERF Prod BOM Version Ext" extends "Production BOM Version"
{
    actions
    {
        addlast(Processing)
        {
            action("ERF CopyBOMVersion")
            {
                Caption = 'Copy BOM Version (Custom)';
                Image = Copy;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BOMVersionMgt: Codeunit "ERF BOM Version Mgt";
                begin
                    BOMVersionMgt.CopyBOMVersion(Rec);
                end;
            }
        }
    }
}
