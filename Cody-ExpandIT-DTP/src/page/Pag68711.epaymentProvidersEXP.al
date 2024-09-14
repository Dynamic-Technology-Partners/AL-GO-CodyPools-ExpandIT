/// <summary>
/// Page e-payment Providers EXP (ID 68711).
/// </summary>
page 68711 "e-payment Providers EXP"
{
    // version EIS5.04.01

    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS5.04.01  2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'e-payment Providers', Comment = 'DAN="e-betalings Udbydere",DEU="e-payment Anbieter",ESP="Proveedores e-Pago",FRA="Fournisseurs de paiement en ligne",SVE="e-betalning provider"';
    CardPageID = "e-payment Provider EXP";
    PageType = List;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "e-payment Provider EXP";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec."Code EXP")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec."Name EXP")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Provider")
            {
                Caption = '&Provider', Comment = 'DAN="&Udbyder",DEU="&Anbieter",ESP="&Proveedor",FRA="Fo&urnisseur",SVE="&Provider"';
                action("e-payment Entries")
                {
                    Caption = 'e-payment Entries', Comment = 'DAN="e-betalingsposter",DEU="e-payment Einträge",ESP="Entradas e-Pago",FRA="Ecitures paiement en ligne",SVE="e-betalningstransaktioner"';
                    Image = CreditCardLog;
                    RunObject = Page "e-payment Entries EXP";
                    RunPageLink = "e-payment Provider Code EXP" = FIELD("Code EXP");
                    RunPageView = SORTING("e-payment Provider Code EXP", "Status EXP");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
            }
        }
    }
}

