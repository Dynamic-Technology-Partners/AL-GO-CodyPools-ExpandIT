// EMSM18.0.6.139  2020-07-27  FAM * Create an Item Tracking Line if SerialNo and Item Tracking Code is set for an Item. 
/// <summary>
/// TableExtension ItemVariantFromItem EXP (ID 68722) extends Record Item.
/// </summary>
tableextension 68722 "ItemVariantFromItem EXP" extends "Item"
{
    fields
    {
        field(68700; "QtyAvailable EXP"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Quantity Available', Comment = 'DAN="Antal på lager",DEU="e-payment Anbietercode",ESP="cantidad disponible",FRA="Quantité disponible",SVE="Tillgänglig kvantitet"';
            Description = 'EIS5.04.02';
            Editable = false;
            TableRelation = "Item Variant";
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter")));

        }
        field(68701; "EXPRequireSerialNo EXP"; Boolean)
        {
            FieldClass = FlowField;
            Caption = 'Require Serial No.', comment = 'DAN="Kræv Serienummer", DEU="",ESP="",FRA="", SVE=""';
            Editable = false;
            TableRelation = "Item Tracking Code";
            CalcFormula = lookup("Item Tracking Code"."SN Specific Tracking" WHERE(Code = FIELD("Item Tracking Code")));
            Description = 'EMSM18.0.6.139';
        }
        field(68702; "EXPRequireLotNo EXP"; Boolean)
        {
            FieldClass = FlowField;
            Caption = 'Require Lot No.', comment = 'DAN="Kræv Lot. Nr.", DEU="",ESP="",FRA="", SVE=""';
            Editable = false;
            TableRelation = "Item Tracking Code";
            CalcFormula = lookup("Item Tracking Code"."Lot Specific Tracking" WHERE(Code = FIELD("Item Tracking Code")));
            Description = 'EMSM18.0.6.139';
        }
        field(68750; "DTP Variant Sort Order"; Integer)
        {
            Caption = 'Variant Sort Order';
            Description = 'EE13.0.0';
            Editable = true;
        }
        field(68755; "DTP Master Item"; Code[20])
        {
            Caption = 'Master Item';
            TableRelation = Item."No.";
            Description = 'EE13.0.0';
            Editable = true;
        }
        field(68760; "DTP UNSPSC"; code[10])
        {
            Caption = 'UNSPSC';
            Description = 'EE13.0.0';
            Editable = true;
        }
    }
}