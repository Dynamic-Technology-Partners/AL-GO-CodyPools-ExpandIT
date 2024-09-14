/// <summary>
/// Table EMSM Service Invoice Line EXP (ID 68742).
/// </summary>
table 68742 "EMSM Service Invoice Line EXP"
{
    // version EMSM3.01.02

    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    // EMSM3.01     2012-05-14  PB  * The field Processed by User ID changed to length = 20 to support long USERID.
    // EMSM3.01.01  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EMSM3.01.02  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM18.0.6.26 2020-02-06 FAM * A workaround for an issue we have in BAS, where sometimes the JobPlanningGuid for EMSM Service Invoice Line is empty. 
    // EMSM18.0.6.52 2020-04-20  FAM * Cost price added (Smart item) 
    // EMSM18.0.6.123 2020-06-10  FAM * Time Start and Time Finish added  
    // EMSM18.0.6.139  2020-07-27  FAM * Create an Item Tracking Line if SerialNo and Item Tracking Code is set for an Item.
    // EMSM18.0.6.141 2020-08-06 FAM * New fields added 
    // EMSM18.0.6.159 2020-09-29 FAM * Comment field added
    // EMSM18.06.176  2018-10-16  FAM * Description 2 field size increased to 100 and is now converted


    Caption = 'EMSM Service Invoice Line', Comment = 'DAN="EMSM Servicefakturalinje",DEU="EMSM Servicerechnungszeile",ESP="Línea Factura de Servicio",FRA="Ligne facture service EMSM",SVE="ExpandIT Servicefakturarader"';

    PasteIsValid = false;

    fields
    {
        field(1; "Order No. EXP"; Code[20])
        {
            Caption = 'Order No.', Comment = 'DAN="Bilagsnr.",DEU="Auftrags-Nr.",ESP="Num. de Pedido",FRA="N° commande",SVE="Ordernr"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(2; "Line No. EXP"; Integer)
        {
            Caption = 'Line No.', Comment = 'DAN="Linjenr.",DEU="Zeilen-Nr.",ESP="Num. de Línea",FRA="N° ligne",SVE="Radnr"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(3; "Service Item Line No. EXP"; Integer)
        {
            Caption = 'Service Item Line No.', Comment = 'DAN="Serviceartikellinjenr.",DEU="Serviceartikelzeilen-Nr.",ESP="Nº lín. prod. servicio",FRA="N° ligne article de service",SVE="Serviceartikel radnr"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(4; "Service Item No. EXP"; Code[20])
        {
            Caption = 'Service Item No.', Comment = 'DAN="Serviceartikelnr.",DEU="Serviceartikel-Nr.",ESP="Nº prod. servicio",FRA="N° article de service",SVE="Serviceartikelnr"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(5; "Service Item Serial No. EXP"; Code[20])
        {
            Caption = 'Service Item Serial No.', Comment = 'DAN="Serviceartikelserienr.",DEU="Serviceartikel Serien-Nr.",ESP="Num. de serie producto de Servicio",FRA="N° de série article de service",SVE="Serviceartikel serienr"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(9; "Type EXP"; Enum "Type EXP")
        {
            Caption = 'Type', Comment = 'DAN="Type",DEU="Typ",ESP="Tipo",FRA="Type",SVE="Typ"';
            DataClassification = CustomerContent;
        }
        field(10; "No. EXP"; Code[20])
        {
            Caption = 'No.', Comment = 'DAN="Nummer",DEU="Nr.",ESP="Num.",FRA="N°",SVE="Nr"';
#pragma warning disable AL0603 // TODO: - Fix
            TableRelation = IF ("Type EXP" = CONST(0)) "Standard Text"
#pragma warning restore AL0603 // TODO: - Fix
            ELSE
            IF ("Type EXP" = CONST(Item)) Item
            ELSE
            IF ("Type EXP" = CONST(Resource)) Resource
            ELSE
            IF ("Type EXP" = CONST(Cost)) "Service Cost";
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(18; "Description EXP"; Text[100])
        {
            Caption = 'Description', Comment = 'DAN="Beskrivelse",DEU="Beschreibung",ESP="Descripción",FRA="Désignation",SVE="Beskrivning"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(19; "Description 2 EXP"; Text[100])
        {
            Caption = 'Description 2', Comment = 'DAN="Beskrivelse 2",DEU="Beschreibung 2",ESP="Descripción 2",FRA="Désignation 2",SVE="Beskrivning 2"';
            Editable = true;
            DataClassification = CustomerContent;
            Description = 'EMSM18.0.6.176';
        }
        field(29; "Fault Area Code EXP"; Code[10])
        {
            Caption = 'Fault Area Code', Comment = 'DAN="Fejlområdekode",DEU="Fehlerbereichs-Code",ESP="Código de Area de defecto",FRA="Code zone panne",SVE="Feltyprskod",DEU="Fehlerbereichscode"';
            TableRelation = "Fault Area";
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(30; "Symptom Code EXP"; Code[10])
        {
            Caption = 'Symptom Code', Comment = 'DAN="Symptomkode",DEU="Symptomcode",ESP="Código de Síntoma",FRA="Code symptôme",SVE="Symptomkod"';
            TableRelation = "Symptom Code";
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(31; "Fault Code EXP"; Code[10])
        {
            Caption = 'Fault Code', Comment = 'DAN="Fejlkode",DEU="Fehler-Code",ESP="Código de Defecto",FRA="Code panne",SVE="Åtgärdskod"';
            TableRelation = "Fault Code".Code WHERE("Fault Area Code" = FIELD("Fault Area Code EXP"),
                                                     "Symptom Code" = FIELD("Symptom Code EXP"));
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(32; "Resolution Code EXP"; Code[10])
        {
            Editable = true;
            Caption = 'Resolution Code', Comment = 'DAN="Løsningskode",DEU="Lösungscode",ESP="Código de Resolución",FRA="Code solution",SVE="Lösningskod"';
            TableRelation = "Resolution Code";
            DataClassification = CustomerContent;
        }
        field(52; "Work Type Code EXP"; Code[10])
        {
            Editable = true;
            Caption = 'Work Type Code', Comment = 'DAN="Arbejdstypekode",DEU="Arbeitstypencode",ESP="Cód. tipo trabajo",FRA="Code type travail",SVE="Arbetstypkod"';
            TableRelation = "Work Type";
            DataClassification = CustomerContent;
        }
        field(56; "Quantity EXP"; Decimal)
        {
            Editable = true;
            Caption = 'Quantity', Comment = 'DAN="Antal",DEU="Menge",ESP="Cantidad",FRA="Quantité",SVE="Antal"';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(57; "Qty. to Invoice EXP"; Decimal)
        {
            Editable = true;
            Caption = 'Qty. to Invoice', Comment = 'DAN="Fakturerbart antal",DEU="Menge für Rechnung",ESP="Ctd. a facturar",FRA="Qté à facturer",SVE="ant. att fakturera"';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(58; "Unit Price EXP"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price', Comment = 'DAN="Salgspris",DEU="Teilepreis",ESP="Precio Unitario",FRA="Prix unitaire",SVE="A-pris"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(62; "Total Amount EXP"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Amount', Comment = 'DAN="I alt",DEU="Gesamtbetrag",ESP="Cantidad Total",FRA="Montant total",SVE="Totalt belopp"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(63; "Amount EXP"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount', Comment = 'DAN="Linjebeløb",DEU="Betrag",ESP="Cantidad",FRA="Montant",SVE="Belopp"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(67; "Fault Reason Code EXP"; Code[10])
        {
            Editable = true;
            Caption = 'Fault Reason Code', Comment = 'DAN="Fejlårsagskode",DEU="Fehlergrund-Code",ESP="Código de Razón de Defecto",FRA="Code motif panne",SVE="Felorsakskod"';
            TableRelation = "Fault Reason Code";
            DataClassification = CustomerContent;
        }
        field(70; "Serial No. EXP"; Code[20])
        {
            Editable = true;
            Caption = 'Serial No.', Comment = 'DAN="Serienr.",DEU="Serien-Nr.",ESP="Num. de Serie",FRA="N° de série",SVE="Serienr"';
            DataClassification = CustomerContent;
        }
        field(71; "Document Type EXP"; enum "Document Type EXP")
        {
            Editable = true;
            Caption = 'Document Type', Comment = 'DAN="Bilagstype",DEU="Dokumententyp",ESP="Tipo de Documento",FRA="Type document",SVE="Dokumenttyp"';
            DataClassification = CustomerContent;

        }
        field(79; "Location Code EXP"; Code[10])
        {
            Editable = true;
            Caption = 'Location Code', Comment = 'DAN="Lokationskode",DEU="Lokations-Code",ESP="Código de Localización",FRA="Code magasin",SVE="Platskod"';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(5407; "Unit of Measure Code EXP"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Unit of Measure Code', Comment = 'DAN="Enhedskode",DEU="Einheitencode",ESP="Cód. unidad medida",FRA="Code unité",SVE="Enhetskod"';
            TableRelation = IF ("Type EXP" = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No. EXP"))
            ELSE
            IF ("Type EXP" = CONST(Resource)) "Resource Unit of Measure".Code WHERE("Resource No." = FIELD("No. EXP"))
            ELSE
            "Unit of Measure";

            trigger OnValidate();
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
                ResUnitofMeasure: Record "Resource Unit of Measure";
            begin
            end;
        }
        field(6000; "Job No. EXP"; Code[20])
        {
            Editable = true;
            Caption = 'Job No.', Comment = 'DAN="Sagsnr.",DEU="Projektnr.",ESP="Num. de trabajo",FRA="N° projet"';
            TableRelation = Job;
            DataClassification = CustomerContent;
        }
        field(6001; "Job Task No. EXP"; Code[20])
        {
            Editable = true;
            Caption = 'Job Task No.', Comment = 'DAN="Sagsopgavenr.",DEU="Projektaufgabennr.",ESP="Tarea Núm.",FRA="N° tâche projet"';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No. EXP"));
            DataClassification = CustomerContent;
        }
        field(6002; "Shipment Date EXP"; Date)
        {
            Editable = true;
            Caption = 'Shipment Date', Comment = 'DAN="Afsendelsesdato",ESP="Fecha envío",FRA="Date d''expédition"';
            DataClassification = CustomerContent;
        }
        field(78740; "Saved Date EXP"; Date)
        {
            Editable = true;
            Caption = 'Saved Date', Comment = 'DAN="Gemt Dato",DEU="Gespeichertes Datum",ESP="Fecha de Almacenamiento",FRA="Enregistré le",SVE="Sparad datum"';
            DataClassification = CustomerContent;
        }
        field(78741; "Saved Time EXP"; Time)
        {
            Editable = true;
            Caption = 'Saved Time', Comment = 'DAN="Gemt Tidspunkt",DEU="Gespeicherte Zeit",ESP="Hora de Almacenamiento",FRA="Enregistré à",SVE="Sparad tid"';
            DataClassification = CustomerContent;
        }
        field(78742; "Convert Status EXP"; Option)
        {
            Editable = true;
            Caption = 'Convert Status', Comment = 'DAN="Konverteringsstatus",DEU="Umwandlungsstatus",ESP="Estado de conversión",FRA="Nouveau statut",SVE="Godkänd status"';
            OptionCaption = 'New,Converted,Rejected,Error', Comment = 'DAN="Ny,Overført,Afvist,Fejl",DEU="Neu,umgewandelt,abgelehnt,Fehler",ESP="Nuevo,Convertido,Rechazado,Error",FRA="Nouveau,Accepté,Rejeté,Erreur",SVE="Ny,Konverterad,Avvisad,Fel"';
            OptionMembers = New,Converted,Rejected,Error;
            DataClassification = CustomerContent;
        }
        field(78743; "Deleted EXP"; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Deleted', Comment = 'DAN="Slettet",DEU="Gelöscht",ESP="Eliminado",FRA="Supprimé",SVE="Borttagen"';
        }
        field(78745; "Service Item Line Guid EXP"; Text[38])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Service Item Line Guid', Comment = 'DAN="Serviceartikellinje GUID",DEU="Serviceartikelzeile Guid",DEU="",ESP="ID de la línea producto de Servicio",FRA="GUID ligne article de service",SVE="Serviceartikelradstyrning"';
        }
        field(78746; "Service Invoice Line Guid EXP"; Text[38])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Service Invoice Line Guid', Comment = 'DAN="Servicefakturalinje GUID",DEU="Führende Servicerechnungszeile",DEU="",ESP="ID de Línea de Factura de Servicio",FRA="GUID ligne facture service",SVE="Servicefakturaradstyrning"';
        }
        field(78748; "BAS Guid EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'BAS Guid', Comment = 'DAN="BAS GUID",DEU="BAS Anleitung",DEU="",ESP="ID del BAS",FRA="GUID BAS",SVE="BAS Guid"';
        }
        field(78749; "RecordAction EXP"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'RecordAction', Comment = 'DAN="RecordAction",DEU="",ESP="RecordAction",FRA="Action d''enregistrement"';
        }
        field(78750; "JobPlanningGuid EXP"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'JobPlanningGuid', Comment = 'DAN="JobPlanningGuid",DEU="",ESP="JobPlanningGuid",FRA="Guide pour Planification de tâche"';
        }
        field(78763; "Error Message EXP"; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Error Message', Comment = 'DAN="Fejlmeddelelse",DEU="",ESP="Mensaje de error",FRA="Message d''erreur"';
        }
        field(78764; "Processed Date Time EXP"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Processed Date Time', Comment = 'DAN="Behandlingstidspunkt",ESP="Fecha y hora procesado",FRA="Date de procédé"';
        }
        field(78765; "Rejected By User ID EXP"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Rejected By User ID', Comment = 'DAN="Afvist af Bruger ID",DEU="",ESP="Rechazada por ID Usuario",FRA="Rejeté par identité de l''utilisateur"';
            TableRelation = User;
        }
        field(78766; "Rejected Date Time EXP"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Rejected Date Time', Comment = 'DAN="Afvisningstidspunkt",DEU="",ESP="Fecha y hora de rechazo",FRA="Date rejeté"';
        }
        field(78767; "Rejected Description EXP"; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Rejected Description', Comment = 'DAN="Afvisningsbeskrivelse",DEU="",ESP="Descripción de rechazo",FRA="Description Rejeté", DEU="Beschreibung abgelehnte"';
        }
        field(78768; "Processed By User ID EXP"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Processed By User ID', Comment = 'DAN="Behandlet af Bruger ID",DEU="",ESP="Procesada por ID Usuario",FRA="Procédé par identité de l''utilisateur"';
            TableRelation = User;
        }
        field(78772; "ttt EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'ttt', Comment = 'ESP="ttt"';
        }
        field(78773; "Proc With Delayed Item Li EXP"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Processed With Delayed Item Li', Comment = 'DAN="Behandlet med sen artikkellin",DEU="",ESP="Procesado con Línea Producto",FRA="Procédé avec ligne différé d''article"';
        }
        field(78774; "HasEMSMSrvItemLine EXP"; Boolean)
        {
            Editable = true;
            CalcFormula = Exist("EMSM Service Item Line EXP" WHERE("JobPlanningGuid EXP" = FIELD("JobPlanningGuid EXP"), "JobPlanningGuid EXP" = filter('')));
            Caption = 'HasEMSMSrvItemLine', Comment = 'ESP="HasEMSMSrvItemLine"';
            FieldClass = FlowField;
        }
        field(78775; "ServiceHeaderExist EXP"; Boolean)
        {
            FieldClass = FlowField;
            Editable = true;
            Caption = 'ServiceHeaderExist', Comment = 'DAN="ServiceHovedEksisterer",DEU="ServiceKopfExistiert",ESP="",FRA="L''en-tête du serveur existe",SVE=""';
            CalcFormula = exist("EMSM Service Item Line EXP" where("Order No. EXP" = field("Order No. EXP"), "Line No. EXP" = field("Service Item Line No. EXP"), "JobPlanningGuid EXP" = field("JobPlanningGuid EXP")));
        }
        field(78776; "Cost Price EXP"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 2;
            Caption = 'Cost Price', Comment = 'DAN="Kostpris",DEU="",ESP="",FRA="Prix de revient",SVE=""';
            Editable = true;
            Description = 'EMSM18.0.6.52';
        }
        field(78777; "Time Start EXP"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Time Start', Comment = 'DAN="Tid Start",DEU="Zeit Start",ESP="",FRA="",SVE=""';
            Editable = true;
            Description = 'EMSM18.0.6.123';
        }
        field(78778; "Time Finish EXP"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Time Finish', Comment = 'DAN="Tid Slut",DEU="Zeit Fertig",ESP="",FRA="",SVE=""';
            Editable = true;
            Description = 'EMSM18.0.6.123';
        }
        field(78779; "Lot No. EXP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.', Comment = 'DAN="Lot Nr.",DEU="",ESP="",FRA="",SVE=""';
            Editable = true;
            Description = 'EMSM18.0.6.139';
        }
        field(78780; "UserGuid EXP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'UserGuid', Comment = 'DAN="Bruger ID",DEU="Benutzer ID",ESP="",FRA="Guide de l''utilisateur",SVE=""';
            Editable = true;
            Description = 'EMSM18.0.6.141';
        }
        field(78781; "Comment"; BLOB)
        {
            Caption = 'Comment', Comment = 'DAN="Kommentar",DEU="",ESP="",FRA="",SVE=""';
            Description = 'EMSM18.0.6.159';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "BAS Guid EXP")
        {
            SumIndexFields = "Amount EXP";
        }
        key(Key2; "Order No. EXP")
        {
        }
        key(Key3; "Order No. EXP", "Service Item Line No. EXP", "Line No. EXP")
        {
        }
    }

    fieldgroups
    {
    }
}

