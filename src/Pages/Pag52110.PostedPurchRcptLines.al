page 52110 "ERF Posted Purch. Rcpt. Lines"
{
    ApplicationArea = All;
    Caption = 'ERF Posted Purch. Rcpt. Lines';
    PageType = List;
    SourceTable = "Purch. Rcpt. Line";
    UsageCategory = Lists;
    SourceTableView = where(Type = const(Item), Quantity = filter(> 0));
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the receipt number.';
                }
                field("PO No."; Rec."Order No.")
                {
                    Caption = 'PO No.';
                    ToolTip = 'Specifies the line number of the order that created the entry.';
                }

                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Item No."; ItemNo)
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of the item on the line.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date the items were expected.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("ERF Supplier Late Delivery"; Rec."ERF Supplier Late Delivery")
                {
                    ToolTip = 'Specifies the value of the Supplier OTD field.', Comment = '%';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Buy-from Vendor No. field.', Comment = '%';
                }
                field(VendorName; VendorName)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        VendorName := '';
        ItemNo := Rec."No.";
        if Vendor.Get(Rec."Buy-from Vendor No.") then
            VendorName := Vendor.Name;
    end;

    var
        Vendor: Record Vendor;
        VendorName: Text[100];
        ItemNo: Code[20];
}
