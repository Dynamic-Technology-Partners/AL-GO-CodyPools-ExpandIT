/// <summary>
/// Page e-payment Provider EXP (ID 68712).
/// </summary>
page 68712 "e-payment Provider EXP"
{
    // version EIS5.04.01,EPAY1.1

    // EIS4.02.02  2018-02-02  DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EIS5.04.01  2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'e-payment Provider', Comment = 'DAN="e-betalings Udbyder",DEU="e-payment Anbieter",ESP="Proveedor e-Pago",FRA="Fournisseur de paiement en ligne",SVE="e-betalning provider"';
    PageType = Card;
    SourceTable = "e-payment Provider EXP";


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'DAN="Generelt",DEU="allgemein",ESP="General",FRA="Général",SVE="Allmänt"';
                field("Code"; Rec."Code EXP")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec."Name EXP")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec."Address EXP")
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2 EXP")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code EXP")
                {
                    Caption = 'Post Code/City', Comment = 'DAN="Postnr./By",DEU="PLZ/Stadt",ESP="C.P./Provincia",FRA="CP/Ville",SVE="Postnr/ort"';
                    ApplicationArea = All;
                }
                field(City; Rec."City EXP")
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code EXP")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No. EXP")
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec."Contact EXP")
                {
                    ApplicationArea = All;
                }
            }
            group(Communication)
            {
                Caption = 'Communication', Comment = 'DAN="Kommunikatin",DEU="Kommunikation",ESP="Comunicación",FRA="Communication",SVE="kommunikation"';
                field(PhoneNo2; Rec."Phone No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No. EXP")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail EXP")
                {
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page EXP")
                {
                    ApplicationArea = All;
                }
            }
            group(Administration)
            {
                Caption = 'Administration', Comment = 'DAN="Administration",DEU="Administration",ESP="Administración",FRA="Administration",SVE="Administration"';
                field("Provider Type"; Rec."Provider Type EXP")
                {
                    ApplicationArea = All;
                }
                field("Merchant ID"; Rec."Merchant ID EXP")
                {
                    ApplicationArea = All;
                }
                field("Login User ID"; Rec."Login User ID EXP")
                {
                    ApplicationArea = All;
                }
                field(Password; Rec."Password EXP")
                {
                    ApplicationArea = All;
                }
                field("Shared Secret"; Rec."Shared Secret EXP")
                {
                    ApplicationArea = All;
                }
                field("Administration Page"; Rec."Administration Page EXP")
                {
                    ApplicationArea = All;
                }
                field("Clearing Validity Period"; Rec."Clearing Validity Period EXP")
                {
                    ApplicationArea = All;
                }
                field("API URL"; Rec."API URL")
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
                action(List)
                {
                    Caption = 'List', Comment = 'DAN="Oversigt",DEU="Liste",ESP="Lista",FRA="Lister",SVE="Lista"';
                    Image = List;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "e-payment Providers EXP";
                    ShortCutKey = 'Shift+Ctrl+L';
                    ApplicationArea = All;
                }
                action("e-payment Entries")
                {
                    Caption = 'e-payment Entries', Comment = 'DAN="e-betalingsposter",DEU="e-payment Einträge",ESP="Entradas e-Pago",FRA="Ecitures paiement en ligne",SVE="e-betalningstransaktioner"';
                    Image = CreditCardLog;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Page "e-payment Entries EXP";
                    RunPageLink = "e-payment Provider Code EXP" = FIELD("Code EXP");
                    RunPageView = SORTING("e-payment Provider Code EXP", "Status EXP");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        Mail: Codeunit Mail;
}

