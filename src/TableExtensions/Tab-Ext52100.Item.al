tableextension 52100 "ERF Item" extends Item
{
    fields
    {
        field(52100; "ERF Qty. on Purch. Quote"; Decimal)
        {
            Caption = 'Qty. on Purch. Quote';
            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where("Document Type" = const(Quote),
                                                                               Type = const(Item),
                                                                               "No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Location Code" = field("Location Filter"),
                                                                               "Drop Shipment" = field("Drop Shipment Filter"),
                                                                               "Variant Code" = field("Variant Filter"),
                                                                               "Expected Receipt Date" = field("Date Filter"),
                                                                               "Unit of Measure Code" = field("Unit of Measure Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(52101; "ERF Qty. Archive Purch. Quote"; Decimal)
        {
            Caption = 'Qty. on Archive Purchase Quote';
            CalcFormula = sum("Purchase Line Archive"."Outstanding Qty. (Base)" where("Document Type" = const(Quote),
                                                                               Type = const(Item),
                                                                               "No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Location Code" = field("Location Filter"),
                                                                               "Drop Shipment" = field("Drop Shipment Filter"),
                                                                               "Variant Code" = field("Variant Filter"),
                                                                               "Expected Receipt Date" = field("Date Filter"),
                                                                               "Unit of Measure Code" = field("Unit of Measure Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
    }
    procedure GetExtendedDescription(): Text
    var
        ItemAdditionalFields: Record "ERF Item Additional Fields";
    begin
        if ItemAdditionalFields.Get(Rec."No.") then
            exit(ItemAdditionalFields."Extended Description");
    end;
}
