// EMSM18.0.6.56 2020-04-17 FAM * Sales origin added
/// <summary>
/// TableExtension Sales_Header EXP (ID 68788) extends Record Sales Header.
/// </summary>
tableextension 68788 "Sales_Header EXP" extends "Sales Header"
{
    // version NAVW111.00.00.19846,EIS5.04.02

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
        field(68702; "Sales Origin EXP"; Text[50])
        {
            Caption = 'Sales Origin', Comment = 'DAN="Salgskanal",DEU="Verkaufsursprung",ESP="",FRA="Origine de la vente",SVE=""';
            Description = 'EMSM18.0.6.56';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(68703; "Web Order No. DTP"; code[20])
        {
            Caption = 'Web Order No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        Item: Record Item;


    //Unsupported feature: PropertyModification on "PrepaymentInvoicesNotPaidErr(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PrepaymentInvoicesNotPaidErr : @@@=You cannot post the document of type Order with the number 1001 before all related prepayment invoices are fully posted and paid.;ENU=You cannot post the document of type %1 with the number %2 before all related prepayment invoices are fully posted and paid.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PrepaymentInvoicesNotPaidErr : @@@=You cannot post the document of type Order with the number 1001 before all related prepayment invoices are posted.;ENU=You cannot post the document of type %1 with the number %2 before all related prepayment invoices are posted.;
    //Variable type has not been exported.
}

