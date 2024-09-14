/// <summary>
/// Page Internet Exchange Rates EXP (ID 68710).
/// </summary>
page 68710 "Internet Exchange Rates EXP"
{
    // version EIS5.04.01

    // EIS4.00.02 2012-01-10  PB  * From-currency made not editable and the form is changed from being a subform to a list form.
    // EIS5.04.01 2018-02-02  FAM  * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EIS6.0.12 2020-09-10 FAM * Get ExpandIT Setup record

    Caption = 'Internet Exchange Rates', Comment = 'DAN="Internet Valutakurser",ESP="Tipos de cambio Internet",FRA="Taux de change sur l''internet"';
    PageType = List;
    SourceTable = "Internet Exchange Rate EXP";


    layout
    {
        area(content)
        {
            repeater(Table1)
            {
                field("From Currency"; Rec."From Currency EXP")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        FromCurrencyOnAfterValidate;
                    end;
                }
                field("To Currency"; Rec."To Currency EXP")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ToCurrencyOnAfterValidate;
                    end;
                }
                field("Exchange Rate"; Rec."Exchange Rate EXP")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ExchangeRateOnAfterValidate;
                    end;
                }
                field(ExampleText; ExampleText)
                {
                    Caption = 'Example', Comment = 'DAN="Eksempel",DEU="Vorschau",ESP="Demostración",FRA="Exemple",SVE="Exempel"';
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        UpdateExample;
    end;

    trigger OnInit();
    begin

    end;

    var
        ExampleText: Text[250];
        ExpandITSetup: Record "ExpandIT Setup EXP";

    /// <summary>
    /// UpdateExample.
    /// </summary>
    procedure UpdateExample();
    var
        FromCurrency: Text[30];
        ToCurrency: Text[30];
        ExpandITUtil: Codeunit "ExpandIT Util";
    begin
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EIS6.0.12
            ToCurrency := Rec."To Currency EXP";
            FromCurrency := Rec."From Currency EXP";

            if (Rec."From Currency EXP" = '') then
                FromCurrency := ExpandITSetup."Internet Default Curr Code EXP";

            if (Rec."To Currency EXP" = '') then
                ToCurrency := ExpandITSetup."Internet Default Curr Code EXP";

            if (FromCurrency <> '') and (ToCurrency <> '') then
                ExampleText := '100 ' + ToCurrency + ' = ' + FORMAT(Rec."Exchange Rate EXP") + ' ' + FromCurrency
            else
                ExampleText := '';
        end;
    end;

    local procedure FromCurrencyOnAfterValidate();
    begin
        UpdateExample;
    end;

    local procedure ToCurrencyOnAfterValidate();
    begin
        UpdateExample;
    end;

    local procedure ExchangeRateOnAfterValidate();
    begin
        UpdateExample;
    end;
}

