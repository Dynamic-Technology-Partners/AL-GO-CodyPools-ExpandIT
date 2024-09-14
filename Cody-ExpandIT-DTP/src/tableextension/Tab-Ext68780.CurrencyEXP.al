/// <summary>
/// TableExtension Currency EXP (ID 68780) extends Record Currency.
/// </summary>
tableextension 68780 "Currency EXP" extends Currency
{
    // version NAVW111.00, EIS5.04.02

    fields
    {
        field(68700; "Prefix EXP"; Text[10])
        {
            Caption = 'Prefix', Comment = 'DAN="Symbol før",DEU="Präfix",ESP="Prefijo",FRA="Préfixe",SVE="Prefix"';
            Description = 'EIS5.04.02';
            DataClassification = CustomerContent;
        }
        field(68701; "Suffix EXP"; Text[10])
        {
            Caption = 'Suffix', Comment = 'DAN="Symbol efter",DEU="Suffix",ESP="Sufijo",FRA="Suffixe",SVE="Suffix"';
            Description = 'EIS5.04.02';
            DataClassification = CustomerContent;
        }
        field(68702; "Enabled EXP"; Boolean)
        {
            Caption = 'Enabled', Comment = 'DAN="Anvend",DEU="berechtigt",ESP="Habilitado",FRA="Activé",SVE="Aktiverad"';
            Description = 'EIS5.04.02';
            DataClassification = CustomerContent;
        }
        field(68703; "Number Of Decimals EXP"; Integer)
        {
            Caption = 'Number Of Decimals', Comment = 'DAN="Antal decimaler",DEU="Anzahl Dezimalstellen",ESP="Número de decimales",FRA="Nombre décimales",SVE="Antal decimaler"';
            Description = 'EIS5.04.02';
            DataClassification = CustomerContent;
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

