page 52123 "Product Test Failure Log Rev C"
{
    ApplicationArea = All;
    Caption = 'F-812-6 Product Test Failure Log Rev C';
    PageType = List;
    SourceTable = "Product Test Failure Log Rev C";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Issue Date"; Rec."Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.', Comment = '%';
                }
                field("Production Order No."; Rec."Production Order No.")
                {
                    ToolTip = 'Specifies the value of the Production Order No. field.', Comment = '%';
                }
                field("Report Issued By"; Rec."Report Issued By")
                {
                    ToolTip = 'Specifies the value of the Report Issued By field.', Comment = '%';
                }
                field("Report Issued By Name"; Rec."Report Issued By Name")
                {
                    ToolTip = 'Specifies the value of the Report Issued By field.', Comment = '%';
                }
                field("Assembled/Build By"; Rec."Assembled/Build By")
                {
                    ToolTip = 'Specifies the value of the Assembled/Build By field.', Comment = '%';
                }
                field("Assembled/Build By Name"; Rec."Assembled/Build By Name")
                {
                    ToolTip = 'Specifies the value of the Assembled/Build By field.', Comment = '%';
                }
                field("Model No./Part No."; Rec."Model No./Part No.")
                {
                    ToolTip = 'Specifies the value of the Model No./Part No. field.', Comment = '%';
                }
                field("Quantity of Parts under Test"; Rec."Quantity of Parts under Test")
                {
                    ToolTip = 'Specifies the value of the Quantity of Parts under Test field.', Comment = '%';
                }
                field("Tested By"; Rec."Tested By")
                {
                    ToolTip = 'Specifies the value of the Tested By field.', Comment = '%';
                }
                field("Tested By Name"; Rec."Tested By Name")
                {
                    ToolTip = 'Specifies the value of the Tested By Name field.', Comment = '%';
                }
                field("Test Date"; Rec."Test Date")
                {
                    ToolTip = 'Specifies the value of the Test Date field.', Comment = '%';
                }
                field("Item Type"; Rec."Item Type")
                {
                    ToolTip = 'Specifies the value of the Item Type field.', Comment = '%';
                }
                field("Serial Number (Failed)"; Rec."Serial Number (Failed)")
                {
                    ToolTip = 'Specifies the value of the Serial Number (Failed) field.', Comment = '%';
                }

                field("Defect Type"; Rec."Defect Type")
                {
                    ToolTip = 'Specifies the value of the Defect Type field.', Comment = '%';
                }
                field("Issue Found"; Rec."Issue Found")
                {
                    ToolTip = 'Specifies the value of the Issue Found field.', Comment = '%';
                }
                field("Corrective Action Taken"; Rec."Corrective Action Taken")
                {
                    ToolTip = 'Specifies the value of the Corrective Action Taken field.', Comment = '%';
                }
                field("Preventive Action Taken"; Rec."Preventive Action Taken")
                {
                    ToolTip = 'Specifies the value of the Preventive Action Taken field.', Comment = '%';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Closed by field.', Comment = '%';
                }
                field("Approved By Name"; Rec."Approved By Name")
                {
                    ToolTip = 'Specifies the value of the Approved By Name field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CopyRevBRecords)
            {
                Caption = 'Copy Rev B Records';
                ApplicationArea = All;
                Image = Copy;

                trigger OnAction()
                var
                begin
                    CopyRecords();
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec."Issue Date" = 0D then
            Rec."Issue Date" := Today;
    end;

    procedure CopyRecords()
    var
        RevB: Record "ERF Product Test Failure Log";
        RevC: Record "Product Test Failure Log Rev C";
        IsCopied: Boolean;
    begin
        if RevB.FindSet() then begin
            repeat
                if not RevC.Get(RevB."Entry No.") then begin
                    RevC.Init();
                    RevC.TransferFields(RevB);
                    RevC.Insert(True);
                end;
            until RevB.Next() = 0;

            Message('Rev B records copied to Rev C.');
        end
        else
            Message('No records there to copy to Rev C ');
    end;

}
