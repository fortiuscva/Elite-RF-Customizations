tableextension 52136 "ERF Job Queue Entry" extends "Job Queue Entry"
{
    fields
    {
        field(52100; "ERF Set Ready When Failed"; Boolean)
        {
            Caption = 'Set Ready When Failed';
            DataClassification = CustomerContent;
        }
        field(52101; "ERF Send Failure Notification"; Boolean)
        {
            Caption = 'Send Failure Notification';
            DataClassification = CustomerContent;
        }
        field(52102; "ERF Notify All EmailRecipients"; Text[250])
        {
            Caption = 'Send Job Queue Failure Notification to all the Email Recipients';
            DataClassification = CustomerContent;
        }
    }
}
