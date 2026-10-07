page 52120 "ERF Update Engg Entry"
{
    ApplicationArea = All;
    Caption = 'Update Engineering Time Tracking Entry';
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
            field(Comments; Comment)
            {
                ApplicationArea = All;
                Caption = 'Comments';
                Importance = Additional;
                MultiLine = true;
                ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
            }
        }
    }
    var
        StartTime: DateTime;
        EndTime: DateTime;
        Comment: Text;

    procedure SetStartTime(StartTimePar: DateTime)
    begin
        StartTime := StartTimePar;
    end;

    procedure SetEndTime(EndTimePar: DateTime)
    begin
        EndTime := EndTimePar;
    end;

    procedure SetComments(CommentsPar: Text)
    begin
        Comment := CommentsPar;
    end;

    procedure GetStartTime(): DateTime
    begin
        exit(StartTime);
    end;

    procedure GetEndTime(): DateTime
    begin
        exit(EndTime);
    end;

    Procedure GetComments(): Text
    begin
        exit(Comment);
    end;
}
