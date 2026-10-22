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
    actions
    {
        addlast("O&rder")
        {
            action("ERF IncomingQualityInspectionCheckList")
            {
                Caption = 'F-812-10 Incoming Quality Inspection CheckList';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Print the incoming quality inspection checklist for the selected purchase order line.';

                trigger OnAction()
                var
                    PurchaseLine: Record "Purchase Line";
                begin
                    CurrPage.SetSelectionFilter(PurchaseLine);
                    PurchaseLine.SetRange(Type, Rec.Type);
                    PurchaseLine.SetRange("No.", Rec."No.");

                    Report.RunModal(Report::"F-812-10 Incoming Quality IC", true, false, PurchaseLine);
                    CurrPage.Update(false);
                end;
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
