/// <summary>
/// Table Internet Exchange Rate EXP (ID 68705).
/// </summary>
table 68705 "Internet Exchange Rate EXP"
{
    // version EIS5.04.01

    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'Internet Currency Exchage', Comment = 'DAN="Internet Valuta Kurs",DEU="Internet Währungskurs",ESP="Internet Cambio Divisa",FRA="Taux de change Internet",SVE="Internet valutaväxling"';

    fields
    {
        field(1; "From Currency EXP"; Code[10])
        {
            Caption = 'From Currency', Comment = 'DAN="Fra Valuta",DEU="Von Währung",ESP="Divisa Origen",FRA="De",SVE="Från valuta"';
            Description = 'EIS5.04.01';
            TableRelation = Currency.Code;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SuggestExchangeRate;
            end;
        }
        field(2; "To Currency EXP"; Code[10])
        {
            Caption = 'To Currency', Comment = 'DAN="Til Valuta",DEU="bis Währung",ESP="Divisa Destino",FRA="A",SVE="Till valuta"';
            Description = 'EIS5.04.01';
            TableRelation = Currency.Code;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SuggestExchangeRate;
            end;
        }
        field(3; "Exchange Rate EXP"; Decimal)
        {
            Caption = 'Exchange Rate', Comment = 'DAN="Valuta Kurs",DEU="Wechselkurs",ESP="Tipo Cambio",FRA="Taux de change",SVE="Växlingskurs"';
            DecimalPlaces = 1 : 6;
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "From Currency EXP", "To Currency EXP")
        {
        }
    }

    fieldgroups
    {
    }

    var
        InternetCurrencyExchange: Record "Internet Exchange Rate EXP";

    /// <summary>
    /// SuggestExchangeRate.
    /// </summary>
    procedure SuggestExchangeRate();
    begin
        "Exchange Rate EXP" := 0;
        if "From Currency EXP" = "To Currency EXP" then begin
            "Exchange Rate EXP" := 1;
        end
        else begin
            InternetCurrencyExchange.SETRANGE("To Currency EXP", "From Currency EXP");
            InternetCurrencyExchange.SETRANGE("From Currency EXP", "To Currency EXP");
            if InternetCurrencyExchange.FIND('-') then begin
                "Exchange Rate EXP" := 10000 / InternetCurrencyExchange."Exchange Rate EXP"
            end
            else begin
                InternetCurrencyExchange.RESET;
                InternetCurrencyExchange.SETRANGE("From Currency EXP", "From Currency EXP");
                InternetCurrencyExchange.SETRANGE("To Currency EXP", "To Currency EXP");
                if InternetCurrencyExchange.FIND('-') then begin
                    "Exchange Rate EXP" := InternetCurrencyExchange."Exchange Rate EXP"
                end;
            end;
        end;
    end;
}

