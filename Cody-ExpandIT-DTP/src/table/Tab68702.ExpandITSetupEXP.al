/// <summary>
/// Table ExpandIT Setup EXP (ID 68702).
/// </summary>
table 68702 "ExpandIT Setup EXP"
{
    // version EIS5.04.01,EMSM2.15

    // EIS3.01   2008-05-21  JR  * EIS Version added.
    //                           * ASPExtension function added.
    // 
    // EIS3.02   2009-01-22 RSP  * Added translations of EIS Version
    // 
    // EIS4.00   2010-06-23 JR   * Added version 4.x to the EIS version option field.
    // 
    // EIS4.01   2010-09-03 JR   * ECRM fields moved to ECRM setup table.
    // 
    // EIS4.01.01       2011-01-12 JR   * Validation of table relation for field "Internet Default Currency Code" was disabled.
    //                                This supports writing a currency code that is not in NAV.
    //                                Normally the default currency code is not in NAV.
    // EIS5.04.01       2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM3.05.04      2019-03-12  FAM * Added Line Type for Job Journal lines
    // EMSM18.0.6.32    2020-03-02  FAM * Smart Item No. added
    // EMSM18.0.6.42    2020-03-20  FAM * Use Resource Name As Description 
    // EMSM18.0.6.45    2020-04-02  FAM * ExpandIT attachment functionality is implemented
    // EMSM18.0.6.47    2020-04-06 FAM * Maintain B2B logic 
    // EMSM18.0.6.48    2020-04-07 FAM * New Job Nos. added. 
    // EMSM18.0.6.50    2020-04-15 FAM * Maintain Related Items in BC
    // EMSM18.0.6.135   2020-07-15 FAM * Added "Override Sales Order Status" 
    // EMSM18.0.6.144   2020-07-15 FAM * Override replacementdialog (Component) from ExpandIT Setup
    // EMSM18.0.6.167,EIS6.0.14 2020-10-12 FAM * OnInsert trigger added

    Caption = 'ExpandIT Setup', Comment = 'DAN="ExpandIT opsætning",DEU="ExpandIT Einrichtung",ESP="Configuración ExpandIT",FRA="Paramètres ExpandIT",SVE="ExpandIT Setup"';
    DataClassification = EndUserIdentifiableInformation;
    fields
    {
        field(1; "Primary Key EXP"; Code[10])
        {
            Caption = 'Primary Key', Comment = 'DAN="Primærnøgle",DEU="Primärer Schlüssel",ESP="Clave Primaria",FRA="Clé primaire",SVE="Primärnyckel"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(2; "Sales Person Code EXP"; Code[10])
        {
            Caption = 'Sales Person Code', Comment = 'DAN="Sælgerkode",DEU="Verkäufercode",ESP="Cod. Vendedor",FRA="Code vendeur",SVE="Säljarkod"';
            Description = 'EIS5.04.01';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;
        }
        field(3; "Prices Include VAT EXP"; Boolean)
        {
            Caption = 'Prices Include VAT', Comment = 'DAN="Priser er inkl. moms",DEU="Preis inkl. MWSt.",ESP="Precios IVA incluido",FRA="Prix TTC",SVE="Priser inklusive moms"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(4; "Show Doc After Conversion EXP"; Boolean)
        {
            Caption = 'Show Document After Conversion', Comment = 'DAN="Vis bilag efter overførsel",DEU="Dokument zeigen nach der Übernahme",ESP="Visualizar doc. tras conversión",FRA="Montrer document après transformation",SVE="Visa dokument efter godkännande"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(5; "Internet Customer EXP"; Code[20])
        {
            Caption = 'Internet Customer', Comment = 'DAN="Internet-kunde",DEU="Internetkunde",ESP="Cliente Internet",FRA="Client Internet",SVE="Internet kund"';
            Description = 'EIS5.04.01';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(6; "Internet Customer Template EXP"; Code[20])
        {
            Caption = 'Internet Customer Template', Comment = 'DAN="Internet-kundeskabelon",DEU="Internet Kundenvorlage",ESP="Plantilla Cliente Internet",FRA="Modèle client Internet",SVE="Internet kundexempel"';
            Description = 'EIS5.04.01';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(7; "New Customer Nos. EXP"; Code[10])
        {
            Caption = 'New Customer Nos.', Comment = 'DAN="Kunde-nummerserie",DEU="Neue Kunden Nr.",ESP="Número Serie Clientes",FRA="N° client",SVE="Ny kundnrserie"';
            Description = 'EIS5.04.01';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(8; "New Sales Document Nos. EXP"; Code[10])
        {
            Caption = 'New Sales Document Nos.', Comment = 'DAN="Dokument-nummerserie",DEU="Neue Verkaufsdokumenten Nr.",ESP="Número Serie Nuevos Pedidos",FRA="N° document ventes",SVE="Nytt försäljningsdokumentnr"';
            Description = 'EIS5.04.01';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(11; "Notify on Conv to Doc. EXP"; Boolean)
        {
            Caption = 'Notify on Conversion to Doc.', Comment = 'DAN="Meddel ved overfør til Dok.",DEU="Benachrichtigung über Umwandlung in Doc.",ESP="Notificar en conversión",FRA="Notifier après transformation de la commande",SVE="Observera, ange koppling till dokument"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(12; "Notify on Rejt of Order EXP"; Boolean)
        {
            Caption = 'Notify on Rejection of Order', Comment = 'DAN="Meddel ved afvis ordre",DEU="Benachrichtigung über Ablehnung der Bestellung",ESP="Notificar en anulación de pedidos",FRA="Notifier si commande est rejetée",SVE="Anteckna på avbruten order"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(13; "Remote Shop URL EXP"; Text[80])
        {
            Caption = 'Remote Shop URL', Comment = 'DAN="Remote Shop URL",DEU="Entfernte Internetshop URL",ESP="URL Internet Shop",FRA="URL boutique hébergée",SVE="Mottagande Shop URL"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                InternetShopMgt.FormatURL("Remote Shop URL EXP");
            end;
        }
        field(15; "VAT % EXP"; Decimal)
        {
            Caption = 'VAT %', Comment = 'DAN="Momspct.",DEU="MWSt %",ESP="IVA %",FRA="% TVA",SVE="Momssats %"';
            DecimalPlaces = 0 : 5;
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(16; "Use Internet Customer EXP"; Option)
        {
            Caption = 'Use Internet Customer', Comment = 'DAN="Brug Internet-kunde",DEU="Nutze Internetkunde",ESP="Usar Cliente Internet",FRA="Utiliser client Internet",SVE="Använd Internet kund"';
            Description = 'EIS5.04.01';
            OptionCaption = 'Always,If No Customer Relation,By Request,Never', Comment = 'DAN="Altid,Hvis ingen kunde relation,Spørg,Aldrig",DEU="Immer,wenn keine Kunderbeziehung,bei Anfrage,nie",ESP="Siempre, Si no hay Relación de Cliente, Por solictitud, Nunca",FRA="Jamais,Si pas de relation client,Si demandé,Toujours",SVE="Alltid, Om kundrelation saknas,Vid förfrågan,Aldrig"';
            OptionMembers = Always,"If No Customer Relation","By Request",Never;
            DataClassification = CustomerContent;
        }
        field(17; "Convert To Document Type"; Enum "Document Type EXP")
        {
            DataClassification = CustomerContent;
            Caption = 'Convert To Document Type', Comment = 'DAN="Konverter til Bilagstype",DEU="Übernahme Convert To Document Type",ESP="Convertir a Tipo Doc.",FRA="Transformation en document type",SVE="Godkänn dokumenttyp"';
        }
        field(18; "Renew Clearing on Conv EXP"; Boolean)
        {
            Caption = 'Renew Clearing on Conversion', Comment = 'DAN="Forny Clearing ved Konvert.",DEU="Erneute verrechnung beim Umrechnen.",ESP="Reacer en conversión",FRA="Renouveler acceptation à la transformation",SVE="Förnya clearing vid konvertering"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(19; "Batch Capture EXP"; Boolean)
        {
            Caption = 'Batch Capture', Comment = 'DAN="Batch Capture",DEU="Stapelerfassung",ESP="Captura por lotes",FRA="Capturer paiment en ligne",SVE="Batch bokför"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(20; "Simulation EXP"; Boolean)
        {
            Caption = 'Simulation', Comment = 'DAN="Simulation",DEU="Simulation",ESP="Simulación",FRA="Simulation",SVE="Simulering"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(21; "Test Clearing on Conv. EXP"; Boolean)
        {
            Caption = 'Test Clearing on Conversion', Comment = 'DAN="Test Clearing ved Konvert.",DEU="Test der Verrechnung bei der Umrechnung.",ESP="Testestear en Conversión",FRA="Test d''acceptation à la transformation",SVE="Prova clearing vid överföring"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(22; "Get Card Type on Conv. EXP"; Boolean)
        {
            Caption = 'Get Card Type on Conversion', Comment = 'DAN="Hent Korttype ved Konvert.",DEU="Kartentyp bei der Umrechnung bekommen.",ESP="Traer tarjeta en Conversión",FRA="Obtenir le type de CB à la transformation",SVE="Hämta korttyp vid överföring"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(23; "Last Used ShopperID EXP"; Text[12])
        {
            Caption = 'Last Used ShopperID', Comment = 'DAN="Sidst anvendte BrugerID",DEU="letze Anwender-Käufer ID",ESP="Última ID de Internet utilizado",FRA="ID dernier client Internet",SVE="Senast använt köpID"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(24; "Internet Default Curr Code EXP"; Code[10])
        {
            Caption = 'Internet Default Currency Code', Comment = 'DAN="Internet standard valuta kode",DEU="Internet alternativer Währungscode",ESP="Cod. Divisa Internet",FRA="Code devise Internet par défaut",SVE="Internet förslagsvalutakod"';
            Description = 'EIS5.04.01';
            TableRelation = Currency;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(25; "EIS Version EXP"; Option)
        {
            Caption = 'EIS Version', Comment = 'DAN="EIS Version",DEU="EIS Version",ESP="Versión EIS",FRA="Version EIS",SVE="EIS Version"';
            Description = 'EIS5.04.01';
            OptionMembers = "2.x","3.x","4.x";
            DataClassification = CustomerContent;
        }
        field(26; "Job Jnl. Template Name EXP"; Code[10])
        {
            Caption = 'Job Jnl. Template Name', Comment = 'DAN="Sagskladdetype",DEU="Projekt  Buch.-Bl.-Vorlagenname",ESP="Nombre Plantilla Diario de Trabajo",FRA="Nom pour le Journal de tâche"';
            Description = 'EIS5.04.01';
            TableRelation = "Job Journal Template";
            DataClassification = CustomerContent;
        }
        field(27; "Job Jnl. Batch Name EXP"; Code[10])
        {
            Caption = 'Job Jnl. Batch Name', Comment = 'DAN="Sagskladdenavn",DEU="Projekt Buch.-Blattname",ESP="Nombre paquete diario trabajo",FRA="Lot de Nom pour le Journal de tâche"';
            Description = 'EIS5.04.01';
            TableRelation = "Job Journal Batch".Name WHERE("Journal Template Name" = FIELD("Job Jnl. Template Name EXP"));
            DataClassification = CustomerContent;
        }
        field(28; "Use ExpandIT Number Series EXP"; Boolean)
        {
            Caption = 'Use ExpandIT Number Series', Comment = 'DAN="Benyt ExpandIT Nummerserie",DEU="Verwenden Sie die ExpandIT Nummernserie",ESP="",FRA="Utilisation de séries de numéro d''ExpanDIT",SVE=""';
            Description = 'EMSM3.05.01';
            DataClassification = CustomerContent;
        }

        field(29; "Line Type EXP"; Option)
        {
            Caption = 'Line Type', Comment = 'DAN="Linjetype",DEU="Zeilentyp",ESP="",FRA="Type de ligne",SVE=""';
            OptionCaption = ' ,Budget,Billable,Both Budget and Billable', Comment = 'DAN=" ,Budget,Fakturerbar,Både Budget og Fakturerbar",DEU=",Budget,Fakturierbar,Beides Budget und Fakturierbar",ESP="",FRA=" ,Budget, Facturable, Budgétaire et Facturable",SVE=""';
            OptionMembers = " ","Budget","Billable","Both Budget and Billable";
            DataClassification = EndUserIdentifiableInformation;
        }

        field(30; "Conversion Rule EXP"; Option)
        {
            Caption = 'Conversion Rule', Comment = 'DAN="Konverterings Regel",DEU="Umwandlungsregel",ESP="",FRA="Règle de conversion",SVE=""';
            OptionCaption = 'Prefer Service Order,Prefer Jobs,Prefer Sales Order', Comment = 'DAN="Foretrækker Serviceordre,Foretrækker Sager,Forestrækker Salgsordre",DEU="Bevorzuge Service Auftrag,Bevorzuge Aufgabe,Bevorzuge Verkaufsauftrag",ESP="",FRA="Ordre de service préférentiel, tâches préférentielles, commande préférentielle de vente",SVE=""';
            OptionMembers = "Prefer Service Order","Prefer Jobs","Prefer Sales Order";
            DataClassification = EndUserIdentifiableInformation;
        }
        field(31; "Sales Order Status EXP"; Option)
        {
            Caption = 'Sales Order Status', Comment = 'DAN="Salgsordre Status",DEU="Status Verkaufsauftrag". ESP="",FRA="statut de la commande",SVE=""';
            OptionCaption = ' ,Open,Released', Comment = 'DAN=" ,Åben,Udgivet",DEU=",Offen,Freigegeben",ESP="",FRA=" ,Ouvert, Publié",SVE=""';
            OptionMembers = " ","Open","Released";
            DataClassification = EndUserIdentifiableInformation;
        }
        field(32; "Maintain B2B Logins in BC EXP"; Boolean)
        {
            Caption = 'Maintain B2B Logins in BC', Comment = 'DAN="Vedlighold B2B Logins i BC",DEU="Pflege der B2B Anmeldungen in BC",ESP="",FRA="Maintenir les connexions B2B en BC",SVE=""';
            DataClassification = EndUserIdentifiableInformation;
            Description = 'EMSM18.0.6.47';
        }
        field(33; "Local Shop URL EXP"; Text[80])
        {
            Caption = 'Portal/Local Shop URL', Comment = 'DAN="Portal/Lokal Shop URL",DEU="",ESP="",FRA="URL du portail/de la boutique locale ",SVE=""';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(34; "Smart Item No. EXP"; Code[20])
        {
            Caption = 'Smart Item No.', Comment = 'DAN="Smart Varenr.",DEU="Artikel Kurzwahl Nr.",ESP="",FRA="No d''article intelligent",SVE=""';
            TableRelation = Item;
            Description = 'EMSM18.0.6.32';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(35; "UseResNameAsDescription EXP"; boolean)
        {
            Caption = 'Transfer with resource as description', Comment = 'DAN="Overfør Ressource som beskrivelse",DEU="Übertragen mit Ressource als Beschreibung",ESP="",FRA="Transfert avec la ressource comme description",SVE=""';
            Description = 'EMSM18.0.6.42';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(36; "ExpandIT URL EXP"; Text[100])
        {
            Caption = 'ExpandIT URL', Comment = 'DAN="ExpandIT URL",DEU="",ESP="",FRA="URL ExpandIT",SVE=""';
            Description = 'EMSM18.0.6.45';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(37; "New Job Document Nos. EXP"; Text[100])
        {
            Caption = 'New Job Document Nos.', Comment = 'DAN="Ny Sags Nummerserie",DEU="",ESP="",FRA="Nouveaux No de documents de tâche",SVE=""';
            Description = 'EMSM18.0.6.48';
            TableRelation = "No. Series";
            DataClassification = EndUserIdentifiableInformation;
        }
        field(38; "Maintain Rel. Items In BC EXP"; boolean)
        {
            Caption = 'Maintain Related Items In BC', Comment = 'DAN="Vedlighold Relaterede Varer i BC",DEU="",ESP="",FRA="Maintenir les articles connexes en BC",SVE=""';
            Description = 'EMSM18.0.6.50';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(39; "Override SalesOrder Status EXP"; Boolean)
        {
            Caption = 'Override Sales Order Status', Comment = 'DAN="Overskriv Salgsordre Status",DEU="Überschreiben Status Verkaufsauftrag". ESP="",FRA="",SVE=""';
            DataClassification = EndUserIdentifiableInformation;
            Description = 'EMSM18.0.6.135';

        }
        field(40; "Replacement Dialog Values EXP"; enum "Replacement Dialog EXP")
        {
            Caption = 'Replacement Dialog Values', Comment = 'DAN="Erstatningsdialogs Værdier",DEU="". ESP="",FRA="",SVE=""';
            DataClassification = EndUserIdentifiableInformation;
            Description = 'EMSM18.0.6.144';
        }
        field(75000; "Debug Active"; Boolean)
        {
            Caption = 'Debug Active';
            DataClassification = EndUserIdentifiableInformation;
            Description = 'DTP Debugging';
        }
        field(78000; "Web Payment Jnl. Template"; Code[20])
        {
            Caption = 'Web Payment Jnl. Template';
            TableRelation = "Gen. Journal Template";
        }
        field(78005; "Web Payment Jnl. Batch"; Code[20])
        {
            Caption = 'Web Payment Jnl. Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Web Payment Jnl. Template"));
        }
        field(78010; "Web Payment Bal. A/C Type"; Option)
        {
            Caption = 'Web Payment Bal. A/C Type';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
        }
        field(78015; "Web Payment Bal. A/C No."; Code[20])
        {
            Caption = 'Web Payment Bal. A/C No.';
            TableRelation = if ("Web Payment Bal. A/C Type" = const("G/L Account")) "G/L Account" else
            if ("Web Payment Bal. A/C Type" = const(Customer)) Customer
            else
            if ("Web Payment Bal. A/C Type" = const(Vendor)) Vendor else
            if ("Web Payment Bal. A/C Type" = const("Bank Account")) "Bank Account"
            else
            if ("Web Payment Bal. A/C Type" = const("Fixed Asset")) "Fixed Asset" else
            if ("Web Payment Bal. A/C Type" = const("IC Partner")) "IC Partner";
        }
        field(78020; "Merchant Fee A/C Type"; Option)
        {
            Caption = 'Merchant Fee A/C Type';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
        }
        field(78025; "Merchant Fee A/C No."; Code[20])
        {
            Caption = 'Merchant Fee A/C No.';
            TableRelation = if ("Merchant Fee A/C Type" = const("G/L Account")) "G/L Account" else
            if ("Merchant Fee A/C Type" = const(Customer)) Customer
            else
            if ("Merchant Fee A/C Type" = const(Vendor)) Vendor else
            if ("Merchant Fee A/C Type" = const("Bank Account")) "Bank Account"
            else
            if ("Merchant Fee A/C Type" = const("Fixed Asset")) "Fixed Asset" else
            if ("Merchant Fee A/C Type" = const("IC Partner")) "IC Partner";
        }
        field(79100; "Freight Account Type"; Option)
        {
            OptionMembers = "G/L Account",Item,Resource,"Charge (Item)";
        }
        field(79101; "Freight Account No."; Code[20])
        {
            tablerelation = IF ("Freight Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Freight Account Type" = CONST(Item)) Item
            ELSE
            IF ("Freight Account Type" = CONST(Resource)) Resource
            ELSE
            IF ("Freight Account Type" = CONST("Charge (Item)")) "Item Charge";
        }
        field(79102; "Freight Dimension 1 Value"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(79103; "Freight Dimension 2 Value"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(79110; "Internet Customer 2"; code[20])
        {
            TableRelation = Customer;
        }
        field(79111; "Internet Customer Template 2"; code[20])
        {
            TableRelation = Customer;
        }
        field(79115; "Default Location Code"; Code[10])
        {
            TableRelation = Location;
        }
    }
    keys
    {
        key(Key1; "Primary Key EXP")
        {
        }
    }

    fieldgroups
    {
    }

    var
        InternetShopMgt: Codeunit "Internet Shop Management EXP";

    /// <summary>
    /// ASPExtension.
    /// </summary>
    /// <returns>Return variable retv of type Text[4].</returns>
    procedure ASPExtension() retv: Text[4];
    begin
        if "EIS Version EXP" = "EIS Version EXP"::"2.x" then retv := 'asp' else retv := 'aspx';
    end;

    // EMSM18.0.6.167 begin 
    trigger OnInsert()
    var
        SalesAndReceivables: Record "Sales & Receivables Setup";
        ServiceMgtSetup: Record "Service Mgt. Setup";
        JobsSetup: Record "Jobs Setup";
        JobJournalTempName: Record "Job Journal Template";
        JobJournalBatch: Record "Job Journal Batch";
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        Currencies: Record Currency;

    begin

        if Rec."New Sales Document Nos. EXP" = '' then begin
            if SalesAndReceivables.FindFirst() then begin
                if (SalesAndReceivables."Order Nos." <> '') then
                    Rec."New Sales Document Nos. EXP" := SalesAndReceivables."Order Nos.";
            end;
        end;

        if Rec."New Customer Nos. EXP" = '' then begin
            if SalesAndReceivables.FindFirst() then begin
                if (SalesAndReceivables."Customer Nos." <> '') then
                    Rec."New Customer Nos. EXP" := SalesAndReceivables."Customer Nos.";
            end;
        end;

        if Rec."New Job Document Nos. EXP" = '' then begin
            if JobsSetup.FindFirst() then begin
                if (JobsSetup."Job Nos." <> '') then
                    Rec."New Job Document Nos. EXP" := JobsSetup."Job Nos.";
            end;
        end;

        if Rec."Job Jnl. Template Name EXP" = '' then begin
            JobJournalTempName.SetFilter(Recurring, '%1', false);
            if JobJournalTempName.FindFirst() then
                Rec."Job Jnl. Template Name EXP" := JobJournalTempName.Name;
        end;

        if Rec."Job Jnl. Batch Name EXP" = '' then begin
            JobJournalBatch.SetFilter(Recurring, '%1', false);
            if JobJournalBatch.FindFirst() then
                Rec."Job Jnl. Batch Name EXP" := JobJournalBatch.Name;
        end;

        if Rec."Internet Customer Template EXP" = '' then begin
            Cust.SetFilter("No.", 'INETTEMPLATE');
            If Cust.FindFirst() then
                Rec."Internet Customer Template EXP" := Cust."No.";
        end;

        if Rec."Internet Customer EXP" = '' then begin
            Cust.SetFilter("No.", 'INET');
            If Cust.FindFirst() then
                Rec."Internet Customer EXP" := Cust."No.";
        end;

        if Rec."EIS Version EXP" <> Rec."EIS Version EXP"::"4.x" then
            Rec."EIS Version EXP" := Rec."EIS Version EXP"::"4.x";

        if Rec."Line Type EXP" = Rec."Line Type EXP"::" " then
            Rec.Validate("Line Type EXP", Rec."Line Type EXP"::Billable);

        if Rec."Internet Default Curr Code EXP" = '' then begin
            if GlSetup.FindFirst() then begin
                if Currencies.Get(GlSetup."LCY Code") then
                    Rec.Validate(Rec."Internet Default Curr Code EXP", GlSetup."LCY Code");
            end;
        end;
    end;

    // EMSM18.0.6.167 end






}

