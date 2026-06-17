pageextension 52123 "ERF Item Tracking Lines" extends "Item Tracking Lines"
{
    layout
    {
        modify(Description)
        {
            Visible = true;
            Caption = 'Date Code';
        }
        addafter(Description)
        {
            field("ERF Description"; Rec."ERF Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description field.', Comment = '%';
            }
        }
        addlast(Content)
        {
            grid(NotesGrid)
            {
                Caption = 'Notes';

                group("ERF NTS SerialNotesGrp")
                {

                    ShowCaption = false;

                    field("ERF NTS SerialNoNotes"; SerialNoNotesTxt)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Caption = 'Serial No. Notes';
                        MultiLine = true;

                    }
                }
            }
        }
    }
    var
        SerialNoNotesTxt: Text;

    trigger OnAfterGetRecord()
    begin
        GetSerialLotNoInfo();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetSerialLotNoInfo();
    end;

    procedure GetSerialLotNoInfo()
    var
        SerialNoInfo: Record "Serial No. Information";
        LotNoInfo: Record "Lot No. Information";
    begin
        Clear(SerialNoNotesTxt);

        if (Rec."Serial No." <> '') and
           SerialNoInfo.Get(Rec."Item No.", Rec."Variant Code", Rec."Serial No.") then
            SerialNoNotesTxt := SerialNoInfo.GetSerialNoNotes();
    end;
}