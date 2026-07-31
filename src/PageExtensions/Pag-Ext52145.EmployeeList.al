pageextension 52145 "ERF Employee List" extends "Employee List"
{
    actions
    {
        addlast(processing)
        {
            action("ERF EmployeeBarcode")
            {
                ApplicationArea = all;
                Caption = 'Employee Barcode';
                Image = BarCode;
                Ellipsis = true;
                trigger OnAction()
                var
                    Employee: Record Employee;
                begin
                    CurrPage.SetSelectionFilter(Employee);
                    Report.RunModal(Report::"ERF Employee Badge", true, false, Employee);
                end;
            }
        }
        addafter("Ledger E&ntries_Promoted")
        {
            actionref("ERF Employee Barcode"; "ERF EmployeeBarcode")
            { }
        }
    }
}
