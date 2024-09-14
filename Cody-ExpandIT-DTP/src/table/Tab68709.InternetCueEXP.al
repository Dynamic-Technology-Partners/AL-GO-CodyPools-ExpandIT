/// <summary>
/// Table Internet Cue EXP (ID 68709).
/// </summary>
table 68709 "Internet Cue EXP"
{
    // version EIS5.04.01

    // EIS4.00   2010-08-23 JR   * This form is for the RTC and shows the number of unconverted Internet orders.
    // EIS5.04.01   2018-02-01 FAM  * DA/DEU/ESP/SVE/FRA label text is added.

    Caption = 'Internet Cue', Comment = 'DAN="Internetkø",ESP="Internet Cue",FRA="Attente internet"';

    fields
    {
        field(1; "Primary Key EXP"; Code[10])
        {
            Caption = 'Primary Key', Comment = 'DAN="Primærnøgle",DEU="Primärschlüssel",ESP="Clave Primaria",FRA="Clé primaire",SVE="Primärnyckel"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(2; "Internet Orders - New EXP"; Integer)
        {
            CalcFormula = Count("ExpandIT Order Header EXP" WHERE("Status EXP" = FILTER(New)));
            Caption = 'Internet Orders - New', Comment = 'DAN="Internetordre - Nye",DEU="Internet Bestellungen - Neu",ESP="Pedidos Internet - Nuevos",FRA="Commandes Internet - Nouvelle",SVE="Internetordrar - nya"';
            Description = 'EIS5.04.01';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key EXP")
        {
        }
    }

    fieldgroups
    {
    }
}

