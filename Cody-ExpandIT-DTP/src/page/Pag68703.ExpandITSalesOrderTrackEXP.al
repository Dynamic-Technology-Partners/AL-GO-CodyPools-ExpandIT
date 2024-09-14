/// <summary>
/// Page ExpandIT Sales Order Track EXP (ID 68703).
/// </summary>
page 68703 "ExpandIT Sales Order Track EXP"
{
    // version EIS5.04.01

    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM18.0.6.148 2020-09-10 FAM * Add FindFirst check for ExpandIT Setup 

    Caption = 'ExpandIT Sales Order Tracking', Comment = 'DAN="ExpandIT Salgsordre-sporing",DEU="ExpandIT Verkaufsbestellungsverfolgung",ESP="Historial Pedidos Ventas ExpandIT",FRA="Traçabilité des commandes ExpandIT",SVE="ExpandIT Försäljningsorderspårning"';
    InsertAllowed = false;
    UsageCategory = Tasks;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "ExpandIT Order Header EXP";
    SourceTableView = SORTING("Order Date EXP")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Customer Reference No."; Rec."Customer Reference No. EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec."Status EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Net Customer No."; Rec."Bill-to Net Customer No. EXP")
                {
                    Editable = false;
                    Lookup = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        if Rec."Bill-to Net Customer No. EXP" <> '' then begin
                            InternetCustomer.SETRANGE("No. EXP", Rec."Bill-to Net Customer No. EXP");
                            PAGE.RUN(PAGE::"Internet Customer Card EXP", InternetCustomer);
                        end;
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No. EXP")
                {
                    Editable = false;
                    Lookup = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        if Rec."Sell-to Customer No. EXP" <> '' then begin
                            Customer.SETRANGE("No.", Rec."Sell-to Customer No. EXP");
                            PAGE.RUN(PAGE::"Customer Card", Customer);
                        end;
                    end;
                }
                field("Bill-to Name"; Rec."Bill-to Name EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code EXP")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Country Code"; Rec."Bill-to Country Code EXP")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Converted-To Document No."; Rec."Converted-To Document No. EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name EXP")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code EXP")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Country Code"; Rec."Ship-to Country Code EXP")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact EXP")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'DAN="F&unktioner",DEU="F&unktionen",ESP="&Funciones",FRA="Fonction&s",SVE="Fu&nktion"';
                action(Card)
                {
                    Caption = 'Card', Comment = 'DAN="Kort",DEU="Karte",ESP="Ficha",FRA="Fiche",SVE="Kort"';
                    Image = EditLines;
                    RunObject = Page "ExpandIT Sales Order EXP";
                    RunPageLink = "Customer Reference No. EXP" = FIELD("Customer Reference No. EXP");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                separator(Separator35)
                {
                }
                action("Re-Send Notification E-mail")
                {
                    Caption = 'Re-Send Notification E-mail', Comment = 'DAN="Send e-mailbekræftelse igen",DEU="Rücksendebestätigung e-mail",ESP="Reenviar Notificación E-mail",FRA="Renvoyer notification par e-mail",SVE="Sänd anmälan med e-post igen"';
                    Image = SendTo;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        if InternetShopSetup.FindFirst() then begin // EMSM18.0.6.148

                            case Rec."Status EXP" of
                                Rec."Status EXP"::New:
                                    MESSAGE(TEXT000, Rec.TABLENAME);
                                Rec."Status EXP"::Rejected:
                                    begin
                                        if Rec."Bill-to E-Mail EXP" <> '' then
                                            InternetShopMgt.InternetOrderRejected(Rec."Bill-to E-Mail EXP", Rec."Order Guid EXP")
                                        else begin
                                            InternetCustomer.GET(Rec."Bill-to Net Customer No. EXP");
                                            InternetCustomer.TESTFIELD("E-Mail EXP");
                                            InternetShopMgt.InternetOrderRejected(InternetCustomer."E-Mail EXP", Rec."Order Guid EXP")
                                        end;
                                    end;
                                Rec."Status EXP"::Converted:
                                    begin
                                        if Rec."Bill-to E-Mail EXP" <> '' then
                                            InternetShopMgt.InternetOrderConverted(Rec."Bill-to E-Mail EXP", Rec."Order Guid EXP")
                                        else begin
                                            InternetCustomer.GET(Rec."Bill-to Net Customer No. EXP");
                                            InternetCustomer.TESTFIELD("E-Mail EXP");
                                            InternetShopMgt.InternetOrderConverted(InternetCustomer."E-Mail EXP", Rec."Order Guid EXP")
                                        end;
                                    end;
                            end;
                        end;
                    end;
                }
                action("Reset Status")
                {
                    Caption = 'Reset Status', Comment = 'DAN="Nulstil Status",DEU="Reset Status",ESP="Reset Estado",FRA="Réinitialiser statut",SVE="Nollställ status"';
                    Image = ResetStatus;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ChangeToNew;
                    end;
                }
            }
        }
    }

    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
        InternetCustomer: Record "Internet Customer EXP";
        InternetOrder: Record "ExpandIT Order Header EXP";
        InternetShopSetup: Record "Sales & Receivables Setup";
        BatchConvertInternetOrders: Report "Bat. Conv. ExpandIT Orders EXP";
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        TEXT000: Label 'The %1 has not yet been converted or rejected.', Comment = 'DAN="%1 er endnu ikke overført eller afvist.",DEU="%1 ist noch nicht umgewandelt oder abgelehnt.",ESP="%1 todavía no ha sido convertido o rechazado.",FRA="%1 n"';
}

