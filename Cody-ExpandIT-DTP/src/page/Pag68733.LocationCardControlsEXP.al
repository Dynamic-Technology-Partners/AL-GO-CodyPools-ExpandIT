/// <summary>
/// Page Location Card - Controls EXP (ID 68733).
/// </summary>
page 68733 "Location Card - Controls EXP"
{
    // version EMI2.13.02,COPYPASTE

    // EMI2.13.01 2010-09-08 JR  * The purpose of this form is to hold controls that you
    //                             can copy and paste to forms using the same source table.
    // EMI2.13.02 2012-11-01 PB  * Moved to NAV 2013 (NAVW17.00)
    // EMI2.13.02 2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    PageType = Card;
    SourceTable = Location;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
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
            group("E&xpandIT")
            {
                // Caption = 'E&xpandIT', Comment = 'DAN="E&xpandIT",DEU="E&xpandIT",ESP="E&xpandIT",FRA="E&xpandIT",SVE="E&xpandIT"';
                // action("Product Stock Defaults")
                // {
                //     Caption = 'Product Stock Defaults', Comment = 'DAN="Vare Normallager",DEU="Warenbestand Vorgabe",ESP="Stock de productos por defecto",FRA="Magasin Article par Défaut",SVE="Produkt Lager Defaults"';
                //     Image = List;
                //     RunObject = Page "EMI Location Product Defaults EXP";
                //     RunPageLink = "Location Code" = FIELD(Code);
                //     ApplicationArea = All;
                // }
            }
        }
    }
}

