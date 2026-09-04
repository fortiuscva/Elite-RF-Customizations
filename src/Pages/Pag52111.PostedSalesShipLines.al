page 52111 "ERF Posted Sales Ship. Lines"
{
    PageType = List;
    SourceTable = "Sales Shipment Line";
    Caption = 'ERF Posted Sales Shipment Lines';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = where(Type = const(Item), Quantity = filter(> 0));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Posted Sales Shipment No."; Rec."Document No.")
                {
                    Caption = 'Posted Sales Shipment No.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Posted Sales Shipment Line No."; Rec."Line No.")
                {
                    Caption = 'Posted Sales Shipment Line No.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sales Order Number"; Rec."Order No.")
                {
                    Caption = 'Sales Order Number';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sales Order Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Item Number"; Rec."No.")
                {
                    Caption = 'Item Number';
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Ship Value"; Rec.Quantity * Rec."Unit Price")
                {
                    Caption = 'Total Ship Value';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("On Time Delivery Flag"; Rec."ERF On Time Shipment")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }
    /* actions
    {
        area(Processing)
        {
            action("ERF Update On Time Shipment")
            {
                ApplicationArea = All;
                Caption = 'Update On Time Shipment';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    SupplierOTDMgt: Codeunit "ERF Supplier OTD Management";
                    SalesShipmentLine: Record "Sales Shipment Line";
                begin
                    CurrPage.SetSelectionFilter(SalesShipmentLine);

                    if not Confirm('Do you want to update On Time Shipment to Yes for the selected records?', false) then
                        Rec."ERF On Time Shipment" := Rec."ERF On Time Shipment"::No
                    else
                        Rec."ERF On Time Shipment" := Rec."ERF On Time Shipment"::Yes;

                    SupplierOTDMgt.UpdateOnTimeShipment(SalesShipmentLine, Rec."ERF On Time Shipment");
                end;
            }
        }
    } */
}