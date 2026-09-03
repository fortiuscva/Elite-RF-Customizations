table 52108 "ERF Engineering Group"
{
    Caption = 'Engineering Group';
    DataClassification = CustomerContent;
    LookupPageId = "ERF Engineering Groups";
    DrillDownPageId = "ERF Engineering Groups";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        {
        }
    }

    trigger OnDelete()
    var
        EngineeringGroupLine: Record "ERF Engineering Group Line";
        Item: Record Item;
        EngineeringGroupDeleteErr: Label 'Engineering Group %1 cannot be deleted because it is already assigned to one or more items.';
    begin
        Item.SetRange("ERF Engineering Group", Code);
        if not Item.IsEmpty() then
            Error(EngineeringGroupDeleteErr, Code);

        EngineeringGroupLine.SetRange("Engineering Group Code", Code);
        EngineeringGroupLine.DeleteAll();
    end;
}

