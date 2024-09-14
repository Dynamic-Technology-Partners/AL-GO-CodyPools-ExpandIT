/// <summary>
/// Page e-payment Entries EXP (ID 68713).
/// </summary>
page 68713 "e-payment Entries EXP"
{
    // version EIS5.04.01

    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS5.04.01  2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM18.0.6.136 2020-07-20 FAM * New Epayment Service implemented

    Caption = 'e-payment Entries', Comment = 'DAN="e-betalingsposter",DEU="e-payment Einträge",ESP="Entradas e-Pago",FRA="Ecitures paiement en ligne",SVE="e-betalningstransaktioner"';
    Editable = true;
    PageType = List;
    SourceTable = "e-payment Entry EXP";


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Transaction ID"; Rec."Transaction ID EXP")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec."Status EXP")
                {
                    ApplicationArea = All;
                }
                field("Card Type"; Rec."Card Type EXP")
                {
                    ApplicationArea = All;
                }
                field("e-payment Provider Code"; Rec."e-payment Provider Code EXP")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type EXP")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Cleared Order No."; Rec."Cleared Order No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Cleared Amount"; Rec."Cleared Amount EXP")
                {
                    ApplicationArea = All;
                }
                field("Clearing Valid-to Date EXP"; Rec."Clearing Valid-to Date EXP")
                {
                    ApplicationArea = All;
                }
                field("Shipment No."; Rec."Shipment No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Shipment Amount"; Rec."Shipment Amount EXP")
                {
                    ApplicationArea = All;
                }
                field("Shipment Posting Date"; Rec."Shipment Posting Date EXP")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Invoiced Amount"; Rec."Invoiced Amount EXP")
                {
                    ApplicationArea = All;
                }
                field("Payment Posting Date"; Rec."Payment Posting Date EXP")
                {
                    ApplicationArea = All;
                }
                field("Captured Amount"; Rec."Captured Amount EXP")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No. EXP")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Clearing ID")
            {
                Caption = '&Clearing ID', Comment = 'DAN="&Clearing ID",DEU="&Verrechnungs ID",ESP="&Aceptación ID",FRA="&ID accept.",SVE="&ClearingID"';
                action("Test Clearing")
                {
                    Caption = 'Test Clearing', Comment = 'DAN="Test Clearing",DEU="Test Verrechnung",ESP="Test Aceptación",FRA="Test d''acceptation",SVE="Testa Clearing"';
                    Image = AuthorizeCreditCard;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.TestClearing(Rec);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("Remove Clearing")
                {
                    Caption = 'Remove Clearing', Comment = 'DAN="Fjern Rydning",DEU="Verrechnung entfernen",ESP="Eliminar Aceptación",FRA="Supprimer l''acceptation",SVE="Ta bort Clearing"';
                    Image = VoidCreditCard;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        SalesHeader.GET(Rec."Document Type EXP", Rec."Document No. EXP");
                        EpaymentService.DeleteClearingSalesHeader(SalesHeader);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("Re&new Clearing")
                {
                    Caption = 'Re&new Clearing', Comment = 'DAN="&Forny Clearing",DEU="Er&neute Verrechnung",ESP="&Renovar Aceptación",FRA="&Renouveler acceptation",SVE="För&nya Clearing"';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.RenewClearing(Rec, WORKDATE);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action(Capture)
                {
                    Caption = 'Capture', Comment = 'DAN="Capture",DEU="Eingabe",ESP="Capturar",FRA="Capturer paiment en ligne",SVE="Överföra"';
                    Image = Post;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.BatchCapture(Rec, 20000101D);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("Manual Sales Capture")
                {
                    Caption = 'Capture', Comment = 'DAN="Capture",DEU="Eingabe",ESP="Capturar",FRA="Capturer paiment en ligne",SVE="Överföra"';
                    Image = Post;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        IF SalesHeader.Get(rec."Document Type EXP", rec."Document No. EXP") THEN
                            EpaymentService.SalesOrderDirectCapture(SalesHeader, WORKDATE);

                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("Manually Cancel")
                {
                    Caption = 'Manually Cancel', Comment = 'DAN="Manuel Sletning",DEU="manuell stornieren",ESP="Cancelar Manualmente",FRA="Annuler manuellement",SVE="Manuellt avbruten"';
                    Image = Status;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.ManuallyDeleteClearing(Rec);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("Get Card Type")
                {
                    Caption = 'Get Card Type', Comment = 'DAN="Hent Korttype",DEU="Kartentyp erhalten",ESP="Obtener Tipo de Tarjeta",FRA="Obtenir le type de CB",SVE="Hämta korttyp"';
                    Image = Import;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.GetCardType(Rec);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
        area(processing)
        {
            group("&Functions")
            {
                action("Assign Missing Posted Sales Invoice")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesInvHeader: Record "Sales Invoice Header";
                        PostedSalesInvoices: Page "Posted Sales Invoices";
                    begin
                        SalesInvHeader.SetRange("Order No.", Rec."Document No. EXP");
                        PostedSalesInvoices.SetTableView(SalesInvHeader);
                        if PostedSalesInvoices.RunModal() = action::LookupOK then begin
                            PostedSalesInvoices.GetRecord(SalesInvHeader);
                            SalesInvHeader.CalcFields("Amount Including VAT");
                            Rec."Invoice No. EXP" := SalesInvHeader."No.";
                            Rec."Invoice Posting Date EXP" := SalesInvHeader."Posting Date";
                            Rec."Invoiced Amount EXP" := SalesInvHeader."Amount Including VAT";
                            Rec.Modify(true);
                        end;
                    end;
                }
            }
            group("&Navigate")
            {
                action("Sales Order-Invoice")
                {
                    Caption = 'Sales Order-Invoice';
                    Image = Document;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        case Rec."Document Type EXP" of
                            Rec."Document Type EXP"::"Blanket Order":
                                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Blanket Order");
                            Rec."Document Type EXP"::"Order":
                                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Order");
                            Rec."Document Type EXP"::"Credit Memo":
                                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Credit Memo");
                            Rec."Document Type EXP"::Invoice:
                                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                            Rec."Document Type EXP"::Quote:
                                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
                        end;
                        SalesHeader.SetRange("No.", Rec."Document No. EXP");
                        SalesHeader.FindFirst();
                        Navigate.SetDoc(SalesHeader."Posting Date", SalesHeader."No.")
                    end;
                }
                action("Posted Sales Invoice")
                {
                    Caption = 'Posted Sales Invoice';
                    Image = Document;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TestField("Invoice No. EXP");
                        Navigate.SetDoc(Rec."Invoice Posting Date EXP", Rec."Invoice No. EXP");
                        Navigate.RUN;
                    end;
                }
                action("Sales Shipment")
                {
                    Caption = 'Sales Shipment';
                    Image = Document;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TestField("Shipment No. EXP");
                        Navigate.SetDoc(Rec."Shipment Posting Date EXP", Rec."Shipment No. EXP");
                        Navigate.RUN;
                    end;
                }
            }
        }
    }

    var
        SalesInvHeader: Record "Sales Invoice Header";
        Navigate: Page Navigate;
        EpaymentService: Codeunit "E-payment Service EXP";
}

