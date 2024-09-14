/// <summary>
/// TableExtension ExpandIT SalesCue EXP (ID 68787) extends Record Sales Cue.
/// </summary>
tableextension 68787 "ExpandIT SalesCue EXP" extends "Sales Cue"
{
    fields
    {
        field(68786; "SalesOrders EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Open Sales Orders', Comment = 'DAN="Åbne Salgsordrer",DEU="Offene Verkaufsaufträge",ESP="",FRA="Commandes de vente",SVE=""';
            CalcFormula = count("ExpandIT Order Header EXP" where("Status EXP" = FILTER(new)));
        }

    }


}