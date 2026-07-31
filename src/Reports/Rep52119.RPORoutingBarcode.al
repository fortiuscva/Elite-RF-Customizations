report 52119 "ERF RPO Routing Barcode"
{
    ApplicationArea = All;
    Caption = 'RPO Routing Barcode';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/ERFRPORoutingBarcode.rdl';
    dataset
    {

        dataitem(ProductionOrder; "Production Order")
        {
            RequestFilterFields = Status, "No.";
            column(RPONOCaption; RPONOCaption)
            { }
            column(RPOBarCodeCaption; RPOBarCodeCaptionLbl)
            { }
            column(CompanyName; CompanyName)
            { }
            Column(RPONo; "No.")
            { }
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = Status = field(Status), "Prod. Order No." = field("No.");
                Column(RPOLineNo; "Line No.")
                { }
                column(RPOLineNoCaption; RPOLineNoCaption)
                { }
                dataitem("Prod. Order Routing Line"; "Prod. Order Routing Line")
                {
                    DataItemLink = Status = field(Status),
                                    "Prod. Order No." = field("Prod. Order No."),
                                    "Routing Reference No." = field("Routing Reference No.");
                    Column(Operation_No_; "Operation No.")
                    { }
                    column(Description; Description)
                    { }
                    Column(BarCodeText; BarCodeText)
                    { }
                    column(OperationNoCaption; OperationNoCaption)
                    { }
                }
            }
        }
    }
    var
        RPONOCaption: Label 'Production Order No.';
        RPOLineNoCaption: Label 'Line No.';
        OperationNoCaption: Label 'Operation No.';
        BarCodeCaption: Label 'BarCode';
        BarCodeText: Text;
        RPOBarCodeCaptionLbl: Label 'Operation No BarCode';
}


