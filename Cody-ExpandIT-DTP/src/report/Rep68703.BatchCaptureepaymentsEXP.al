/// <summary>
/// Report Batch Capture e-payments EXP (ID 68703).
/// </summary>
report 68703 "Batch Capture e-payments EXP"
{
    // version EIS4.02.02

    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EMSM18.0.6.136 2020-07-20 FAM * New Epayment Service implemented

    DefaultLayout = RDLC;
    RDLCLayout = './Batch Capture e-payments.rdlc';

    Caption = 'Batch Capture e-payments', Comment = 'DAN="Batch Capture e-betalinger",DEU="Stapeleingabe e-payments",ESP="Captura e-Pagos por lotes",FRA="Capture d''écran des paiements électroniques par lots"';
    UsageCategory = Documents;
    ApplicationArea = All;
    UseRequestPage = true;
    AccessByPermission = tabledata "e-payment Entry EXP" = RIMD;

    dataset
    {
        dataitem("e-payment Entry"; "e-payment Entry EXP")
        {
            DataItemTableView = SORTING("e-payment Provider Code EXP", "Status EXP") WHERE("Status EXP" = CONST("Ready to Capture"));
            RequestFilterFields = "e-payment Provider Code EXP", "Invoice Posting Date EXP";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
                // }
                // column(CurrReport_PAGENO;CurrReport.PAGENO)
                // {
                //TODO: FIX PageNo
            }
            column(USERID; USERID)
            {
            }
            column(e_payment_Entry__e_payment_Provider_Code_; "e-payment Provider Code EXP")
            {
            }
            column(e_payment_Entry__Captured_Amount_; "Captured Amount EXP")
            {
            }
            column(e_payment_Entry__Payment_Posting_Date_; "Payment Posting Date EXP")
            {
            }
            column(e_payment_Entry__Invoiced_Amount_; "Invoiced Amount EXP")
            {
            }
            column(e_payment_Entry__Invoice_No__; "Invoice No. EXP")
            {
            }
            column(e_payment_Entry__Invoice_Posting_Date_; "Invoice Posting Date EXP")
            {
            }
            column(e_payment_Entry__Transaction_ID_; "Transaction ID EXP")
            {
            }
            column(e_payment_Entry_Status; "Status EXP")
            {
            }
            column(e_payment_Entry__Entry_No__; "Entry No. EXP")
            {
            }
            column(e_payment_Entry_Status_Control11; "Status EXP")
            {
            }
            column(e_payment_Entry__Transaction_ID__Control14; "Transaction ID EXP")
            {
            }
            column(e_payment_Entry__Invoice_Posting_Date__Control17; "Invoice Posting Date EXP")
            {
            }
            column(e_payment_Entry__Invoice_No___Control20; "Invoice No. EXP")
            {
            }
            column(e_payment_Entry__Invoiced_Amount__Control23; "Invoiced Amount EXP")
            {
            }
            column(e_payment_Entry__Payment_Posting_Date__Control26; "Payment Posting Date EXP")
            {
            }
            column(e_payment_Entry__Captured_Amount__Control29; "Captured Amount EXP")
            {
            }
            column(e_payment_Entry__Entry_No___Control32; "Entry No. EXP")
            {
            }
            column(EPaymentEntry__Captured_Amount_; EPaymentEntry."Captured Amount EXP")
            {
            }
            column(EPaymentEntry__Payment_Posting_Date_; EPaymentEntry."Payment Posting Date EXP")
            {
            }
            column(EPaymentEntry_Status; EPaymentEntry."Status EXP")
            {
            }
            column(Total_for___FIELDNAME__e_payment_Provider_Code__; 'Total for ' + FIELDNAME("e-payment Provider Code EXP"))
            {
            }
            column(e_payment_Entry__Invoiced_Amount__Control35; "Invoiced Amount EXP")
            {
            }
            column(e_payment_Entry__Captured_Amount__Control36; "Captured Amount EXP")
            {
            }
            column(e_payment_EntryCaption; e_payment_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(e_payment_Entry_Status_Control11Caption; FIELDCAPTION("Status EXP"))
            {
            }
            column(e_payment_Entry__Transaction_ID__Control14Caption; FIELDCAPTION("Transaction ID EXP"))
            {
            }
            column(e_payment_Entry__Invoice_Posting_Date__Control17Caption; FIELDCAPTION("Invoice Posting Date EXP"))
            {
            }
            column(e_payment_Entry__Invoice_No___Control20Caption; FIELDCAPTION("Invoice No. EXP"))
            {
            }
            column(e_payment_Entry__Invoiced_Amount__Control23Caption; FIELDCAPTION("Invoiced Amount EXP"))
            {
            }
            column(e_payment_Entry__Payment_Posting_Date__Control26Caption; FIELDCAPTION("Payment Posting Date EXP"))
            {
            }
            column(e_payment_Entry__Captured_Amount__Control29Caption; FIELDCAPTION("Captured Amount EXP"))
            {
            }
            column(e_payment_Entry__Entry_No___Control32Caption; FIELDCAPTION("Entry No. EXP"))
            {
            }
            column(EPaymentEntry_StatusCaption; EPaymentEntry_StatusCaptionLbl)
            {
            }
            column(EPaymentEntry__Payment_Posting_Date_Caption; EPaymentEntry__Payment_Posting_Date_CaptionLbl)
            {
            }
            column(EPaymentEntry__Captured_Amount_Caption; EPaymentEntry__Captured_Amount_CaptionLbl)
            {
            }
            column(e_payment_Entry__e_payment_Provider_Code_Caption; FIELDCAPTION("e-payment Provider Code EXP"))
            {
            }

            trigger OnAfterGetRecord();
            begin
                if ("Status EXP" = "Status EXP"::"Ready to Capture") and PostCaptures then begin
                    SalesInvHeader.GET("Invoice No. EXP");

                    // EMSM18.0.6.136 begin
                    if UseInvoiceDate then
                        EpaymentService.BatchCapture(
                          "e-payment Entry", SalesInvHeader."Posting Date")
                    else
                        EpaymentService.BatchCapture("e-payment Entry", PostingDate);
                    // EMSM18.0.6.136 end

                    EPaymentEntry.GET("Entry No. EXP");

                    COMMIT;
                end;
            end;

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO("e-payment Provider Code EXP");

                if not UseInvoiceDate and PostCaptures and (PostingDate = 00000101D) then
                    ERROR(TEXT000);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        EPaymentEntry: Record "e-payment Entry EXP";
        SalesInvHeader: Record "Sales Invoice Header";
        EpaymentService: Codeunit "E-payment Service EXP";
        PostingDate: Date;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PostCaptures: Boolean;
        UseInvoiceDate: Boolean;
        TEXT000: Label 'Posting Date must be entered.', Comment = 'DAN="Bogføringsdato skal udfyldes.",DEU="Versanddatum muss eingegeben sein.",ESP="Debe Introducir Fecha de Envío.",FRA="Vous devez saisir une date de comptabilisation.",SVE="Bokföringsdatum måste anges."';
        e_payment_EntryCaptionLbl: Label 'e-payment Entry', Comment = 'DAN="e-betaingspost",DEU="e-payment Eintrag",ESP="Entrada e-Pago",FRA="Eciture paiement en ligne",SVE="e-betalningstransaktion"';
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'DAN="Side",DEU="Seite",ESP="Página",FRA="Page",SVE="Sida"';
        EPaymentEntry_StatusCaptionLbl: Label 'New Status', Comment = 'DAN="Ny Status",DEU="Neuer Status",ESP="Nuevo Estado",FRA="Nouveau statut",SVE="Ny status"';
        EPaymentEntry__Payment_Posting_Date_CaptionLbl: Label 'New Payment Posting Date', Comment = 'DAN="Ny Bogføringsdato",DEU="Neues Zahlungs Versanddatum",ESP="Nueva Fecha de Envío de Pago",FRA="Nouvelle date comptabilisation du paiement",SVE="Ny betalningsdag"';
        EPaymentEntry__Captured_Amount_CaptionLbl: Label 'New Captured Amount', Comment = 'DAN="Nyt Capturet Beløb",DEU="Neuer eingegebener Wert",ESP="Nuevo Importe Capturado",FRA="Nouveau montant capturé",SVE="Nytt godkänt belopp"';
}

