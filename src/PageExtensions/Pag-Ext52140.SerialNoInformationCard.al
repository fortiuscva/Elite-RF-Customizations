pageextension 52140 "Serial No. Information Card" extends "Serial No. Information Card"
{
    layout
    {
        addlast(General)
        {
            group("ERF NTS SerialNo. Notes")
            {
                Caption = 'Serial No. Notes';
                field("ERF NTS Serial No. Notes"; SerialNoNotes)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;

                    trigger OnValidate()
                    begin
                        Rec.SetSerialNoNotes(SerialNoNotes);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SerialNoNotes := Rec.GetSerialNoNotes();
    end;

    var
        SerialNoNotes: Text;
}