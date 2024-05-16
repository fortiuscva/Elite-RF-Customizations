pageextension 52102 "ERF Item List" extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("ERF Additional Information"; Rec.GetExtendedDescription())
            {
                ApplicationArea = Suite;
                Caption = 'Extended Description';
                Editable = false;
                ToolTip = 'Specifies extended description for the item.';

                trigger OnDrillDown()
                var
                    ItemAdditionalFields: Record "ERF Item Additional Fields";
                begin
                    if ItemAdditionalFields.Get(Rec."No.") then
                        Page.RunModal(Page::"ERF Item Additional Fields", ItemAdditionalFields);
                end;
            }
        }
    }
    actions
    {
        addafter(ApplyTemplate)
        {
            action("ERF Filter AdditionalInfo")
            {
                Caption = 'Filter Additional Information';
                ApplicationArea = All;
                Image = DataEntry;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Shows the Filter on Additional Item Information.';

                trigger OnAction()
                var
                    ItemAddInfoRep: Report "ERF Item Additional Info.";
                    Item: Record Item;
                    TempItem: Record Item temporary;
                begin
                    Rec.ClearMarks();
                    Rec.Reset();

                    Clear(TempItem);
                    TempItem.DeleteAll();

                    ItemAddInfoRep.RunModal();
                    ItemAddInfoRep.GetMarkedItem(Item);

                    if Item.FindSet() then
                        repeat
                            TempItem.Init();
                            TempItem.TransferFields(Item);
                            TempItem.Insert();
                        until Item.Next() = 0;

                    if Rec.FindSet() then
                        repeat
                            if TempItem.Get(Rec."No.") then begin
                                Rec.Mark(true);
                            end;
                        until Rec.Next() = 0;

                    Rec.MarkedOnly(true);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.GetExtendedDescription();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Rec.GetExtendedDescription();
    end;
}