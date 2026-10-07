page 52120 "ERF Update Engg Entry"
{
    ApplicationArea = All;
    Caption = 'Update Engg Entry';
    PageType = StandardDialog;
    layout
    {
        area(Content)
        {

            field("Start Time"; StartTime)
            {
                ApplicationArea = All;
                Caption = 'Satrt Time';
            }
            field("End Time"; "EndTime")
            {
                ApplicationArea = All;
                Caption = 'End Time';
            }
        }
    }
    var
        StartTime: DateTime;
        EndTime: DateTime;

    procedure SetStartTime(StartTimePar: DateTime)
    begin
        StartTime := StartTimePar;
    end;

    procedure SetEndTime(EndTimePar: DateTime)
    begin
        EndTime := EndTimePar;
    end;

    procedure GetStartTime(): DateTime
    begin
        exit(StartTime);
    end;

    procedure GetEndTime(): DateTime
    begin
        exit(EndTime);
    end;
}
