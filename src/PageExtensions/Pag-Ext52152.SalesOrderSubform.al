pageextension 52152 "ERF Sales Order Subform" extends "Sales Order Subform"
{
    actions
    {
        addlast("O&rder")
        {
            action("ERF Final Quality Checklist")
            {
                ApplicationArea = All;
                Caption = 'Final Quality Checklist';
                Image = Print;

                ToolTip = 'Print the Final Quality Checklist for the selected sales order line.';

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."Document No.");
                    SalesLine.SetRange("Line No.", Rec."Line No.");
                    SalesLine.SetRange(Type, Rec.Type);
                    SalesLine.SetRange("No.", Rec."No.");

                    Report.RunModal(Report::"ERF Final Quality Checklist", true, false, SalesLine);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
