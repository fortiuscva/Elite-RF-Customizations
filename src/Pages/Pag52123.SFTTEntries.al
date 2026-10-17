page 52123 "ERF SFTT Entries"
{
    ApplicationArea = All;
    Caption = 'Shop Floor Time Tracking Entries';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ERF SFTT Entry";
    SourceTableView = sorting("Entry No.")
                      order(descending);
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }

                field("Prod Order No."; Rec."Prod Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Production Order No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Operation No. field.', Comment = '%';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Routing Header Item Description field.', Comment = '%';
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Routing Line Operation Description field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("Output Quantity"; Rec."Output Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Output Quantity field.', Comment = '%';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
                }
                field("Duration in Minutes"; Rec."Duration in Minutes")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Duration in Minutes field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Processed field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {
                Caption = 'Notes';
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateOutputJournals)
            {
                ApplicationArea = All;
                Caption = 'Create Output Journals';
                Ellipsis = true;
                Image = OutputJournal;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    SFTTSetup: Record "ERF SFTT Setup";
                    SFTTFunctions: Codeunit "ERF SFTT Functions";
                    CreateOutputJournalConfirmQst: Label 'Do you want to create an Output Journal for this Shop Floor Time Tracking Entry?';
                    OutputJournalSuccessfullyCreatedLbl: Label 'The Output Journal was created successfully for this Shop Floor Time Tracking Entry.';
                begin
                    if Confirm(CreateOutputJournalConfirmQst, false) then begin
                        Rec.TestField(Rec.Status, Rec.Status::Finished);
                        SFTTSetup.Get();
                        SFTTFunctions.CreateOutputJournal(Rec, SFTTSetup);
                        Message(OutputJournalSuccessfullyCreatedLbl, Rec."Entry No.");
                    end;
                end;
            }
            action(DeleteEntry)
            {
                ApplicationArea = all;
                Caption = 'Delete Entry';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    Rec.TestField(Processed, false);
                    Rec.TestField(Rec.Status, Rec.Status::Finished);
                    Rec.Delete(true);
                end;

            }
            action(UpdateEntry)
            {
                ApplicationArea = all;
                Caption = 'Update Entry';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    UpdateSFTTEntry: Page "ERF Update SFTT Entry";
                    UserSetup: Record "User Setup";
                begin
                    Rec.TestField(Processed, false);
                    Rec.TestField(Rec.Status, Rec.Status::Finished);
                    If UserSetup.Get(UserId) then
                        if not UserSetup."ERF Allow Update SFTT Entries" then
                            Error('You do not have the necessary permissions to update this Shop Floor Time Tracking Entry');

                    UpdateSFTTEntry.SetStartTime(Rec."Start Time");
                    UpdateSFTTEntry.SetEndTime(Rec."End Time");
                    UpdateSFTTEntry.SetOutputQty(Rec."Output Quantity");
                    UpdateSFTTEntry.SetSerialNo(Rec."Serial No.");

                    if UpdateSFTTEntry.RunModal() = Action::OK then begin
                        Rec.Validate("Start Time", UpdateSFTTEntry.GetStartTime());
                        Rec.Validate("End Time", UpdateSFTTEntry.GetEndTime());
                        Rec.Validate("Output Quantity", UpdateSFTTEntry.GetOutputQty());
                        Rec.Validate("Serial No.", UpdateSFTTEntry.GetSerialNo());
                        Rec.Modify(true);
                        CurrPage.Update(false);
                    end
                end;
            }
        }
        area(Navigation)
        {
            action(RPO)
            {
                ApplicationArea = All;
                Caption = 'Released Production Order';
                Ellipsis = true;
                Image = Production;
                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                begin
                    ProductionOrder.Reset();
                    if ProductionOrder.Get(ProductionOrder.Status::Released, Rec."Prod Order No.") then
                        Page.Run(Page::"Released Production Order", ProductionOrder);
                end;
            }
            action(Employee)
            {
                ApplicationArea = All;
                Caption = 'Employee';
                Ellipsis = true;
                Image = Employee;
                trigger OnAction()
                var
                    Employee: Record Employee;
                begin
                    Employee.Reset();
                    if Employee.Get(Rec."Employee No.") then
                        Page.Run(Page::"Employee Card", Employee);
                end;
            }
            action(ProdOrderRouting)
            {
                ApplicationArea = All;
                Caption = 'Prod. Order Routing';
                Ellipsis = true;
                Image = Route;
                trigger OnAction()
                var
                    ProdOrderRoutingLine: Record "Prod. Order Routing Line";
                    RoutingNo: Code[20];
                begin
                    RoutingNo := Rec.GetRoutingNo(Rec."Prod Order No.", Rec."Line No.", Rec."Operation No.");
                    ProdOrderRoutingLine.Reset();
                    if ProdOrderRoutingLine.Get(ProdOrderRoutingLine.Status::Released, Rec."Prod Order No.", Rec."Line No.", RoutingNo, Rec."Operation No.") then
                        Page.Run(Page::"Prod. Order Routing Lines", ProdOrderRoutingLine);
                end;
            }
            action(EmployeeUserIDMapping)
            {
                ApplicationArea = All;
                Caption = 'Employee User ID Mapping';
                Ellipsis = true;
                Image = Route;
                trigger OnAction()
                var
                    EmployeeUserIDMapping: Record "ERF User ID Mapping";
                begin
                    EmployeeUserIDMapping.Reset();
                    EmployeeUserIDMapping.SetRange("Employee No.", Rec."Employee No.");
                    if EmployeeUserIDMapping.FindLast() then
                        Page.RunModal(Page::"ERF User ID Mappings", EmployeeUserIDMapping);
                end;
            }
        }
    }
}
