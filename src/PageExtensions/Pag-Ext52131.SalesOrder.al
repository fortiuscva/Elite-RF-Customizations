pageextension 52131 "ERF Sales Order" extends "Sales Order"
{
    layout
    {
        addafter("Package Tracking No.")
        {
            field("ERF On Time Shipment"; Rec."ERF On Time Shipment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the On Time Shipment field.', Comment = '%';
            }
        }
    }
    trigger OnOpenPage()
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetRange("Completely Shipped", false);
        if SalesLine.FindLast() then begin
            Rec."ERF On Time Shipment" := Rec."ERF On Time Shipment"::No;
            Rec.Modify();
        end;
    end;

    var
        SalesLine: Record "Sales Line";
}
