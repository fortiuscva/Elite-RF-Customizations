page 52107 "ERF TrackingCodeInputDialog"
{
    PageType = StandardDialog;
    Caption = 'Enter New Tracking Code';

    layout
    {
        area(Content)
        {
            field(NewTrackingCode; NewTrackingCode)
            {
                ApplicationArea = All;
                Caption = 'New Item Tracking Code';
                TableRelation = "Item Tracking Code";
            }
        }
    }

    var
        NewTrackingCode: Code[10];

    procedure GetTrackingCode(): Code[10]
    begin
        exit(NewTrackingCode);
    end;
}
