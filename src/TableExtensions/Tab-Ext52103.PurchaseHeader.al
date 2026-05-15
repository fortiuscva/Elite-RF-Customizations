tableextension 52103 "ERF Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(52100; "ERF CoC Required"; Boolean)
        {
            Caption = 'COC Required';
            DataClassification = CustomerContent;
        }
        field(52101; "ERF Job ID"; Code[20])
        {
            Caption = 'Job ID';
            DataClassification = CustomerContent;
            TableRelation = "Sales Header"."No." where("Document Type" = filter(order));

            trigger OnValidate()
            begin
                Rec.RecreatePurchLines("ERF Job ID");
            end;
        }
    }

    trigger OnInsert()
    begin
        "ERF CoC Required" := true;
    end;
}
