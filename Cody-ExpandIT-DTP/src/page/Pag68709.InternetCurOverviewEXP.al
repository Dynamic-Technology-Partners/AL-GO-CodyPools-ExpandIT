/// <summary>
/// Page Internet Cur. Overview EXP (ID 68709).
/// </summary>
page 68709 "Internet Cur. Overview EXP"
{
    // version EIS5.04.01

    // EIS5.04.01 2012-01-10  PB  * The form is changed from being a card to a list form.

    Caption = 'Internet Currencies Overview', Comment = 'DAN="Internet Valuta Overblik",ESP="Resumen de monedas Internet",FRA="Aperçu des devises sur l''internet"';
    PageType = List;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = Currency;

    layout
    {
        area(content)
        {
            repeater(Control1160840000)
            {
                field("Code"; Rec.Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Enabled; Enabled)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Exch. &Rates")
            {
                Caption = 'Exch. &Rates', Comment = 'DAN="Kur&ser",ESP="&Tipo Cambio",FRA="&Taux de change"';
                Image = CurrencyExchangeRates;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Internet Exchange Rates EXP";
                RunPageLink = "From Currency EXP" = FIELD("Code");
                ApplicationArea = All;
            }
        }
    }

    var
        Enabled: Boolean;
}

