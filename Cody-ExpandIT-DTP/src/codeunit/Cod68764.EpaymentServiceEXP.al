// version EIS6.0.17
// EIS6.0.11 2020-08-11 FAM * Use shoplocal URL in RequestURI
// EIS6.0.12 2020-09-10 FAM * Get ExpandIT Setup record
// EIS6.0.16 2020-11-26 FAM * Remove TestField for status "Cleared" and Check for status "Dismissed" and "Ready To Capture". 
/// <summary>
/// Codeunit E-payment Service EXP (ID 68764).
/// </summary>
codeunit 68764 "E-payment Service EXP"
{
    trigger OnRun()
    begin
    end;

    var
        ExpandITUtil: Codeunit "ExpandIT Util";
        CaptureEPayment: Boolean;
        BatchCaptureVar: Boolean;
        CaptureEPayment2: Boolean;
        BatchCaptureVar2: Boolean;
        PaymentMethod: Record "Payment Method";
        NewEPaymentEntry: Record "e-payment Entry EXP";
        EPaymentProvider: Record "e-payment Provider EXP";
        InternetShopSetup: Record "ExpandIT Setup EXP";
        CardIDPage: Page "Enter Card ID EXP";
        CardNumber: Code[20];
        ExpiryMonth: Integer;
        ExpiryYear: Integer;
        DebugText: Text;
        TEXT000: Label 'Total clearing amount is %1.', Comment = 'DAN="Total clearingsbeløb er %1.",DEU="Der gesamt verrechnete Betrag ist is %1.",ESP="Importe Total Aceptado %1.",FRA="Montant total accepté : %1.",SVE="Totalt godkänt belopp är %1."';
        TEXT001: Label 'Clearing of %1 on %2 %3 was not possible\Error Description:\%4', Comment = 'DAN="Clearing af %1 på %2 %3 er ikke muligt\Fejlbeskrivelse:\%4",DEU="Verrechnung für %1 auf %2 %3 war nicht möglich\Fehlerbeschreibung:\%4",ESP="Aceptación de %1 en %2 %3 no fue posible\Error Descripción:\%4",FRA="Acceptation de %1 sur %2 %3 n"';
        TEXT002: Label '%1 must be %2 or %3.', Comment = 'DAN="%1 skal være %2 eller %3.",DEU="%1 muss %2 oder %3 sein.",ESP="%1 debe ser %2 o %3.",FRA="%1 devrait être %2 ou %3.",SVE="%1 måste vara %2 eller %3."';
        TEXT003: Label 'Transaction %1 order Number %2\', Comment = 'DAN="Transaktion %1 ordre nummer %2\",DEU="Transaktion %1 Bestellnummer %2\",ESP="Transacción %1 No. Pedido %2\",FRA="Transaction %1 N° commande %2\",SVE="Transaktion %1 ordernummer %2\"';
        TEXT004: Label 'from provider %3 cannot be tested.\', Comment = 'DAN="fra Udbyder %3 kan ikke testes.\",DEU="Von Anbieter %3 wurde nicht getestet.\",ESP="de Proveedor %3 no se puede testear.\",FRA="du fournisseur de paiement en ligne %3 ne peut être testé.",SVE="från säljare %3 kan ej testas.\"';
        TEXT005: Label 'This could be due to hacking on the Web Site.', Comment = 'DAN="Dette kan skyldes hacking på dit Web Site.",DEU="Das könnte von einem Hacker der Web-Seite verursacht werden.",ESP="Esto podría ser debido a hacking del Sitio Web. ",FRA="Ceci peut être du à un problème de sécurité sur le site Internet.",SVE="Detta kan tillåtas vid registrering via Websidan"';
        TEXT006: Label 'Transaction %1 from provider %2 cannot be tested.\', Comment = 'DAN="Transaktion %1 fra udbyder %2 kan ikke testes.\",DEU="Transaktion %1 von Anbieter %2 Wurde nicht getestet.\",ESP="Transacción %1 de Proveedor %2 no se puede testear.\",FRA="Transaction %1 du fournisseur de paiement en ligne %2 ne peut être testée.\",SVE="Transaktion %1 från säljare %2 kan ej testas.\"';
        TEXT007: Label 'Error Description %3', Comment = 'DAN="Fejlbeskrivelse %3",DEU="Fehlerbeschreibung %3",ESP="Error Descripción %3",FRA="Erreur %3",SVE="Felmeddelande %3"';
        TEXT008: Label 'Transaction %1 from provider %2 cannot be tested.\', Comment = 'DAN="Transaktion %1 fra udbyder %2 kan ikke testes.\",DEU="Transaktion %1 von Anbieter %2 Wurde nicht getestet.\",ESP="Transacción %1 de proveedor %2 no se puede testear.\",FRA="Transaction %1 du fournisseur de paiement en ligne %2 ne peut être testée.\",SVE="Transaktion %1 från säljare %2 kan ej testas.\"';
        TEXT009: Label 'The Cleared Amount is %3 it should be %4.', Comment = 'DAN="Cleared beløb er %3, det skulle være %4.",DEU="Der Nettobetrag ist %3 es sollte sein %4.",ESP="El Importe Aceptado es %3 debería ser %4.",FRA="Le montant accepté devrait être %4. Il est %3.",SVE="Godkänt belopp är %3 och borde vara %4."';
        TEXT010: Label 'Transaction %1 from provider %2 cannot be renewed.\', Comment = 'DAN="Transaktion %1 fra udbyder %2 kan ikke fornys.\",DEU="Transaktion %1 von Anbieter %2 Wurde nicht getestet.\",ESP="Transacción %1 de Proveedor %2 no se puede renovar.\",FRA="Transaction %1 du fournisseur de paiement en ligne %2 ne peut être renouvellée.\",SVE="Transaktionen %1från säljare %2 kan inte uppdateras.\"';
        TEXT011: Label 'Error Description %3', Comment = 'DAN="Fejlbeskrivelse %3",DEU="Fehlerbeschreibung %3",ESP="Error Descripción %3",FRA="Erreur %3",SVE="Felmeddelande %3"';
        TEXT012: Label 'Transaction %1 from provider %2 cannot be cancelled.\', Comment = 'DAN="Transaktion %1 fra udbyder %2 kan ikke slettes.\",DEU="Transaktion %1 von Anbieter %2 wurde nicht storniert.\",ESP="Transacción %1 de Proveedor %2 no se puede cancelar.\",FRA="Transaction %1 du fournisseur de paiement en ligne %2 ne peut être annulée.\",SVE="Transaktion %1 från %2 kan ej avbrytas.\"';
        TEXT013: Label 'Error Description %3', Comment = 'DAN="Fejlbeskrivelse %3",DEU="Fehlerbeschreibung %3",ESP="Error Descripción %3",FRA="Erreur %3",SVE="Felmeddelande %3"';
        TEXT014: Label 'Transaction %1 from provider %2 cannot be captured.\', Comment = 'DAN="Transaktion %1 fra udbyder %2 kan ikke blive captured.\",DEU="Transaktion %1 von Anbieter %2 Wurde nicht eingegeben.\",ESP="Transacción %1 de Proveedor %2 no se puede capturar.\",FRA="Transaction %1 du fournisseur de paiement en ligne %2 ne peut être capturée.\",SVE="Transaktionen %1från säljaren%2 kan ej tas emot.\"';
        TEXT015: Label 'Error Description %3', Comment = 'DAN="Fejlbeskrivelse %3",DEU="Fehlerbeschreibung %3",ESP="Error Descripción %3",FRA="Erreur %3",SVE="Felmeddelande %3"';
        TEXT016: Label 'Card Type for Transaction %1 from provider %2 cannot be found.\', Comment = 'DAN="Korttype til Transaktion %1 fra udbyder %2 kan ikke hentes.\",DEU="Kartentyp für Transaktion %1 von Anbieter %2 wurde nicht gefunden.\",ESP="Tipo de Tarjeta para la Transacción %1 de Proveedor %2 no se puede encontrar.\",FRA="Type carte bancaire pour la transaction %1 du fournisseur de paiement en ligne %2 ne peut être trouvée.\",SVE="Korttyp för transaktion %1 från försäljare %2 saknas.\"';
        TEXT017: Label 'Error Description %3', Comment = 'DAN="Fejlbeskrivelse %3",DEU="Fehlerbeschreibung %3",ESP="Error Descripción %3",FRA="Erreur %3",SVE="Felmeddelande %3"';
        TEXT018: Label 'must be Cleared or Ready to Capture', Comment = 'DAN="skal være Clearet eller Klar til Capture.",DEU="muss eindeutig oder fertig zur Eingabe sein",ESP="debe ser aceptado o preparado para Capturar",FRA="devrait être accepté ou prêt à être capturé",SVE="måste rensas eller vara färdig för överföring"';

    /// <summary>
    /// TestClearing.
    /// </summary>
    /// <param name="EPaymentEntry">Record "e-payment Entry EXP".</param>
    procedure TestClearing(EPaymentEntry: Record "e-payment Entry EXP");
    var
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
        ClearedAmount: Decimal;
    begin
        TestCleardOrReadyToCapture(EPaymentEntry);
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            EPaymentProvider.GET(EPaymentEntry."e-payment Provider Code EXP");
            RequestUri := ExpandITUtil."TrimExpandITURL"(InternetShopSetup."Local Shop URL EXP") + 'api/EpaymentApi/testtransaction';
            RequestObject.Add('Simulation', InternetShopSetup."Simulation EXP");
            RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
            RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
            RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
            RequestObject.Add('Password', EPaymentProvider."Password EXP");
            RequestObject.Add('TransactionSignature', EPaymentEntry."Signature EXP");
            RequestObject.Add('TransactionId', EPaymentEntry."Transaction ID EXP");
            RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
            RequestObject.Add('OrderNo', EPaymentEntry."Cleared Order No. EXP");
            RequestObject.Add('Amount', EPaymentEntry."Cleared Amount EXP");
            RequestObject.Add('CurrencyCode', EPaymentEntry."CurrencyCode EXP");
            if CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject) then begin
                ClearedAmount := GetJsonToken(ResponseObject, 'Amount').AsValue().AsDecimal();
                if ClearedAmount = 0 then
                    if ErrorDescription = '' then
                        ERROR(
                          TEXT003 +
                          TEXT004 +
                          TEXT005,
                          EPaymentEntry."Transaction ID EXP",
                          EPaymentEntry."Cleared Order No. EXP",
                          EPaymentEntry."e-payment Provider Code EXP")
                    else
                        ERROR(
                          TEXT006 +
                          TEXT007,
                          EPaymentEntry."Transaction ID EXP",
                          EPaymentEntry."e-payment Provider Code EXP",
                          ErrorDescription);
                if ROUND(ClearedAmount, 0.01) <> ROUND(EPaymentEntry."Cleared Amount EXP", 0.01) then
                    ERROR(StrSubstNo(
                      TEXT008 +
                      TEXT009,
                      EPaymentEntry."Transaction ID EXP",
                      EPaymentEntry."e-payment Provider Code EXP",
                      FORMAT(ClearedAmount), FORMAT(EPaymentEntry."Cleared Amount EXP")));
            end;
        end;
    end;

    /// <summary>
    /// RenewClearing.
    /// </summary>
    /// <param name="EPaymentEntry">Record "e-payment Entry EXP".</param>
    /// <param name="CurrentDate">Date.</param>
    procedure RenewClearing(EPaymentEntry: Record "e-payment Entry EXP"; CurrentDate: Date);
    var
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
    begin
        TestCleardOrReadyToCapture(EPaymentEntry);
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            EPaymentProvider.GET(EPaymentEntry."e-payment Provider Code EXP");
            RequestUri := ExpandITUtil."TrimExpandITURL"(InternetShopSetup."Local Shop URL EXP") + 'api/EpaymentApi/renewtransaction';
            RequestObject.Add('Simulation', InternetShopSetup."Simulation EXP");
            RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
            RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
            RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
            RequestObject.Add('Password', EPaymentProvider."Password EXP");
            RequestObject.Add('TransactionSignature', EPaymentEntry."Signature EXP");
            RequestObject.Add('TransactionId', EPaymentEntry."Transaction ID EXP");
            RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
            RequestObject.Add('OrderNo', EPaymentEntry."Cleared Order No. EXP");
            RequestObject.Add('Amount', EPaymentEntry."Cleared Amount EXP");
            RequestObject.Add('CurrencyCode', EPaymentEntry."CurrencyCode EXP");
            if not CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject) then
                ERROR(
                    TEXT010 +
                    TEXT011,
                    EPaymentEntry."Transaction ID EXP",
                    EPaymentEntry."e-payment Provider Code EXP",
                    ErrorDescription);
            EPaymentEntry."Clearing Valid-to Date EXP" := CALCDATE(EPaymentProvider."Clearing Validity Period EXP", CurrentDate);
            EPaymentEntry."Transaction ID EXP" := GetJsonToken(ResponseObject, 'TransactionId').AsValue().AsText();
            EPaymentEntry."Signature EXP" := GetJsonToken(ResponseObject, 'TransactionSignature').AsValue().AsText();
            EPaymentEntry.Modify();
        end;
    end;

    local procedure DeleteClearing(EpaymentEntry: Record "e-payment Entry EXP");
    var
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
    begin
        TestCleardOrReadyToCapture(EPaymentEntry);
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            EPaymentProvider.GET(EPaymentEntry."e-payment Provider Code EXP");
            RequestUri := ExpandITUtil."TrimExpandITURL"(InternetShopSetup."Local Shop URL EXP") + 'api/EpaymentApi/canceltransaction';
            RequestObject.Add('Simulation', InternetShopSetup."Simulation EXP");
            RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
            RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
            RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
            RequestObject.Add('Password', EPaymentProvider."Password EXP");
            RequestObject.Add('TransactionId', EPaymentEntry."Transaction ID EXP");
            RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
            if not CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject) then
                ERROR(
                    TEXT012 +
                    TEXT013,
                    EpaymentEntry."Transaction ID EXP",
                    EpaymentEntry."e-payment Provider Code EXP",
                    ErrorDescription);
            EpaymentEntry."Status EXP" := EpaymentEntry."Status EXP"::Dismissed;
            EpaymentEntry.MODIFY;
        end;
    end;

    /// <summary>
    /// ManuallyDeleteClearing.
    /// </summary>
    /// <param name="EpaymentEntry">Record "e-payment Entry EXP".</param>
    procedure ManuallyDeleteClearing(EpaymentEntry: Record "e-payment Entry EXP");
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        TestCleardOrReadyToCapture(EpaymentEntry);
        if InternetShopSetup.FindFirst() then begin // EMSM18.0.6.148
            EPaymentProvider.GET(EpaymentEntry."e-payment Provider Code EXP");
            if EpaymentEntry."Status EXP" = EpaymentEntry."Status EXP"::Cleared then begin
                SalesHeader.GET(EpaymentEntry."Document Type EXP", EpaymentEntry."Document No. EXP");
                SalesHeader.TESTFIELD("e-payment Provider Code EXP");
                SalesHeader.TESTFIELD("e-payment Clearing OK EXP", true);
                SalesHeader."e-payment Provider Code EXP" := '';
                SalesHeader."e-payment Clearing OK EXP" := false;
                SalesHeader.MODIFY;
                EpaymentEntry.TESTFIELD("Invoice Posting Date EXP", 0D);
                EpaymentEntry.TESTFIELD("Invoice No. EXP", '');
                EpaymentEntry.TESTFIELD("Invoiced Amount EXP", 0);
            end else begin
                SalesInvoiceHeader.GET(EpaymentEntry."Invoice No. EXP");
                SalesInvoiceHeader.TESTFIELD("e-payment Provider Code EXP");
                SalesInvoiceHeader.TESTFIELD("e-payment Clearing OK EXP");
                SalesInvoiceHeader."e-payment Provider Code EXP" := '';
                SalesInvoiceHeader."e-payment Clearing OK EXP" := false;
                SalesInvoiceHeader.MODIFY;
                EpaymentEntry.TESTFIELD("Invoice Posting Date EXP");
                EpaymentEntry.TESTFIELD("Invoice No. EXP");
                EpaymentEntry.TESTFIELD("Invoiced Amount EXP");
            end;
            EpaymentEntry.TESTFIELD("Payment Posting Date EXP", 0D);
            EpaymentEntry.TESTFIELD("Captured Amount EXP", 0);
            EpaymentEntry."Status EXP" := EpaymentEntry."Status EXP"::"Manually Corrected";
            EpaymentEntry.MODIFY;
        end;
    end;

    /// <summary>
    /// GetCardType.
    /// </summary>
    /// <param name="EPaymentEntry">Record "e-payment Entry EXP".</param>
    procedure GetCardType(EPaymentEntry: Record "e-payment Entry EXP");
    var
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
    begin
        TestCleardOrReadyToCapture(EPaymentEntry);
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            EPaymentProvider.GET(EPaymentEntry."e-payment Provider Code EXP");
            RequestUri := ExpandITUtil."TrimExpandITURL"(InternetShopSetup."Local Shop URL EXP") + 'api/EpaymentApi/findcardtype';
            RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
            RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
            RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
            RequestObject.Add('Password', EPaymentProvider."Password EXP");
            RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
            RequestObject.Add('TransactionId', EPaymentEntry."Transaction ID EXP");
            CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject);
            EPaymentEntry."Card Type EXP" := GetJsonToken(ResponseObject, 'CardType').AsValue().AsText();
            if EPaymentEntry."Card Type EXP" = '' then
                ERROR(
                  TEXT016 +
                  TEXT017,
                  EPaymentEntry."Transaction ID EXP",
                  EPaymentEntry."e-payment Provider Code EXP",
                  ErrorDescription);
            EPaymentEntry.Modify();
        end;
    end;

    /// <summary>
    /// TestCleardOrReadyToCapture.
    /// </summary>
    /// <param name="EPaymentEntry">Record "e-payment Entry EXP".</param>
    procedure TestCleardOrReadyToCapture(EPaymentEntry: Record "e-payment Entry EXP");
    begin
        if (EPaymentEntry."Status EXP" <> EPaymentEntry."Status EXP"::Cleared) and
           (EPaymentEntry."Status EXP" <> EPaymentEntry."Status EXP"::"Ready to Capture")
        then
            EPaymentEntry.FIELDERROR("Status EXP", TEXT018);
    end;

    /// <summary>
    /// BatchCapture.
    /// </summary>
    /// <param name="EPaymentEntry">Record "e-payment Entry EXP".</param>
    /// <param name="PostingDate">Date.</param>
    procedure BatchCapture(EPaymentEntry: Record "e-payment Entry EXP"; PostingDate: Date);
    var
        SalesInvHeader: Record "Sales Invoice Header";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        EPaymentEntry.TESTFIELD("Invoice No. EXP");
        EPaymentEntry.TESTFIELD("Status EXP", EPaymentEntry."Status EXP"::"Ready to Capture");
        SalesInvHeader.GET(EPaymentEntry."Invoice No. EXP");
        PostSalesInvoiceCapture(SalesInvHeader, PostingDate);
        CustLedgEntry.RESET;
        CustLedgEntry.SETCURRENTKEY("Document Type", "Document No.", "Customer No.");
        CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice);
        CustLedgEntry.SETRANGE("Document No.", SalesInvHeader."No.");
        CustLedgEntry.SETRANGE("Customer No.", SalesInvHeader."Bill-to Customer No.");
        CustLedgEntry.FIND('-');
        CustLedgEntry.CALCFIELDS(Amount);
        // Posting Payment
        GenJnlLine.INIT;
        GenJnlLine.VALIDATE("Posting Date", PostingDate);
        GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.VALIDATE("External Document No.", SalesInvHeader."External Document No.");
        GenJnlLine.VALIDATE("Document No.", SalesInvHeader."No.");
        GenJnlLine.VALIDATE(Description, SalesInvHeader."Posting Description");
        // #STARTREGION: REMOVE IN 2.60
        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", SalesInvHeader."Shortcut Dimension 1 Code");
        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", SalesInvHeader."Shortcut Dimension 2 Code");
        // #ENDREGION: REMOVE IN 2.60
        GenJnlLine.VALIDATE("Reason Code", SalesInvHeader."Reason Code");
        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
        GenJnlLine.VALIDATE("Account No.", SalesInvHeader."Bill-to Customer No.");
        GenJnlLine."External Document No." := SalesInvHeader."External Document No.";
        if SalesInvHeader."Bal. Account Type" = SalesInvHeader."Bal. Account Type"::"Bank Account" then
            GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
        GenJnlLine.VALIDATE("Bal. Account No.", SalesInvHeader."Bal. Account No.");
        GenJnlLine.VALIDATE("Currency Code", SalesInvHeader."Currency Code");
        // #STARTREGION: REMOVE IN 2.60
        GenJnlLine.VALIDATE(Amount, -CustLedgEntry.Amount + CustLedgEntry."Original Pmt. Disc. Possible");
        /*
        // #ENDREGION: REMOVE IN 2.60
        GenJnlLine.VALIDATE(Amount, -CustLedgEntry.Amount);
        // #STARTREGION: REMOVE IN 2.60
        */
        // #ENDREGION: REMOVE IN 2.60
        GenJnlLine.VALIDATE(Correction, SalesInvHeader.Correction);
        GenJnlLine.VALIDATE("Applies-to Doc. Type", GenJnlLine."Applies-to Doc. Type"::Invoice);
        GenJnlLine.VALIDATE("Applies-to Doc. No.", SalesInvHeader."No.");
        GenJnlLine.VALIDATE("Source Type", GenJnlLine."Source Type"::Customer);
        GenJnlLine.VALIDATE("Source No.", SalesInvHeader."Bill-to Customer No.");
        GenJnlPostLine.RUN(GenJnlLine);
    end;

    /// <summary>
    /// CallWebService.
    /// </summary>
    /// <param name="RequestObject">JsonObject.</param>
    /// <param name="RequestUri">Text[250].</param>
    /// <param name="VAR ErrorDescription">Text.</param>
    /// <param name="VAR ResponseObject">JsonObject.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CallWebService(RequestObject: JsonObject; RequestUri: Text[250]; VAR ErrorDescription: Text; VAR ResponseObject: JsonObject): Boolean;
    var
        HttpWebClient: HttpClient;
        HttpWebRequest: HttpRequestMessage;
        HttpWebRequestHeader: HttpHeaders;
        HttpWebResponse: HttpResponseMessage;
        HttpWebContent: HttpContent;
        HttpWebContentHeader: HttpHeaders;
        ResponseString: Text;
        OutPutText: Text;
        JToken: JsonToken;
        JObject: JsonObject;
        JArray: JsonArray;
    begin
        // Set up content to post        
        HttpWebContent.Clear();
        HttpWebContent.GetHeaders(HttpWebContentHeader);
        //Set up json and parameters        
        RequestObject.WriteTo(OutPutText);
        HttpWebContent.WriteFrom(OutPutText);
        if (HttpWebContentHeader.Contains('Content-Type')) then HttpWebContentHeader.Remove('Content-Type');
        HttpWebContentHeader.Add('Content-Type', 'application/json');
        HttpWebRequest.Content(HttpWebContent);
        // Set up request
        HttpWebRequest.GetHeaders(HttpWebRequestHeader);
        HttpWebRequestHeader.Add('Accept', 'application/json');
        HttpWebRequest.Method := 'POST';
        HttpWebRequest.SetRequestUri(RequestUri);
        // Send request
        HttpWebClient.Send(HttpWebRequest, HttpWebResponse);
        HttpWebResponse.Content.ReadAs(ResponseString);
        IF not (HttpWebResponse.IsSuccessStatusCode) then begin
            ErrorDescription := HttpWebResponse.ReasonPhrase();
            ERROR(StrSubstNo('%1 : %2 : %3', HttpWebResponse.HttpStatusCode, ResponseString, HttpWebResponse.ReasonPhrase()));
        end;

        //Read Json data from ResponseString into a new JSON object    
        ResponseObject.ReadFrom(ResponseString);
        if ResponseObject.Contains('ErrorDescription') then begin  //This is to read the response from ExpandIT's credit card functionality
            JToken := GetJsonToken(ResponseObject, 'ErrorDescription');
            Clear(ErrorDescription);
            if JToken.WriteTo(ErrorDescription) then
                IF ErrorDescription = '""' then
                    Clear(ErrorDescription);
        end;
        if ResponseObject.Contains('transactionResponse') then begin  //This is to read the response from Authorize.Net's API
            //Authorize.Net Response Code: 
            //https://developer.authorize.net/api/reference/responseCodes.html
            //https://developer.authorize.net/api/reference/dist/json/responseCodes.json
            //Testing Guide:
            //https://developer.authorize.net/hello_world/testing_guide.html
            JToken := GetJsonToken(ResponseObject, 'transactionResponse');
            JObject := JToken.AsObject();
            JToken := GetJsonToken(JObject, 'responseCode');
            if JToken.AsValue().AsText() <> '1' then begin
                JToken := GetJsonToken(JObject, 'errors');
                JArray.ReadFrom(Format(JToken));
                JArray.Get(0, JToken);
                JObject := JToken.AsObject();
                JToken := GetJsonToken(JObject, 'errorCode');
                JToken.WriteTo(ErrorDescription);
                JToken := GetJsonToken(JObject, 'errorText');
                JToken.WriteTo(ResponseString);
                ErrorDescription := ErrorDescription + ' ' + ResponseString;
            end;
        end;

        if ErrorDescription = '' then
            exit(true)
        else
            exit(false);
    end;

    /// <summary>
    /// GetJsonToken.
    /// </summary>
    /// <param name="JsonObject">JsonObject.</param>
    /// <param name="TokenKey">Text.</param>
    /// <returns>Return variable JsonToken of type JsonToken.</returns>
    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: Text) JsonToken: JsonToken;
    var
        JsonObjText: Text;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then begin
            //>>DTP Debugging
            if InternetShopSetup."Debug Active" then begin
                JsonObject.WriteTo(JsonObjText);
                Message('Could not find a token with key %1 in the Json:\%2', TokenKey, JsonObjText);
            end;
            //<<DTP
            Clear(JsonToken);
        end;
    end;

    /// <summary>
    /// SalesHeaderAuthorize.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    /// <param name="CurrentDate">Date.</param>
    procedure SalesHeaderAuthorize(var SalesHeader: Record "Sales Header"; CurrentDate: Date);
    var
        SalesLine: Record "Sales Line";
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        AmountToAuthorize: Decimal;
        CalcAmountFrom: Option " ","Qty. to Ship","Qty. to Invoice","Qty. Outstanding","Cancel";
        TransReq: JsonObject;
        JO1: JsonObject;
        JO2: JsonObject;
        JO3: JsonObject;
        JA: JsonArray;
        JT: JsonToken;
        DecimalVar: Decimal;
        Customer: Record Customer;
        Contact: Record Contact;
        ShipTo: Record "Ship-to Address";
        TextVar: Text;
        Item: Record Item;
    begin
        Clear(NewEPaymentEntry);
        NewEPaymentEntry.Reset();
        NewEPaymentEntry.SETCURRENTKEY("Document No. EXP");
        NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
        if NewEPaymentEntry.FindLast() then
            if NewEPaymentEntry."Status EXP" in [NewEPaymentEntry."Status EXP"::Cleared, NewEPaymentEntry."Status EXP"::"Ready to Capture"] then
                if NewEPaymentEntry."Clearing Valid-to Date EXP" >= Today() then begin
                    Message('There is an open e-payment valid authorization for this order!');
                    exit;
                end;
        Clear(NewEPaymentEntry);
        SalesHeader.TESTFIELD("e-payment Provider Code EXP");
        SalesHeader.TESTFIELD("e-payment Clearing OK EXP", false);
        SalesHeader.TESTFIELD("Payment Method Code");
        PaymentMethod.GET(SalesHeader."Payment Method Code");
        PaymentMethod.TESTFIELD("e-payment Provider Code EXP");
        EPaymentProvider.GET(PaymentMethod."e-payment Provider Code EXP");
        EPaymentProvider.TESTFIELD("Merchant ID EXP");
        EPaymentProvider.TESTFIELD("Login User ID EXP");
        EPaymentProvider.TESTFIELD("Provider Type EXP");
        EPaymentProvider.TESTFIELD("Clearing Validity Period EXP");
        EPaymentProvider.TestField("API URL");
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            RequestUri := EPaymentProvider."API URL";  //Test Authorize.Net URL:  'https://apitest.authorize.net/xml/v1/request.api'
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
            SalesHeader.CalcFields("Amount Including VAT", Amount);
            IF SalesHeader."Amount Including VAT" <= 0 then
                Error(TEXT000, Format(SalesHeader."Amount Including VAT"));
            SalesLine.SetFilter(Type, '>0');
            SalesLine.SetFilter(Quantity, '<>0');
            If SalesLine.FindSet then
                repeat
                    AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Ship";
                Until SalesLine.next = 0;
            If AmountToAuthorize <= 0 then begin
                CalcAmountFrom := StrMenu('Qty. to Ship, Qty. to Invoice, Qty. Outstanding, Cancel', 1, 'Select which amount to calculate:');
                If SalesLine.FindSet then
                    repeat
                        case CalcAmountFrom of
                            CalcAmountFrom::"Qty. to Ship":
                                AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Ship";
                            CalcAmountFrom::"Qty. to Invoice":
                                AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Invoice";
                            CalcAmountFrom::"Qty. Outstanding":
                                AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Outstanding Quantity";
                        end;
                    Until SalesLine.next = 0;
                If AmountToAuthorize <= 0 then
                    Error(TEXT000, Format(AmountToAuthorize));
            end;
            AmountToAuthorize := Round(AmountToAuthorize, 0.01, '>');
            // End New Code
            CLEAR(CardIDPage);
            CardIDPage.SetClearingAmount(AmountToAuthorize);
            CardIDPage.SetSalesHeader(SalesHeader);
            CardIDPage.LOOKUPMODE(true);
            if not (CardIDPage.RUNMODAL = ACTION::LookupOK) then
                exit;
            CardIDPage.GetCardID(CardNumber, ExpiryMonth, ExpiryYear);
            CardIDPage.VerifyCardInformation(CardNumber, ExpiryMonth, ExpiryYear, true);


            //Set up a json object
            //RequestUri := ExpandITUtil."TrimExpandITURL"(InternetShopSetup."Local Shop URL EXP") + 'api/EpaymentApi/cleartransaction';
            //RequestObject.Add('Simulation', InternetShopSetup."Simulation EXP");
            //RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
            //RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
            //RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
            //RequestObject.Add('Password', EPaymentProvider."Password EXP");
            //RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
            //RequestObject.Add('OrderNo', SalesHeader."No.");
            //--RequestObject.Add('Amount', SalesLine."Outstanding Amount");
            //RequestObject.Add('Amount', CardIDPage.GetClearingAmount());
            //--if SalesHeader."Currency Code" <> '' then
            //RequestObject.Add('CurrencyCode', SalesHeader."Currency Code");
            //--else
            //--    RequestObject.Add('CurrencyCode', 'USD');
            //RequestObject.Add('CardNo', CardNumber);
            //RequestObject.Add('ExpiryMonth', ExpiryMonth);
            //RequestObject.Add('ExpiryYear', ExpiryYear);
            //RequestObject.Add('CVC', CardIDPage.GetCVC());


            if CardIDPage.GetClearingAmount() <= 0 then begin
                Message('Capture Amount Cannot Be Zero!');
                exit;
            end;
            if CardIDPage.GetClearingAmount() > SalesHeader."Amount Including VAT" then
                if not Confirm('The amount specified to capture ($%1) is more than the total amount of the order ($%2).\Are you sure you want to continue?',
                                false,
                                Format(Round(CardIDPage.GetClearingAmount(), 0.01)),
                                Format(Round(SalesHeader."Amount Including VAT", 0.01))) then
                    Error('Function cancelled by user!');

            TransReq.Add('transactionType', 'authOnlyTransaction');  //authorize the transaction
            TransReq.Add('amount', CardIDPage.GetClearingAmount());  //Transaction Amount

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);
            JO1.Add('cardNumber', CardNumber);
            JO1.Add('expirationDate', Format(ExpiryYear) + '-' + Format(ExpiryMonth));
            JO1.Add('cardCode', CardIDPage.GetCVC());
            JO2.Add('creditCard', JO1);
            TransReq.Add('payment', JO2);

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);
            JO1.Add('invoiceNumber', SalesHeader."No.");
            TransReq.Add('order', JO1);

            if false then begin  //>>DTP - lineItems property is not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('itemId', SalesLine."No.");
                JO1.Add('name', Item.Description);
                JO1.Add('description', SalesLine.Description);
                JO1.Add('quantity', SalesLine.Quantity);
                JO1.Add('unitPrice', SalesLine."Unit Price");
                JO2.Add('lineItem', JO1);
                JA.Add(JO2);
                Clear(JO1);
                Clear(JO2);
                JO1.Add('itemId', SalesLine."No.");
                JO1.Add('name', Item.Description);
                JO1.Add('description', SalesLine.Description);
                JO1.Add('quantity', SalesLine.Quantity);
                JO1.Add('unitPrice', SalesLine."Unit Price");
                JO2.Add('lineItem', JO1);
                JA.Add(JO2);
                TransReq.Add('lineItems', JA);
            end; //<<DTP

            DecimalVar := SalesHeader."Amount Including VAT" - SalesHeader.Amount;
            if DecimalVar <> 0 then begin
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('amount', DecimalVar);
                JO1.Add('name', Format(Round((100 * ((SalesHeader."Amount Including VAT" - SalesHeader.Amount) / SalesHeader.Amount)), 0.01)) + '% sales tax');  //'Sales Order ' + SalesHeader."No." + ' Tax');
                JO1.Add('description', Format(Round((100 * ((SalesHeader."Amount Including VAT" - SalesHeader.Amount) / SalesHeader.Amount)), 0.01)) + '% sales tax');  //'Sales Order ' + SalesHeader."No." + ' Tax');
                TransReq.Add('tax', JO1);
            end;

            if false then begin  //Duty is not calculated currently
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('amount', DecimalVar);
                JO1.Add('name', 'Sales Order ' + SalesHeader."No." + ' Duty');
                JO1.Add('description', 'Sales Order ' + SalesHeader."No." + ' Duty');
                TransReq.Add('duty', JO1);
            end;

            if false then begin  //The shipping fee is not calculated currently
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('amount', DecimalVar);
                JO1.Add('name', 'Sales Order ' + SalesHeader."No." + ' Shipping');
                JO1.Add('description', 'Sales Order ' + SalesHeader."No." + ' Shipping');
                TransReq.Add('shipping', JO1);
            end;

            //if SalesHeader."Your Reference" <> '' then
            //    TransReq.Add('poNumber', SalesHeader."Your Reference");
            if SalesHeader."External Document No." <> '' then
                TransReq.Add('poNumber', SalesHeader."External Document No.");

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);
            if SalesHeader."Bill-to Customer No." <> '' then begin
                JO1.Add('id', SalesHeader."Bill-to Customer No.");
                Customer.Get(SalesHeader."Bill-to Customer No.");
            end else begin
                JO1.Add('id', SalesHeader."Sell-to Customer No.");
                Customer.Get(SalesHeader."Sell-to Customer No.");
            end;
            TransReq.Add('customer', JO1);

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);

            if SalesHeader."Bill-to Name" <> '' then
                Customer.Name := SalesHeader."Bill-to Name";

            if StrPos(Customer.Name, ' ') > 0 then begin
                JO1.Add('firstName', CopyStr(Customer.Name, 1, StrPos(Customer.Name, ' ')));
                JO1.Add('lastName', CopyStr(Customer.Name, StrPos(Customer.Name, ' ') + 1, 100));
            end else begin
                JO1.Add('firstName', Customer.Name);
                JO1.Add('lastName', '');
            end;
            Customer.GetPrimaryContact(customer."No.", Contact);
            if Contact."Company Name" <> '' then
                JO1.Add('company', Contact."Company Name");

            if SalesHeader."Bill-to Address" <> '' then begin
                JO1.Add('address', SalesHeader."Bill-to Address");
                JO1.Add('city', SalesHeader."Bill-to City");
                JO1.Add('state', SalesHeader."Bill-to County");
                JO1.Add('zip', SalesHeader."Bill-to Post Code");
                JO1.Add('country', SalesHeader."Bill-to Country/Region Code");
            end else begin
                JO1.Add('address', Customer.Address);
                JO1.Add('city', Customer.City);
                JO1.Add('state', Customer.County);
                JO1.Add('zip', Customer."Post Code");
                JO1.Add('country', customer."Country/Region Code");
            end;

            TransReq.Add('billTo', JO1);

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);
            if SalesHeader."Ship-to Code" <> '' then begin
                if not ShipTo.Get(SalesHeader."Ship-to Code") then
                    Clear(ShipTo);
            end else
                Clear(ShipTo);
            if ShipTo.Code <> '' then begin
                if StrPos(ShipTo.Name, ' ') > 0 then begin
                    JO1.Add('firstName', CopyStr(ShipTo.Name, 1, StrPos(ShipTo.name, ' ')));
                    JO1.Add('lastName', CopyStr(ShipTo.Name, StrPos(ShipTo.name, ' ') + 1, 100));
                end else begin
                    JO1.Add('firstName', ShipTo.Name);
                    JO1.Add('lastName', '');
                end;
                if ShipTo.Contact <> '' then begin
                    if not Contact.Get(ShipTo.Contact) then
                        Clear(Contact);
                end else
                    Clear(Contact);
                if Contact."No." <> '' then
                    JO1.Add('company', Contact."Company Name")
                else
                    JO1.Add('company', '');
            end else begin
                if StrPos(SalesHeader."Ship-to Name", ' ') > 0 then begin
                    JO1.Add('firstName', CopyStr(SalesHeader."Ship-to Name", 1, StrPos(SalesHeader."Ship-to Name", ' ')));
                    JO1.Add('lastName', CopyStr(SalesHeader."Ship-to Name", StrPos(SalesHeader."Ship-to Name", ' ') + 1, 100));
                end else begin
                    JO1.Add('firstName', SalesHeader."Ship-to Name");
                    JO1.Add('lastName', '');
                end;
                JO1.Add('company', '');
            end;
            JO1.Add('address', SalesHeader."Ship-to Address");
            JO1.Add('city', SalesHeader."Ship-to City");
            JO1.Add('state', SalesHeader."Ship-to County");
            JO1.Add('zip', SalesHeader."Ship-to Post Code");
            JO1.Add('country', SalesHeader."Ship-to Country/Region Code");
            TransReq.Add('shipTo', JO1);

            //TransReq.Add('customerIP', '127.0.0.1');  //Customer IP is not currently tracked

            if false then begin  //>>DTP - Transacation Settings are not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('settingName', 'testRequest');
                JO1.Add('settingValue', 'false');
                JO2.Add('setting', JO1);
                TransReq.Add('transactionSettings', JO2);
            end;  //<<DTP

            if false then begin  //>>DTP - User Fields is not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('name', 'MerchantDefinedFieldName1');
                JO1.Add('value', 'MerchantDefinedFieldValue1');
                JA.Add(JO1);
                Clear(JO1);
                JO1.Add('name', 'favorite_color');
                JO1.Add('value', 'blue');
                JA.Add(JO1);
                JO2.Add('userField', JA);
                TransReq.Add('userFields', JO2);
            end;  //<<DTP

            if false then begin  //>>DTP - isSubsequentAuth setting is not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('isSubsequentAuth', 'true');
                TransReq.Add('processingOptions', JO1);
            end;  //<<DTP

            if false then begin  //>>DTP - subsequentAuthInfomation setting is not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('originalNetworkTransId', '123456789NNNH');
                JO1.Add('originalAuthAmount', '45.00');
                JO1.Add('reason', 'resubmission');
                TransReq.Add('subsequentAuthInformation', JO1);
            end;  //<<DTP

            if false then begin  //>>DTP - authorizationIndicatorType is not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('authorizationIndicator', 'final');
                TransReq.Add('authorizationIndicatorType', JO1);
            end;  //<<DTP

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);
            JO1.Add('name', EPaymentProvider."Login User ID EXP");
            JO1.Add('transactionKey', EPaymentProvider."Password EXP");
            JO2.Add('merchantAuthentication', JO1);
            JO2.Add('refId', SalesHeader."No."); //Document No.
            JO2.Add('transactionRequest', TransReq);
            RequestObject.Add('createTransactionRequest', JO2);

            //>>DTP Debugging
            if InternetShopSetup."Debug Active" then begin
                RequestObject.WriteTo(TextVar);
                Message('RequestJson:\' + TextVar);
            end;
            //<<DTP Debugging

            if (CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject)) then begin
                //Insert a new payment entry
                NewEPaymentEntry.RESET;
                if not NewEPaymentEntry.FIND('+') then
                    NewEPaymentEntry."Entry No. EXP" := 1
                else
                    NewEPaymentEntry."Entry No. EXP" := NewEPaymentEntry."Entry No. EXP" + 1;
                NewEPaymentEntry.INIT;
                JT := GetJsonToken(ResponseObject, 'transactionResponse');
                ResponseObject := JT.AsObject();
                NewEPaymentEntry."Transaction ID EXP" := GetJsonToken(ResponseObject, 'transId').AsValue().AsText();
                NewEPaymentEntry."Cleared Order No. EXP" := SalesHeader."No.";
                NewEPaymentEntry."Document Type EXP" := SalesHeader."Document Type";
                NewEPaymentEntry."Document No. EXP" := SalesHeader."No.";
                NewEPaymentEntry."Cleared Amount EXP" := CardIDPage.GetClearingAmount();
                NewEPaymentEntry."e-payment Provider Code EXP" := PaymentMethod."e-payment Provider Code EXP";
                NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Cleared;
                NewEPaymentEntry."Clearing Valid-to Date EXP" := CALCDATE(EPaymentProvider."Clearing Validity Period EXP", CurrentDate);
                NewEPaymentEntry.INSERT;
                //update salesheader with payment information
                SalesHeader."e-payment Provider Code EXP" := PaymentMethod."e-payment Provider Code EXP";
                SalesHeader."e-payment Clearing OK EXP" := true;
                SalesHeader.MODIFY;
                Message('Credit card authorization %1 was created for $%2 and will be valid thru %3.', NewEPaymentEntry."Transaction ID EXP", NewEPaymentEntry."Cleared Amount EXP", NewEPaymentEntry."Clearing Valid-to Date EXP");
            end else begin
                ERROR(
                    TEXT001,
                    FORMAT(SalesLine."Outstanding Amount"), SalesHeader."Document Type", SalesHeader."No.", ErrorDescription);
            end;
        end;
    end;

    /// <summary>
    /// SalesCredit.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    /// <param name="CurrentDate">Date.</param>
    procedure SalesCredit(var SalesHeader: Record "Sales Header"; CurrentDate: Date);
    var
        SalesLine: Record "Sales Line";
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        AmountToAuthorize: Decimal;
        CalcAmountFrom: Option " ","Qty. to Ship","Qty. to Invoice","Qty. Outstanding","Cancel";
        TransReq: JsonObject;
        JO1: JsonObject;
        JO2: JsonObject;
        JO3: JsonObject;
        JA: JsonArray;
        JT: JsonToken;
        DecimalVar: Decimal;
        Customer: Record Customer;
        Contact: Record Contact;
        ShipTo: Record "Ship-to Address";
        TextVar: Text;
        Item: Record Item;
    begin
        Clear(NewEPaymentEntry);
        NewEPaymentEntry.Reset();
        NewEPaymentEntry.SETCURRENTKEY("Document No. EXP");
        NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
        if NewEPaymentEntry.FindLast() then
            if NewEPaymentEntry."Status EXP" in [NewEPaymentEntry."Status EXP"::Cleared, NewEPaymentEntry."Status EXP"::"Ready to Capture"] then
                if NewEPaymentEntry."Clearing Valid-to Date EXP" >= Today() then begin
                    Message('There is an open e-payment valid authorization for this order!');
                    exit;
                end;
        Clear(NewEPaymentEntry);
        SalesHeader.TESTFIELD("e-payment Provider Code EXP");
        SalesHeader.TESTFIELD("e-payment Clearing OK EXP", false);
        SalesHeader.TESTFIELD("Payment Method Code");
        PaymentMethod.GET(SalesHeader."Payment Method Code");
        PaymentMethod.TESTFIELD("e-payment Provider Code EXP");
        EPaymentProvider.GET(PaymentMethod."e-payment Provider Code EXP");
        EPaymentProvider.TESTFIELD("Merchant ID EXP");
        EPaymentProvider.TESTFIELD("Login User ID EXP");
        EPaymentProvider.TESTFIELD("Provider Type EXP");
        EPaymentProvider.TESTFIELD("Clearing Validity Period EXP");
        EPaymentProvider.TestField("API URL");
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            RequestUri := EPaymentProvider."API URL";  //Test Authorize.Net URL:  'https://apitest.authorize.net/xml/v1/request.api'
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
            SalesHeader.CalcFields("Amount Including VAT", Amount);
            IF SalesHeader."Amount Including VAT" <= 0 then
                Error(TEXT000, Format(SalesHeader."Amount Including VAT"));
            SalesLine.SetFilter(Type, '>0');
            SalesLine.SetFilter(Quantity, '<>0');
            If SalesLine.FindSet then
                repeat
                    AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Ship";
                Until SalesLine.next = 0;
            If AmountToAuthorize <= 0 then begin
                CalcAmountFrom := StrMenu('Qty. to Ship, Qty. to Invoice, Qty. Outstanding, Cancel', 1, 'Select which amount to calculate:');
                If SalesLine.FindSet then
                    repeat
                        case CalcAmountFrom of
                            CalcAmountFrom::"Qty. to Ship":
                                AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Ship";
                            CalcAmountFrom::"Qty. to Invoice":
                                AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Invoice";
                            CalcAmountFrom::"Qty. Outstanding":
                                AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Outstanding Quantity";
                        end;
                    Until SalesLine.next = 0;
                If AmountToAuthorize <= 0 then
                    Error(TEXT000, Format(AmountToAuthorize));
            end;
            AmountToAuthorize := Round(AmountToAuthorize, 0.01, '>');
            // End New Code
            CLEAR(CardIDPage);
            CardIDPage.SetClearingAmount(AmountToAuthorize);
            CardIDPage.SetSalesHeader(SalesHeader);
            CardIDPage.LOOKUPMODE(true);
            if not (CardIDPage.RUNMODAL = ACTION::LookupOK) then
                exit;
            CardIDPage.GetCardID(CardNumber, ExpiryMonth, ExpiryYear);
            CardIDPage.VerifyCardInformation(CardNumber, ExpiryMonth, ExpiryYear, true);


            //Set up a json object
            //RequestUri := ExpandITUtil."TrimExpandITURL"(InternetShopSetup."Local Shop URL EXP") + 'api/EpaymentApi/cleartransaction';
            //RequestObject.Add('Simulation', InternetShopSetup."Simulation EXP");
            //RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
            //RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
            //RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
            //RequestObject.Add('Password', EPaymentProvider."Password EXP");
            //RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
            //RequestObject.Add('OrderNo', SalesHeader."No.");
            //--RequestObject.Add('Amount', SalesLine."Outstanding Amount");
            //RequestObject.Add('Amount', CardIDPage.GetClearingAmount());
            //--if SalesHeader."Currency Code" <> '' then
            //RequestObject.Add('CurrencyCode', SalesHeader."Currency Code");
            //--else
            //--    RequestObject.Add('CurrencyCode', 'USD');
            //RequestObject.Add('CardNo', CardNumber);
            //RequestObject.Add('ExpiryMonth', ExpiryMonth);
            //RequestObject.Add('ExpiryYear', ExpiryYear);
            //RequestObject.Add('CVC', CardIDPage.GetCVC());


            if CardIDPage.GetClearingAmount() <= 0 then begin
                Message('Capture Amount Cannot Be Zero!');
                exit;
            end;
            if CardIDPage.GetClearingAmount() > SalesHeader."Amount Including VAT" then
                if not Confirm('The amount specified to capture ($%1) is more than the total amount of the order ($%2).\Are you sure you want to continue?',
                                false,
                                Format(Round(CardIDPage.GetClearingAmount(), 0.01)),
                                Format(Round(SalesHeader."Amount Including VAT", 0.01))) then
                    Error('Function cancelled by user!');

            TransReq.Add('transactionType', 'authOnlyTransaction');  //authorize the transaction
            TransReq.Add('amount', CardIDPage.GetClearingAmount());  //Transaction Amount

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);
            JO1.Add('cardNumber', CardNumber);
            JO1.Add('expirationDate', Format(ExpiryYear) + '-' + Format(ExpiryMonth));
            JO1.Add('cardCode', CardIDPage.GetCVC());
            JO2.Add('creditCard', JO1);
            TransReq.Add('payment', JO2);

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);
            JO1.Add('invoiceNumber', SalesHeader."No.");
            TransReq.Add('order', JO1);

            if false then begin  //>>DTP - lineItems property is not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('itemId', SalesLine."No.");
                JO1.Add('name', Item.Description);
                JO1.Add('description', SalesLine.Description);
                JO1.Add('quantity', SalesLine.Quantity);
                JO1.Add('unitPrice', SalesLine."Unit Price");
                JO2.Add('lineItem', JO1);
                JA.Add(JO2);
                Clear(JO1);
                Clear(JO2);
                JO1.Add('itemId', SalesLine."No.");
                JO1.Add('name', Item.Description);
                JO1.Add('description', SalesLine.Description);
                JO1.Add('quantity', SalesLine.Quantity);
                JO1.Add('unitPrice', SalesLine."Unit Price");
                JO2.Add('lineItem', JO1);
                JA.Add(JO2);
                TransReq.Add('lineItems', JA);
            end; //<<DTP

            DecimalVar := SalesHeader."Amount Including VAT" - SalesHeader.Amount;
            if DecimalVar <> 0 then begin
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('amount', DecimalVar);
                JO1.Add('name', Format(Round((100 * ((SalesHeader."Amount Including VAT" - SalesHeader.Amount) / SalesHeader.Amount)), 0.01)) + '% sales tax');  //'Sales Order ' + SalesHeader."No." + ' Tax');
                JO1.Add('description', Format(Round((100 * ((SalesHeader."Amount Including VAT" - SalesHeader.Amount) / SalesHeader.Amount)), 0.01)) + '% sales tax');  //'Sales Order ' + SalesHeader."No." + ' Tax');
                TransReq.Add('tax', JO1);
            end;

            if false then begin  //Duty is not calculated currently
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('amount', DecimalVar);
                JO1.Add('name', 'Sales Order ' + SalesHeader."No." + ' Duty');
                JO1.Add('description', 'Sales Order ' + SalesHeader."No." + ' Duty');
                TransReq.Add('duty', JO1);
            end;

            if false then begin  //The shipping fee is not calculated currently
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('amount', DecimalVar);
                JO1.Add('name', 'Sales Order ' + SalesHeader."No." + ' Shipping');
                JO1.Add('description', 'Sales Order ' + SalesHeader."No." + ' Shipping');
                TransReq.Add('shipping', JO1);
            end;

            //if SalesHeader."Your Reference" <> '' then
            //    TransReq.Add('poNumber', SalesHeader."Your Reference");
            if SalesHeader."External Document No." <> '' then
                TransReq.Add('poNumber', SalesHeader."External Document No.");

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);
            if SalesHeader."Bill-to Customer No." <> '' then begin
                JO1.Add('id', SalesHeader."Bill-to Customer No.");
                Customer.Get(SalesHeader."Bill-to Customer No.");
            end else begin
                JO1.Add('id', SalesHeader."Sell-to Customer No.");
                Customer.Get(SalesHeader."Sell-to Customer No.");
            end;
            TransReq.Add('customer', JO1);

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);

            if SalesHeader."Bill-to Name" <> '' then
                Customer.Name := SalesHeader."Bill-to Name";

            if StrPos(Customer.Name, ' ') > 0 then begin
                JO1.Add('firstName', CopyStr(Customer.Name, 1, StrPos(Customer.Name, ' ')));
                JO1.Add('lastName', CopyStr(Customer.Name, StrPos(Customer.Name, ' ') + 1, 100));
            end else begin
                JO1.Add('firstName', Customer.Name);
                JO1.Add('lastName', '');
            end;
            Customer.GetPrimaryContact(customer."No.", Contact);
            if Contact."Company Name" <> '' then
                JO1.Add('company', Contact."Company Name");

            if SalesHeader."Bill-to Address" <> '' then begin
                JO1.Add('address', SalesHeader."Bill-to Address");
                JO1.Add('city', SalesHeader."Bill-to City");
                JO1.Add('state', SalesHeader."Bill-to County");
                JO1.Add('zip', SalesHeader."Bill-to Post Code");
                JO1.Add('country', SalesHeader."Bill-to Country/Region Code");
            end else begin
                JO1.Add('address', Customer.Address);
                JO1.Add('city', Customer.City);
                JO1.Add('state', Customer.County);
                JO1.Add('zip', Customer."Post Code");
                JO1.Add('country', customer."Country/Region Code");
            end;

            TransReq.Add('billTo', JO1);

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);
            if SalesHeader."Ship-to Code" <> '' then begin
                if not ShipTo.Get(SalesHeader."Ship-to Code") then
                    Clear(ShipTo);
            end else
                Clear(ShipTo);
            if ShipTo.Code <> '' then begin
                if StrPos(ShipTo.Name, ' ') > 0 then begin
                    JO1.Add('firstName', CopyStr(ShipTo.Name, 1, StrPos(ShipTo.name, ' ')));
                    JO1.Add('lastName', CopyStr(ShipTo.Name, StrPos(ShipTo.name, ' ') + 1, 100));
                end else begin
                    JO1.Add('firstName', ShipTo.Name);
                    JO1.Add('lastName', '');
                end;
                if ShipTo.Contact <> '' then begin
                    if not Contact.Get(ShipTo.Contact) then
                        Clear(Contact);
                end else
                    Clear(Contact);
                if Contact."No." <> '' then
                    JO1.Add('company', Contact."Company Name")
                else
                    JO1.Add('company', '');
            end else begin
                if StrPos(SalesHeader."Ship-to Name", ' ') > 0 then begin
                    JO1.Add('firstName', CopyStr(SalesHeader."Ship-to Name", 1, StrPos(SalesHeader."Ship-to Name", ' ')));
                    JO1.Add('lastName', CopyStr(SalesHeader."Ship-to Name", StrPos(SalesHeader."Ship-to Name", ' ') + 1, 100));
                end else begin
                    JO1.Add('firstName', SalesHeader."Ship-to Name");
                    JO1.Add('lastName', '');
                end;
                JO1.Add('company', '');
            end;
            JO1.Add('address', SalesHeader."Ship-to Address");
            JO1.Add('city', SalesHeader."Ship-to City");
            JO1.Add('state', SalesHeader."Ship-to County");
            JO1.Add('zip', SalesHeader."Ship-to Post Code");
            JO1.Add('country', SalesHeader."Ship-to Country/Region Code");
            TransReq.Add('shipTo', JO1);

            //TransReq.Add('customerIP', '127.0.0.1');  //Customer IP is not currently tracked

            if false then begin  //>>DTP - Transacation Settings are not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('settingName', 'testRequest');
                JO1.Add('settingValue', 'false');
                JO2.Add('setting', JO1);
                TransReq.Add('transactionSettings', JO2);
            end;  //<<DTP

            if false then begin  //>>DTP - User Fields is not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('name', 'MerchantDefinedFieldName1');
                JO1.Add('value', 'MerchantDefinedFieldValue1');
                JA.Add(JO1);
                Clear(JO1);
                JO1.Add('name', 'favorite_color');
                JO1.Add('value', 'blue');
                JA.Add(JO1);
                JO2.Add('userField', JA);
                TransReq.Add('userFields', JO2);
            end;  //<<DTP

            if false then begin  //>>DTP - isSubsequentAuth setting is not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('isSubsequentAuth', 'true');
                TransReq.Add('processingOptions', JO1);
            end;  //<<DTP

            if false then begin  //>>DTP - subsequentAuthInfomation setting is not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('originalNetworkTransId', '123456789NNNH');
                JO1.Add('originalAuthAmount', '45.00');
                JO1.Add('reason', 'resubmission');
                TransReq.Add('subsequentAuthInformation', JO1);
            end;  //<<DTP

            if false then begin  //>>DTP - authorizationIndicatorType is not currently used
                Clear(JO1);
                Clear(JO2);
                Clear(JO3);
                JO1.Add('authorizationIndicator', 'final');
                TransReq.Add('authorizationIndicatorType', JO1);
            end;  //<<DTP

            Clear(JO1);
            Clear(JO2);
            Clear(JO3);
            JO1.Add('name', EPaymentProvider."Login User ID EXP");
            JO1.Add('transactionKey', EPaymentProvider."Password EXP");
            JO2.Add('merchantAuthentication', JO1);
            JO2.Add('refId', SalesHeader."No."); //Document No.
            JO2.Add('transactionRequest', TransReq);
            RequestObject.Add('createTransactionRequest', JO2);

            //>>DTP Debugging
            if InternetShopSetup."Debug Active" then begin
                RequestObject.WriteTo(TextVar);
                Message('RequestJson:\' + TextVar);
            end;
            //<<DTP Debugging

            if (CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject)) then begin
                //Insert a new payment entry
                NewEPaymentEntry.RESET;
                if not NewEPaymentEntry.FIND('+') then
                    NewEPaymentEntry."Entry No. EXP" := 1
                else
                    NewEPaymentEntry."Entry No. EXP" := NewEPaymentEntry."Entry No. EXP" + 1;
                NewEPaymentEntry.INIT;
                JT := GetJsonToken(ResponseObject, 'transactionResponse');
                ResponseObject := JT.AsObject();
                NewEPaymentEntry."Transaction ID EXP" := GetJsonToken(ResponseObject, 'transId').AsValue().AsText();
                NewEPaymentEntry."Cleared Order No. EXP" := SalesHeader."No.";
                NewEPaymentEntry."Document Type EXP" := SalesHeader."Document Type";
                NewEPaymentEntry."Document No. EXP" := SalesHeader."No.";
                NewEPaymentEntry."Cleared Amount EXP" := CardIDPage.GetClearingAmount();
                NewEPaymentEntry."e-payment Provider Code EXP" := PaymentMethod."e-payment Provider Code EXP";
                NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Cleared;
                NewEPaymentEntry."Clearing Valid-to Date EXP" := CALCDATE(EPaymentProvider."Clearing Validity Period EXP", CurrentDate);
                NewEPaymentEntry.INSERT;
                //update salesheader with payment information
                SalesHeader."e-payment Provider Code EXP" := PaymentMethod."e-payment Provider Code EXP";
                SalesHeader."e-payment Clearing OK EXP" := true;
                SalesHeader.MODIFY;
                Message('Credit card authorization %1 was created for $%2 and will be valid thru %3.', NewEPaymentEntry."Transaction ID EXP", NewEPaymentEntry."Cleared Amount EXP", NewEPaymentEntry."Clearing Valid-to Date EXP");
            end else begin
                ERROR(
                    TEXT001,
                    FORMAT(SalesLine."Outstanding Amount"), SalesHeader."Document Type", SalesHeader."No.", ErrorDescription);
            end;
        end;
    end;
    /// <summary>
    /// ClearingSalesHeader.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    /// <param name="CurrentDate">Date.</param>
    /// <param name="Silent">Boolean.</param>
    procedure ClearingSalesHeader(var SalesHeader: Record "Sales Header"; CurrentDate: Date; Silent: Boolean);
    var
        SalesLine: Record "Sales Line";
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        AmountToAuthorize: Decimal;
        CalcAmountFrom: Option " ","Qty. to Ship","Qty. to Invoice","Qty. Outstanding","Cancel";

    begin
        Clear(NewEPaymentEntry);
        NewEPaymentEntry.Reset();
        NewEPaymentEntry.SETCURRENTKEY("Document No. EXP");
        NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
        if NewEPaymentEntry.FindLast() then
            if NewEPaymentEntry."Status EXP" in [NewEPaymentEntry."Status EXP"::Cleared, NewEPaymentEntry."Status EXP"::"Ready to Capture"] then
                if NewEPaymentEntry."Clearing Valid-to Date EXP" >= Today() then
                    exit;
        Clear(NewEPaymentEntry);
        SalesHeader.TESTFIELD("e-payment Provider Code EXP", '');
        SalesHeader.TESTFIELD("e-payment Clearing OK EXP", false);
        SalesHeader.TESTFIELD("Payment Method Code");
        PaymentMethod.GET(SalesHeader."Payment Method Code");
        PaymentMethod.TESTFIELD("e-payment Provider Code EXP");
        EPaymentProvider.GET(PaymentMethod."e-payment Provider Code EXP");
        EPaymentProvider.TESTFIELD("Merchant ID EXP");
        EPaymentProvider.TESTFIELD("Login User ID EXP");
        EPaymentProvider.TESTFIELD("Provider Type EXP");
        EPaymentProvider.TESTFIELD("Clearing Validity Period EXP");
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
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
                Error(TEXT000, Format(SalesHeader."Amount Including VAT"));
            SalesLine.SetFilter(Type, '>0');
            SalesLine.SetFilter(Quantity, '<>0');
            If SalesLine.FindSet then
                repeat
                    AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Ship";
                Until SalesLine.next = 0;
            If AmountToAuthorize <= 0 then begin
                CalcAmountFrom := StrMenu('Qty. to Ship, Qty. to Invoice, Qty. Outstanding, Cancel', 1, 'Select which amount to calculate:');
                If SalesLine.FindSet then
                    repeat
                        case CalcAmountFrom of
                            CalcAmountFrom::"Qty. to Ship":
                                AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Ship";
                            CalcAmountFrom::"Qty. to Invoice":
                                AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Invoice";
                            CalcAmountFrom::"Qty. Outstanding":
                                AmountToAuthorize += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Outstanding Quantity";
                        end;
                    Until SalesLine.next = 0;
                If AmountToAuthorize <= 0 then
                    Error(TEXT000, Format(AmountToAuthorize));
            end;
            AmountToAuthorize := Round(AmountToAuthorize, 0.01, '>');
            // End New Code
            CLEAR(CardIDPage);
            CardIDPage.SetClearingAmount(AmountToAuthorize);
            CardIDPage.SetSalesHeader(SalesHeader);
            CardIDPage.LOOKUPMODE(true);
            if not (CardIDPage.RUNMODAL = ACTION::LookupOK) then
                exit;
            CardIDPage.GetCardID(CardNumber, ExpiryMonth, ExpiryYear);
            CardIDPage.VerifyCardInformation(CardNumber, ExpiryMonth, ExpiryYear, true);
            //Set up a json object
            //RequestUri := ExpandITUtil."TrimExpandITURL"(InternetShopSetup."Local Shop URL EXP") + 'api/EpaymentApi/cleartransaction';
            RequestUri := 'https://dyn-bc.dynatechpartners.com/covid/api/EpaymentApi/cleartransaction';
            RequestObject.Add('Simulation', InternetShopSetup."Simulation EXP");
            RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
            RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
            RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
            RequestObject.Add('Password', EPaymentProvider."Password EXP");
            RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
            RequestObject.Add('OrderNo', SalesHeader."No.");
            //RequestObject.Add('Amount', SalesLine."Outstanding Amount");
            RequestObject.Add('Amount', CardIDPage.GetClearingAmount());
            //if SalesHeader."Currency Code" <> '' then
            RequestObject.Add('CurrencyCode', SalesHeader."Currency Code");
            //else
            //    RequestObject.Add('CurrencyCode', 'USD');
            RequestObject.Add('CardNo', CardNumber);
            RequestObject.Add('ExpiryMonth', ExpiryMonth);
            RequestObject.Add('ExpiryYear', ExpiryYear);
            RequestObject.Add('CVC', CardIDPage.GetCVC());
            if (CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject)) then begin
                //Insert a new payment entry
                NewEPaymentEntry.RESET;
                if not NewEPaymentEntry.FIND('+') then
                    NewEPaymentEntry."Entry No. EXP" := 1
                else
                    NewEPaymentEntry."Entry No. EXP" := NewEPaymentEntry."Entry No. EXP" + 1;
                NewEPaymentEntry.INIT;
                NewEPaymentEntry."Transaction ID EXP" := GetJsonToken(ResponseObject, 'TransactionId').AsValue().AsText();
                NewEPaymentEntry."Cleared Order No. EXP" := GetJsonToken(ResponseObject, 'OrderNo').AsValue().AsText();
                NewEPaymentEntry."Document Type EXP" := SalesHeader."Document Type";
                NewEPaymentEntry."Document No. EXP" := GetJsonToken(ResponseObject, 'OrderNo').AsValue().AsText();
                NewEPaymentEntry."Cleared Amount EXP" := GetJsonToken(ResponseObject, 'Amount').AsValue().AsDecimal();
                NewEPaymentEntry."e-payment Provider Code EXP" := PaymentMethod."e-payment Provider Code EXP";
                NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Cleared;
                NewEPaymentEntry."Clearing Valid-to Date EXP" := CALCDATE(EPaymentProvider."Clearing Validity Period EXP", CurrentDate);
                NewEPaymentEntry."Signature EXP" := GetJsonToken(ResponseObject, 'TransactionSignature').AsValue().AsText();
                //NewEPaymentEntry."CurrencyCode EXP" := GetJsonToken(ResponseObject, 'CurrencyCode').AsValue().AsText();
                NewEPaymentEntry.INSERT;
                //update salesheader with payment information
                SalesHeader."e-payment Provider Code EXP" := PaymentMethod."e-payment Provider Code EXP";
                SalesHeader."e-payment Clearing OK EXP" := true;
                SalesHeader.MODIFY;
                if not Silent then
                    Message('Credit card authorization %1 was created for $%2 and will be valid thru %3.', NewEPaymentEntry."Transaction ID EXP", NewEPaymentEntry."Cleared Amount EXP", NewEPaymentEntry."Clearing Valid-to Date EXP");
            end else begin
                ERROR(
                    TEXT001,
                    FORMAT(SalesLine."Outstanding Amount"), SalesHeader."Document Type", SalesHeader."No.", ErrorDescription);
            end;
        end;
    end;

    /// <summary>
    /// InsertClearedSalesHeader.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    /// <param name="CurrentDate">Date.</param>
    /// <param name="OrderNo">Code[20].</param>
    /// <param name="TransactionID">Code[20].</param>
    /// <param name="ClearedAmount">Decimal.</param>
    /// <param name="TransactionSignature">Text[250].</param>
    procedure InsertClearedSalesHeader(var SalesHeader: Record "Sales Header"; CurrentDate: Date; OrderNo: Code[20]; TransactionID: Code[20]; ClearedAmount: Decimal; TransactionSignature: Text[250]);
    begin
        SalesHeader.TESTFIELD("e-payment Provider Code EXP", '');
        SalesHeader.TESTFIELD("e-payment Clearing OK EXP", false);
        if not (SalesHeader."Document Type" in
                [SalesHeader."Document Type"::Order,
                SalesHeader."Document Type"::Invoice])
        then
            ERROR(
              TEXT002,
              SalesHeader.FIELDNAME("Document Type"),
              FORMAT(SalesHeader."Document Type"::Order),
              FORMAT(SalesHeader."Document Type"::Invoice));

        SalesHeader.TESTFIELD("Payment Method Code");
        PaymentMethod.GET(SalesHeader."Payment Method Code");
        PaymentMethod.TESTFIELD("e-payment Provider Code EXP");
        EPaymentProvider.GET(PaymentMethod."e-payment Provider Code EXP");
        NewEPaymentEntry.RESET;
        if not NewEPaymentEntry.FIND('+') then
            NewEPaymentEntry."Entry No. EXP" := 1
        else
            NewEPaymentEntry."Entry No. EXP" := NewEPaymentEntry."Entry No. EXP" + 1;
        NewEPaymentEntry.INIT;
        NewEPaymentEntry."Transaction ID EXP" := TransactionID;
        NewEPaymentEntry."Signature EXP" := TransactionSignature;
        NewEPaymentEntry."Cleared Order No. EXP" := OrderNo;
        NewEPaymentEntry."Document Type EXP" := SalesHeader."Document Type";
        NewEPaymentEntry."Document No. EXP" := SalesHeader."No.";
        NewEPaymentEntry."Cleared Amount EXP" := ClearedAmount;
        NewEPaymentEntry."e-payment Provider Code EXP" := PaymentMethod."e-payment Provider Code EXP";
        if ExpandITOrderHeaderExists(SalesHeader."External Document No.", SalesHeader."Sell-to Customer No.") then begin
            NewEPaymentEntry."Captured Amount EXP" := ClearedAmount;
            NewEPaymentEntry."Payment Posting Date EXP" := SalesHeader."Posting Date";
            NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Captured;
        end else
            NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Cleared;
        NewEPaymentEntry."Clearing Valid-to Date EXP" := CALCDATE(EPaymentProvider."Clearing Validity Period EXP", CurrentDate);
        NewEPaymentEntry."CurrencyCode EXP" := SalesHeader."Currency Code";
        NewEPaymentEntry.INSERT;
        SalesHeader."e-payment Provider Code EXP" := PaymentMethod."e-payment Provider Code EXP";
        SalesHeader."e-payment Clearing OK EXP" := true;
        SalesHeader.MODIFY;
    end;

    /// <summary>
    /// TestClearingSalesHeader.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    procedure TestClearingSalesHeader(SalesHeader: Record "Sales Header");
    begin
        SalesHeader.TESTFIELD("e-payment Provider Code EXP");
        SalesHeader.TESTFIELD("e-payment Clearing OK EXP");
        NewEPaymentEntry.RESET;
        NewEPaymentEntry.SETCURRENTKEY("Document Type EXP", "Document No. EXP");
        NewEPaymentEntry.SETRANGE("Document Type EXP", SalesHeader."Document Type");
        NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
        NewEPaymentEntry.FIND('+');
        NewEPaymentEntry.TESTFIELD("Status EXP", NewEPaymentEntry."Status EXP"::Cleared);
        TestClearing(NewEPaymentEntry);
    end;

    /// <summary>
    /// RenewClearingSalesHeader.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    /// <param name="CurrentDate">Date.</param>
    procedure RenewClearingSalesHeader(SalesHeader: Record "Sales Header"; CurrentDate: Date);
    begin
        SalesHeader.TESTFIELD("e-payment Provider Code EXP");
        SalesHeader.TESTFIELD("e-payment Clearing OK EXP");
        NewEPaymentEntry.RESET;
        NewEPaymentEntry.SETCURRENTKEY("Document Type EXP", "Document No. EXP");
        NewEPaymentEntry.SETRANGE("Document Type EXP", SalesHeader."Document Type");
        NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
        NewEPaymentEntry.FIND('+');
        NewEPaymentEntry.TESTFIELD("Status EXP", NewEPaymentEntry."Status EXP"::Cleared);
        RenewClearing(NewEPaymentEntry, CurrentDate);
        NewEPaymentEntry.MODIFY;
    end;

    /// <summary>
    /// DeleteClearingSalesHeader.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    procedure DeleteClearingSalesHeader(var SalesHeader: Record "Sales Header");
    begin
        SalesHeader.TESTFIELD("e-payment Provider Code EXP");
        SalesHeader.TESTFIELD("e-payment Clearing OK EXP");
        NewEPaymentEntry.RESET;
        NewEPaymentEntry.SETCURRENTKEY("Document Type EXP", "Document No. EXP");
        NewEPaymentEntry.SETRANGE("Document Type EXP", SalesHeader."Document Type");
        NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
        NewEPaymentEntry.FIND('+');
        DeleteClearing(NewEPaymentEntry);
        SalesHeader."e-payment Provider Code EXP" := '';
        SalesHeader."e-payment Clearing OK EXP" := false;
        SalesHeader.MODIFY;
    end;

    /// <summary>
    /// GetCardTypeSalesHeader.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    procedure GetCardTypeSalesHeader(SalesHeader: Record "Sales Header");
    begin
        SalesHeader.TESTFIELD("e-payment Provider Code EXP");
        SalesHeader.TESTFIELD("e-payment Clearing OK EXP");
        NewEPaymentEntry.RESET;
        NewEPaymentEntry.SETCURRENTKEY("Document Type EXP", "Document No. EXP");
        NewEPaymentEntry.SETRANGE("Document Type EXP", SalesHeader."Document Type");
        NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
        NewEPaymentEntry.FIND('+');
        NewEPaymentEntry.TESTFIELD("Status EXP", NewEPaymentEntry."Status EXP"::Cleared);
        GetCardType(NewEPaymentEntry);
    end;

    /// <summary>
    /// SalesOrderCapture.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    /// <param name="PostingDate">Date.</param>
    procedure SalesOrderDirectCapture(SalesHeader: Record "Sales Header"; PostingDate: Date);
    var
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
        TransReq: JsonObject;
        JO1: JsonObject;
        JO2: JsonObject;
        JO3: JsonObject;
        JA: JsonArray;
        TextVar: Text;
        DecimalVar: Decimal;
        Customer: Record Customer;
        Contact: Record Contact;
        ShipTo: Record "Ship-to Address";
        JT: JsonToken;
        SalesLine: Record "Sales Line";
        Item: Record Item;
    begin
        NewEPaymentEntry.Reset();
        NewEPaymentEntry.SETCURRENTKEY("Document No. EXP");
        NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
        if not NewEPaymentEntry.FindLast() then begin
            NewEPaymentEntry.Reset();
            if not NewEPaymentEntry.FindLast() then
                NewEPaymentEntry."Entry No. EXP" := 1
            else
                NewEPaymentEntry."Entry No. EXP" := NewEPaymentEntry."Entry No. EXP" + 1;
            NewEPaymentEntry.INIT;
            NewEPaymentEntry.Insert(true);
            NewEPaymentEntry."Document Type EXP" := SalesHeader."Document Type";
            NewEPaymentEntry."Document No. EXP" := SalesHeader."No.";
            if SalesHeader."e-payment Provider Code EXP" = '' then begin
                PaymentMethod.Get(SalesHeader."Payment Method Code");
                PaymentMethod.TestField("e-payment Provider Code EXP");
                SalesHeader."e-payment Provider Code EXP" := PaymentMethod."e-payment Provider Code EXP";
                SalesHeader.Modify(true);
            end;
            NewEPaymentEntry."e-payment Provider Code EXP" := SalesHeader."e-payment Provider Code EXP";
            NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::"Ready to Capture";
            NewEPaymentEntry."Cleared Order No. EXP" := SalesHeader."No.";
            NewEPaymentEntry."Cleared Amount EXP" := 0;
            NewEPaymentEntry."Transaction ID EXP" := 'AutoGenDirectCapture';
            NewEPaymentEntry."Clearing Valid-to Date EXP" := Today();
            NewEPaymentEntry.Modify(true);
            Commit();
        end;
        if NewEPaymentEntry."Status EXP" <> NewEPaymentEntry."Status EXP"::Captured then
            if NewEPaymentEntry."Status EXP" in [NewEPaymentEntry."Status EXP"::Cleared, NewEPaymentEntry."Status EXP"::"Ready to Capture"] then
                //Error('E-Payment Entry %1 must be Status Cleared or Ready to Capture!', NewEPaymentEntry."Transaction ID EXP");
                if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
                    EPaymentProvider.GET(NewEPaymentEntry."e-payment Provider Code EXP");
                    EPaymentProvider.TestField("API URL");
                    RequestUri := EPaymentProvider."API URL";  //Test Authorize.Net URL:  'https://apitest.authorize.net/xml/v1/request.api'

                    //>>DTP - Old RequestObject Coding
                    //RequestObject.Add('Simulation', InternetShopSetup."Simulation EXP");
                    //RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
                    //RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
                    //RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
                    //RequestObject.Add('Password', EPaymentProvider."Password EXP");
                    //RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
                    //RequestObject.Add('OrderNo', NewEPaymentEntry."Cleared Order No. EXP");
                    //RequestObject.Add('Amount', NewEPaymentEntry."Cleared Amount EXP");
                    //RequestObject.Add('CurrencyCode', SalesHeader."Currency Code");
                    //RequestObject.Add('TransactionId', NewEPaymentEntry."Transaction ID EXP");
                    //<<DTP - Old RequestObject Coding

                    SalesHeader.CalcFields("Amount Including VAT", Amount);
                    CLEAR(CardIDPage);
                    CardIDPage.SetClearingAmount(SalesHeader."Amount Including VAT");
                    CardIDPage.SetSalesHeader(SalesHeader);
                    CardIDPage.LOOKUPMODE(true);
                    if not (CardIDPage.RUNMODAL = ACTION::LookupOK) then
                        exit;
                    CardIDPage.GetCardID(CardNumber, ExpiryMonth, ExpiryYear);
                    CardIDPage.VerifyCardInformation(CardNumber, ExpiryMonth, ExpiryYear, true);

                    if CardIDPage.GetClearingAmount() <= 0 then begin
                        Message('Capture Amount Cannot Be Zero!');
                        exit;
                    end;
                    if CardIDPage.GetClearingAmount() > SalesHeader."Amount Including VAT" then
                        if not Confirm('The amount specified to capture ($%1) is more than the total amount of the order ($%2).\Are you sure you want to continue?',
                                       false,
                                       Format(Round(CardIDPage.GetClearingAmount(), 0.01)),
                                       Format(Round(SalesHeader."Amount Including VAT", 0.01))) then
                            Error('Function cancelled by user!');

                    TransReq.Add('transactionType', 'authCaptureTransaction');  //authorize and automatically capture the transaction
                    TransReq.Add('amount', CardIDPage.GetClearingAmount());  //Transaction Amount

                    Clear(JO1);
                    Clear(JO2);
                    Clear(JO3);
                    JO1.Add('cardNumber', CardNumber);
                    JO1.Add('expirationDate', Format(ExpiryYear) + '-' + Format(ExpiryMonth));
                    JO1.Add('cardCode', CardIDPage.GetCVC());
                    JO2.Add('creditCard', JO1);
                    TransReq.Add('payment', JO2);

                    Clear(JO1);
                    Clear(JO2);
                    Clear(JO3);
                    JO1.Add('invoiceNumber', SalesHeader."No.");
                    TransReq.Add('order', JO1);

                    if false then begin  //>>DTP - lineItems property is not currently used
                        Clear(JO1);
                        Clear(JO2);
                        Clear(JO3);
                        JO1.Add('itemId', SalesLine."No.");
                        JO1.Add('name', Item.Description);
                        JO1.Add('description', SalesLine.Description);
                        JO1.Add('quantity', SalesLine.Quantity);
                        JO1.Add('unitPrice', SalesLine."Unit Price");
                        JO2.Add('lineItem', JO1);
                        JA.Add(JO2);
                        Clear(JO1);
                        Clear(JO2);
                        JO1.Add('itemId', SalesLine."No.");
                        JO1.Add('name', Item.Description);
                        JO1.Add('description', SalesLine.Description);
                        JO1.Add('quantity', SalesLine.Quantity);
                        JO1.Add('unitPrice', SalesLine."Unit Price");
                        JO2.Add('lineItem', JO1);
                        JA.Add(JO2);
                        TransReq.Add('lineItems', JA);
                    end; //<<DTP

                    DecimalVar := SalesHeader."Amount Including VAT" - SalesHeader.Amount;
                    if DecimalVar <> 0 then begin
                        Clear(JO1);
                        Clear(JO2);
                        Clear(JO3);
                        JO1.Add('amount', DecimalVar);
                        JO1.Add('name', Format(Round((100 * ((SalesHeader."Amount Including VAT" - SalesHeader.Amount) / SalesHeader.Amount)), 0.01)) + '% sales tax');  //'Sales Order ' + SalesHeader."No." + ' Tax');
                        JO1.Add('description', Format(Round((100 * ((SalesHeader."Amount Including VAT" - SalesHeader.Amount) / SalesHeader.Amount)), 0.01)) + '% sales tax');  //'Sales Order ' + SalesHeader."No." + ' Tax');
                        TransReq.Add('tax', JO1);
                    end;

                    if false then begin  //Duty is not calculated currently
                        Clear(JO1);
                        Clear(JO2);
                        Clear(JO3);
                        JO1.Add('amount', DecimalVar);
                        JO1.Add('name', 'Sales Order ' + SalesHeader."No." + ' Duty');
                        JO1.Add('description', 'Sales Order ' + SalesHeader."No." + ' Duty');
                        TransReq.Add('duty', JO1);
                    end;

                    if false then begin  //The shipping fee is not calculated currently
                        Clear(JO1);
                        Clear(JO2);
                        Clear(JO3);
                        JO1.Add('amount', DecimalVar);
                        JO1.Add('name', 'Sales Order ' + SalesHeader."No." + ' Shipping');
                        JO1.Add('description', 'Sales Order ' + SalesHeader."No." + ' Shipping');
                        TransReq.Add('shipping', JO1);
                    end;

                    //if SalesHeader."Your Reference" <> '' then
                    //    TransReq.Add('poNumber', SalesHeader."Your Reference");
                    if SalesHeader."External Document No." <> '' then
                        TransReq.Add('poNumber', SalesHeader."External Document No.");

                    Clear(JO1);
                    Clear(JO2);
                    Clear(JO3);
                    if SalesHeader."Bill-to Customer No." <> '' then begin
                        JO1.Add('id', SalesHeader."Bill-to Customer No.");
                        Customer.Get(SalesHeader."Bill-to Customer No.");
                    end else begin
                        JO1.Add('id', SalesHeader."Sell-to Customer No.");
                        Customer.Get(SalesHeader."Sell-to Customer No.");
                    end;
                    TransReq.Add('customer', JO1);

                    Clear(JO1);
                    Clear(JO2);
                    Clear(JO3);

                    if SalesHeader."Bill-to Name" <> '' then
                        Customer.Name := SalesHeader."Bill-to Name";

                    if StrPos(Customer.Name, ' ') > 0 then begin
                        JO1.Add('firstName', CopyStr(Customer.Name, 1, StrPos(Customer.Name, ' ')));
                        JO1.Add('lastName', CopyStr(Customer.Name, StrPos(Customer.Name, ' ') + 1, 100));
                    end else begin
                        JO1.Add('firstName', Customer.Name);
                        JO1.Add('lastName', '');
                    end;
                    Customer.GetPrimaryContact(customer."No.", Contact);
                    if Contact."Company Name" <> '' then
                        JO1.Add('company', Contact."Company Name");

                    if SalesHeader."Bill-to Address" <> '' then begin
                        JO1.Add('address', SalesHeader."Bill-to Address");
                        JO1.Add('city', SalesHeader."Bill-to City");
                        JO1.Add('state', SalesHeader."Bill-to County");
                        JO1.Add('zip', SalesHeader."Bill-to Post Code");
                        JO1.Add('country', SalesHeader."Bill-to Country/Region Code");
                    end else begin
                        JO1.Add('address', Customer.Address);
                        JO1.Add('city', Customer.City);
                        JO1.Add('state', Customer.County);
                        JO1.Add('zip', Customer."Post Code");
                        JO1.Add('country', customer."Country/Region Code");
                    end;

                    TransReq.Add('billTo', JO1);

                    Clear(JO1);
                    Clear(JO2);
                    Clear(JO3);
                    if SalesHeader."Ship-to Code" <> '' then begin
                        if not ShipTo.Get(SalesHeader."Ship-to Code") then
                            Clear(ShipTo);
                    end else
                        Clear(ShipTo);
                    if ShipTo.Code <> '' then begin
                        if StrPos(ShipTo.Name, ' ') > 0 then begin
                            JO1.Add('firstName', CopyStr(ShipTo.Name, 1, StrPos(ShipTo.name, ' ')));
                            JO1.Add('lastName', CopyStr(ShipTo.Name, StrPos(ShipTo.name, ' ') + 1, 100));
                        end else begin
                            JO1.Add('firstName', ShipTo.Name);
                            JO1.Add('lastName', '');
                        end;
                        if ShipTo.Contact <> '' then begin
                            if not Contact.Get(ShipTo.Contact) then
                                Clear(Contact);
                        end else
                            Clear(Contact);
                        if Contact."No." <> '' then
                            JO1.Add('company', Contact."Company Name")
                        else
                            JO1.Add('company', '');
                    end else begin
                        if StrPos(SalesHeader."Ship-to Name", ' ') > 0 then begin
                            JO1.Add('firstName', CopyStr(SalesHeader."Ship-to Name", 1, StrPos(SalesHeader."Ship-to Name", ' ')));
                            JO1.Add('lastName', CopyStr(SalesHeader."Ship-to Name", StrPos(SalesHeader."Ship-to Name", ' ') + 1, 100));
                        end else begin
                            JO1.Add('firstName', SalesHeader."Ship-to Name");
                            JO1.Add('lastName', '');
                        end;
                        JO1.Add('company', '');
                    end;
                    JO1.Add('address', SalesHeader."Ship-to Address");
                    JO1.Add('city', SalesHeader."Ship-to City");
                    JO1.Add('state', SalesHeader."Ship-to County");
                    JO1.Add('zip', SalesHeader."Ship-to Post Code");
                    JO1.Add('country', SalesHeader."Ship-to Country/Region Code");
                    TransReq.Add('shipTo', JO1);

                    //TransReq.Add('customerIP', '127.0.0.1');  //Customer IP is not currently tracked

                    if false then begin  //>>DTP - Transacation Settings are not currently used
                        Clear(JO1);
                        Clear(JO2);
                        Clear(JO3);
                        JO1.Add('settingName', 'testRequest');
                        JO1.Add('settingValue', 'false');
                        JO2.Add('setting', JO1);
                        TransReq.Add('transactionSettings', JO2);
                    end;  //<<DTP

                    if false then begin  //>>DTP - User Fields is not currently used
                        Clear(JO1);
                        Clear(JO2);
                        Clear(JO3);
                        JO1.Add('name', 'MerchantDefinedFieldName1');
                        JO1.Add('value', 'MerchantDefinedFieldValue1');
                        JA.Add(JO1);
                        Clear(JO1);
                        JO1.Add('name', 'favorite_color');
                        JO1.Add('value', 'blue');
                        JA.Add(JO1);
                        JO2.Add('userField', JA);
                        TransReq.Add('userFields', JO2);
                    end;  //<<DTP

                    if false then begin  //>>DTP - isSubsequentAuth setting is not currently used
                        Clear(JO1);
                        Clear(JO2);
                        Clear(JO3);
                        JO1.Add('isSubsequentAuth', 'true');
                        TransReq.Add('processingOptions', JO1);
                    end;  //<<DTP

                    if false then begin  //>>DTP - subsequentAuthInfomation setting is not currently used
                        Clear(JO1);
                        Clear(JO2);
                        Clear(JO3);
                        JO1.Add('originalNetworkTransId', '123456789NNNH');
                        JO1.Add('originalAuthAmount', '45.00');
                        JO1.Add('reason', 'resubmission');
                        TransReq.Add('subsequentAuthInformation', JO1);
                    end;  //<<DTP

                    if false then begin  //>>DTP - authorizationIndicatorType is not currently used
                        Clear(JO1);
                        Clear(JO2);
                        Clear(JO3);
                        JO1.Add('authorizationIndicator', 'final');
                        TransReq.Add('authorizationIndicatorType', JO1);
                    end;  //<<DTP

                    Clear(JO1);
                    Clear(JO2);
                    Clear(JO3);
                    JO1.Add('name', EPaymentProvider."Login User ID EXP");
                    JO1.Add('transactionKey', EPaymentProvider."Password EXP");
                    JO2.Add('merchantAuthentication', JO1);
                    JO2.Add('refId', SalesHeader."No."); //Document No.
                    JO2.Add('transactionRequest', TransReq);
                    RequestObject.Add('createTransactionRequest', JO2);

                    //>>DTP Debugging
                    if InternetShopSetup."Debug Active" then begin
                        RequestObject.WriteTo(TextVar);
                        Message('RequestJson:\' + TextVar);
                    end;
                    //<<DTP Debugging

                    if not CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject) then
                        ERROR(TEXT014 +
                              TEXT015,
                              NewEPaymentEntry."Transaction ID EXP",
                              NewEPaymentEntry."e-payment Provider Code EXP",
                              ErrorDescription);
                    JT := GetJsonToken(ResponseObject, 'transactionResponse');
                    ResponseObject := JT.AsObject();
                    NewEPaymentEntry."Transaction ID EXP" := GetJsonToken(ResponseObject, 'transId').AsValue().AsText();
                    NewEPaymentEntry."Captured Amount EXP" := CardIDPage.GetClearingAmount();
                    NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Captured;
                    NewEPaymentEntry."Payment Posting Date EXP" := PostingDate;
                    NewEPaymentEntry.Modify();
                    Message('Credit card authorization %1 was captured for $%2.', NewEPaymentEntry."Transaction ID EXP", NewEPaymentEntry."Captured Amount EXP");
                end;
    end;

    /// <summary>
    /// SalesOrderCapture2.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    /// <param name="PostingDate">Date.</param>
    procedure SalesOrderCapture(SalesHeader: Record "Sales Header"; PostingDate: Date);
    var
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
    begin
        NewEPaymentEntry.Reset();
        NewEPaymentEntry.SETCURRENTKEY("Document No. EXP");
        NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
        NewEPaymentEntry.FindLast();
        // EIS6.0.16 begin 
        if NewEPaymentEntry."Status EXP" <> NewEPaymentEntry."Status EXP"::Captured then
            if NewEPaymentEntry."Status EXP" in [NewEPaymentEntry."Status EXP"::Cleared, NewEPaymentEntry."Status EXP"::"Ready to Capture"] then
                //Error('E-Payment Entry %1 must be Status Cleared or Ready to Capture!', NewEPaymentEntry."Transaction ID EXP");
                if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
                    //RequestUri := ExpandITUtil."TrimExpandITURL"(InternetShopSetup."Local Shop URL EXP") + '/api/EpaymentApi/capturetransaction';
                    RequestUri := 'https://dyn-bc.dynatechpartners.com/covid/api/EpaymentApi/capturetransaction';
                    //RequestUri := EPaymentProvider."API URL";
                    EPaymentProvider.GET(NewEPaymentEntry."e-payment Provider Code EXP");
                    RequestObject.Add('Simulation', InternetShopSetup."Simulation EXP");
                    RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
                    RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
                    RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
                    RequestObject.Add('Password', EPaymentProvider."Password EXP");
                    RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
                    RequestObject.Add('OrderNo', NewEPaymentEntry."Cleared Order No. EXP");
                    RequestObject.Add('Amount', NewEPaymentEntry."Cleared Amount EXP");
                    RequestObject.Add('CurrencyCode', SalesHeader."Currency Code");
                    RequestObject.Add('TransactionId', NewEPaymentEntry."Transaction ID EXP");
                    if not CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject) then
                        ERROR(
                        TEXT014 +
                        TEXT015,
                        NewEPaymentEntry."Transaction ID EXP",
                        NewEPaymentEntry."e-payment Provider Code EXP",
                        ErrorDescription);
                    NewEPaymentEntry."Captured Amount EXP" := NewEPaymentEntry."Cleared Amount EXP";
                    NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Captured;
                    NewEPaymentEntry."Payment Posting Date EXP" := PostingDate;
                    NewEPaymentEntry.Modify();
                    Message('Credit card authorization %1 was captured for $%2.', NewEPaymentEntry."Transaction ID EXP", NewEPaymentEntry."Captured Amount EXP");
                end;
        // EIS6.0.16 end
    end;

    /// <summary>
    /// PostSalesShipmentModifyLine.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    /// <param name="SalesShptHeader">Record "Sales Shipment Header".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure PostSalesShipmentModifyLine(SalesHeader: Record "Sales Header"; SalesShptHeader: Record "Sales Shipment Header"): Boolean;
    var
        SalesLine: Record "Sales Line";
        SalesShptLine: Record "Sales Shipment Line";
        ShippedAmount: Decimal;
    begin
        SalesHeader.TestField(Status, SalesHeader.Status::Released);
        SalesHeader.TestField("e-payment Provider Code EXP");
        SalesHeader.TestField("e-payment Clearing OK EXP");
        SalesHeader.TestField("Applies-to ID", '');
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin
            NewEPaymentEntry.RESET;
            NewEPaymentEntry.SETCURRENTKEY("Document Type EXP", "Document No. EXP");
            NewEPaymentEntry.SETRANGE("Document Type EXP", SalesHeader."Document Type");
            NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
            NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
            NewEPaymentEntry.FindLast();
            //if NewEPaymentEntry."Status EXP" = NewEPaymentEntry."Status EXP"::Dismissed then
            //    NewEPaymentEntry.FieldError("Status EXP");
            if NewEPaymentEntry."Status EXP" <> NewEPaymentEntry."Status EXP"::Captured then
                if NewEPaymentEntry."Status EXP" in [NewEPaymentEntry."Status EXP"::Cleared, NewEPaymentEntry."Status EXP"::"Ready to Capture"] then begin
                    //Set status to Ready To Capture if it is not already captured
                    if NewEPaymentEntry."Status EXP" = NewEPaymentEntry."Status EXP"::Cleared then
                        NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::"Ready to Capture";
                    NewEPaymentEntry."Shipment No. EXP" := SalesShptHeader."No.";
                    SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                    SalesLine.SetRange("Document No.", SalesHeader."No.");
                    SalesLine.SetFilter(Type, '>0');
                    SalesLine.SetFilter("Outstanding Quantity", '<>0');
                    shippedamount := 0;
                    If SalesLine.FindSet then
                        repeat
                            ShippedAmount += (SalesLine."Amount Including VAT" / SalesLine.Quantity) * SalesLine."Qty. to Ship";
                        Until SalesLine.next = 0;
                    If ShippedAmount <= 0 then
                        Error(StrSubstNo(TEXT009, '', '', NewEPaymentEntry."Cleared Amount EXP", 'equal to or less than the shipped amount: ' + Format(ShippedAmount)));
                    ShippedAmount := Round(ShippedAmount, 0.01, '>');
                    NewEPaymentEntry."Shipment Amount EXP" := ShippedAmount;
                    NewEPaymentEntry."Shipment Posting Date EXP" := SalesShptHeader."Posting Date";
                    if ExpandITOrderHeaderExists(SalesHeader."External Document No.", SalesHeader."Sell-to Customer No.") then begin  //Sales Orders from the web site have already been charged
                        NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Captured;
                        NewEPaymentEntry."Captured Amount EXP" := ShippedAmount;
                        NewEPaymentEntry."Payment Posting Date EXP" := SalesHeader."Posting Date";
                    end;
                    NewEPaymentEntry.MODIFY(True);
                end;  //else
                      //NewEPaymentEntry.FieldError("Status EXP");
            exit(InternetShopSetup."Batch Capture EXP");
        end;
    end;

    /// <summary>
    /// PostSalesShipmentCapture.
    /// </summary>
    /// <param name="SalesShptHeader">Record "Sales Shipment Header".</param>
    /// <param name="PostingDate">Date.</param>
    procedure PostSalesShipmentCapture(SalesShptHeader: Record "Sales Shipment Header"; PostingDate: Date);
    var
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Get(SalesHeader."Document Type"::Order, SalesShptHeader."Order No.");
        NewEPaymentEntry.Reset();
        NewEPaymentEntry.SETCURRENTKEY("Document No. EXP");
        NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
        NewEPaymentEntry.FindLast();
        // EIS6.0.16 begin 
        if NewEPaymentEntry."Status EXP" <> NewEPaymentEntry."Status EXP"::Captured then
            if NewEPaymentEntry."Status EXP" in [NewEPaymentEntry."Status EXP"::Cleared, NewEPaymentEntry."Status EXP"::"Ready to Capture"] then
                if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
                    RequestUri := ExpandITUtil."TrimExpandITURL"(InternetShopSetup."Local Shop URL EXP") + 'api/EpaymentApi/capturetransaction';
                    //RequestUri := EPaymentProvider."API URL";
                    EPaymentProvider.GET(NewEPaymentEntry."e-payment Provider Code EXP");
                    RequestObject.Add('Simulation', InternetShopSetup."Simulation EXP");
                    RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
                    RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
                    RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
                    RequestObject.Add('Password', EPaymentProvider."Password EXP");
                    RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
                    RequestObject.Add('OrderNo', NewEPaymentEntry."Cleared Order No. EXP");
                    RequestObject.Add('Amount', NewEPaymentEntry."Shipment Amount EXP");
                    RequestObject.Add('CurrencyCode', SalesShptHeader."Currency Code");
                    RequestObject.Add('TransactionId', NewEPaymentEntry."Transaction ID EXP");
                    if not CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject) then
                        ERROR(
                        TEXT014 +
                        TEXT015,
                        NewEPaymentEntry."Transaction ID EXP",
                        NewEPaymentEntry."e-payment Provider Code EXP",
                        ErrorDescription);
                    NewEPaymentEntry."Captured Amount EXP" := NewEPaymentEntry."Shipment Amount EXP";
                    NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Captured;
                    NewEPaymentEntry."Payment Posting Date EXP" := PostingDate;
                    NewEPaymentEntry.Modify();
                end;
        // EIS6.0.16 end
    end;

    /// <summary>
    /// PostSalesInvoiceModifyLine.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    /// <param name="SalesInvHeader">Record "Sales Invoice Header".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure PostSalesInvoiceModifyLine(SalesHeader: Record "Sales Header"; SalesInvHeader: Record "Sales Invoice Header"): Boolean;
    begin
        SalesHeader.TESTFIELD("e-payment Provider Code EXP");
        SalesHeader.TESTFIELD("e-payment Clearing OK EXP");
        SalesHeader.TESTFIELD("Applies-to ID", '');
        //SalesHeader.TESTFIELD("Bal. Account No.");
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            NewEPaymentEntry.RESET;
            NewEPaymentEntry.SETCURRENTKEY("Document Type EXP", "Document No. EXP");
            NewEPaymentEntry.SETRANGE("Document Type EXP", SalesHeader."Document Type");
            NewEPaymentEntry.SETRANGE("Document No. EXP", SalesHeader."No.");
            NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesHeader."e-payment Provider Code EXP");
            NewEPaymentEntry.FindLast();
            //EIS6.0.16 begin
            //if NewEPaymentEntry."Status EXP" = NewEPaymentEntry."Status EXP"::Dismissed then
            //    NewEPaymentEntry.FieldError("Status EXP");
            //Set status to Ready To Capture if it is not already captured
            if NewEPaymentEntry."Status EXP" <> NewEPaymentEntry."Status EXP"::Captured then begin
                if NewEPaymentEntry."Status EXP" in [NewEPaymentEntry."Status EXP"::Cleared, NewEPaymentEntry."Status EXP"::"Ready to Capture"] then begin
                    if NewEPaymentEntry."Status EXP" = NewEPaymentEntry."Status EXP"::Cleared then
                        NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::"Ready to Capture";
                    NewEPaymentEntry."Invoice No. EXP" := SalesInvHeader."No.";
                    SalesInvHeader.CalcFields("Amount Including VAT");
                    NewEPaymentEntry."Invoiced Amount EXP" := SalesInvHeader."Amount Including VAT";
                    NewEPaymentEntry."Invoice Posting Date EXP" := SalesInvHeader."Posting Date";
                    //Sales Orders from the web site have already been charged
                    if ExpandITOrderHeaderExists(SalesHeader."External Document No.", SalesHeader."Sell-to Customer No.") then begin
                        NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Captured;
                        NewEPaymentEntry."Captured Amount EXP" := SalesInvHeader."Amount Including VAT";
                        NewEPaymentEntry."Payment Posting Date EXP" := SalesInvHeader."Posting Date";
                    end;
                    NewEPaymentEntry.MODIFY(True);
                end;
            end;
            //EIS6.0.16 end
            exit(InternetShopSetup."Batch Capture EXP");
        end;
    end;

    /// <summary>
    /// PostSalesInvoiceCapture.
    /// </summary>
    /// <param name="SalesInvHeader">Record "Sales Invoice Header".</param>
    /// <param name="PostingDate">Date.</param>
    procedure PostSalesInvoiceCapture(SalesInvHeader: Record "Sales Invoice Header"; PostingDate: Date);
    var
        RequestObject: JsonObject;
        RequestUri: Text[250];
        ErrorDescription: Text;
        ResponseObject: JsonObject;
        SalesHeader: Record "Sales Header";
    begin
        NewEPaymentEntry.Reset;
        NewEPaymentEntry.SETCURRENTKEY("Invoice No. EXP");
        NewEPaymentEntry.SETRANGE("Invoice No. EXP", SalesInvHeader."No.");
        NewEPaymentEntry.SETRANGE("e-payment Provider Code EXP", SalesInvHeader."e-payment Provider Code EXP");
        NewEPaymentEntry.FindLast();
        // EIS6.0.16 begin 
        if NewEPaymentEntry."Status EXP" <> NewEPaymentEntry."Status EXP"::Captured then
            if NewEPaymentEntry."Status EXP" in [NewEPaymentEntry."Status EXP"::Cleared, NewEPaymentEntry."Status EXP"::"Ready to Capture"] then
                if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
                    RequestUri := ExpandITUtil."TrimExpandITURL"(InternetShopSetup."Local Shop URL EXP") + 'api/EpaymentApi/capturetransaction';
                    EPaymentProvider.GET(NewEPaymentEntry."e-payment Provider Code EXP");
                    RequestObject.Add('Simulation', InternetShopSetup."Simulation EXP");
                    RequestObject.Add('Provider', FORMAT(EPaymentProvider."Provider Type EXP"));
                    RequestObject.Add('MerchantId', EPaymentProvider."Merchant ID EXP");
                    RequestObject.Add('UserName', EPaymentProvider."Login User ID EXP");
                    RequestObject.Add('Password', EPaymentProvider."Password EXP");
                    RequestObject.Add('SharedSecret', EPaymentProvider."Shared Secret EXP");
                    RequestObject.Add('OrderNo', NewEPaymentEntry."Cleared Order No. EXP");
                    RequestObject.Add('Amount', NewEPaymentEntry."Invoiced Amount EXP");
                    RequestObject.Add('CurrencyCode', SalesInvHeader."Currency Code");
                    RequestObject.Add('TransactionId', NewEPaymentEntry."Transaction ID EXP");
                    if not CallWebService(RequestObject, RequestUri, ErrorDescription, ResponseObject) then
                        ERROR(
                        TEXT014 +
                        TEXT015,
                        NewEPaymentEntry."Transaction ID EXP",
                        NewEPaymentEntry."e-payment Provider Code EXP",
                        ErrorDescription);
                    NewEPaymentEntry."Captured Amount EXP" := NewEPaymentEntry."Invoiced Amount EXP";
                    NewEPaymentEntry."Status EXP" := NewEPaymentEntry."Status EXP"::Captured;
                    NewEPaymentEntry."Payment Posting Date EXP" := PostingDate;
                    NewEPaymentEntry.Modify();
                end;
        // EIS6.0.16 end
    end;

    local procedure ExpandITOrderHeaderExists(CustRefNo: Code[20]; SellToCustNo: Code[20]): Boolean;
    var
        ExpandITOrderHeader: Record "ExpandIT Order Header EXP";
    begin
        ExpandITOrderHeader.SetRange("Customer Reference No. EXP", CustRefNo);
        ExpandITOrderHeader.SetRange("Sell-to Customer No. EXP", SellToCustNo);
        exit(ExpandITOrderHeader.FindFirst());
    end;

    /// <summary>
    /// OnAfterPostSalesLines.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    /// <param name="SalesShipmentHeader">VAR Record "Sales Shipment Header".</param>
    /// <param name="SalesInvoiceHeader">VAR Record "Sales Invoice Header".</param>
    /// <param name="SalesCrMemoHeader">VAR Record "Sales Cr.Memo Header".</param>
    /// <param name="ReturnReceiptHeader">VAR Record "Return Receipt Header".</param>
    /// <param name="WhseShip">Boolean.</param>
    /// <param name="WhseReceive">Boolean.</param>
    /// <param name="SalesLinesProcessed">VAR Boolean.</param>
    /// <param name="CommitIsSuppressed">Boolean.</param>
    /// <param name="EverythingInvoiced">Boolean.</param>
    /// <param name="TempSalesLineGlobal">Temporary VAR Record "Sales Line".</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', true, true)]
    procedure OnAfterPostSalesLines(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; WhseShip: Boolean; WhseReceive: Boolean; var SalesLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    begin
        CaptureEPayment := (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) AND
                           (SalesHeader."e-payment Provider Code EXP" <> '') AND SalesHeader."e-payment Clearing OK EXP";
        if CaptureEPayment then
            BatchCaptureVar := PostSalesShipmentModifyLine(SalesHeader, SalesShipmentHeader);
    end;

    /// <summary>
    /// OnAfterPostGLAndCustomer.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    /// <param name="GenJnlPostLine">VAR Codeunit "Gen. Jnl.-Post Line".</param>
    /// <param name="TotalSalesLine">Record "Sales Line".</param>
    /// <param name="TotalSalesLineLCY">Record "Sales Line".</param>
    /// <param name="CommitIsSuppressed">Boolean.</param>
    /// <param name="WhseShptHeader">Record "Warehouse Shipment Header".</param>
    /// <param name="WhseShip">Boolean.</param>
    /// <param name="TempWhseShptHeader">VAR Record "Warehouse Shipment Header".</param>
    /// <param name="SalesInvHeader">VAR Record "Sales Invoice Header".</param>
    /// <param name="SalesCrMemoHeader">VAR Record "Sales Cr.Memo Header".</param>
    /// <param name="CustLedgEntry">VAR Record "Cust. Ledger Entry".</param>
    /// <param name="SrcCode">VAR Code[10].</param>
    /// <param name="GenJnlLineDocNo">Code[20].</param>
    /// <param name="GenJnlLineExtDocNo">Code[35].</param>
    /// <param name="GenJnlLineDocType">VAR Enum "Gen. Journal Document Type".</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostGLAndCustomer', '', true, true)]
    procedure OnAfterPostGLAndCustomer(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; TotalSalesLine: Record "Sales Line"; TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean;
        WhseShptHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var SalesInvHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var CustLedgEntry: Record "Cust. Ledger Entry"; var SrcCode: Code[10]; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; var GenJnlLineDocType: Enum "Gen. Journal Document Type")
    begin
        CaptureEPayment := (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) AND
                           (SalesHeader."e-payment Provider Code EXP" <> '') AND SalesHeader."e-payment Clearing OK EXP";
        if CaptureEPayment then begin
            BatchCaptureVar := PostSalesInvoiceModifyLine(SalesHeader, SalesInvHeader);
            // EIS5.04.05.01 end            
        end;
    end;

    /// <summary>
    /// FinalizePosting.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    /// <param name="SalesShipmentHeader">VAR Record "Sales Shipment Header".</param>
    /// <param name="SalesInvoiceHeader">VAR Record "Sales Invoice Header".</param>
    /// <param name="SalesCrMemoHeader">VAR Record "Sales Cr.Memo Header".</param>
    /// <param name="ReturnReceiptHeader">VAR Record "Return Receipt Header".</param>
    /// <param name="GenJnlPostLine">VAR Codeunit "Gen. Jnl.-Post Line".</param>
    /// <param name="CommitIsSuppressed">Boolean.</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeFinalizePosting', '', true, true)]
    procedure FinalizePosting(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean)
    var
        InternetShopSetup: Record "ExpandIT Setup EXP";
    begin
        InternetShopSetup.FindFirst();
        CaptureEPayment := (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) AND
                          (SalesHeader."e-payment Provider Code EXP" <> '') AND SalesHeader."e-payment Clearing OK EXP";
        if CaptureEPayment then begin
            BatchCaptureVar := InternetShopSetup."Batch Capture EXP";
            // EIS5.04.05.01 end            
        end;
        if not ExpandITOrderHeaderExists(SalesHeader."External Document No.", SalesHeader."Sell-to Customer No.") then begin
            if CaptureEPayment then begin
                SalesHeader."e-payment Provider Code EXP" := '';
                SalesHeader."e-payment Clearing OK EXP" := false;
            end;
            if CaptureEPayment AND NOT BatchCaptureVar then begin
                if SalesInvoiceHeader."No." <> '' then
                    PostSalesInvoiceCapture(SalesInvoiceHeader, SalesInvoiceHeader."Posting Date");
                if SalesShipmentHeader."No." <> '' then
                    PostSalesShipmentCapture(SalesShipmentHeader, SalesShipmentHeader."Posting Date");
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Payment Terms Code', True, true)]
    local procedure PopulateAuthNet(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        PaymentTerms: Record "Payment Terms";
    begin
        If PaymentTerms.GET(Rec."Payment Terms Code") then
            IF PaymentTerms."Credit Card DTP" then begin
                //todo
                rec.Validate("Payment Method Code", 'AUTHNET');
                rec.Validate("e-payment Provider Code EXP", 'AUTHNET');
                //todo
            end else
                if (rec."e-payment Provider Code EXP" <> '') or (rec."e-payment Clearing OK EXP") then begin
                    rec.VALIDATE("e-payment Provider Code EXP", '');
                    rec.VALIDATE("e-payment Clearing OK EXP", false);
                end;
    end;
}