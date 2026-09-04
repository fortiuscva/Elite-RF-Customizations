pageextension 52148 "ERF Job Queue Entry Card" extends "Job Queue Entry Card"
{
    layout
    {
        addlast(General)
        {

            field("ERF Set Ready When Failed"; Rec."ERF Set Ready When Failed")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Set Ready When Failed field.', Comment = '%';
            }
            field("ERF Send Failure Notification"; Rec."ERF Send Failure Notification")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Send Failure Notification field.', Comment = '%';
            }
            field("ERF Notify All EmailRecipients"; Rec."ERF Notify All EmailRecipients")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Send Job Queue Failure Notification to all the Email Recipients field.', Comment = '%';
            }
        }
    }
}
