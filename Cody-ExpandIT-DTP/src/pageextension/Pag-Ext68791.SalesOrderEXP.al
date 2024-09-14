// EMSM13.0.6.45 2020-04-02 FAM * ExpandIT attachment functionality is implemented
// EMSM13.0.6.56 2020-04-21 FAM * Sales origin added
// EMSM18.0.6.134 2020-07-07 FAM * Bug fixed - missing ExpandIT Setup
// EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record 
/// <summary>
/// PageExtension Sales_Order EXP (ID 68791) extends Record Sales Order.
/// </summary>
pageextension 68791 "Sales_Order EXP" extends "Sales Order"
{
    // version NAVW111.00.00.19846,EIS5.04.02

    layout
    {

        //Unsupported feature: CodeModification on ""Currency Code"(Control 111).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0,Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0,Rec);
        //EIS5.04.05 begin
        CurrencyCodeOnAfterValidate();
        //EIS5.04.05 end
        */
        //end;
        addlast(Content)
        {
            group(ExpandIT)
            {
                Caption = 'ExpandIT';
                field("Web Order No. DTP"; rec."Web Order No. DTP")
                {
                    ApplicationArea = all;
                    Visible = true;
                    Caption = 'Web Order No.';
                }
                field("e-payment Provider Code EXP"; Rec."e-payment Provider Code EXP")
                {
                    ApplicationArea = All;
                    visible = true;
                }
                field("e-payment Clearing OK EXP"; Rec."e-payment Clearing OK EXP")
                {
                    ApplicationArea = All;
                    visible = true;
                }
                field("Sales Origin EXP"; Rec."Sales Origin EXP")
                {
                    ApplicationArea = All;
                    visible = true;
                }
            }
        }
    }
    // EMSM13.0.6.45 begin
    actions
    {
        addlast(processing)
        {
            action("Open In ExpandIT EXP")
            {
                Caption = 'Open in ExpandIT', comment = 'ESP="", DAN="Åbn i ExpandIT", DEU="", SVE="", FRA=""';
                ToolTip = 'Opens ExpandIT Work Order in BAS', comment = 'DAN="Åbner ExpandIT Ordre i BAS", ESP="", DEU="", SVE="", FRA="Ouverture de l''ordre de travail ExpandIT dans le BAS"';
                Visible = ShowExpandITAttachmentMenu;
                ApplicationArea = All;
                Image = Attachments;

                trigger OnAction()
                var
                    ExpandITSetup: Record "ExpandIT Setup EXP";
                    EMSMServiceITemLine: Record "EMSM Service Item Line EXP";
                    ExpandITUtil: Codeunit "ExpandIT Util";
                begin
                    if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
                        EMSMServiceITemLine.SetFilter("Service Header Guid EXP", Rec."No.");
                        if EMSMServiceITemLine.FindFirst() then
                            Hyperlink(ExpandITUtil.TrimExpandITURL(ExpandITSetup."ExpandIT URL EXP") + 'Modules/emsm_NewServiceOrder/NewServiceOrder.asp?ServiceOrderGuid=' + EMSMServiceITemLine."Order No. EXP");
                    end;
                end;
            }
            group("&ExpandIT E-payment EXP")
            {
                Caption = '&ExpandIT E-payment', Comment = 'DAN="E-payment",DEU="E-payment",ESP="E-payment",FRA="Paiement en ligne",SVE="E-payment"';
                action("Clearing EXP")
                {
                    Caption = 'Authorize', Comment = 'DAN="Clearing",DEU="Verrechnung",ESP="Aceptado",FRA="Acceptation",SVE="Clearing"';
                    Image = CreditCard;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.SalesHeaderAuthorize(Rec, WORKDATE);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("Capture EXP")
                {
                    Caption = 'Capture';
                    Image = CreditCard;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.ClearingSalesHeader(Rec, WORKDATE, false);
                        Commit();
                        CLEAR(EpaymentService);
                        EpaymentService.SalesOrderCapture(Rec, WorkDate());
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("Test Clearing EXP")
                {
                    Caption = 'Test Clearing', Comment = 'DAN="Test Clearing",DEU="Test der Verrechnung",ESP="Test Aceptado",FRA="Test d''acceptation",SVE="Testa Clearing"';
                    Image = AuthorizeCreditCard;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.TestClearingSalesHeader(Rec);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("Remove Clearing EXP")
                {
                    Caption = 'Remove Clearing', Comment = 'DAN="Slet Clearing",DEU="Vernderte Verrechnung",ESP="Eliminacin Aceptado",FRA="Supprimer l''acceptation",SVE="Ta bort Clearing"';
                    Image = VoidCreditCard;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.DeleteClearingSalesHeader(Rec);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("Re&new Clearing EXP")
                {
                    Caption = 'Re&new Clearing', Comment = 'DAN="&Forny Clearing",DEU="Er&neute Verrechnung",ESP="&Renovar Aceptado",FRA="&Renouveler acceptation",SVE="Fr&nya Clearing"';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.RenewClearingSalesHeader(Rec, WORKDATE);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("E-Payment Entries")
                {
                    Caption = 'E-Payment Entries';
                    Image = EntriesList;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        EPaymentEntriesPage: Page "e-payment Entries EXP";
                        EPaymentEntry: Record "e-payment Entry EXP";
                    begin
                        case Rec."Document Type" of
                            Rec."Document Type"::"Blanket Order":
                                EPaymentEntry.SetRange("Document Type EXP", EPaymentEntry."Document Type EXP"::"Blanket Order");
                            Rec."Document Type"::"Order":
                                EPaymentEntry.SetRange("Document Type EXP", EPaymentEntry."Document Type EXP"::"Order");
                            Rec."Document Type"::"Credit Memo":
                                EPaymentEntry.SetRange("Document Type EXP", EPaymentEntry."Document Type EXP"::"Credit Memo");
                            Rec."Document Type"::Invoice:
                                EPaymentEntry.SetRange("Document Type EXP", EPaymentEntry."Document Type EXP"::Invoice);
                            Rec."Document Type"::Quote:
                                EPaymentEntry.SetRange("Document Type EXP", EPaymentEntry."Document Type EXP"::Quote);
                        end;
                        EPaymentEntry.SetRange("Document No. EXP", Rec."No.");
                        EPaymentEntriesPage.SetTableView(EPaymentEntry);
                        EPaymentEntriesPage.RunModal();
                    end;
                }
            }

        }
    }
    // EMSM13.0.6.45 end
    var
        EpaymentService: Codeunit "E-payment Service EXP";

    local procedure CurrencyCodeOnAfterValidate();
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    var
        ExpandITSetup: Record "ExpandIT Setup EXP";
        ShowExpandITAttachmentMenu: Boolean;
        ExpandITUtil: Codeunit "ExpandIT Util";
    // EMSM13.0.6.45 begin
    trigger OnAfterGetRecord()
    begin
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
            if ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Sales Order" then
                ShowExpandITAttachmentMenu := true
            else
                ShowExpandITAttachmentMenu := false;
        end;
    end;
    // EMSM13.0.6.45 end

}

