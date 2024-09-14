/// <summary>
/// Table EMSM Service Item Line EXP (ID 68741).
/// </summary>
table 68741 "EMSM Service Item Line EXP"
{
    // version EMSM3.01.02

    // EMSM3.00.01  2011-09-22  PB * Added Fault Reason Code, Fault Area Code, Symptom Code, Fault Code and Resolution Code
    //                               as these are now provided by the client.
    //              2011-10-27  PB * EMSM Error handling UI implemented.
    //                             * Handling of Service Order Type added.
    // 
    // EMSM3.01     2012-05-14  PB * The field Processed by User ID changed to length = 20 to support long USERID.
    // EMSM3.01.01  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EMSM3.01.02  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM3.01.05  2018-04-09  FAM * Field 772..776 is added.
    // EMSM3.05.05  2019-05-06  FAM * Field "Converted To Service Order" added.
    // EMSM3.05.09  2019-08-12  FAM * Field "UserGuid" added.
    // EMSM18.0.6.65  2020-05-25  FAM * ValidateTableRelation = false added to Job No. to let the user add NEW in the field.
    // EMSM18.0.6.141 2020-08-06 FAM * New fields added
    // EMSM18.0.6.174 2020-10-26 FAM * New field (Location of Service Item) is added   


    Caption = 'EMSM Service Item Line', Comment = 'DAN="EMSM Serviceartikellinje",DEU="EMSM Serviceartikelzeile",ESP="Línea producto de servicio",FRA="EMSM ligne article de service",SVE="ExpandIT Service Artikelrad"';

    PasteIsValid = false;

    fields
    {
        field(1; "Order No. EXP"; Code[20])
        {
            Caption = 'Order No.', Comment = 'DAN="Bilagsnr.",DEU="Auftrags-Nr.",ESP="Num. de Pedido",FRA="N° commande",SVE="Ordernr"';
            DataClassification = CustomerContent;
        }
        field(2; "Line No. EXP"; Integer)
        {
            Caption = 'Line No.', Comment = 'DAN="Linjenr.",DEU="Zeilen-Nr.",ESP="Línea num.",FRA="N° ligne",SVE="Radnr"';
            DataClassification = CustomerContent;
        }
        field(3; "Service Item No. EXP"; Code[20])
        {
            Caption = 'Service Item No.', Comment = 'DAN="Serviceartikelnr.",DEU="Serviceartikel-Nr.",ESP="Nº prod. servicio",FRA="N° article de service",SVE="Serviceartikelnr"';
            TableRelation = "Service Item"."No.";
            DataClassification = CustomerContent;
        }
        field(5; "Item No. EXP"; Code[20])
        {
            Caption = 'Item No.', Comment = 'DAN="Varenr.",DEU="Artikel-Nr.",ESP="Nº producto",FRA="N° article",SVE="Artikelnr"';
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
        }
        field(6; "Serial No. EXP"; Code[20])
        {
            Caption = 'Serial No.', Comment = 'DAN="Serienr.",DEU="Serien-Nr.",ESP="Num. de Serie",FRA="N° de série",SVE="Serienr"';
            DataClassification = CustomerContent;
        }
        field(7; "Description EXP"; Text[30])
        {
            Caption = 'Description', Comment = 'DAN="Beskrivelse",DEU="Beschreibung",ESP="Descripción",FRA="Désignation",SVE="Beskrivning"';
            DataClassification = CustomerContent;
        }
        field(9; "Repair Status Code EXP"; Code[10])
        {
            Caption = 'Repair Status Code', Comment = 'DAN="Reparationsstatuskode",DEU="Reparaturstatus-Code",ESP="Código de Estado de Reparación",FRA="Code état réparation",SVE="Reparationsstatuskod"';
            TableRelation = "Repair Status";
            DataClassification = CustomerContent;
        }
        field(10; "Priority EXP"; Option)
        {
            Caption = 'Priority', Comment = 'DAN="Prioritet",DEU="Priorität",ESP="Prioridad",FRA="Priorité",SVE="Prioritet"';
            OptionCaption = 'Low,Medium,High', Comment = 'DAN="Lav,Medium,Høj",DEU="Niedrig,Mittel,Hoch",ESP="Bajo,Medio,Alto",FRA="Faible,Moyenne,Haute",SVE="Låg,Medium,Hög"';
            OptionMembers = Low,Medium,High;
            DataClassification = CustomerContent;
        }
        field(11; "Response Time (Hours) EXP"; Decimal)
        {
            Caption = 'Response Time (Hours)', Comment = 'DAN="Svartid (timer)",DEU="Antwortzeit (Stunden)",ESP="Tiempo de respuesta (Horas)",FRA="Délai de réponse (heures)",SVE="Svarstid (timmar)"';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(12; "Response Date EXP"; Date)
        {
            Caption = 'Response Date', Comment = 'DAN="Svardato",DEU="Antwortdatum",ESP="Fecha de Respuesta",FRA="Date de réponse",SVE="Svarsdatum"';
            DataClassification = CustomerContent;
        }
        field(13; "Response Time EXP"; Time)
        {
            Caption = 'Response Time', Comment = 'DAN="Svartidspunkt",DEU="Antwortzeit",ESP="Hora de Respuesta",FRA="Délai de réponse",SVE="Svarstid"';
            DataClassification = CustomerContent;
        }
        field(14; "Starting Date EXP"; Date)
        {
            Caption = 'Starting Date', Comment = 'DAN="Startdato",DEU="Startdatum",ESP="Fecha de comienzo",FRA="Date début",SVE="Startdatum"';
            DataClassification = CustomerContent;
        }
        field(15; "Starting Time EXP"; Time)
        {
            Caption = 'Starting Time', Comment = 'DAN="Starttidspunkt",DEU="Startzeit",ESP="Hora de Comienzo",FRA="Heure début",SVE="Starttid"';
            DataClassification = CustomerContent;
        }
        field(16; "Finishing Date EXP"; Date)
        {
            Caption = 'Finishing Date', Comment = 'DAN="Færdiggørelsesdato",DEU="Enddatum",ESP="Fecha de finalización",FRA="Date fin",SVE="Färdigdatum"';
            DataClassification = CustomerContent;
        }
        field(17; "Finishing Time EXP"; Time)
        {
            Caption = 'Finishing Time', Comment = 'DAN="Færdiggørelsestidspunkt",DEU="Endzeit",ESP="Hora de Finalización",FRA="Heure fin",SVE="Färdigtid"';
            DataClassification = CustomerContent;
        }
        field(31; "Fault Reason Code EXP"; Code[10])
        {
            Caption = 'Fault Reason Code', Comment = 'DAN="Fejlårsagskode",DEU="",ESP="Cód. razón defecto",FRA="Code motif panne"';
            TableRelation = "Fault Reason Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                FaultReasonCode: Record "Fault Reason Code";
                RecR: RecordRef;
                TypeR: FieldRef;
                TypeStr: Text[50];
            begin
            end;
        }
        field(33; "Fault Area Code EXP"; Code[10])
        {
            Caption = 'Fault Area Code', Comment = 'DAN="Fejlområdekode",DEU="Fehlerbereichscode",ESP="Cód. área defecto",FRA="Code zone panne"';
            TableRelation = "Fault Area";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ServPriceMgmt: Codeunit "Service Price Management";
            begin
            end;
        }
        field(34; "Symptom Code EXP"; Code[10])
        {
            Caption = 'Symptom Code', Comment = 'DAN="Symptomkode",DEU="Symptomcode",ESP="Cód. síntoma",FRA="Code symptôme"';
            TableRelation = "Symptom Code";
            DataClassification = CustomerContent;
        }
        field(35; "Fault Code EXP"; Code[10])
        {
            Caption = 'Fault Code', Comment = 'DAN="Fejlkode",ESP="Cód. defecto",FRA="Code d''erreur"';
            TableRelation = "Fault Code".Code WHERE("Fault Area Code" = FIELD("Fault Area Code EXP"),
                                                     "Symptom Code" = FIELD("Symptom Code EXP"));
            DataClassification = CustomerContent;
        }
        field(36; "Resolution Code EXP"; Code[10])
        {
            Caption = 'Resolution Code', Comment = 'DAN="Løsningskode",DEU="Lösungscode",ESP="Cód. resolución",FRA="Code solution"';
            TableRelation = "Resolution Code";
            DataClassification = CustomerContent;
        }
        field(37; "Fault Comment EXP"; Boolean)
        {
            CalcFormula = Exist("EMSM Service Comment Line EXP" WHERE("No. EXP" = FIELD("Order No. EXP"),
                                                                   "Table Line No. EXP" = FIELD("Line No. EXP"),
                                                                   "JobPlanningGuid EXP" = FIELD("JobPlanningGuid EXP")));
            Caption = 'Fault Comment', Comment = 'DAN="Bemærkning til fejl",DEU="",ESP="Comentario defecto",FRA="Commentaire d''erreur"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(43; "Document Type EXP"; enum "Document Type EXP")
        {
            Caption = 'Document Type', Comment = 'DAN="Bilagstype",DEU="Dokumententyp",ESP="Tipo de Documento",FRA="Type document",SVE="Dokumenttyp"';
            DataClassification = CustomerContent;

        }
        field(44; "Salesperson Code EXP"; Code[10])
        {
            Caption = 'Salesperson Code', Comment = 'DAN="Sælgerkode",DEU="",ESP="Cód. vendedor",FRA="Code vendeur"';
            Description = 'EMSM3.01.03';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;
        }
        field(45; "Job No. EXP"; Code[20])
        {
            Caption = 'Job No.', Comment = 'DAN="Sagsnr.",DEU="",ESP="Num. de trabajo",FRA="N° projet"';
            Description = 'EMSM18.0.6.65';
            TableRelation = Job;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(78740; "Saved Date EXP"; Date)
        {
            Caption = 'Saved Date', Comment = 'DAN="Gemt Dato",DEU="Gespeichertes Datum",ESP="Fecha de almacenamiento",FRA="Enregistré le",SVE="Saved datum"';
            DataClassification = CustomerContent;
        }
        field(78741; "Saved Time EXP"; Time)
        {
            Caption = 'Saved Time', Comment = 'DAN="Gemt Tidspunkt",DEU="Gespeicherte Zeit",ESP="Hora de almacenamiento",FRA="Enregistré à",SVE="Sparad tid"';
            DataClassification = CustomerContent;
        }
        field(78742; "Convert Status EXP"; Option)
        {
            Caption = 'Convert Status', Comment = 'DAN="Konverteringsstatus",DEU="Umwandlungsstatus",ESP="Estado de conversión",FRA="Nouveau statut",SVE="Godkänd status"';
            OptionCaption = 'New,Converted,Rejected,Error', Comment = 'DAN="Ny,Overført,Afvist,Fejl",DEU="Neu,umgewandelt,abgelehnt,Error",ESP="Nuevo,Convertido,Rechazado,Error",FRA="Nouveau,Accepté,Rejeté,Erreur",SVE="Ny,Godkänd,Avbruten,Fel"';
            OptionMembers = New,Converted,Rejected,Error;
            DataClassification = CustomerContent;
        }
        field(78744; "Service Header Guid EXP"; Text[38])
        {
            Caption = 'Service Header Guid', Comment = 'DAN="Serviceordrehoved GUID",DEU="Führender Servicekopf",ESP="ID de Cabecera de Servicio",FRA="GUID en-tête service",SVE="Serviceorderstyrning"';
            DataClassification = CustomerContent;
        }
        field(78745; "Service Item Line Guid EXP"; Text[38])
        {
            Caption = 'Service Item Line Guid', Comment = 'DAN="Serviceartikellinje GUID",DEU="Serviceartikelzeile Guid",ESP="ID de la línea producto de Servicio",FRA="GUID ligne article de service",SVE="Serviceartikelradstyrning"';
            DataClassification = CustomerContent;
        }
        field(78748; "BAS Guid EXP"; Integer)
        {
            Caption = 'BAS Guid', Comment = 'DAN="BAS GUID",DEU="BAS Anleitung",ESP="ID del BAS",FRA="GUID BAS",SVE="BAS Guid"';
            DataClassification = CustomerContent;
        }
        field(78749; "RecordAction EXP"; Code[10])
        {
            Caption = 'RecordAction', Comment = 'DAN="RecordAction",ESP="RecordAction",FRA="Action d''enregistrement"';
            DataClassification = CustomerContent;
        }
        field(78750; "JobPlanningGuid EXP"; Code[50])
        {
            Caption = 'JobPlanningGuid', Comment = 'DAN="JobPlanningGuid",ESP="JobPlanningGuid",FRA="Guide pour Planification de tâche"';
            DataClassification = CustomerContent;
        }
        field(78751; "Customer No. EXP"; Code[20])
        {
            Caption = 'Customer No.', Comment = 'DAN="Debitornr.",DEU="Debitorennr.",ESP="Nº cliente",FRA="N° client",SVE="Kundnr"';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(78752; "Ship-to Code EXP"; Code[10])
        {
            Caption = 'Ship-to Code', Comment = 'DAN="Leveringsadressekode",DEU="Lief. an Code",ESP="Cód. dirección envío cliente",FRA="Code destinataire",SVE="Leveransadresskod"';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No. EXP"));
            DataClassification = CustomerContent;
        }
        field(78753; "Ship-to Name EXP"; Text[50])
        {
            Caption = 'Ship-to Name', Comment = 'DAN="Leveringsnavn",DEU="Lief. an Name",ESP="Envío a-Nombre",FRA="Nom du destinataire",SVE="Leveransnamn"';
            DataClassification = CustomerContent;
        }
        field(78754; "Ship-to Address EXP"; Text[50])
        {
            Caption = 'Ship-to Address', Comment = 'DAN="Leveringsadresse",DEU="Lief. an Adresse",ESP="Envío a-Dirección",FRA="Adresse destinataire",SVE="Leveransadress"';
            DataClassification = CustomerContent;
        }
        field(78755; "Ship-to Address 2 EXP "; Text[50])
        {
            Caption = 'Ship-to Address 2 ';
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
        }
        field(78756; "Ship-to City EXP"; Text[30])
        {
            Caption = 'Ship-to City', Comment = 'DAN="Leveringsby",DEU="Lief. an Ort",ESP="Envío a-Población",FRA="Ville destinataire",SVE="Leveransort"';
            DataClassification = CustomerContent;
        }
        field(78757; "Ship-to Post Code EXP"; Code[20])
        {
            Caption = 'Ship-to Post Code', Comment = 'DAN="Leveringspostnr.",DEU="Lief. an PLZ-Code",ESP="Envío a-C.P.",FRA="Code postal destinataire",SVE="Leveranspostnrkod"';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(78758; "Ship-to County EXP"; Text[30])
        {
            Caption = 'Ship-to County', Comment = 'DAN="Leveringsamt",DEU="Lief. an Bundesregion",ESP="Envío a-Provincia",FRA="Région destinataire",SVE="Leveransdelstat"';
            DataClassification = CustomerContent;
        }
        field(78759; "Ship-to Country/RegCode EXP"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code', Comment = 'DAN="Lande-/områdekode for levering",DEU="Lief. an Länder-/Regionscode",ESP="Envío a-Cód. país",FRA="Code pays/région destinataire",SVE="Leveranslandkod"';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(78760; "Contract No. EXP"; Code[20])
        {
            Caption = 'Contract No.', Comment = 'DAN="Kontraktnr.",DEU="Vertragsnr.",ESP="Nº contrato",FRA="N° contrat",SVE="Kontraktsnr"';
            DataClassification = CustomerContent;
        }
        field(78761; "AddressType EXP"; Integer)
        {
            Caption = 'AddressType', Comment = 'DAN="Adressetype",DEU="Adresstyp",ESP="AddressType",FRA="Type d''adresse "';
            DataClassification = CustomerContent;
        }
        field(78762; "ItemType EXP"; Integer)
        {
            Caption = 'ItemType', Comment = 'DAN="Varetype",ESP="",DEU="ArtikelTyp",FRA="Type d''article"';
            DataClassification = CustomerContent;
        }
        field(78763; "Error Message EXP"; Text[250])
        {
            Caption = 'Error Message', Comment = 'DAN="Fejlmeddelelse",DEU="Fehlermeldung",ESP="Mensaje de error",FRA="Message d''erreur"';
            DataClassification = CustomerContent;
        }
        field(78764; "Processed Date Time EXP"; DateTime)
        {
            Caption = 'Processed Date Time', Comment = 'DAN="Behandlingstidspunkt",DEU="Verarbeitetes Datum Uhrzeit",ESP="Processed Date Time",FRA="Date de procédé"';
            DataClassification = CustomerContent;
        }
        field(78765; "Rejected By User ID EXP"; Code[50])
        {
            Caption = 'Rejected By User ID', Comment = 'DAN="Afvist af Bruger ID",DEU="Abgelehnt von Benutzer-ID",ESP="Rechazada por ID Usuario",FRA="Rejeté par identité de l''utilisateur"';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(78766; "Rejected Date Time EXP"; DateTime)
        {
            Caption = 'Rejected Date Time', Comment = 'DAN="Afvisningstidspunkt",DEU="Abgelehntes Datum Uhrzeit",ESP="Rechazada a Fecha y Hora",FRA="Date rejeté"';
            DataClassification = CustomerContent;
        }
        field(78767; "Rejected Description EXP"; Text[250])
        {
            Caption = 'Rejected Description', Comment = 'DAN="Afvisningsbeskrivelse",DEU="Abgelehnte Beschreibung",ESP="Descripción rechazada",FRA="Description Rejeté", DEU="Beschreibung abgelehnte"';
            DataClassification = CustomerContent;
        }
        field(78768; "Processed By User ID EXP"; Code[50])
        {
            Caption = 'Processed By User ID', Comment = 'DAN="Behandlet af Bruger ID",DEU="Verarbeitet nach Benutzer ID",ESP="Procesada por ID Usuario",FRA="Procédé par identité de l''utilisateur"';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(78771; "Service Order Type EXP"; Code[10])
        {
            Caption = 'Service Order Type', Comment = 'DAN="Serviceordretype",DEU="Serviceauftragsart",ESP="",FRA="Type commande service"';
            TableRelation = "Service Order Type";
            DataClassification = CustomerContent;
        }
        field(78772; "Customer Reference No. EXP"; Code[20])
        {
            Caption = 'Customer Reference No.', comment = 'DAN="Kundereferencenr.",DEU="",FRA="",SVE="",ESP=""';
            Description = 'EMSM3.01.05';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(78773; "Order By Contact Name EXP"; Text[50])
        {
            Caption = 'Order By Contact Name', comment = 'DAN="Bestilt af",DEU="",FRA="Commande par nom de contact",SVE="",ESP=""';
            Description = 'EMSM3.01.05';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(78774; "Job Description EXP"; Text[50])
        {
            Caption = 'Job Description', comment = 'ESP="",DAN="",FRA="Description de la tâche ",SVE="",DEU=""';
            Description = 'EMSM3.01.05';
            DataClassification = CustomerContent;
        }
        field(78775; "IsUrgent EXP"; Boolean)
        {
            Caption = 'IsUrgent', comment = 'DAN="Haster",DEU="",FRA="Urgent",SVE="",ESP=""';
            Description = 'EMSM3.01.05';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(78776; "ShiptoDoCallBeforeVisit EXP"; Boolean)
        {
            Caption = 'Call Before Visit', comment = 'DAN="Ring før besøg",DEU="",FRA="expédier à appeler avant la visite",SVE="",ESP=""';
            Description = 'EMSM3.01.05';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(78778; "Has Multi Serv. Item Lines EXP"; Boolean)
        {
            CalcFormula = Exist("EMSM Service Item Line EXP" WHERE("JobPlanningGuid EXP" = FIELD("JobPlanningGuid EXP"),
                                                                "Order No. EXP" = FIELD("Order No. EXP"),
                                                                "Job No. EXP" = FIELD("Job No. EXP"),
                                                                "Line No. EXP" = CONST(0),
                                                                "Convert Status EXP" = FILTER(<> Converted)));
            Description = 'EMSM3.03';
            FieldClass = FlowField;
        }
        field(78770; "Converted To Service Order EXP"; Code[20])
        {
            Caption = 'Converted To Service Order', Comment = 'DAN="Konverteret Til Serviceordre",DEU="Umgewandelt in Serviceauftrag",ESP="",FRA="",SVE=""';
            Description = 'EMSM3.05.05';
            DataClassification = CustomerContent;
        }
        field(78779; "Job Task No. EXP"; Code[20])
        {
            Caption = 'Job Task No.', Comment = 'DAN="Aktivitetsnr.",DEU="Projektaufgabennr.",ESP="",FRA="N° de tâche ",SVE=""';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No. EXP"));
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(78780; "UserGuid EXP"; Code[20])
        {
            Caption = 'UserGuid', Comment = 'DAN="Bruger ID",DEU="Benutzer ID",ESP="",FRA="Guide de l''utilisateur",SVE=""';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(78781; "Converted To Sales Order EXP"; Code[20])
        {
            Caption = 'Converted To Sales Order', Comment = 'DAN="Konverteret Til Salgsordre",DEU="Umgewandelt in Verkaufsauftrag",ESP="",FRA="Converti en ordre de service",SVE=""';
            Description = 'EMSM3.05.10';
            DataClassification = CustomerContent;
        }
        field(78782; "Ship-to Name 2 EXP"; Text[50])
        {
            Caption = 'Ship-to Name 2', Comment = 'DAN="Leveringsnavn 2",DEU="Lief. an Name 2",ESP="Envío a-Nombre 2",FRA="Nom du destinataire 2",SVE="Leveransnamn 2"';
            Editable = true;
            Description = 'EMSM18.0.6.141 ';
            DataClassification = CustomerContent;
        }
        field(78783; "Responsible EXP"; Code[20])
        {
            Caption = 'Responsible', Comment = 'DAN="Sagsansvarlig",DEU="",ESP="",FRA="",SVE=""';
            Editable = true;
            Description = 'EMSM18.0.6.141';
            DataClassification = CustomerContent;
        }
        field(78784; "Location of Service Item"; Text[30])
        {
            Caption = 'Location of Service Item', Comment = 'DAN="Serviceartikel Lokation",DEU="",ESP="",FRA="",SVE=""';
            Editable = true;
            Description = 'EMSM18.0.6.174';
            DataClassification = CustomerContent;
        }
        field(78855; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "BAS Guid EXP")
        {
        }
        key(Key2; "Order No. EXP")
        {
        }

    }

    fieldgroups
    {
    }

    /// <summary>
    /// OpenRelatedEMSMServItemLines.
    /// </summary>
    /// <param name="ServiceItemLine">Record "Service Item Line".</param>
    procedure OpenRelatedEMSMServItemLines(ServiceItemLine: Record "Service Item Line");
    var
        EMSMIncommingServiceOrders: Page "EMSM Incoming Serv Orders EXP";
    begin
        SETCURRENTKEY("Order No. EXP");
        SETRANGE("Order No. EXP", ServiceItemLine."Document No.");
        SETRANGE("Line No. EXP", ServiceItemLine."Line No.");
        EMSMIncommingServiceOrders.SETTABLEVIEW(Rec);
        EMSMIncommingServiceOrders.RUN;
    end;
}

