reportextension 52100 "Create Invt Put-away/Pick/Mvmt" extends "Create Invt Put-away/Pick/Mvmt"
{
    requestpage
    {
        layout
        {
            modify("Reserved From Stock")
            {
                trigger OnAfterValidate()
                var
                    SingleInstance: Codeunit "ERF Single Instance";
                begin
                    SingleInstance.SetReservedFroMStock(ReservedFromStock);
                end;
            }
        }
    }
}
