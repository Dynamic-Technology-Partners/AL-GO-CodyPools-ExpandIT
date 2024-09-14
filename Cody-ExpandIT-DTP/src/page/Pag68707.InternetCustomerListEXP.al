/// <summary>
/// Page Internet Customer List EXP (ID 68707).
/// </summary>
page 68707 "Internet Customer List EXP"
{
    // version EIS5.04.01

    // EIS5.04.01  2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'Internet Customer List', Comment = 'DAN="Internet Kundeoversigt",DEU="Internet Kundenliste",ESP="Lista Clientes Internet",FRA="Liste des clients Internet",SVE="Internet kundlista"';
    CardPageID = "Internet Customer Card EXP";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "Internet Customer EXP";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Name; Rec."Name EXP")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No. EXP")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail EXP")
                {
                    ApplicationArea = All;
                }
                field(Login; Rec."Login EXP")
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec."Contact EXP")
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
            group("Net &Cust.")
            {
                Caption = 'Net &Cust.', Comment = 'DAN="Net &kunde",DEU="Net &Kunde",ESP="&e-Cliente",FRA="&Client",SVE="Nät &Kund"';
                separator(Separator30)
                {
                }
                action(Impersonate)
                {
                    Caption = 'Impersonate', Comment = 'DAN="Login som kunde",DEU="darstellen",ESP="Impersonalizar",FRA="Imiter client Internet",SVE="Personifiera"';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        InternetShopMgt.CustomerImpersonate(Rec);
                    end;
                }
                action("New Password")
                {
                    Caption = 'New Password', Comment = 'DAN="Nyt kodeord",DEU="Neues Passwort",ESP="Nueva Password",FRA="Nouveau mot de passe",SVE="Nytt lösenord"';
                    Image = NewSparkle;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        InternetShopMgt.CustomerChangePassword(Rec);
                    end;
                }
            }
            group("Net S&ales")
            {
                Caption = 'Net S&ales', Comment = 'DAN="Net s&alg",DEU="Net V&erkauf",ESP="&e-Ventas",FRA="&Ventes",SVE="Nät Fö&rsäljning"';
                action("&Orders")
                {
                    Caption = '&Orders', Comment = 'DAN="&Ordrer",DEU="&Bestellungen",ESP="&Pedidos",FRA="C&ommandes",SVE="&Order"';
                    Image = Document;
                    RunObject = Page "ExpandIT Sales List EXP";
                    RunPageLink = "Bill-to Net Customer No. EXP" = FIELD("No. EXP");
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := true;
    end;

    var
        InternetShopSetup: Record "Sales & Receivables Setup";
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
}

