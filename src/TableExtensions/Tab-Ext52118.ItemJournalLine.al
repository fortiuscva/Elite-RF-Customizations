tableextension 52118 "ERF Item Journal Line" extends "Item Journal Line"
{
    fields
    {
        field(52100; "ERF Prod. Ord. Comp. Rem. Qty"; Decimal)
        {
            Caption = 'Prod. Order. Comp. Rem. Qty';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52101; "ERF Pick Code"; Text[500])
        {
            Caption = 'Pick Code';
            Editable = false;
        }
    }
}