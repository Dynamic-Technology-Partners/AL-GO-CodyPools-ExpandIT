/// <summary>
/// Page ExpandIT Sales List EXP (ID 68702).
/// </summary>
page 68702 "ExpandIT Sales List EXP"
{
    // version EIS5.04.02

    // EIS3.01  2008-06-25  JR  * Currency and amount fields were added to the form.
    // 
    // EIS4.01  2010-08-23  JR  * Function buttons added to the list for better RTC transformation.
    // 
    // EIS4.01.01  2011-02-01  PB  * SourceTableView changed to the sorting "Status,Order Date"
    //                             * Filter on Status=New added in the OnOpenForm trigger.
    // 
    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS5.04.01  2018-03-13  FAM * Label text is added to some actions.
    // EIS5.04.02  2018-04-19  FAM * New Actions: Show all for tracking, Re-send notification email, reset Status.

    Caption = 'ExpandIT Sales List', Comment = 'DAN="ExpandIT Salgsoversigt",DEU="ExpandIT Verkaufsliste",ESP="Lista Ventas ExpandIT",FRA="Liste des ventes ExpandIT",SVE="ExpandIT Försäljningslista"';
    CardPageID = "ExpandIT Sales Order EXP";
    DataCaptionFields = "Status EXP";
    UsageCategory = Lists;
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ExpandIT Order Header EXP";
    SourceTableView = SORTING("Status EXP", "Order Date EXP");



    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Status; Rec."Status EXP")
                {
                    ApplicationArea = All;
                }
                field("Customer Reference No."; Rec."Customer Reference No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date EXP")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Net Customer No."; Rec."Bill-to Net Customer No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No. EXP")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name EXP")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Country Code"; Rec."Bill-to Country Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Country Code"; Rec."Ship-to Country Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec."Amount EXP")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1907460707; "ExpandIT Sales Order FactBox")
            {
                SubPageLink = "Order Guid EXP" = FIELD("Order Guid EXP");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1903066607; "ExpandIT Sales Line FactBox")
            {
                SubPageLink = "Order Guid EXP" = FIELD("Order Guid EXP");
                Visible = true;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Net &Order")
            {
                Caption = 'Net &Order', Comment = 'DAN="Net &ordre",DEU="Net &Bestellung",ESP="&e-Pedido",FRA="C&ommande Internet",SVE="Nät &Order"';
                action("&Internet Customer")
                {
                    Caption = '&Internet Customer', Comment = 'DAN="&Internet-kunde",DEU="&Internet Kunde",ESP="&Cliente Internet",FRA="&Client Internet",SVE="&Internet kund"';
                    Image = Customer;
                    RunObject = Page "Internet Customer List EXP";
                    RunPageLink = "No. EXP" = FIELD("Bill-to Net Customer No. EXP");
                    ApplicationArea = All;
                }
                separator(Separator1160840012)
                {
                }
                action("&Show All for Tracking")
                {
                    Caption = '&Show All for Tracking', Comment = 'DAN="&Vis alt for sporing",ESP="&Mostrar todo para registro",FRA="&Afficher Tout pour le suivi"';
                    Image = CustomerList;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.SETRANGE("Status EXP");
                        Rec.SETCURRENTKEY("Order Date EXP");
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'DAN="Fu&nktion",DEU="F&unktionen",ESP="&Funciones",FRA="F&onctions",SVE="F&unktioner"';
                action("&Reject Order")
                {
                    Caption = '&Reject Order', Comment = 'DAN="&Afvis ordre",DEU="&Bestellung ablehnen",ESP="&Rechazar Pedido",FRA="&Rejeter la Commande",SVE="&Avbryt order"';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        InternetShopSetup: Record "Sales & Receivables Setup";
                        TEXT000: label 'Do you want to reject the %1?';
                    //TextConst DAN = 'Ønsker du at afvise %1?',DEU = 'Wünschen Sie die %1 abzulehnen?', ENU = 'Do you want to reject the %1?',ESP = '¿Desea rechazar %1?',FRA = 'Voulez-vous rejeter la %1 ?',SVE = 'Vill du avbryta %1?';
                    begin
                        Rec.RejectOrder;
                    end;
                }
                separator(Separator1160840010)
                {
                }
                action("&Create Customer")
                {
                    Caption = '&Create Customer', Comment = 'DAN="&Opret kunde",DEU="&Erstelle Kunde",ESP="&Crear Cliente",FRA="&Créer un Client",SVE="&Skapa kund"';
                    Image = AddContacts;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        InternetCustomer.GET(Rec."Bill-to Net Customer No. EXP");
                        InternetCustomer.CreateCustomer;
                    end;
                }
                separator(Separator1160840016)
                {
                }
                action("Re-Send &Notification E-mail")
                {
                    Caption = 'Re-Send &Notification E-mail', Comment = 'DAN="&Send e-mailbekræftelse igen",ESP="&Reenvío y notificación por correo electrónico",FRA="&Renvoyer l''E-mail de notification"';
                    Image = SendTo;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ReSendNotificationEmail;
                    end;
                }
                action("Reset &Status")
                {
                    Caption = 'Reset &Status', Comment = 'DAN="&Nulstil Status",ESP="&Restablecer y estado",FRA="Remettre le &Statut"';
                    Image = ResetStatus;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ChangeToNew;
                    end;
                }
            }
            action("Make &Sales Document")
            {
                Caption = 'Make &Sales Document', Comment = 'DAN="Overfør til &Dokument",DEU="Erstelle &Verkaufsdokument",ESP="&Convertir a Doc. Venta",FRA="Faire le Document &Ventes",SVE="Skapa &försäljningsdokument"';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CODEUNIT.RUN(50071, Rec);
                end;
            }
        }
    }

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := true;
    end;

    trigger OnOpenPage();
    begin
        Rec.SETRANGE("Status EXP", Rec."Status EXP"::New);
    end;

    var
        Customer: Record Customer;
        InternetCustomer: Record "Internet Customer EXP";
        InternetOrderLine: Record "ExpandIT Order Line EXP";
        InternetShopSetup: Record "Sales & Receivables Setup";
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        InternetCustomerB2B: Record "Internet Customer B2B EXP";
}

