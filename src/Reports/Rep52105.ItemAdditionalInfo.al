report 52105 "ERF Item Additional Info."
{
    Caption = 'Item Additional Information';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;
    dataset
    {
        dataitem(ERFItemAdditionalFields; "ERF Item Additional Fields")
        {
            RequestFilterFields = "Extended Description";
            trigger OnPreDataItem()
            begin
                if FilterText = '' then
                    Error(FilterTextErr);

                Clear(TempItemGbl);
                TempItemGbl.DeleteAll();
            end;

            trigger OnAfterGetRecord()
            begin
                TempItemGbl.Init();
                TempItemGbl."No." := ERFItemAdditionalFields."Item No.";
                TempItemGbl.Insert();
            end;
        }
    }

    trigger OnPreReport()
    begin
        FilterText := ERFItemAdditionalFields.GetFilter("Extended Description");
    end;

    trigger OnPostReport()
    begin
        Clear(Item);
        Item.ClearMarks();

        repeat
            if TempItemGbl.Get(Item."No.") then
                Item.Mark(true);
        until Item.Next() = 0;
        Item.MarkedOnly(true);

        if Item.FindSet() then;
    end;

    var
        FilterText: Text;
        TempItemGbl: Record Item temporary;
        Item: Record Item;
        FilterTextErr: Label 'Need to provide filter for Extended Description.';

    procedure GetMarkedItem(Var ItemPar: Record Item)
    begin
        ItemPar.Copy(Item);
    end;

}