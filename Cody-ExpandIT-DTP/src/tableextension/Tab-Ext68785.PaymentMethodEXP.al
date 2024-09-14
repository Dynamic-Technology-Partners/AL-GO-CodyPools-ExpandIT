/// <summary>
/// TableExtension Payment_Method EXP (ID 68785) extends Record Payment Method.
/// </summary>
tableextension 68785 "Payment_Method EXP" extends "Payment Method"
{
    // version NAVW111.00,EIS5.04.02

    fields
    {
        field(68700; "e-payment Provider Code EXP"; Code[10])
        {
            Caption = 'e-payment Provider Code', Comment = 'DAN="e-betaling Udbyder Kode",DEU="E-payment Anbietercode",ESP="Código Proveedor de pago",FRA="Code fournisseur de paiement en ligne",SVE="e-betalning providerkod"';
            Description = 'EIS5.04.02';
            TableRelation = "e-payment Provider EXP"."Code EXP";
            DataClassification = CustomerContent;

        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

