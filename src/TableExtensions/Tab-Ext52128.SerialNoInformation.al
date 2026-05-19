
tableextension 52128 "ERF Serial No. Information" extends "Serial No. Information"
{
    fields
    {
        field(52100; "ERF Serial No. Notes"; Blob)
        {
            Caption = 'Serial No. Notes';
            Subtype = Memo;
        }
        field(52101; "ERF Serial No. Notes Exists"; Boolean)
        {
            Caption = 'Serial No. Notes Exists';
            Editable = false;
        }
    }

    trigger OnBeforeInsert()
    begin
        HasSerialNoNotes();
    end;

    trigger OnBeforeModify()
    begin
        HasSerialNoNotes();
    end;

    procedure SetSerialNoNotes(NewNotes: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec."ERF Serial No. Notes");
        Rec."ERF Serial No. Notes".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewNotes);
        Rec.Modify();
    end;

    procedure GetSerialNoNotes(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields("ERF Serial No. Notes");

        if not Rec."ERF Serial No. Notes".HasValue then
            exit('');

        Rec."ERF Serial No. Notes".CreateInStream(InStream, TextEncoding::UTF8);

        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(),
                Rec.FieldName("ERF Serial No. Notes")
            ));
    end;

    procedure HasSerialNoNotes()
    begin
        Rec.CalcFields("ERF Serial No. Notes");
        if Rec."ERF Serial No. Notes".HasValue then
            Rec."ERF Serial No. Notes Exists" := true
        else
            Rec."ERF Serial No. Notes Exists" := false;
    end;
}