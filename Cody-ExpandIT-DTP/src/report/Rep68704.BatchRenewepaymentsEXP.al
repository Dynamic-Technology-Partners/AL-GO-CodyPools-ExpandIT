/// <summary>
/// Report Batch Renew e-payments EXP (ID 68704).
/// </summary>
report 68704 "Batch Renew e-payments EXP"
{
    // version EIS4.02.02

    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)

    DefaultLayout = RDLC;
    RDLCLayout = './Batch Renew e-payments.rdlc';

    Caption = 'Batch Renew e-payments', Comment = 'DAN="Batch Forny e-betalings Clear.",DEU="Stapel erneut e-payments",ESP="Renovar e-Pagos por lotes",FRA="Renouveler paiement en ligne",SVE="Batch förnya e-betalningar"';
    UsageCategory = Documents;
    ApplicationArea = All;
    AccessByPermission = tabledata "e-payment Entry EXP" = RIMD;

    dataset
    {
        dataitem("e-payment Entry"; "e-payment Entry EXP")
        {
            DataItemTableView = SORTING("e-payment Provider Code EXP", "Status EXP") WHERE("Status EXP" = CONST(Cleared));
            RequestFilterFields = "e-payment Provider Code EXP", "Clearing Valid-to Date EXP";
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
            column(e_payment_Entry__Entry_No__; "Entry No. EXP")
            {
            }
            column(EPaymentEntry__Clearing_Valid_to_Date_; EPaymentEntry."Clearing Valid-to Date EXP")
            {
            }
            column(e_payment_Entry__Clearing_Valid_to_Date_; "Clearing Valid-to Date EXP")
            {
            }
            column(e_payment_Entry__Cleared_Amount_; "Cleared Amount EXP")
            {
            }
            column(e_payment_Entry__Document_No__; "Document No. EXP")
            {
            }
            column(e_payment_Entry__Document_Type_; "Document Type EXP")
            {
            }
            column(e_payment_Entry__Transaction_ID_; "Transaction ID EXP")
            {
            }
            column(e_payment_Entry_Status; "Status EXP")
            {
            }
            column(Total_for___FIELDNAME__e_payment_Provider_Code__; 'Total for ' + FIELDNAME("e-payment Provider Code EXP"))
            {
            }
            column(e_payment_Entry__Cleared_Amount__Control12; "Cleared Amount EXP")
            {
            }
            column(e_payment_EntryCaption; e_payment_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(e_payment_Entry__Entry_No__Caption; FIELDCAPTION("Entry No. EXP"))
            {
            }
            column(EPaymentEntry__Clearing_Valid_to_Date_Caption; EPaymentEntry__Clearing_Valid_to_Date_CaptionLbl)
            {
            }
            column(e_payment_Entry__Clearing_Valid_to_Date_Caption; FIELDCAPTION("Clearing Valid-to Date EXP"))
            {
            }
            column(e_payment_Entry__Cleared_Amount_Caption; FIELDCAPTION("Cleared Amount EXP"))
            {
            }
            column(e_payment_Entry__Document_No__Caption; FIELDCAPTION("Document No. EXP"))
            {
            }
            column(e_payment_Entry__Document_Type_Caption; FIELDCAPTION("Document Type EXP"))
            {
            }
            column(e_payment_Entry__Transaction_ID_Caption; FIELDCAPTION("Transaction ID EXP"))
            {
            }
            column(e_payment_Entry_StatusCaption; FIELDCAPTION("Status EXP"))
            {
            }
            column(e_payment_Entry__e_payment_Provider_Code_Caption; FIELDCAPTION("e-payment Provider Code EXP"))
            {
            }

            trigger OnAfterGetRecord();
            begin
                if PostRenewal then begin
                    // EMSM18.0.6.136 begin
                    EpaymentService.RenewClearing("e-payment Entry", WORKDATE);
                    // EMSM18.0.6.136 end

                    EPaymentEntry.GET("Entry No. EXP");

                    COMMIT;
                end;
            end;

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO("e-payment Provider Code EXP");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PostRenewal: Boolean;
        e_payment_EntryCaptionLbl: Label 'e-payment Entry', Comment = 'DAN="e-betaingspost",DEU="e-payment Eintrag",ESP="Entrada e-Pago",FRA="Eciture paiement en ligne",SVE="e-betalningstransaktion"';
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'DAN="Side",DEU="Seite",ESP="Página",FRA="Page",SVE="Sida"';
        EPaymentEntry__Clearing_Valid_to_Date_CaptionLbl: Label 'New Clearing Valid-to Date', Comment = 'DAN="Ny Clearing Valid-til Dato",DEU="Neue Gültigkeit der Verrechnung bis Datum",ESP="Nueva Aceptación Fecha de Validez",FRA="Nouvelle date de validité de l"';
}

