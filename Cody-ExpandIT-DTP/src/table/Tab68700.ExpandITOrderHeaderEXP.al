/// <summary>
/// Table ExpandIT Order Header EXP (ID 68700).
/// </summary>
table 68700 "ExpandIT Order Header EXP"
{
    // version EIS6.0.12,EMI2.13,EPAY1.3

    // EIS3.01     2009-04-08  JR  * Field 35 "Prices Including VAT" was added to the table.
    // 
    // EIS4.00     2010-08-23 JR   * Subtype bitmap was added to the signature field.
    // 
    // EIS4.01     2011-02-01  JR  * New key Status,Order Date was added.
    // 
    // EIS4.01.02  2011-03-25 PB   * Added "Shipping Amount Including Tax","Handling Amount Including Tax",
    //                               "Payment Fee Amount Incl. Tax" in order to support VAT on finance charges.
    // 
    // EIS4.02.02
    //             2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // 
    // EIS4.02.03  2014-04-01  PB  * Bitmap field is now not compressed in order to support NAV 12013.
    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/ESP/SVE/FRA is now added to fields and TextConstants.
    // EMSM18.0.6.56 2020-04-17 FAM * Sales origin added
    // EIS6.0.12 2020-09-10 FAM * Get ExpandIT Setup record

    Caption = 'ExpandIT Order Header', Comment = 'DAN="ExpandIT-ordrehoved",DEU="ExpandIT Bestellkopf",ESP="Encabezado de Pedido ExpandIT",FRA="Commande ExpandIT",SVE="ExpandIT orderhuvud"';
    DataCaptionFields = "Customer Reference No. EXP", "Sell-to Customer Name EXP";
    LookupPageID = "ExpandIT Sales List EXP";

    fields
    {
        field(2; "Sell-to Customer No. EXP"; Code[20])
        {
            Caption = 'Sell-to Customer No.', Comment = 'DAN="Kundenr.",DEU="Verkauf an Kunde Nr.",ESP="Venta a-No cliente",FRA="No donneur d''ordre",SVE="Förs.kundnr"';
            TableRelation = Customer;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CALCFIELDS(
                  "Sell-to Customer Name EXP",
                  "Sell-to Address EXP",
                  "Sell-to Address 2 EXP",
                  "Sell-to Post Code EXP",
                  "Sell-to City EXP",
                  "Sell-to Contact EXP");
            end;
        }
        field(5; "Bill-to Name EXP"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Name', Comment = 'DAN="Navn",DEU="Rechnung an Name",ESP="Fact. a-Nombre",FRA="Nom client facturé",SVE="Faktureras namn"';
        }
        field(7; "Bill-to Address EXP"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Address', Comment = 'DAN="Adresse",DEU="Rechnung an Adresse",ESP="Fact. a-Dirección",FRA="Adresse facturation",SVE="Faktureras adress"';
        }
        field(8; "Bill-to Address 2 EXP"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Address 2', Comment = 'DAN="Adresse 2",DEU="Rechnung an Adresse 2",ESP="Fact. a-Dirección 2",FRA="Adresse facturation (2ème ligne)",SVE="Faktureras adress 2"';
        }
        field(9; "Bill-to City EXP"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to City', Comment = 'DAN="By",DEU="Rechnung an Stadt",ESP="Fact. a-Población",FRA="Ville facturation",SVE="Faktureras ort"';
        }
        field(10; "Bill-to Contact EXP"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Contact', Comment = 'DAN="Attention",DEU="Rechnung an Kontakt",ESP="Fact. a-Atención",FRA="Contact facturation",SVE="Faktureras kontaktperson"';
        }
        field(13; "Ship-to Name EXP"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Name', Comment = 'DAN="Leveringsnavn",DEU="Lieferung an Name",ESP="Envío a-Nombre",FRA="Nom du destinataire",SVE="Leveransnamn"';
        }
        field(15; "Ship-to Address EXP"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Address', Comment = 'DAN="Leveringsadresse",DEU="Lieferung an Adresse",ESP="Envío a-Dirección",FRA="Adresse destinataire",SVE="Leveransadress"';
        }
        field(16; "Ship-to Address 2 EXP"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Address 2', Comment = 'DAN="Leveringsadresse 2",DEU="Lieferung an Adresse 2",ESP="Envío a-Dirección 2",FRA="Adresse destinataire 2",SVE="Leveransadress 2"';
        }
        field(17; "Ship-to City EXP"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to City', Comment = 'DAN="Leveringsby",DEU="Lieferung an Stadt",ESP="Envío a-Población",FRA="Ville destinataire",SVE="Leveransort"';
        }
        field(18; "Ship-to Contact EXP"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Contact', Comment = 'DAN="Leveres attention",DEU="Lieferung an Kontakt",ESP="Envío a-Atención",FRA="Contact destinataire",SVE="Leveranskontaktperson"';
        }
        field(19; "Order Date EXP"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Order Date', Comment = 'DAN="Ordredato",DEU="Bestelldatum",ESP="Fecha pedido",FRA="Date commande",SVE="Orderdatu"';
        }
        field(21; "Shipment Date EXP"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment Date', Comment = 'DAN="Leveringsdato",DEU="Lieferdatum",ESP="Fecha envío",FRA="Date de préparation",SVE="Utleveransdatum"';
        }
        field(32; "Currency Code EXP"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code', Comment = 'DAN="Valutakode",DEU="Währungscode",ESP="Cód. divisa",FRA="Code devise",SVE="Valutakod"';
        }
        field(35; "Prices Including VAT EXP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prices Including VAT', Comment = 'DAN="Priser inkl. moms",ESP="Precios IVA incluido",FRA="T.V.A. est inclus dans les prix"';
        }
        field(43; "Salesperson Code EXP"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Salesperson Code', Comment = 'DAN="Sælgerkode",DEU="Verkäufercode",ESP="Cód. vendedor",FRA="Code vendeur",SVE="Säljarkod"';
            TableRelation = "Salesperson/Purchaser";
        }
        field(60; "Amount EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Amount', Comment = 'DAN="Beløb",DEU="Betrag",ESP="Importe",FRA="Montant",SVE="Belopp"';
        }
        field(61; "Amount Including Tax EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including Tax', Comment = 'DAN="Beløb inkl. moms",DEU="Betrag inkl. MWSt.",ESP="Importe IVA incl.",FRA="Montant TTC",SVE="Belopp inklusive moms"';
        }
        field(79; "Sell-to Customer Name EXP"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Sell-to Customer No. EXP")));
            Caption = 'Sell-to Customer Name', Comment = 'DAN="Kundenavn",DEU="Verkauf an Kundenname",ESP="Venta a-Nombre",FRA="Nom du donneur d''ordre",SVE="Kundnamn"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(81; "Sell-to Address EXP"; Text[100])
        {
            CalcFormula = Lookup(Customer.Address WHERE("No." = FIELD("Sell-to Customer No. EXP")));
            Caption = 'Sell-to Address', Comment = 'DAN="Kundeadresse",DEU="Verkauf an Adresse",ESP="Venta a-Dirección",FRA="Adresse donneur d''ordre",SVE="Kundadress"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(82; "Sell-to Address 2 EXP"; Text[50])
        {
            CalcFormula = Lookup(Customer."Address 2" WHERE("No." = FIELD("Sell-to Customer No. EXP")));
            Caption = 'Sell-to Address 2', Comment = 'DAN="Kundeadresse 2",DEU="Verkauf an Adresse 2",ESP="Venta a-Dirección 2",FRA="Adresse donneur d''ordre 2",SVE="Kundadress 2"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(83; "Sell-to City EXP"; Text[30])
        {
            CalcFormula = Lookup(Customer.City WHERE("No." = FIELD("Sell-to Customer No. EXP")));
            Caption = 'Sell-to City', Comment = 'DAN="Kundeby",DEU="Verkauf an Stadt",ESP="Venta a-Población",FRA="Ville donneur d''ordre",SVE="Kundort"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(84; "Sell-to Contact EXP"; Text[100])
        {
            CalcFormula = Lookup(Customer.Contact WHERE("No." = FIELD("Sell-to Customer No. EXP")));
            Caption = 'Sell-to Contact', Comment = 'DAN="Kundeattention",DEU="Verkauf an Kontakt",ESP="Venta a-Atención",FRA="Contact donneur d''ordre",SVE="Kundkontaktperson"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85; "Bill-to Post Code EXP"; Code[20])
        {
            Caption = 'Bill-to Post Code', Comment = 'DAN="Postnr.",DEU="Verkauf an PLZ",ESP="Fact. a-C.P.",FRA="Code postal facturation",SVE="Faktureras postnr"';
            TableRelation = "Post Code";
            DataClassification = CustomerContent;
        }
        field(86; "Bill-to State EXP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to State', Comment = 'DAN="Stat",DEU="Verkauf an Staat",ESP="Fact. a-Provincia",FRA="Etat facturation",SVE="Faktureras land"';
        }
        field(88; "Sell-to Post Code EXP"; Code[20])
        {
            CalcFormula = Lookup(Customer."Post Code" WHERE("No." = FIELD("Sell-to Customer No. EXP")));
            Caption = 'Sell-to Post Code', Comment = 'DAN="Kundepostnr.",DEU="Verkauf an PLZ",ESP="Venta a-C.P.",FRA="Code postal donneur d''ordre",SVE="Kundpostnrkod"';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(89; "Sell-to State EXP"; Text[30])
        {
            CalcFormula = Lookup(Customer.County WHERE("No." = FIELD("Sell-to Customer No. EXP")));
            Caption = 'Sell-to State', Comment = 'DAN="Kundestat",DEU="Verkauf an Staat",ESP="Venta a-Provincia",FRA="Etat donneur d''ordre",SVE="Säljarens stat"';
            FieldClass = FlowField;
        }
        field(90; "Bill-to Country Code EXP"; Code[10])
        {
            Caption = 'Bill-to Country Code', Comment = 'DAN="Kundelandekode",DEU="Rechnung an Ländercode",ESP="Fact. a-Cód. país",FRA="Code pays/région facturation",SVE="Faktureras land"';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(91; "Ship-to Post Code EXP"; Code[20])
        {
            Caption = 'Ship-to Post Code', Comment = 'DAN="Leveringspostnr.",DEU="Lieferung an PLZ",ESP="Envío a-C.P.",FRA="Code postal destinataire",SVE="Leveranspostnrkod"';
            TableRelation = "Post Code";
            DataClassification = CustomerContent;
        }
        field(92; "Ship-to State EXP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to State', Comment = 'DAN="Leveringsstat",DEU="Lieferung an Staat",ESP="Envío a-Provincia",FRA="Etat destinataire",SVE="Leverans stat"';
        }
        field(93; "Ship-to Country Code EXP"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Country Code', Comment = 'DAN="Leveringslandekode",DEU="Lieferung an Ländercode",ESP="Envío a-Cód. país",FRA="Code pays/région destinataire",SVE="Leveranslandkod"';
            TableRelation = "Country/Region";
        }
        field(60000; "DTP Customer UPS Acct"; Code[20])
        {
            Caption = 'Customer UPS Acct';
            DataClassification = ToBeClassified;
        }
        field(60001; "DTP Project Name"; Text[100])
        {
            Caption = 'Project Name';
            DataClassification = ToBeClassified;
        }
        field(60002; "DTP Shipping Agent Service"; Code[50])
        {
            Caption = 'Shipping Agent Service';
            DataClassification = ToBeClassified;
        }
        field(60003; "DTP Shipping Svc. Name"; Text[50])
        {
            CalcFormula = lookup("Shipping Agent".Name where("DTP Shipping Service Code" = FIELD("DTP Shipping Agent Service")));
            Caption = 'Shipping Svc. Name';
            FieldClass = FlowField;
        }
        field(78700; "Customer Reference No. EXP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Reference No.', Comment = 'DAN="Kunde reference nr.",DEU="Kundenreferenznummer",ESP="Nº Referencia cliente",FRA="Référence client",SVE="Kundreferensnr"';
            Description = 'EIS5.04.01';
        }
        field(78701; "Bill-to Net Customer No. EXP"; Text[38])
        {
            Caption = 'Bill-to Net Customer No.', Comment = 'DAN="Internet-kundenr.",DEU="Rechnung an Net Kundennummer",ESP="Fact. a-Nº Cliente Internet",FRA="N° client Internet facturé",SVE="Faktureras nät kundnr"';
            Description = 'EIS5.04.01';
            TableRelation = "Internet Customer EXP";
            DataClassification = CustomerContent;
        }
        field(78702; "Status EXP"; Option)
        {
            Caption = 'Status', Comment = 'DAN="Status",DEU="Status",ESP="Estado",FRA="Statut",SVE="Status"';
            Description = 'EIS5.04.01';
            OptionCaption = 'New,Converted,Rejected', Comment = 'DAN="Ny,Overført,Afvist",DEU="Neu,Übernommen,Abgelehnt",ESP="Nuevo, convertido, rechazado",FRA="Nouveau,Accepté,Rejeté",SVE="Ny,Godkänd,Avbruten"';
            OptionMembers = New,Converted,Rejected;
            DataClassification = CustomerContent;
        }
        field(78703; "Converted-To Document No. EXP"; Code[20])
        {
            Caption = 'Converted-To Document No.', Comment = 'DAN="Konveret til Bilagsnr.",DEU="Übernommen für Dokument Nr.",ESP="Convertido a Nº Documento",FRA="Nouveau n° document",SVE="Utbytt till dokumentnr"';
            Description = 'EIS5.04.01';
            TableRelation = "Sales Header"."No.";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if "Converted-To Document No. EXP" <> '' then begin
                    if SalesHeader.GET("Converted-To Document Type EXP", "Converted-To Document No. EXP") then
                        case "Converted-To Document Type EXP" of
                            "Converted-To Document Type EXP"::Quote:
                                PAGE.RUN(PAGE::"Sales Quote", SalesHeader);
                            "Converted-To Document Type EXP"::Order:
                                PAGE.RUN(PAGE::"Sales Order", SalesHeader);
                            "Converted-To Document Type EXP"::Invoice:
                                PAGE.RUN(PAGE::"Sales Invoice", SalesHeader);
                        end
                    else
                        MESSAGE(
                          TEXT000,
                          "Converted-To Document Type EXP", "Converted-To Document No. EXP");
                end;
            end;
        }
        field(78704; "Converted-To Document Type EXP"; Enum "Document Type EXP")
        {
            DataClassification = CustomerContent;
            Caption = 'Converted-To Document Type', Comment = 'DAN="Konveret til Bilagstype",DEU="Übernommen für Dokumenttyp",ESP="Convertido a Tipo Documento",FRA="Nouveau type document",SVE="Utbytt till dokumenttyp"';
        }
        field(78705; "Bill-to E-Mail EXP"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to E-Mail', Comment = 'DAN="e-mail",DEU="Rechnung an e-mail",ESP="Fact. a-E-Mail",FRA="E-mail client Internet facturé",SVE="Faktureras E-post"';
            Description = 'EIS5.04.01';
        }
        field(78706; "Payment Type EXP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Type', Comment = 'DAN="Betalingstype",DEU="Zahlungstyp",ESP="Términos pago",FRA="Type de règlement",SVE="Betalningstyp"';
            Description = 'EIS5.04.01';
        }
        field(78707; "Transaction ID EXP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction ID', Comment = 'DAN="Transaktions ID",DEU="Transaktions ID",ESP="Nº Transacción",FRA="ID transaction",SVE="TransaktionsID"';
            Description = 'EIS5.04.01';
        }
        field(78708; "Transaction Signature EXP"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Signature', Comment = 'DAN="Transaktions signatur",DEU="Transaktionsunterschrift",ESP="Firma Transacción",FRA="Signature transaction",SVE="Transaktionssignatur"';
            Description = 'EIS5.04.01';
        }
        field(78709; "e-payment Provider Code EXP"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'e-payment Provider Code', Comment = 'DAN="e-betaling Udbyder Kode",DEU="e-payment Anbietercode",ESP="Código Proveedor de pago",FRA="Code fournisseur de paiement en ligne",SVE="e-betalning providerkod"';
            Description = 'EIS5.04.01';
            TableRelation = "e-payment Provider EXP";
        }
        field(78710; "e-payment Clearing OK EXP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'e-payment Clearing OK', Comment = 'DAN="e-betaling Clearing OK",DEU="e-payment Verrechnung OK",ESP="Pago aceptado",FRA="Paiement en ligne accepté",SVE="e-betalning clearing OK"';
            Description = 'EIS5.04.01';
        }
        field(78711; "Invoice Discount EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Discount', Comment = 'DAN="Faktura rabat",DEU="Rechnungsrabatt",ESP="Descuento Fact.",FRA="Montant remise facture",SVE="Fakturarabatt"';
            Description = 'EIS5.04.01';
        }
        field(78712; "Service Charge EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Service Charge', Comment = 'DAN="Servicegebyr",DEU="Servicekosten",ESP="Cargo Servicio",FRA="Frais forfaitaires",SVE="Faktureringsavgift"';
            Description = 'EIS5.04.01';
        }
        field(78713; "Comment EXP"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Comment', Comment = 'DAN="Kommentar",DEU="Bemerkung",ESP="Comentario",FRA="Commentaires",SVE="Kommentar"';
            Description = 'EIS5.04.01';
        }
        field(78714; "Customer P.O. No. EXP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer P.O. No.', Comment = 'DAN="Kunde indkøbsnummer",DEU="Kunden P.O. Nr.",ESP="Nº Ref. Cliente",FRA="Référence client",SVE="Inköpsordernr"';
            Description = 'EIS5.04.01';
        }
        field(78715; "Order Guid EXP"; Text[38])
        {
            DataClassification = CustomerContent;
            Caption = 'Order Guid', Comment = 'DAN="Ordre GUID",DEU="Bestellhinweis",ESP="Nº Pedido",FRA="GUID commande",SVE="Orderstyrning"';
            Description = 'EIS5.04.01';
        }
        field(78716; "Ship-to E-Mail EXP"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to E-Mail', Comment = 'DAN="Levering E-mail",DEU="Lieferung an e-mail",ESP="Envío a-E-Mail",FRA="E-mail destinataire",SVE="Leverans till E-post"';
            Description = 'EIS5.04.01';
        }
        field(78717; "Bill-to County EXP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to County', Comment = 'DAN="Amt",DEU="Rechnung an Bezirk",ESP="Fact. a-Provincia",FRA="Région",SVE="Faktureras delstat"';
            Description = 'EIS5.04.01';
        }
        field(78718; "Ship-to County EXP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to County', Comment = 'DAN="Leveringsamt",DEU="Lieferung an Bezirk",ESP="Envío a-Provincia",FRA="Région destinataire",SVE="Leveransdelstat"';
            Description = 'EIS5.04.01';
        }
        field(78719; "Document Type EXP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type', Comment = 'DAN="Dokumenttype",DEU="Dokumenttyp",ESP="Tipo documento",FRA="Type document",SVE="Dokumenttyp"';
            Description = 'EIS5.04.01';
        }
        field(78720; "Shipping Handling Provider EXP"; Text[38])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Agent Code', Comment = 'DAN="Speditørkode",DEU="Versand Agentencode",ESP="Cód. transportista",FRA="Code transporteur",SVE="Speditörkod"';
            Description = 'EIS5.04.01';
        }
        field(78721; "Shipping Amount EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Amount', Comment = 'DAN="Leveringsgebyr",DEU="Versandwert",ESP="Importe",FRA="Frais livraison",SVE="Leveransbelopp"';
            Description = 'EIS5.04.01';
        }
        field(78722; "Handling Amount EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Handling Amount', Comment = 'DAN="Ekspeditionsgebyr 2",DEU="Bearbeitungswert",ESP="Importe pendiente",FRA="Frais traitement",SVE="Hanteringsbelopp"';
            Description = 'EIS5.04.01';
        }
        field(78723; "Payment Fee Amount EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Fee Amount', Comment = 'DAN="Betalingsgebyr",DEU="Zahlungsgebühr Betrag",ESP="Payment Fee Amount",FRA="Frais paiement",SVE="Betalningsavgift"';
            Description = 'EIS5.04.01';
        }
        field(78724; "BMP Signature EXP"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'BMP Signatur', Comment = 'DAN="BMP Signatur",DEU="BMP Signatur",ESP="Firma BMP",FRA="Signature",SVE="BMP Signatur"';
            Compressed = false;
            Description = 'EIS5.04.01';
            SubType = Bitmap;
        }
        field(78725; "Inventory Location EXP"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Location', Comment = 'DAN="Lokationskode",DEU="Inventur Lokation",ESP="Localización de Inventario",FRA="Magasin",SVE="Lagerplats"';
            Description = 'EIS5.04.01';
            TableRelation = Location;
        }
        field(78726; "Shipping Amt Including Tax EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Amount Including Tax', Comment = 'DAN="Leveringsbeløb incl. moms",ESP="Importe Envío Imp. Inc.",FRA="T.V.A. est inclus dans la livraison"';
            Description = 'EIS5.04.01';
        }
        field(78727; "Handling Amt Including Tax EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Handling Amount Including Tax', Comment = 'DAN="Expeditionsgebyr incl. moms",ESP="Importe Manipulación Imp. Inc.",FRA="T.V.A. est inclus dans la manipulation du service"';
            Description = 'EIS5.04.01';
        }
        field(78728; "Payment Fee Amt Incl. Tax EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Fee Amount Incl. Tax', Comment = 'DAN="Betalingsgebyr inkl. moms",ESP="Importe Comisión de Pago IVA incl.",FRA="T.V.A. est inclus dans le frais de paiement"';
            Description = 'EIS5.04.01';
        }
        field(78729; "Sales Origin EXP"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Origin', Comment = 'DAN="Salgskanal",DEU="Verkaufsursprung",ESP="",FRA="Origine de la vente",SVE=""';
            Description = 'EMSM18.0.6.56';
            Editable = false;
        }
        field(78730; "Shipping Service Code DTP"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Service Code';
            Editable = false;
        }
        field(78735; "Tax Area Code DTP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area".Code;
            Editable = false;
        }
        field(78740; "Tax Liable DTP"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Order Guid EXP")
        {
        }
        key(Key2; "Customer Reference No. EXP")
        {
        }
        key(Key3; "Bill-to Net Customer No. EXP")
        {
        }
        key(Key4; "Sell-to Customer No. EXP")
        {
        }
        key(Key5; "Converted-To Document No. EXP")
        {
        }
        key(Key6; "Order Date EXP")
        {
        }
        key(Key7; "Status EXP", "Order Date EXP")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        InternetOrderLine.SETRANGE("Order Guid EXP", "Order Guid EXP");
        InternetOrderLine.DELETEALL;
    end;

    var
        InternetShopSetup: Record "ExpandIT Setup EXP";
        InternetCustomer: Record "Internet Customer EXP";
        InternetOrderHeader: Record "ExpandIT Order Header EXP";
        InternetOrderLine: Record "ExpandIT Order Line EXP";
        SalesHeader: Record "Sales Header";
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        TEXT000: Label '%1 %2 no longer exists. It could have been converted to a sales order or posted.', Comment = 'DAN="%1 %2 eksisterer ikke længere. Den kan være overført til en ordre eller bogført.",DEU="%1 %2 existiert nicht länger. Es könnte in einer Verkaufsbestellung oder versendet sein.",ESP="%1 %2 ya no existe. Podría haber sido convertido a un pedido o enviado.",FRA="%1 %2 n''existe plus. Elle a peut-être été transformer en commande vente ou validé.",SVE="%1 %2 finns inte. Den kan ha överförts till säljorder eller blivit bokförd."';
        TEXT001: Label 'Do you want to change status on %1 %2 to ''new''?', Comment = 'DAN="Vil du ændre status på %1 %2 til ''''Ny''''?",DEU="Wünschen Sie den Status von %1 %2 auf ''''new'''' zu verändern?",ESP="Desea cambiar el estado a %1 %2 o ''''nuevo''''?",FRA="Voulez-vous changer le statut de %1 %2 au "nouveau" ?",SVE="Vill du ändra status på %1 %2 till ''''ny''''"';
        //TextConst DAN='Vil du ændre status på %1 %2 til ''''Ny''''?',DEU='Wünschen Sie den Status von %1 %2 auf ''''new'''' zu verändern?',ENU='Do you want to change status on %1 %2 to ''''new''''?',ESP='Desea cambiar el estado a %1 %2 o ''''nuevo''''?',FRA='Voulez-vous changer le statut de %1 %2 au "nouveau" ?',SVE='Vill du ändra status på %1 %2 till ''''ny''''';
        TEXT002: Label 'The %1 has not yet been converted or rejected.', Comment = 'DAN="%1 er endnu ikke overført eller afvist.",DEU="%1 ist noch nicht umgewandelt oder abgelehnt.",ESP="%1 todavía no ha sido convertido o rechazado.",FRA="%1 n''a pas été converti ou rejeté.",SVE="%1 har ej ännu blivit godkänd eller avbrutits."';
        //TextConst DAN='%1 er endnu ikke overført eller afvist.',DEU='%1 ist noch nicht umgewandelt oder abgelehnt.',ENU='The %1 has not yet been converted or rejected.',ESP='%1 todavía no ha sido convertido o rechazado.',FRA='%1 n''a pas été converti ou rejeté.',SVE='%1 har ej ännu blivit godkänd eller avbrutits.';
        TEXT003: Label 'Do you want to reject the %1?', Comment = 'DAN="Ønsker du at afvise %1?",DEU="Wünschen Sie die %1 abzulehnen?",ESP="¿Desea rechazar %1?",FRA="Voulez-vous rejeter la %1 ?",SVE="Vill du avbryta %1?"';
    //TextConst DAN='Ønsker du at afvise %1?',DEU='Wünschen Sie die %1 abzulehnen?',ENU='Do you want to reject the %1?',ESP='¿Desea rechazar %1?',FRA='Voulez-vous rejeter la %1 ?',SVE='Vill du avbryta %1?';

    /// <summary>
    /// ChangeToNew.
    /// </summary>
    procedure ChangeToNew();
    begin
        if ("Status EXP" <> "Status EXP"::New) then
            if CONFIRM(TEXT001, true, Rec.TABLENAME, "Customer Reference No. EXP") then begin
                "Status EXP" := "Status EXP"::New;
                MODIFY;
            end;
    end;

    /// <summary>
    /// ReSendNotificationEmail.
    /// </summary>
    procedure ReSendNotificationEmail();
    begin
        if InternetShopSetup.FindFirst() then begin // EMSM18.0.6.148

            case "Status EXP" of
                "Status EXP"::New:
                    MESSAGE(TEXT002, TABLENAME);
                "Status EXP"::Rejected:
                    begin
                        if "Bill-to E-Mail EXP" <> '' then
                            InternetShopMgt.InternetOrderRejected("Bill-to E-Mail EXP", "Order Guid EXP")
                        else begin
                            InternetCustomer.GET("Bill-to Net Customer No. EXP");
                            InternetCustomer.TESTFIELD("E-Mail EXP");
                            InternetShopMgt.InternetOrderRejected(InternetCustomer."E-Mail EXP", "Order Guid EXP")
                        end;
                    end;
                "Status EXP"::Converted:
                    begin
                        if "Bill-to E-Mail EXP" <> '' then
                            InternetShopMgt.InternetOrderConverted("Bill-to E-Mail EXP", "Order Guid EXP")
                        else begin
                            InternetCustomer.GET("Bill-to Net Customer No. EXP");
                            InternetCustomer.TESTFIELD("E-Mail EXP");
                            InternetShopMgt.InternetOrderConverted(InternetCustomer."E-Mail EXP", "Order Guid EXP")
                        end;
                    end;
            end;
        end;
    end;

    /// <summary>
    /// RejectOrder.
    /// </summary>
    procedure RejectOrder();
    var
        Customer: Record Customer;
        InternetCustomer: Record "Internet Customer EXP";
        InternetOrderLine: Record "ExpandIT Order Line EXP";
        ExpandITUtil: Codeunit "ExpandIT Util";
    begin
        TESTFIELD("Status EXP", "Status EXP"::New);
        TESTFIELD("Customer Reference No. EXP");

        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12

            if not CONFIRM(TEXT003, false, TABLENAME) then
                exit;

            if InternetShopSetup."Notify on Rejt of Order EXP" then
                if "Bill-to E-Mail EXP" <> '' then
                    InternetShopMgt.InternetOrderRejected("Bill-to E-Mail EXP", "Order Guid EXP")
                else begin
                    if InternetCustomer.GET("Bill-to Net Customer No. EXP") then begin
                        InternetCustomer.TESTFIELD("E-Mail EXP");
                        InternetShopMgt.InternetOrderRejected(InternetCustomer."E-Mail EXP", "Order Guid EXP")
                    end else
                        if Customer.GET("Sell-to Customer No. EXP") then
                            if Customer."E-Mail" <> '' then
                                InternetShopMgt.InternetOrderRejected(Customer."E-Mail", "Order Guid EXP");
                end;

            "Status EXP" := "Status EXP"::Rejected;
            InternetOrderLine.SETRANGE("Order Guid EXP", "Order Guid EXP");
            InternetOrderLine.MODIFYALL("Status EXP", InternetOrderLine."Status EXP"::Rejected);
            MODIFY;
        end;
    end;
}

