/// <summary>
/// Page EMSM Service Sign List EXP (ID 68741).
/// </summary>
page 68741 "EMSM Service Sign List EXP"
{
    // version EMSM3.01.01

    // EMSM3.01.01  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EMSM3.01.01  2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'EMSM Service Signature List', Comment = 'DAN="EMSM Service Underskriftsliste",DEU="EMSM Service Unterschriftenliste",ESP="Lista firma servicio",FRA="Liste signature service EMSM",SVE="EMSM service underskriftslista"';
    CardPageID = "EMSM Service Sign List EXP";
    DataCaptionFields = "Order No. EXP";
    Editable = false;
    PageType = List;
    SourceTable = "EMSM Service Signature EXP";


    layout
    {
        area(content)
        {
            repeater(Control1160840000)
            {
                field("Order No."; Rec."Order No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Line No."; Rec."Item Line No. EXP")
                {
                    ApplicationArea = All;
                }
                field("BMP Signature"; Rec."BMP Signature EXP")
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
            group("&Signature")
            {
                Caption = '&Signature', Comment = 'DAN="&Underskrift",DEU="&Unterschrift",ESP="&Firma",FRA="&Signature",SVE="&Signatur"';
                action(View)
                {
                    Caption = 'View', Comment = 'DAN="Vis",DEU="Sicht",ESP="Vista",FRA="Afficher",SVE="Visa"';
                    Image = SignUp;
                    RunObject = Page "EMSM Service Sign List EXP";
                    RunPageLink = "BAS Guid EXP" = FIELD("BAS Guid EXP");
                    ApplicationArea = All;
                }
            }
        }
    }
}

