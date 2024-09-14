/// <summary>
/// TableExtension ItemVariant EXP (ID 68720) extends Record Item Variant.
/// </summary>
tableextension 68720 "ItemVariant EXP" extends "Item Variant"
{
    fields
    {
        field(68700; "QtyAvailable EXP"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Quantity Available', Comment = 'DAN="Antal på lager",DEU="e-payment Anbietercode",ESP="cantidad disponible",FRA="Quantité disponible",SVE="Tillgänglig kvantitet"';
            Description = 'EIS5.04.02';
            Editable = false;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."), "Variant Code" = FIELD(Code)));

        }

        field(78750; "DTP Variant Sort Order"; Integer)
        {
            Caption = 'Variant Sort Order';
            Editable = true;
        }
    }
}