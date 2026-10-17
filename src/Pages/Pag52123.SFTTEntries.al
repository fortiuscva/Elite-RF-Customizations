page 52123 "ERF SFTT Entries"
{
    ApplicationArea = All;
    Caption = 'Shop Floor Time Tracking Entries';
    CardPageId = "ERF SFTT Entry";
    PageType = List;
    SourceTable = "ERF SFTT Entry";
    SourceTableView = sorting("Entry No.")
                      order(descending);

    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                    Visible = false;
                }
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
            action(UpdateEntry)
            {
                ApplicationArea = all;
                Caption = 'Update Entry';
                Ellipsis = true;
                Image = EditLines;
                trigger OnAction()
                var
                    UpdateSFTTEntry: Page "ERF Update SFTT Entry";
                begin
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
                begin
                    ProdOrderRoutingLine.Reset();
                    if ProdOrderRoutingLine.Get(ProdOrderRoutingLine.Status::Released, Rec."Prod Order No.", Rec."Line No.", 'STD', Rec."Operation No.") then
                        Page.RunModal(Page::"Prod. Order Routing", ProdOrderRoutingLine);
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
                    EmployeeUserIDMapping.SetRange("User ID", Rec."User ID");
                    if EmployeeUserIDMapping.FindLast() then
                        Page.RunModal(Page::"ERF User ID Mappings", EmployeeUserIDMapping);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(UpdateEntry_Promoted; UpdateEntry)
                {
                }
            }
            // group(Category_Category4)
            // {
            //     Caption = 'Related';
            //     actionref(Employee_Promoted; Employee)
            //     {
            //     }
            //     actionref(RPO_Promoted; RPO)
            //     {
            //     }
            // }
        }
    }
}
