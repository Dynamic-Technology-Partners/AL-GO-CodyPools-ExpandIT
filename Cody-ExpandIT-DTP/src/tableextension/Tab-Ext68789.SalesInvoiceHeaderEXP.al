/// <summary>
/// TableExtension Sales_Invoice_Header EXP (ID 68789) extends Record Sales Invoice Header.
/// </summary>
tableextension 68789 "Sales_Invoice_Header EXP" extends "Sales Invoice Header"
{
    // version NAVW111.00, EIS5.04.02

    fields
    {
        field(68700; "e-payment Provider Code EXP"; Code[10])
        {
            Caption = 'e-payment Provider Code', Comment = 'DAN="e-betaling Udbyder Kode",DEU="e-payment Anbietercode",ESP="Código de pago",FRA="Code fournisseur de paiement en ligne",SVE="e-betalning providerkod"';
            Description = 'EIS5.04.02';
            Editable = false;
            TableRelation = "e-payment Provider EXP";
            DataClassification = CustomerContent;
        }
        field(68701; "e-payment Clearing OK EXP"; Boolean)
        {
            Caption = 'e-payment Clearing OK', Comment = 'DAN="e-betaling Clearing OK",DEU="e-payment Verrechnung OK",ESP="Pago aceptado",FRA="Paiement en ligne accepté",SVE="e-betalning Clearing OK"';
            Description = 'EIS5.04.02';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(68703; "Web Order No. DTP"; code[20])
        {
            Caption = 'Web Order No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(68712; "e-payment Provider Code Old"; Code[10])
        {
            Caption = 'e-payment Provider Code', Comment = 'DAN="e-betaling Udbyder Kode",DEU="e-payment Anbietercode",ESP="Código de pago",FRA="Code fournisseur de paiement en ligne",SVE="e-betalning providerkod"';
            Description = 'EIS5.04.02';
            Editable = false;
            TableRelation = "e-payment Provider EXP";
            ObsoleteState = Removed;
            DataClassification = CustomerContent;
        }
        field(68713; "e-payment Clearing OK EXP Old"; Boolean)
        {
            Caption = 'e-payment Clearing OK', Comment = 'DAN="e-betaling Clearing OK",DEU="e-payment Verrechnung OK",ESP="Pago aceptado",FRA="Paiement en ligne accepté",SVE="e-betalning Clearing OK"';
            Description = 'EIS5.04.02';
            Editable = false;
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
        }
        field(68714; "MailIT Recipients  EXP"; Text[250])
        {
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'Not getting used';
        }
        field(68715; "MailIT Sent EXP"; DateTime)
        {
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'Not getting used';
        }
        field(68716; "MailIT Status EXP"; Option)
        {
            Caption = 'Status', Comment = 'DAN="Status",DEU="Status",SVE="Status"';
            OptionCaption = 'None,Sent,Error', Comment = 'DAN="Ingen,Sendt,Fejl",DEU="Keine,Gesendet,Fehler",SVE="Inga,Skickade,Fel"';
            OptionMembers = "None",Sent,Error;
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'Not getting used';
        }
        field(68717; "MailIT Status Message EXP"; Text[250])
        {
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'Not getting used';
        }
        field(68718; "MailIT Status Data EXP"; BLOB)
        {
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'Not getting used';
        }
        field(68719; "MailIT Next Retry EXP"; DateTime)
        {
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'Not getting used';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

