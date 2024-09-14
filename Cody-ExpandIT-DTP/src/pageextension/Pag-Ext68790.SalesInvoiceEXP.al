/// <summary>
/// PageExtension Sales_Invoice EXP (ID 68790) extends Record Sales Invoice.
/// </summary>
pageextension 68790 "Sales_Invoice EXP" extends "Sales Invoice"
{
    // version NAVW111.00.00.19846,EIS5.04.02
    // EMSM18.0.6.136 2020-07-20 FAM * New Epayment Service implemented

    layout
    {
        //Unsupported feature: CodeModification on ""Currency Code"(Control 107).OnValidate". Please convert manually.

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
        addlast(content)
        {
            group(ExpandIT)
            {
                field("Web Order No. DTP"; rec."Web Order No. DTP")
                {
                    ApplicationArea = all;
                    Visible = true;
                    Caption = 'Web Order No.';
                }
            }
        }
    }
    actions
    {
        addafter(History)
        {
            group("&ExpandIT E-payment EXP")
            {
                Caption = '&ExpandIT E-payment', Comment = 'DAN="E-payment",DEU="E-payment",ESP="E-payment",FRA="Paiement en ligne",SVE="E-payment"';
                action("Clearing EXP")
                {
                    Caption = 'Clearing', Comment = 'DAN="Clearing",DEU="Verrechnung",ESP="Aceptado",FRA="Acceptation",SVE="Clearing"';
                    Image = CreditCard;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.ClearingSalesHeader(Rec, WORKDATE, False);
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
            }
        }
    }

    var
        EpaymentService: Codeunit "E-payment Service EXP";

    local procedure CurrencyCodeOnAfterValidate();
    begin
        CurrPage.SalesLines.PAGE.UpdatePage(true);
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

