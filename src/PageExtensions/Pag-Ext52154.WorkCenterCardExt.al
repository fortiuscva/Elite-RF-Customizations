pageextension 52154 "ERF Work Center Card Ext" extends "Work Center Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("ERF No to Print Barcode"; Rec."ERF Do Not Print Barcode")
            {
                ApplicationArea = All;
            }
        }
    }
}
