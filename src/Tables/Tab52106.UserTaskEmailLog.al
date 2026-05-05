table 52106 "ERF User Task Email Log"
{
    Caption = 'User Task Email Log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(2; "User Task ID"; Code[50])
        {
            Caption = 'User Task ID';
        }

        field(3; "Task Subject"; Text[100])
        {
            Caption = 'Task Subject';
        }

        field(4; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
        }

        field(5; Email; Text[100])
        {
            Caption = 'Email Address';
        }

        field(6; "Sent DateTime"; DateTime)
        {
            Caption = 'Sent Date & Time';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
