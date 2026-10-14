
page 52128 "ERF SFTT Entry test"
{
    ApplicationArea = All;
    Caption = 'Shop Floor Time Tracking Entry Test';
    PageType = Card;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;
    UsageCategory = Tasks;



    layout
    {
        area(Content)
        {
            grid(MainLayout)
            {
                GridLayout = Columns;

                group(ScannerGroup)
                {
                    ShowCaption = false;

                    usercontrol(Scanner; "ERF SFTT Scanner")
                    {
                        ApplicationArea = All;

                        trigger ControlAddInReady()
                        begin
                        end;


                        trigger BarcodeScanned(Barcode: Text)
                        var
                            Parts: List of [Text];
                        begin
                            if Barcode = '' then
                                exit;

                            Parts := Barcode.Split('-');

                            if Parts.Count() <> 3 then
                                Error(
                                    'Invalid operation barcode. Expected ProductionOrder-LineNo-OperationNo.');

                            ProdOrderNoVarGbl := CopyStr(Parts.Get(1), 1, 20);

                            if not Evaluate(LineNoVarGbl, Parts.Get(2)) then
                                Error('Invalid line number in barcode.');

                            OperationNoVarGbl := CopyStr(Parts.Get(3), 1, 10);

                            CurrPage.Update(false);
                        end;

                    }
                }

                group(Fields)
                {
                    ShowCaption = false;

                    field("Prod Order No."; ProdOrderNoVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'RPO No.';
                        Editable = false;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ProductionOrder: Record "Production Order";
                        begin
                            ProductionOrder.Reset();
                            ProductionOrder.Get(
                                ProductionOrder.Status::Released,
                                ProdOrderNoVarGbl);

                            if Page.RunModal(
                                Page::"Released Production Order",
                                ProductionOrder) = Action::LookupOK
                            then
                                exit(true);
                        end;
                    }

                    field("Line No."; LineNoVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Line No.';
                        Editable = false;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ProdOrderLine: Record "Prod. Order Line";
                        begin
                            ProdOrderLine.Reset();
                            ProdOrderLine.Get(
                                ProdOrderLine.Status::Released,
                                ProdOrderNoVarGbl,
                                LineNoVarGbl);

                            if Page.RunModal(
                                Page::"Prod. Order Line List",
                                ProdOrderLine) = Action::LookupOK
                            then
                                exit(true);
                        end;
                    }

                    field("Operation No."; OperationNoVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Operation No.';
                        Editable = false;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ProdOrderRoutingLine: Record "Prod. Order Routing Line";
                            SFTTFunctions: Codeunit "ERF SFTT Functions";
                            RoutingNo: Code[20];
                        begin
                            RoutingNo := SFTTFunctions.GetRoutingNo(
                                ProdOrderNoVarGbl,
                                LineNoVarGbl,
                                OperationNoVarGbl);

                            ProdOrderRoutingLine.Reset();
                            ProdOrderRoutingLine.Get(
                                ProdOrderRoutingLine.Status::Released,
                                ProdOrderNoVarGbl,
                                LineNoVarGbl,
                                RoutingNo,
                                OperationNoVarGbl);

                            if Page.RunModal(
                                Page::"Prod. Order Routing",
                                ProdOrderRoutingLine) = Action::LookupOK
                            then
                                exit(true);
                        end;
                    }

                    field("Output Quantity"; OutputQtyVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Output Quantity';
                        DecimalPlaces = 0 : 2;
                    }

                    field("Serial No."; SerialNoVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Serial No.';
                    }
                }
            }
        }
    }



    actions
    {
        area(Processing)
        {
            action(StartOperation)
            {
                ApplicationArea = All;
                Caption = 'Start Operation';
                Ellipsis = true;
                Image = Start;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SFTTFunctions: Codeunit "ERF SFTT Functions";
                    StartOperationConfirmQst: Label 'Do you want to start the operation?';
                begin
                    if Confirm(StartOperationConfirmQst, false) then begin
                        SFTTFunctions.ValidateStartOperation(
                            ProdOrderNoVarGbl,
                            LineNoVarGbl,
                            OperationNoVarGbl);

                        SFTTFunctions.CreateShopFloorTimeTrackingEntry(
                            ProdOrderNoVarGbl,
                            LineNoVarGbl,
                            OperationNoVarGbl);
                    end;
                end;
            }

            action(StopOperation)
            {
                ApplicationArea = All;
                Caption = 'Stop Operation';
                Ellipsis = true;
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SFTTFunctions: Codeunit "ERF SFTT Functions";
                    StopOperationConfirmQst: Label 'Do you want to stop the operation?';
                begin
                    if Confirm(StopOperationConfirmQst, false) then begin
                        SFTTFunctions.UpdateShopFloorTimeTrackingEntry(
                            ProdOrderNoVarGbl,
                            LineNoVarGbl,
                            OperationNoVarGbl,
                            OutputQtyVarGbl,
                            SerialNoVarGbl);

                        Clear(ScanOperationCodeVarGbl);
                        Clear(ProdOrderNoVarGbl);
                        Clear(LineNoVarGbl);
                        Clear(OperationNoVarGbl);
                        Clear(OutputQtyVarGbl);
                        Clear(SerialNoVarGbl);

                        CurrPage.Scanner.ClearInputs();
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }

    var
        ScanOperationCodeVarGbl: Text;
        ProdOrderNoVarGbl: Code[20];
        LineNoVarGbl: Integer;
        OperationNoVarGbl: Code[10];
        OutputQtyVarGbl: Decimal;
        SerialNoVarGbl: Code[50];
}
