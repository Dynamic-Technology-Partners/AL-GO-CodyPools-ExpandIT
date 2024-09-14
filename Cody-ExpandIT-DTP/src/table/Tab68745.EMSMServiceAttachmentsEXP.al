/// <summary>
/// Table EMSM Service Attachments EXP (ID 68745).
/// </summary>
Table 68745 "EMSM Service Attachments EXP"
{
    Caption = 'EMSM Service Attachments', Comment = 'DAN="EMSM Service Vedhæftede Filer",DEU="EMSM Serviceanhänge",ESP="",FRA="Pièces jointes du service EMSM",SVE=""';

    fields
    {
        field(1; "AttachmentGuid EXP"; Text[38])
        {
            DataClassification = CustomerContent;
            Caption = 'AttachmentGuid', Comment = 'DAN="VedhæftningsID",DEU="ZubehörID",ESP="",FRA="guide de pièces jointes",SVE=""';
        }
        field(2; "Order No. EXP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Order No.', Comment = 'DAN="Ordrenr.",DEU="",ESP="",FRA="",SVE=""';
        }
        field(3; "Service Header Guid EXP"; Text[38])
        {
            DataClassification = CustomerContent;
            Caption = 'Service Header Guid', Comment = 'DAN="",DEU="",ESP="",FRA="",SVE=""';
        }
        field(4; "Job No. EXP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.', Comment = 'DAN="Sagsnr.",DEU="Projektnr.",ESP="Num. de trabajo",FRA="N° projet"';
        }
        field(5; "Line No. EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.', Comment = 'DAN="Linjenr.",DEU="Zeilennr.",ESP="Nº línea",FRA="N° ligne",SVE="Radnr."';
        }
        field(6; "Saved Date EXP"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Saved Date', Comment = 'DAN="Gemt dato",DEU="Gespeichertes Datum",ESP="Fecha de almacenamiento",FRA="Enregistré le",SVE="Sparad datum"';
        }
        field(7; "Saved Time EXP"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Saved Time', Comment = 'DAN="Gemt tidspunkt",DEU="Gespeicherte Zeit",ESP="Hora de almacenamiento",FRA="Enregistré à",SVE="Sparad tid"';
        }
        field(8; "JobPlanningGuid EXP"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'JobPlanningGuid', Comment = 'DAN="",DEU="ProjektplanungsID",ESP="",FRA="",SVE=""';
        }
        field(9; "FileName EXP"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'FileName', Comment = 'DAN="Filnavn",DEU="DateiName",ESP="",FRA="Nom du fichier",SVE=""';
        }
        field(10; "FileExtension EXP"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'FileExtension', Comment = 'DAN="Filtype",DEU="Dateinamenserweiterung",ESP="",FRA="Exstension du fichier",SVE=""';
        }

        field(11; "ContentType EXP"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'ContentType', Comment = 'DAN="Indholdstype",DEU="Inhaltstype",ESP="",FRA="Type de contenu",SVE=""';
        }
        field(12; "FileSize EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'FileSize', Comment = 'DAN="Filstørrelse",DEU="DateiGröße",ESP="",FRA="Taille du fichier",SVE=""';
        }
        field(13; "FileData EXP"; Media)
        {
            DataClassification = CustomerContent;
            Caption = 'FileData', Comment = 'DAN="FilData",DEU="DateiDaten",ESP="",FRA="Taille des données",SVE=""';
        }
        field(14; "ExportTime EXP"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'ExportTime', Comment = 'DAN="EksportTid",DEU="ExportZeit",ESP="",FRA="Temps d''exportation",SVE=""';
        }
        field(15; "ExportPath EXP"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'ExportPath', Comment = 'DAN="EksportSti",DEU="ExportPfad",ESP="",FRA="Chemin d''exportation",SVE=""';
        }

        field(16; "RecordAction EXP"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'RecordAction', Comment = 'DAN="",DEU="AufnahmeAktion",ESP="",FRA="",SVE=""';
        }

        field(17; "Description EXP"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description', Comment = 'DAN="Beskrivelse",DEU="Beschreibung",ESP="Descripción",FRA="Désignation",SVE="Beskrivning"';
        }

        field(18; "AttachmentRelation EXP"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'AttachmentRelation', Comment = 'DAN="",DEU="AnlageVerhältnis",ESP="",FRA="Relation de l''attachement",SVE=""';
        }
        field(19; "readOnly"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'readOnly', Comment = 'DAN="",DEU="",ESP="",FRA="Lire uniquement",SVE=""';
        }
        field(20; "ClientGuid"; code[36])
        {
            DataClassification = CustomerContent;
            Caption = 'ClientGuid', Comment = 'DAN="",DEU="BenutzerID",ESP="",FRA="Guide du client",SVE=""';
        }
        field(21; "Service Item Line No. EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Service Item Line No.', Comment = 'DAN="",DEU="",ESP="",FRA="",SVE=""';
        }
        field(22; "Service Item No. EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Service Item No.', Comment = 'DAN="Service Artikel Nr.",DEU="Service Artikel Nr.",ESP="",FRA="",SVE=""';
        }
        field(23; "Service Item Description EXP"; text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Service Item Description', Comment = 'DAN="Service Artikel Beskrivelse",DEU="Service Artikel Beschreibung",ESP="",FRA="Description de l''élément service",SVE=""';
        }
        field(24; "ExternalURL EXP"; text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'ExternalURL', Comment = 'DAN="EksternURL",DEU="ExterneURL",ESP="",FRA="URL externe",SVE=""';
        }
        field(25; "BAS Guid EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'BAS Guid', Comment = 'DAN="",DEU="",ESP="",FRA="",SVE=""';
        }
        field(26; "Convert Status EXP"; Option)
        {
            Caption = 'Convert Status', Comment = 'DAN="Konverteringsstatus",DEU="Umwandlungsstatus",ESP="Estado de conversión",FRA="Nouveau statut",SVE="Konverteringsstatus"';
            OptionCaption = 'New,Converted,Rejected', Comment = 'DAN="Ny,Overført,Afvist",DEU="Neu,umgewandelt,abgelehnt",ESP="Nuevo,Convertido,Rechazado",FRA="Nouveau,Accepté,Rejeté",SVE="Ny,Godkänd,Avbruten"';
            OptionMembers = New,Converted,Rejected,Error;
            DataClassification = CustomerContent;
        }
        field(27; "Processed Date Time EXP"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Processed Date Time', Comment = 'DAN="Bearbejdet Dato Tid",DEU="Verarbeitete Datum Zeit",ESP="",FRA="",SVE=""';
        }
        field(28; "Processed By User ID EXP"; Code[50])
        {
            Caption = 'Processed By User ID', Comment = 'DAN="Bearbejdet Af Bruger ID",DEU="Verarbeitet durch User ID",ESP="",FRA="",SVE=""';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "BAS Guid EXP")
        {
        }
        key(Key2; "AttachmentGuid EXP")
        {
        }

    }
}