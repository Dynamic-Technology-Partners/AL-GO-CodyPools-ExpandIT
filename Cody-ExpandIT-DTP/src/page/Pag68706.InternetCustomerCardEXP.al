/// <summary>
/// Page Internet Customer Card EXP (ID 68706).
/// </summary>
page 68706 "Internet Customer Card EXP"
{
    // version EIS5.04.01

    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'Internet Customer Card', Comment = 'DAN="Internet Kundekort",DEU="Internet Kundenkarte",ESP="Ficha Cliente Internet",FRA="Fiche client Internet",SVE="Internet kundkort"';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Internet Customer EXP";


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'DAN="Generelt",DEU="allgemein",ESP="General",FRA="Général",SVE="Allmänt"';
                field("No."; Rec."No. EXP")
                {
                    Editable = false;
                    Lookup = false;
                    LookupPageID = "Internet Customer List EXP";
                    ApplicationArea = All;
                }
                field(Name; Rec."Name EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Address; Rec."Address EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2 EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code EXP")
                {
                    Caption = 'Post Code/City', Comment = 'DAN="Postnr./By",DEU="PLZ/Stadt",ESP=" C.P./Provincia",FRA="CP/Ville",SVE="Postnr/Ort"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(City; Rec."City EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No. EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Contact; Rec."Contact EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Login; Rec."Login EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Created; Rec."Created EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No. EXP")
                {
                    Editable = "Customer No.Editable";
                    ApplicationArea = All;
                }
                field("B2B Customer"; Rec."B2B Customer EXP")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Secondary Currency Code"; Rec."Secondary Currency Code EXP")
                {
                    Editable = false;
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
                Caption = 'Net &Cust.', Comment = 'DAN="Net &Kunde",DEU="Net &Kunde",ESP="&e-Cliente",FRA="&Client",SVE="Nät &Kund"';
                separator(Separator32)
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
                    Caption = 'New Password', Comment = 'DAN="Nyt kodeord",DEU="Neues Passwort",ESP="Nueva contraseña",FRA="Nouveau mot de passe",SVE="Nytt lösenord"';
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
                Caption = 'Net S&ales', Comment = 'DAN="Net s&alg",DEU="Net V&erkauf",ESP="&e-Ventas ",FRA="&Ventes",SVE="Nät F&örsäljning"';
                action(Customer)
                {
                    Caption = 'Customer', Comment = 'DAN="Kunde",DEU="Kunde",ESP="Cliente",FRA="Client",SVE="Kund"';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Customer No. EXP");
                    ApplicationArea = All;
                }
                action("&Orders")
                {
                    Caption = '&Orders', Comment = 'DAN="&Ordrer",DEU="&Bestellungen",ESP="&Pedidos",FRA="C&ommandes",SVE="&Order"';
                    Image = Document;
                    RunObject = Page "ExpandIT Sales List EXP";
                    RunPageLink = "Bill-to Net Customer No. EXP" = FIELD("No. EXP");
                    ApplicationArea = All;
                }
                action(Tracking)
                {
                    Caption = 'Tracking', Comment = 'DAN="Sporing",DEU="Verfolgen",ESP="Historial Registros",FRA="Traçabilité",SVE="Spårning"';
                    Image = OrderTracking;
                    RunObject = Page "ExpandIT Sales Order Track EXP";
                    RunPageLink = "Bill-to Net Customer No. EXP" = FIELD("No. EXP");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'DAN="F&unktioner",DEU="F&unktionen",ESP="&Funciones",FRA="Fonction&s",SVE="F&unktion"';
                action("Create &Customer")
                {
                    Caption = 'Create &Customer', Comment = 'DAN="Opret &kunde",DEU="Anlage &Kunde",ESP="&Crear cliente ",FRA="&Créer client",SVE="Skapa &Kund"';
                    Image = NewCustomer;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CreateCustomer;
                    end;
                }
                action("Enable B2B")
                {
                    Caption = 'Enable B2B', Comment = 'DAN="Opret som &B2B",DEU="Möglich B2B",ESP="Activar B2B",FRA="Activer B2B",SVE="Aktivera B2B"';
                    Image = ICPartner;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec."B2B Enable";
                    end;
                }
                action("Update Customer")
                {
                    Caption = 'Update Customer', Comment = 'DAN="&Opdater Kunde",DEU="aktualisiere Kunde",ESP="Actualizar cliente",FRA="MAJ fiche client",SVE="Uppdatera kunder"';
                    Image = ChangeTo;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.UpdateToCustomerYesNo;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        AfterGetCurrRecord;
    end;

    trigger OnInit();
    begin
        "Customer No.Editable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        AfterGetCurrRecord;
    end;

    var
        InternetShopSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        [InDataSet]
        "Customer No.Editable": Boolean;

    /// <summary>
    /// SetEditable.
    /// </summary>
    procedure SetEditable();
    begin
        "Customer No.Editable" := not Rec."B2B Customer EXP";
    end;

    local procedure AfterGetCurrRecord();
    begin
        xRec := Rec;
        SetEditable;
    end;
}

