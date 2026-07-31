pageextension 52144 "DSHIP Quick Label Worksheet" extends "DSHIP Quick Label Worksheet"
{
    layout
    {
        addafter("Shpt. Dim. Unit of Measure")
        {
            field("ERF Insurance Value"; Rec."ERF Insurance Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Insurance Value field.', Comment = '%';
            }
        }
    }
}
