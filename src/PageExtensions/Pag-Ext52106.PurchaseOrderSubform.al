pageextension 52106 "ERF Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("ERF Job Id"; Rec."ERF Job Id")
            {
                ApplicationArea = all;
                ToolTip = 'Job Id';
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PurchHeader: Record "Purchase Header";
    begin
        if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then
            Rec."ERF Job ID" := PurchHeader."ERF Job ID";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PurchHeader: Record "Purchase Header";
    begin
        if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then
            Rec."ERF Job ID" := PurchHeader."ERF Job ID";
    end;
}
