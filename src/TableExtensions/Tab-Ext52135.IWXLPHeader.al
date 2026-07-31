tableextension 52135 "ERF IWX LP Header" extends "IWX LP Header"
{
    fields
    {
        field(52100; "ERF Insurance Value"; Decimal)
        {
            Caption = 'Insurance Value';
            DataClassification = CustomerContent;
        }
    }
}
