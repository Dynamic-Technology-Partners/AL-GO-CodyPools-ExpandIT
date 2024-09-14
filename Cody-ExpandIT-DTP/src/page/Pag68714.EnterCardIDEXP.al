/// <summary>
/// Page Enter Card ID EXP (ID 68714).
/// </summary>
page 68714 "Enter Card ID EXP"
{
    // version EIS5.04.01

    // EIS5.04.01  28-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'Enter Card ID', Comment = 'DAN="Indtast Kort ID",DEU="Eingabe der Karten ID",ESP="Introducir Id Tarjeta",FRA="Identification carte bancaire",SVE="Ange kortID"';
    PageType = Card;


    layout
    {
        area(content)
        {
            field("NewCardNumber EXP"; NewCardNumber)
            {
                Caption = 'Card Number', Comment = 'DAN="Kortnummer",DEU="Kartennummer",ESP="No. de Tarjeta",FRA="Numéro de carte",SVE="Kortnr"';
                ApplicationArea = All;
            }
            field("NewExpiryMonth EXP"; NewExpiryMonth)
            {
                Caption = 'Expiry Month', Comment = 'DAN="Udløbsmåned",DEU="Ablauf Monat",ESP="Mes de caducidad",FRA="Mois d''expiration",SVE="Utgångsmånad"';
                ApplicationArea = All;
            }
            field("NewExpiryYear EXP"; NewExpiryYear)
            {
                Caption = 'Expiry Year', Comment = 'DAN="Udløbsår",DEU="Ablauf Jahr",ESP="Año de caducidad",FRA="Année d''expiration",SVE="Utgångsår"';
                ApplicationArea = All;
            }
            field("NewCVC"; NewCVC)
            {
                Caption = 'CVV';
                ApplicationArea = All;
            }
            field("ClearingAmount"; ClearingAmount)
            {
                Caption = 'Amount';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calculate Clearing Amount")
            {
                Caption = 'Calculate Clearing Amount';
                ToolTip = 'Calculate the amount to authorize from the sales transaction.';
                Visible = true;
                ApplicationArea = All;
                Image = CreditCard;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    case StrMenu('Qty. to Ship, Qty. to Invoice, Outstanding Amount, Cancel', 1, 'Select which amount to calculate:') of
                        1:
                            ClearingAmount := CalculateClearingAmount(1);
                        2:
                            ClearingAmount := CalculateClearingAmount(2);
                        3:
                            ClearingAmount := CalculateClearingAmount(3);
                        4:
                            exit;
                    end;
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        NewCardNumber: Code[20];
        NewExpiryMonth: Integer;
        NewExpiryYear: Integer;
        NewCVC: Code[4];
        MinYear: Integer;
        MaxYear: Integer;
        TEXT000: Label 'Card number must have 13 or 16 characters.', Comment = 'DAN="Kortnummer skal have 13 eller 16 cifre.",DEU="Kartennummer muss 13 oder 16 Zeichen haben.",ESP="Número de tarjeta debe tener 13 ó 16 dígitos.",FRA="Le numéro de carte bancaire doit avoir 13 ou 16 chiffres.",SVE="Kortnr måste ha 13 eller 16 tecken."';
        TEXT001: Label 'Card number must have 16 characters.', Comment = 'DAN="Kortnummer skal have 16 cifre.",DEU="Kartennummer muss 16 Zeichen haben.",ESP="Número de tarjeta debe tener 16 dígitos.",FRA="Le numéro de carte bancaire doit avoir 16 chiffres.",SVE="Kortnr måste ha 16 tecken."';
        TEXT002: Label 'Expiry Year must be from %1 to %2.', Comment = 'DAN="Udløbsår skal være %1 til %2.",DEU="Das Ablaufjahr muss die Form %1 bis %2 sein.",ESP="Añod de caducidad debe estar entre %1 y %2.",FRA="Année d"';
        TEXT003: Label 'Total clearing amount is %1.', Comment = 'DAN="Total clearingsbeløb er %1.",DEU="Der gesamt verrechnete Betrag ist is %1.",ESP="Importe Total Aceptado %1.",FRA="Montant total accepté : %1.",SVE="Totalt godkänt belopp är %1."';
        ClearingAmount: Decimal;
        SalesHeader: Record "Sales Header";

    /// <summary>
    /// SetCardID.
    /// </summary>
    /// <param name="CardNumber">Code[20].</param>
    /// <param name="ExpiryMonth">Integer.</param>
    /// <param name="ExpiryYear">Integer.</param>
    procedure SetCardID(CardNumber: Code[20]; ExpiryMonth: Integer; ExpiryYear: Integer);
    begin
        NewCardNumber := CardNumber;
        NewExpiryMonth := ExpiryMonth;
        NewExpiryYear := ExpiryYear;
    end;

    /// <summary>
    /// GetCardID.
    /// </summary>
    /// <param name="CardNumber">VAR Code[20].</param>
    /// <param name="ExpiryMonth">VAR Integer.</param>
    /// <param name="ExpiryYear">VAR Integer.</param>
    procedure GetCardID(var CardNumber: Code[20]; var ExpiryMonth: Integer; var ExpiryYear: Integer);
    begin
        CardNumber := NewCardNumber;
        ExpiryMonth := NewExpiryMonth;
        ExpiryYear := NewExpiryYear;
    end;

    /// <summary>
    /// VerifyCardInformation.
    /// </summary>
    /// <param name="CardNumber">Code[20].</param>
    /// <param name="ExpiryMonth">Integer.</param>
    /// <param name="ExpiryYear">Integer.</param>
    /// <param name="GiveError">Boolean.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure VerifyCardInformation(CardNumber: Code[20]; ExpiryMonth: Integer; ExpiryYear: Integer; GiveError: Boolean): Boolean;
    begin
        /*
        IF NOT ((STRLEN(DELCHR(CardNumber,'=',' ')) = 16) or
                (STRLEN(DELCHR(CardNumber,'=',' ')) = 13))
        THEN
          IF GiveError THEN
            ERROR(TEXT000)
          ELSE
            EXIT(FALSE);
        */

        if (ExpiryMonth < 1) or (ExpiryMonth > 12) then
            if GiveError then
                ERROR(TEXT001)
            else
                exit(false);

        MinYear := DATE2DMY(TODAY, 3);
        MaxYear := DATE2DMY(TODAY, 3) + 12;

        if (ExpiryYear < MinYear) or (ExpiryYear > MaxYear) then
            if GiveError then
                ERROR(STRSUBSTNO(TEXT002, MinYear, MaxYear))
            else
                exit(false);

        exit(true);

    end;

    /// <summary>
    /// SetClearingAmount.
    /// </summary>
    /// <param name="ParmClearingAmount">VAR Decimal.</param>
    procedure SetClearingAmount(var ParmClearingAmount: Decimal);
    begin
        ClearingAmount := ParmClearingAmount;
    end;

    /// <summary>
    /// GetClearingAmount.
    /// </summary>
    /// <returns>Return value of type Decimal.</returns>
    procedure GetClearingAmount(): Decimal;
    begin
        Exit(ClearingAmount);
    end;

    /// <summary>
    /// GetCVC.
    /// </summary>
    /// <returns>Return value of type Code[4].</returns>
    procedure GetCVC(): Code[4];
    begin
        exit(NewCVC);
    end;
    /// <summary>
    /// SetSalesHeader.
    /// </summary>
    /// <param name="paramSalesHeader">Record "Sales Header".</param>
    procedure SetSalesHeader(paramSalesHeader: Record "Sales Header");
    begin
        SalesHeader := paramSalesHeader;
    end;

    local procedure CalculateClearingAmount(CalculateAmountFrom: Integer) AmountToAuthorize: Decimal;
    var
        SalesLine: Record "Sales Line";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
    begin
        SalesHeader.TestField("No.");
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.CALCSUMS("Outstanding Amount");
        //SalesLine."Outstanding Amount" :=
        //  ROUND(SalesLine."Outstanding Amount", 1, '>');
        //if SalesLine."Outstanding Amount" <= 0 then
        //    ERROR(TEXT000, FORMAT(SalesLine."Outstanding Amount"));
        // New Code
        If SalesHeader.Status <> SalesHeader.Status::Released THEN begin
            ReleaseSalesDoc.PerformManualRelease(SalesHeader);
            Commit();
        end;
        SalesHeader.CalcFields("Amount Including VAT");
        IF SalesHeader."Amount Including VAT" <= 0 then
            Error(TEXT003, Format(SalesHeader."Amount Including VAT"));
        SalesLine.SetFilter(Type, '>0');
        SalesLine.SetFilter(Quantity, '<>0');
        If SalesLine.FindSet then
            repeat
                case CalculateAmountFrom of
                    1:
                        AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Ship";
                    2:
                        AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Invoice";
                    3:
                        AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Outstanding Quantity";
                    4:
                        exit;
                end;
            Until SalesLine.next = 0;
    end;
}

