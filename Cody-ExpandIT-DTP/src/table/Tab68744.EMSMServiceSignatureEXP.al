/// <summary>
/// Table EMSM Service Signature EXP (ID 68744).
/// </summary>
table 68744 "EMSM Service Signature EXP"
{
    // version EMSM2.15.02

    // EMSM2.15.01  2014-04-01  PB  * Bitmap field is now not compressed in order to support NAV 12013.
    // EMSM2.15.02  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'EMSM Service Signature', Comment = 'DAN="EMSM Service Underskrift",DEU="EMSM Service-Unterschrift",ESP="Firma del Servicio",FRA="Signature service EMSM",SVE="EMSM service underskrift"';
    DataCaptionFields = "Order No. EXP", "Item Line No. EXP";
    LookupPageID = "EMSM Service Sign List EXP";

    fields
    {
        field(1; "Order No. EXP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Order No.', Comment = 'DAN="Bilagsnr.",DEU="Auftrags-Nr.",ESP="Num. del Pedido",FRA="N° commande",SVE="Ordernr"';
        }
        field(2; "Item Line No. EXP"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Item Line No.', Comment = 'DAN="Artikellinienr.",DEU="Artikelzeilen-Nr.",ESP="Num. de Línea del producto",FRA="N° ligne article",SVE="Serviceartikel radnr"';
        }
        field(3; "BMP Signature EXP"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'BMP Signature', Comment = 'DAN="BMP Underskrift",DEU="BMP Unterschrift",ESP="Firma BMP",FRA="Signature BMP",SVE="BMP Signatur"';
            Compressed = false;
            SubType = Bitmap;
        }
        field(78740; "Saved Date EXP"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Saved Date', Comment = 'DAN="Gemt Tidspunkt",DEU="Gespeichertes Datum",ESP="Fecha Almacenada",FRA="Enregistré le",SVE="Sparad datum"';
        }
        field(78741; "Saved Time EXP"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Saved Time', Comment = 'DAN="Gemt Tidspunkt",DEU="Gespeicherte Zeit",ESP="Hora Almacenada",FRA="Enregistré à",SVE="Sparad tid"';
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
    }

    keys
    {
        key(Key1; "BAS Guid EXP")
        {
        }
        key(Key2; "Order No. EXP", "Item Line No. EXP")
        {
        }
    }

    fieldgroups
    {
    }
}

