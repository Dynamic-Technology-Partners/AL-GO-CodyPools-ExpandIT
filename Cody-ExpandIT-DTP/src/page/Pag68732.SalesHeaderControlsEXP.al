/// <summary>
/// Page Sales Header - Controls EXP (ID 68732).
/// </summary>
page 68732 "Sales Header - Controls EXP"
{
    // version EIS4.02.02,COPYPASTE

    // EIS4.01     2010-09-08  JR  * The purpose of this form is to hold controls that you
    //                               can copy and paste to forms using the same source table.
    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS4.02.02  2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM18.0.6.136 2020-07-20 FAM * New Epayment Service implemented

    PageType = Card;
    SourceTable = "Sales Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&ExpandIT E-payment")
            {
                Caption = '&ExpandIT E-payment', Comment = 'DAN="&E-payment",DEU="&e-Payment",ESP="&E-Pago",FRA="&E-paiement",SVE="&E-betalning"';
                action(Clearing)
                {
                    Caption = 'Clearing', Comment = 'DAN="Clearing",DEU="Verrechnung",ESP="Aceptado",FRA="Acceptation",SVE="Clearing"';
                    Image = CreditCard;
                    ApplicationArea = All;

                    trigger OnAction();

                    begin
                        // EMSM18.0.6.136 begin
                        CLEAR(EpaymentService);
                        EpaymentService.ClearingSalesHeader(Rec, WORKDATE, True);
                        // EMSM18.0.6.136 end
                        CurrPage.UPDATE;
                    end;
                }
                action("Test Clearing")
                {
                    Caption = 'Test Clearing', Comment = 'DAN="Test Clearing",DEU="Test Verrechnung",ESP="Test Aceptación",FRA="Test d''acceptation",SVE="Pröva clearing"';
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
                action("Remove Clearing")
                {
                    Caption = 'Remove Clearing', Comment = 'DAN="Slet Clearing",DEU="Verrechnung entfernen",ESP="Eliminar Aceptación",FRA="Supprimer l''acceptation",SVE="Ta bort clearing"';
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
                action("Re&new Clearing")
                {
                    Caption = 'Re&new Clearing', Comment = 'DAN="&Forny Clearing",DEU="Er&neute Verrechnung",ESP="&Renovar Aceptación",FRA="Re&nouveler acceptation",SVE="För&nya Clearing"';
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
}

