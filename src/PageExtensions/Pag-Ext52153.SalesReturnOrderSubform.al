pageextension 52153 "ERF Sales Return Order Subform" extends "Sales Return Order Subform"
{
    actions
    {
        addlast("&Line")
        {
            action("ERF NCMForm")
            {
                ApplicationArea = All;
                Caption = 'Non Conforming Material Form';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Print the Nonconforming Material Form for the selected Sales Return Order Line.';

                trigger OnAction()
                var
                    NCMReport: Report "Non Confirming Material Form";
                    SalesLine: Record "Sales Line";
                begin
                    if Rec."Document Type" <> Rec."Document Type"::"Return Order" then
                        Error('The NCM Form can only be printed for Sales Return Orders.');

                    CurrPage.SetSelectionFilter(SalesLine);
                    SalesLine.SetRange(Type, Rec.Type);
                    SalesLine.SetRange("No.", Rec."No.");

                    Report.RunModal(Report::"Non Confirming Material Form", true, false, SalesLine);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
