page 52114 "ERF Engineering Group Subpage"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "ERF Engineering Group Line";
    Caption = 'Lines';

    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                }
                field("Created User Name"; GetCreatedUserName())
                {
                    ApplicationArea = All;
                    Caption = 'Created User';
                    Editable = false;
                }

                field("Created Date Time"; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    Caption = 'Created Date Time';
                    Editable = false;
                }

                field("Last Modified User Name"; GetModifiedUserName())
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified User';
                    Editable = false;
                }

                field("Last Modified Date Time"; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified Date Time';
                    Editable = false;
                }
            }
        }
    }
    local procedure GetCreatedUserName(): Text[80]
    begin
        if CreatedByUser.Get(Rec.SystemCreatedBy) then
            exit(CreatedByUser."Full Name");

        exit('');
    end;

    local procedure GetModifiedUserName(): Text[80]
    begin
        if ModifiedByUser.Get(Rec.SystemModifiedBy) then
            exit(ModifiedByUser."Full Name");

        exit('');
    end;

    var
        CreatedByUser: Record User;
        ModifiedByUser: Record User;
}
