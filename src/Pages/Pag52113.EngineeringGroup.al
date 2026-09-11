page 52113 "ERF Engineering Group"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "ERF Engineering Group";

    Caption = 'Engineering Group';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }

            part(Lines; "ERF Engineering Group Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Engineering Group Code" = field(Code);
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;

                SubPageLink = "Table ID" = const(Database::"ERF Engineering Group"),
                              "No." = field(Code);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendEmail)
            {
                Caption = 'Send Email';
                ApplicationArea = All;
                Image = Email;

                trigger OnAction()
                var
                    EngineeringGroupEmail: Codeunit "ERF Engineering Group Email";
                begin
                    EngineeringGroupEmail.OpenEmailEditor(Rec);
                end;
            }
        }
    }
}

