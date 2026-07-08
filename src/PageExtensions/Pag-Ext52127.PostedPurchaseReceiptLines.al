pageextension 52127 "Posted Purchase Receipt Lines" extends "Posted Purchase Receipt Lines"
{
    layout
    {
        addlast(Control1)
        {

            field("ERF Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
            }
            field("ERF Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
            }
            field("ERF Job ID"; Rec."ERF Job ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job ID field.';
            }
        }
        addafter(Description)
        {
            field("ERF Supplier Late Delivery"; Rec."ERF Supplier Late Delivery")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier OTD field.', Comment = '%';
            }
        }
        modify("Expected Receipt Date")
        {
            Visible = true;
        }
    }
    actions
    {
        addlast(Processing)
        {
            action("ERF UpdateSupplierOTD")
            {
                ApplicationArea = All;
                Caption = 'Update Supplier OTD';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SupplierOTDMgt: Codeunit "ERF Supplier OTD Management";
                    PurchRcptLine: Record "Purch. Rcpt. Line";

                begin
                    CurrPage.SetSelectionFilter(PurchRcptLine);

                    if not Confirm('Do you want to update Supplier OTD to Yes for the selected records?',
       false) then
                        Rec."ERF Supplier Late Delivery" := false
                    else
                        Rec."ERF Supplier Late Delivery" := true;
                    SupplierOTDMgt.UpdateSupplierOTD(PurchRcptLine, Rec."ERF Supplier Late Delivery");
                end;
            }
        }
    }
}
