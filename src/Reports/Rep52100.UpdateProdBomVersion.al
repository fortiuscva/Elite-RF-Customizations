report 52100 "ERF Update Prod Bom Version"
{
    ApplicationArea = All;
    Caption = 'Update Desc. on Prod Bom Version';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(ProductionBOMLine; "Production BOM Line")
        {
            DataItemTableView = where("Version Code" = filter(<> ''), Type = const(Item));
            trigger OnAfterGetRecord()
            var
                Item: Record Item;
            begin
                if Item.Get("No.") then begin
                    Description := Item.Description;
                    Modify();
                end;
            end;
        }
    }
}
