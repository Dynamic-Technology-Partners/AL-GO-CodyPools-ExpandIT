/// <summary>
/// Table e-payment Entry EXP (ID 68707).
/// </summary>
table 68707 "e-payment Entry EXP"
{
    // version EIS5.04.01,EPAY1.1

    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'e-payment Entry', Comment = 'DAN="e-betalingspost",DEU="e-payment Anmeldung",ESP="Entrada de pago",FRA="Eciture paiement en ligne",SVE="e-betalningstransaktion"';
    DrillDownPageID = "e-payment Entries EXP";
    LookupPageID = "e-payment Entries EXP";

    fields
    {
        field(1; "Entry No. EXP"; Integer)
        {
            Caption = 'Entry No.', Comment = 'DAN="Løbenr.",DEU="Anmeldungs Nr.",ESP="Nº Entrada",FRA="N° séquence",SVE="Löpnr"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(2; "Transaction ID EXP"; Code[50])
        {
            Caption = 'Transaction ID', Comment = 'DAN="Transaktions ID",DEU="Transaktions ID",ESP="Nº Transacción",FRA="ID transaction",SVE="TransaktionsID"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(3; "e-payment Provider Code EXP"; Code[10])
        {
            Caption = 'e-payment Provider Code', Comment = 'DAN="e-betaling Udbyder Kode",DEU="e-payment Anbietercode",ESP="Código Proveedor de pago",FRA="Code fournisseur de paiement en ligne",SVE="e-betalning providerkod"';
            Description = 'EIS5.04.01';
            TableRelation = "e-payment Provider EXP";
            DataClassification = CustomerContent;
        }
        field(4; "Status EXP"; Option)
        {
            Caption = 'Status', Comment = 'DAN="Status",DEU="Status",ESP="Estado",FRA="Statut",SVE="Status"';
            Description = 'EIS5.04.01';
            OptionCaption = 'Cleared,Captured,Dismissed,Ready to Capture,Manually Corrected', Comment = 'DAN="Clearet,Capturet,Slettet,Klar til Capture,Manuelt Slettet",DEU="Gelöscht,Erfasst,Abgewiesen,fertig zur Erfassung,manuell korrigiert",ESP="Aceptado,Capturada,Desestimada,Preparada para Captura, Corregida Manualmente",FRA="Accepté,Capturé,Refusé,Prêt à capturer,Corrigé manuellement",SVE="Godkänd,Bokförd,Borttagen,Klar att bokföra,Manuellt justerad"';
            OptionMembers = Cleared,Captured,Dismissed,"Ready to Capture","Manually Corrected";
            DataClassification = CustomerContent;
        }
        field(5; "Document Type EXP"; enum "Document Type EXP")
        {
            Caption = 'Document Type', Comment = 'DAN="Bilagstype",DEU="Dokumenttyp",ESP="Tipo de documento",FRA="Type document",SVE="Dokumenttyp"';
            DataClassification = CustomerContent;
        }
        field(6; "Document No. EXP"; Code[20])
        {
            Caption = 'Document No.', Comment = 'DAN="Bilagsnr.",DEU="Dokument Nr.",ESP="Nº Documento",FRA="N° document",SVE="Dokumentnr"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(7; "Cleared Amount EXP"; Decimal)
        {
            Caption = 'Cleared Amount', Comment = 'DAN="Cleared Beløb",DEU="Gelöschter Betrag",ESP="Importe aceptado",FRA="Montant accepté",SVE="Godkänt belopp"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(8; "Invoice Posting Date EXP"; Date)
        {
            Caption = 'Invoice Posting Date', Comment = 'DAN="Faktura Bogføringsdato",DEU="Rechnungs Versanddatum",ESP="Fecha Envio",FRA="Date compta. facture",SVE="Faktura bokföringsdatum"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(9; "Invoice No. EXP"; Code[20])
        {
            Caption = 'Invoice No.';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(10; "Invoiced Amount EXP"; Decimal)
        {
            Caption = 'Invoiced Amount', Comment = 'DAN="Faktureret Beløb",DEU="Rechnungsbetrag",ESP="Importe",FRA="Montant facturé",SVE="Fakturerat belopp"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(11; "Payment Posting Date EXP"; Date)
        {
            Caption = 'Payment Posting Date', Comment = 'DAN="Betalingsbogføringsdato",DEU="Zahlungs Versanddatum",ESP="Fecha Registro Pago",FRA="Date comptabilisation du paiement",SVE="Betalningsdatum"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(12; "Captured Amount EXP"; Decimal)
        {
            Caption = 'Captured Amount', Comment = 'DAN="Captured Beløb",DEU="Erfasster Betrag",ESP="Importe Capturado",FRA="Montant capturé",SVE="Erhållet belopp"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(13; "Clearing Valid-to Date EXP"; Date)
        {
            Caption = 'Clearing Valid-to Date', Comment = 'DAN="Clearing Valid-til Dato",DEU="lösche Gültigkeit bis Datum",ESP="Liquidación hasta fecha",FRA="Date de validité de l''acceptation",SVE="Clearing giltigt tom datum"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(14; "Cleared Order No. EXP"; Code[20])
        {
            Caption = 'Cleared Order No.', Comment = 'DAN="Cleared Ordrenr.",DEU="Gelöschte Bestell Nr.",ESP="No. Pedido Liquidado",FRA="N° commande accepté",SVE="Cleared Order No.Godkänt ordernr"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(15; "Card Type EXP"; Code[10])
        {
            Caption = 'Card Type', Comment = 'DAN="Korttype",DEU="Kartentyp",ESP="Tipo ficha",FRA="Type carte bancaire",SVE="Korttyp"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(16; "Signature EXP"; Text[250])
        {
            Caption = 'Signature', Comment = 'DAN="Signatur",DEU="Unterschrift",ESP="Firma",FRA="Signature",SVE="Signatur"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(17; "CurrencyCode EXP"; Code[20])
        {
            Caption = 'Currency Code', Comment = 'DAN="Valutakode",DEU="Währungscode",ESP="Cod. Divisa",FRA="Code devise",SVE="Valutakod"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(18; "Shipment Posting Date EXP"; Date)
        {
            Caption = 'Shipment Posting Date';
            Description = 'DTP6.00.00';
            DataClassification = CustomerContent;
        }
        field(19; "Shipment No. EXP"; Code[20])
        {
            Caption = 'Shipment No.';
            Description = 'DTP6.00.00';
            DataClassification = CustomerContent;
        }
        field(20; "Shipment Amount EXP"; Decimal)
        {
            Caption = 'Shipment Amount';
            Description = 'DTP6.00.00';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No. EXP")
        {
        }
        key(Key2; "Transaction ID EXP")
        {
        }
        key(Key3; "Document Type EXP", "Document No. EXP")
        {
        }
        key(Key4; "Invoice No. EXP", "Payment Posting Date EXP")
        {
        }
        key(Key5; "e-payment Provider Code EXP", "Status EXP")
        {
        }
    }

    fieldgroups
    {
    }
}

