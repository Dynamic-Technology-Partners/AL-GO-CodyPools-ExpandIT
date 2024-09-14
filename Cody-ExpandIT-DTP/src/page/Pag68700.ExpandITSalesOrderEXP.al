/// <summary>
/// Page ExpandIT Sales Order EXP (ID 68700).
/// </summary>
page 68700 "ExpandIT Sales Order EXP"
{
    // version EIS5.04.01

    // EIS3.01   2009-01-14  JR  * Make sales order button is controlled by code instead of properties.
    // 
    // EIS3.02   2009-04-08  JR  * Field "Prices Including VAT" was added to the form.
    // 
    // EIS4.00   2010-08-23  JR  * The status field was made visible on the form.
    // 
    // EIS4.0.01   2011-02-10  PB  * Moved SETRANGE to the OnOpen trigger to apply to changed behavior in RTC
    // 
    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM18.0.6.56 2020-04-17 FAM * Sales origin added


    Caption = 'ExpandIT Sales Order', Comment = 'DAN="ExpandIT Salgsordre",DEU="ExpandIT Verkaufsbestellung",ESP="Pedidos de Venta ExpandIT",FRA="Commande vente ExpandIT",SVE="ExpandIT Försäljningsorder"';
    InsertAllowed = false;
    PageType = Document;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "ExpandIT Order Header EXP";
    SourceTableView = SORTING("Order Date EXP");

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'DAN="Generelt",DEU="allgemein",ESP="General",FRA="Général",SVE="Allmänt"';
                field("Customer Reference No."; Rec."Customer Reference No. EXP")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No. EXP")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address EXP")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2 EXP")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code EXP")
                {
                    Caption = 'Sell-to Post Code/City', Comment = 'DAN="Kundepostnr./By",DEU="Verkauf an PLZ/Stadt",ESP="Venta a-C.P./Provincia",FRA="CP/Ville donneur d''ordre",SVE="Kund postnr/ort"';
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City EXP")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact EXP")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field(Comment; Rec."Comment EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec."Status EXP")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date EXP")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec."Amount EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Invoice Discount"; Rec."Invoice Discount EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Service Charge"; Rec."Service Charge EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipping Amount"; Rec."Shipping Amount EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Handling Amount"; Rec."Handling Amount EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount Including Tax"; Rec."Amount Including Tax EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT EXP")
                {
                    ApplicationArea = All;
                }
                field("Sales Origin"; Rec."Sales Origin EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                    Description = 'EMSM18.0.6.56';
                }
                field("Customer P.O. No. EXP"; rec."Customer P.O. No. EXP")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
            }
            part(SubForm; "ExpandIT Sales Order Sub EXP")
            {
                SubPageLink = "Order Guid EXP" = FIELD("Order Guid EXP");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'DAN="Fakturering",DEU="Rechnungslegung",ESP="Facturar",FRA="Facturation",SVE="Fakturering"';
                field("Bill-to Net Customer No."; Rec."Bill-to Net Customer No. EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2 EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code EXP")
                {
                    Caption = 'Bill-to Post Code/City', Comment = 'DAN="Postnr./By",DEU="Rechnung an PLZ/Stadt",ESP="Fact. a-C.P./Provincia",FRA="CP/Ville",SVE="Faktureras postnr/ort"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Country Code"; Rec."Bill-to Country Code EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to E-Mail"; Rec."Bill-to E-Mail EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transaction ID"; Rec."Transaction ID EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code EXP")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping', Comment = 'DAN="Levering",DEU="Versand",ESP="Enviar",FRA="Livraison",SVE="Leverans"';
                field("Ship-to Name"; Rec."Ship-to Name EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2 EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code EXP")
                {
                    Caption = 'Ship-to Post Code/City', Comment = 'DAN="Leveringspostnr./By",DEU="Versand an PLZ/Stadt",ESP="Envío a-C.P./Provincia",FRA="CP/Ville destinataire",SVE="Leverans postnr/ort"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Country Code"; Rec."Ship-to Country Code EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to E-Mail"; Rec."Ship-to E-Mail EXP")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipping Handling Provider EXP"; rec."Shipping Handling Provider EXP")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Shipping Service Code DTP"; rec."Shipping Service Code DTP")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Tax Area Code DTP"; rec."Tax Area Code DTP")
                {
                    Editable = false;
                    Caption = 'Ship-to Tax Area Code';
                    ApplicationArea = all;
                }
                field("Tax Liable DTP"; rec."Tax Liable DTP")
                {
                    Editable = false;
                    Caption = 'Ship-to Tax Liable';
                    ApplicationArea = all;
                }
            }
            group(Signature)
            {
                Caption = 'Signature', Comment = 'DAN="Underskrift",DEU="Unterschrift",ESP="Firma",FRA="Signature",SVE="Underskrift"';
                field("BMP Signature"; Rec."BMP Signature EXP")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
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
                Caption = 'Net &Order', Comment = 'DAN="Net &ordre",DEU="Net &Bestellung",ESP="&e-Pedido",FRA="&Commande",SVE="Nät &Order"';
                action("Internet Customer")
                {
                    Caption = 'Internet Customer', Comment = 'DAN="Internet-kunde",DEU="Internet Kunde",ESP="Cliente Internet",FRA="Client Internet",SVE="Internet kund"';
                    Image = Customer;
                    RunObject = Page "Internet Customer Card EXP";
                    RunPageLink = "No. EXP" = FIELD("Bill-to Net Customer No. EXP");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'DAN="F&unktioner",DEU="F&unktionen",ESP="&Funciones",FRA="Fonction&s",SVE="Fu&nktion"';
                action("&Reject Order")
                {
                    Caption = '&Reject Order', Comment = 'DAN="&Afvis ordre",DEU="&Bestellung ablehnen",ESP="&Rechazar Pedido",FRA="&Rejeter commande",SVE="&Avbryt order"';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.RejectOrder;
                    end;
                }
                separator(Separator23)
                {
                }
                action("&Create Customer")
                {
                    Caption = '&Create Customer', Comment = 'DAN="&Opret kunde",DEU="&Erstelle Kunde",ESP="&Crear Cliente",FRA="&Créer client",SVE="&Skapa kund"';
                    Image = AddContacts;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        InternetCustomer.GET(Rec."Bill-to Net Customer No. EXP");
                        InternetCustomer.CreateCustomer;
                    end;
                }
                separator(Separator1160840005)
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
                Caption = 'Make &Sales Document', Comment = 'DAN="Overfør til &Dokument",DEU="Erstelle &Verkaufsdokument",ESP="&Convertir a Doc. Venta",FRA="A&ccepter",SVE="Skapa f&örsäljningsdokument"';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CODEUNIT.RUN(CODEUNIT::"Int Ord to Doc(Yes/No) EXP", Rec);
                    if Rec."Status EXP" <> xRec."Status EXP" then
                        CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        AfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SAVERECORD;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        AfterGetCurrRecord;
    end;

    var
        Customer: Record Customer;
        InternetCustomer: Record "Internet Customer EXP";
        InternetOrderLine: Record "ExpandIT Order Line EXP";
        InternetShopSetup: Record "Sales & Receivables Setup";
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        InternetCustomerB2B: Record "Internet Customer B2B EXP";
        TEXT000: Label 'Do you want to reject the %1?';
    //TextConst DAN = 'Ønsker du at afvise %1?',DEU = 'Wünschen Sie die %1 abzulehnen?', ENU = 'Do you want to reject the %1?',ESP = '¿Desea rechazar %1?',FRA = 'Voulez-vous rejeter la %1 ?',SVE = 'Vill du avbryta %1?';

    local procedure AfterGetCurrRecord();
    var
        CustomerNo: Code[20];
    begin
        xRec := Rec;
        Rec.SETRANGE("Customer Reference No. EXP");

        if Rec."Sell-to Customer No. EXP" = '' then
            if InternetCustomer.GET(Rec."Bill-to Net Customer No. EXP") then
                Rec.VALIDATE("Sell-to Customer No. EXP", InternetCustomer."Customer No. EXP");

        if Rec."Sell-to Customer No. EXP" = '' then
            if InternetCustomerB2B.GET(Rec."Bill-to Net Customer No. EXP") then
                Rec.VALIDATE("Sell-to Customer No. EXP", InternetCustomerB2B."Customer No. EXP");
    end;
}

