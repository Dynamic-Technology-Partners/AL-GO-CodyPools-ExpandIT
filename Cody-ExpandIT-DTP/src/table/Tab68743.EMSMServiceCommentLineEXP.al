/// <summary>
/// Table EMSM Service Comment Line EXP (ID 68743).
/// </summary>
table 68743 "EMSM Service Comment Line EXP"
{
    // version EMSM3.01.03

    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    // 
    // EMSM3.01     2012-05-14  PB * The field Processed by User ID changed to length = 20 to support long USERID.
    // EMSM3.01.01  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EMSM3.01.02  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM3.01.03  2018-04-16  FAM * There has been added some new options to field "Type" in its OptionStrings.
    // EMSM3.05.09  2019-08-12  FAM * New key added 


    Caption = 'EMSM Service Comment Line', Comment = 'DAN="EMSM Bemærkninger til servicelinje",DEU="EMSM Servicekommentarzeile",ESP="Línea Comentario de Servicio",FRA="EMSM Ligne commentaire service",SVE="ExpandIT Servicekommentarrad"';
    DataCaptionFields = "Type EXP", "No. EXP";
    DrillDownPageID = "Service Comment Sheet";
    LookupPageID = "Service Comment Sheet";

    fields
    {
        field(1; "Type EXP"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type', Comment = 'DAN="Type",DEU="Typ",ESP="Tipo",FRA="Type",SVE="Typ"';
            Description = 'EMSM3.01.03';
            OptionCaption = 'Internal,Service Order,Fault,Resolution,Accessory,Service Item,Service Contract,Loaner,Service Item Loaner,,Invoice,Vendor Comment,Portal', Comment = 'DAN="Intern,Generelt,Fejl,Løsning,Tilbehør,Serviceartikel,Servicekontrakt,Låntager,Udlånsserviceart.,,Faktura,Leverandør Kommentar,Portal",DEU="eigene,Serviceauftrag,Fehler,Lösung,Zubehör,Serviceartikel,Servicevertrag,Geliehen,Serviceartikel geliehen,,Rechnung,Lieferantenkommentar,Portal",ESP="Interno,Pedido de Servicio,Defecto,Resolución,Accesorio,Producto de Servicio,Contrato de Servicio,Prestamista,Prestamista producto de Servicio,,Factura,Comentario del proveedor,Portal",FRA="Interne,Commandes service,Panne,Solution,Accessoire,Article de service,Contrat de service,Article de prêt,Article de service de prêt,,Facture,Commentaire du vendeur,Portail",SVE="Internt,Serviceorder,Fel,Lösning,Tillbehör,Serviceartikel,Servicekontrakt,Låntagare,Serviceartikellån,,Faktura,Leverantörs kommentar,Portal"';
            OptionMembers = Internal,"Service Order",Fault,Resolution,Accessory,"Service Item","Service Contract",Loaner,"Service Item Loaner",,Invoice,"Vendor Comment",Portal;
        }
        field(2; "No. EXP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.', Comment = 'DAN="Nummer",DEU="Nr.",ESP="Num.",FRA="N°",SVE="Nr"';
            NotBlank = true;
        }
        field(3; "Table Line No. EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table Line No.', Comment = 'DAN="Tabellinjenr.",DEU="Tabellenzeilen-Nr.",ESP="Num de Línea en la tabla",FRA="N° ligne table",SVE="Tabellradnr"';
        }
        field(4; "Line No. EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.', Comment = 'DAN="Linjenr.",DEU="Zeilen-Nr.",ESP="Num. de línea",FRA="N° ligne",SVE="Radnr"';
        }
        field(6; "Comment EXP"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Comment', Comment = 'DAN="Bemærkning",DEU="Bemerkung",ESP="Comentario",FRA="Commentaires",SVE="Kommentar"';
        }
        field(7; "Date EXP"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date', Comment = 'DAN="Dato",DEU="Datum",ESP="Fecha",FRA="Date",SVE="Datum"';
        }
        field(78740; "Saved Date EXP"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Saved Date', Comment = 'DAN="Gemt Dato",DEU="Gespeichertes Datum",ESP="Fecha de almacenamiento",FRA="Enregistré le",SVE="Sparad datum"';
        }
        field(78741; "Saved Time EXP"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Saved Time', Comment = 'DAN="Gemt Tidspunkt",DEU="Gespeicherte Zeit",ESP="Hora de almacenamiento",FRA="Enregistré à",SVE="Sparad tid"';
        }
        field(78742; "Convert Status EXP"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Convert Status', Comment = 'DAN="Koveteringstatus",DEU="Umwandlungsstatus",ESP="Estado de conversión",FRA="Nouveau statut",SVE="Godkänd status"';
            OptionCaption = 'New,Converted,Rejected', Comment = 'DAN="Ny,Overført,Afvist",DEU="Neu,umgewandelt,abgewiesen",ESP="Nuevo,Convertido,Rechazado",FRA="Nouveau,Accepté,Rejeté",SVE="Ny,Godkänd,Avbruten"';
            OptionMembers = New,Converted,Rejected,Error;
        }
        field(78747; "Service Comment Line Guid EXP"; Text[38])
        {
            DataClassification = CustomerContent;
            Caption = 'Service Comment Line Guid', Comment = 'DAN="Kommentarlinie GUID",DEU="Führende Servicebemerkungszeile",ESP="ID del Comentario del Servicio",FRA="GUID ligne commentaire service",SVE="Servicekommentarradstyrning"';
        }
        field(78748; "BAS Guid EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'BAS Guid', Comment = 'DAN="BAS GUID",DEU="BAS Anleitung",ESP="ID del BAS",FRA="GUID BAS",SVE="BAS Guid"';
        }
        field(78749; "RecordAction EXP"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'RecordAction', Comment = 'DAN="RecordAction",ESP="RecordAction",FRA="Action d''enregistrement"';
        }
        field(78750; "JobPlanningGuid EXP"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'JobPlanningGuid', Comment = 'DAN="JobPlanningGuid",ESP="JobPlanningGuid",FRA="Guide pour Planification de tâche"';
        }
        field(78764; "Processed Date Time EXP"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Processed Date Time', Comment = 'DAN="Behandlingstidspunkt",ESP="Procesado a Fecha y Hora",FRA="Date de procédé"';
        }
        field(78768; "Processed By User ID EXP"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Processed By User ID', Comment = 'DAN="Behandlet af Bruger ID",ESP="Procesada por ID Usuario",FRA="Procédé par identité de l''utilisateur"';
            TableRelation = User;
        }
        field(78769; "Service Item No. EXP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Service Item No.';
            TableRelation = "Service Item"."No.";
            Enabled = true;
        }
    }

    keys
    {
        key(Key1; "BAS Guid EXP")
        {
        }
        key(Key2; "Convert Status EXP", "Saved Date EXP", "Saved Time EXP")
        {
        }
        key(Key3; "No. EXP", "Table Line No. EXP", "JobPlanningGuid EXP", "Type EXP", "Line No. EXP")
        {

        }
    }

    fieldgroups
    {
    }
}

