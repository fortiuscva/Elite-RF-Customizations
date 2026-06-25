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
        }
    }
}
