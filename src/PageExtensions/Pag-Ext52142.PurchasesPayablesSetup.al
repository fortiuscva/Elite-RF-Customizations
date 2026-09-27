pageextension 52142 "ERF Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("ERF Supplier Grace Period"; Rec."ERF Supplier Grace Period")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier Grace Period field.', Comment = '%';
            }
            field("ERF PO Over Due Email To"; Rec."ERF PO Over Due Email To")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Over Due Report Email To field.';
            }
            field("ERF PO Over Due Email CC To"; Rec."ERF PO Over Due Email CC To")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Over Due Email CC To field.';
            }
        }
    }
}
