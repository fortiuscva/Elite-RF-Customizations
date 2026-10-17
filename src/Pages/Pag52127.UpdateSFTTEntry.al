page 52127 "ERF Update SFTT Entry"
{
    ApplicationArea = All;
    Caption = 'Update Shop Floor Time Tracking Entry';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field("Start Time"; StartTime)
            {
                ApplicationArea = all;
                Caption = 'Start Time';
            }
            field("End Time"; EndTime)
            {
                ApplicationArea = all;
                Caption = 'End Time';
            }
            field("Output Quantity"; OutputQty)
            {
                ApplicationArea = all;
                Caption = 'Output Quantity';
            }
            field("Serial No."; SerialNo)
            {
                ApplicationArea = All;
                Caption = 'Serial No.';

            }
        }
    }
    var
        StartTime: DateTime;
        EndTime: DateTime;
        OutputQty: Decimal;
        SerialNo: Code[250];

    procedure SetStartTime(StartTimePar: DateTime)
    begin
        StartTime := StartTimePar;
    end;

    procedure SetEndTime(EndTimePar: DateTime)
    begin
        EndTime := EndTimePar;
    end;

    procedure SetOutputQty(OutputQtyPar: Decimal)
    begin
        OutputQty := OutputQtyPar;
    end;

    procedure SetSerialNo(SerialNoPar: Code[250])
    begin
        SerialNo := SerialNoPar;
    end;

    procedure GetStartTime(): DateTime
    begin
        exit(StartTime);
    end;

    procedure GetEndTime(): DateTime
    begin
        exit(EndTime);
    end;

    procedure GetOutputQty(): Decimal
    begin
        exit(OutputQty);
    end;

    procedure GetSerialNo(): Code[250]
    begin
        exit(SerialNo);
    end;
}
