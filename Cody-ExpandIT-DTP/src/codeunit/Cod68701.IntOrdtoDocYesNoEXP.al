/// <summary>
/// Codeunit Int Ord to Doc(Yes/No) EXP (ID 68701).
/// </summary>
codeunit 68701 "Int Ord to Doc(Yes/No) EXP"
{
    // version EIS6.0.12 // EIS6.0.12 2020-09-10 FAM * Get ExpandIT Setup record
    // EIS2.02     2007-05-22  JR  * Parameter TotalAdjCostLCY added to call to SumSaleslines.
    // 
    // EIS4.01     2010-09-03  JR  * Code regions introduced for backward compatibility.
    // 
    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EIS6.0.12 2020-09-10 FAM * Get ExpandIT Setup record
    TableNo = "ExpandIT Order Header EXP";

    trigger OnRun();
    var
        i: Integer;
        ExpandITUtil: Codeunit "ExpandIT Util";
    begin
        Rec.TESTFIELD("Customer Reference No. EXP");
        Rec.TESTFIELD("Status EXP", Rec."Status EXP"::New);
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12           
            if not CONFIRM(
                     TEXT000,
                     true, FORMAT(InternetShopSetup."Convert To Document Type"))
            then
                exit;
            //
            // Which customer should we use?
            //
            //if not Customer.GET(Rec."Sell-to Customer No. EXP") then
            IF (Rec."Sell-to Customer No. EXP" = 'INET') or (Rec."Sell-to Customer No. EXP" = 'INET2') or
                (Rec."Sell-to Customer No. EXP" = '') THEN
                Rec."Sell-to Customer No. EXP" := SelectSellToCustNo(Rec);
            //
            // Convert Value from Shop to appropriate value in BC
            // begin-->
            if (rec."Shipping Handling Provider EXP" = 'UPS') or (rec."Shipping Handling Provider EXP" = 'GROUND UPS') then
                //rec."Shipping Handling Provider EXP" := 'UPS GROUND';
                rec."Shipping Handling Provider EXP" := 'UPS';
            // <--end
            CODEUNIT.RUN(CODEUNIT::"Int Order to Sales-Doc. EXP", Rec);
            COMMIT;
            //
            // Send Confirmation Mail
            //
            if InternetShopSetup."Notify on Conv to Doc. EXP" then
                if Rec."Bill-to E-Mail EXP" <> '' then
                    InternetShopMgt.InternetOrderConverted(Rec."Bill-to E-Mail EXP", Rec."Order Guid EXP")
                else begin
                    if InternetCustomer.GET(Rec."Bill-to Net Customer No. EXP") then begin
                        InternetCustomer.TESTFIELD("E-Mail EXP");
                        InternetShopMgt.InternetOrderConverted(InternetCustomer."E-Mail EXP", Rec."Order Guid EXP");
                    end else
                        if Customer.GET(Rec."Sell-to Customer No. EXP") then
                            if Customer."E-Mail" <> '' then
                                InternetShopMgt.InternetOrderConverted(Customer."E-Mail", Rec."Order Guid EXP");
                end;
            CLEAR(SalesPost);
            SalesHeader.GET(Rec."Converted-To Document Type EXP", Rec."Converted-To Document No. EXP");
            //
            // DTP Sales Tax Module
            // begin-->
            SalesHeader.CalcFields("Amount Including VAT");
            // <--end
            // #STARTREGION: REMOVE IN 4.00
            /*
            SalesPost.SumSalesLines(
              SalesHeader,
              0, TotalSalesLine, TotalSalesLineLCY,
              VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);
            */
            // #ENDREGION: REMOVE IN 4.00
            // #STARTREGION: REMOVE IN 4.00
            /*
            // #ENDREGION: REMOVE IN 4.00
            SalesPost.SumSalesLines(
              SalesHeader,
              0,TotalSalesLine,TotalSalesLineLCY,
              VATAmount,VATAmountText,ProfitLCY,ProfitPct);
            // #STARTREGION: REMOVE IN 4.00
            */
            // #ENDREGION: REMOVE IN 4.00
            /*
            if ROUND(Rec."Amount Including Tax EXP", 2) <> ROUND(TotalSalesLine."Amount Including VAT", 2) then
                MESSAGE(
                  TEXT001,
                  Rec.TABLENAME, SalesHeader.TABLENAME);
            */
            //
            // Finalize
            //
            if InternetShopSetup."Show Doc After Conversion EXP" then begin
                case Rec."Converted-To Document Type EXP" of
                    Rec."Converted-To Document Type EXP"::Quote:
                        PAGE.RUN(PAGE::"Sales Quote", SalesHeader);
                    Rec."Converted-To Document Type EXP"::Order:
                        PAGE.RUN(PAGE::"Sales Order", SalesHeader);
                    Rec."Converted-To Document Type EXP"::Invoice:
                        PAGE.RUN(PAGE::"Sales Invoice", SalesHeader);
                end;
            end else
                MESSAGE(
                  TEXT002,
                  Rec."Converted-To Document Type EXP", Rec."Converted-To Document No. EXP", Rec."Customer Reference No. EXP");
        end else
            error(ExpandItSetupError); // EMSM18.0.6.193
    end;

    var
        ExpandITUtil: Codeunit "ExpandIT Util";
        SalesHeader: Record "Sales Header";
        InternetOrderLine: Record "ExpandIT Order Line EXP";
        InternetShopSetup: Record "ExpandIT Setup EXP";
        Customer: Record Customer;
        TotalSalesLine: Record "Sales Line";
        TotalSalesLineLCY: Record "Sales Line";
        InternetCustomer: Record "Internet Customer EXP";
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        SalesPost: Codeunit "Sales-Post";
        VATAmount: Decimal;
        VATAmountText: Text[30];
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        TEXT000: Label 'Do you want to convert the Internet order to a sales %1?', Comment = 'DAN="Vil du overføre Internet-ordren til en salgs %1?",DEU="Wünschen Sie die Internetbestellung in einen Verkauf %1 umzuwandeln?",ESP="¿Desea convertir el pedido de Internet a Ventas %1?",FRA="Voulez-vous convertir la commande Internet en %1 ?",SVE="Vill du omvandla Internet ordern till en försäljnings%1?"';
        TEXT001: Label 'Warning: Total amount on the %1 is different from total amount on the %2.', Comment = 'DAN="Advarsel: Total på %1 er forskellig fra total på %2.",DEU="Warnung: Der Gesamtbetrag für %1 ist ungleich zum Gesamtbetrag für %2.",ESP="Atención: Importe total en %1 no coincide con importe total en %2.",FRA="Attention : Le montant total sur la %1 est différent du montant total de la %2.",SVE="Varning: Totalt belopp på %1 är olika jämfört med totalt belopp på %2."';
        TEXT002: Label 'Sales %1 %2 has been created from internet order %3.', Comment = 'DAN="Salgs %1 %2 er blevet oprettet fra internet ordre %3.",DEU="Verkäufe %1 %2 wurden von Internetbestellung %3 erzeugt.",ESP="Venta %1 %2 creada desde pedido internet  %3.",FRA="La commande Internet %3 a éét converti en %1 %2.",SVE="Försäljning %1 %2 har skapats från internet order %3."';
        TEXT003: Label 'Do you want to create/select a %1 for the %2?\', Comment = 'DAN="Vil du oprette/knytte en %1 til %2?\",DEU="Wünschen Sie einen %1 zu erstellen/auszuwählen für %2?\",ESP="¿Desea crear/seleccionar %1 para %2?\",FRA="voulez-vous créer/sélectioner un %1 pour le %2 ?",SVE="Vill du skapa/välja en %1 för %2?\"';
        TEXT004: Label 'If you choose no, the cash customer selected in setup, will be used.', Comment = 'DAN="Hvis du vælger nej vil kontant-salgs kunden, valgt i Internet Shop opsætning blive benyttet.",DEU="Wenn Sie nein wählen, wird der im Setup festgelegte Bar-Kunde genutzt.",ESP="Si elige no, se usarán los datos de cliente preseleccionado en configuración ExpandIT.",FRA="Si vous choissez Non, le client éspece choisi dans la configuration, sera utilisé.",SVE="Om du väljer nej, kommer kontantkunden att användas."';
        TEXT005: Label 'It was not possible to determine which %1 to use for the Sales Order', Comment = 'DAN="Det var ikke mulig at bestemme hvilken %1 der skulle bruges på salgs ordren.",DEU="Es war nicht möglich zu bestimmen, welcher %1 für die Verkaufsbestellung zu nutzen ist.",ESP="No fue possible determinar qué %1 utilizar para el Pedido de Venta",FRA="Il n"';
        TotalAdjCostLCY: Decimal;
        ExpandItSetupError: Label 'Setup is empty', comment = 'ESP="", DAN="ExpandIT Opsætning er tom", DEU="", FRA="", SVE=""';

    /// <summary>
    /// SelectSellToCustNo.
    /// </summary>
    /// <param name="Rec">VAR Record "ExpandIT Order Header EXP".</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure SelectSellToCustNo(var Rec: Record "ExpandIT Order Header EXP"): Code[20];
    var
        CustNo: Code[20];
        recInternetCustomer: Record "Internet Customer EXP";
        recCustomer: Record Customer;
        cuUserManagement: Codeunit "User Management DTP";
    begin
        CustNo := '';

        if not recInternetCustomer.GET(Rec."Bill-to Net Customer No. EXP") then begin
            //Anonymous Internet Customer
            if (InternetShopSetup."Use Internet Customer EXP" = InternetShopSetup."Use Internet Customer EXP"::Always) then begin
                CustNo := UseInternetCustomer;
            end else begin
                CustNo := cuUserManagement.CreateCustomerFromOrder(Rec);
            end;
        end;

        IF CustNo = '' then begin
            // B2B or B2c iNTERNET cUSTOMER
            case InternetShopSetup."Use Internet Customer EXP" of
                InternetShopSetup."Use Internet Customer EXP"::Always:
                    begin
                        CustNo := UseInternetCustomer;
                    end;

                InternetShopSetup."Use Internet Customer EXP"::"If No Customer Relation":
                    begin
                        if cuUserManagement.GetSalesCustomer(recInternetCustomer) = '' then
                            CustNo := UseInternetCustomer
                        else
                            CustNo := UseExistingCustomerEx(recInternetCustomer);
                    end;

                InternetShopSetup."Use Internet Customer EXP"::"By Request":
                    begin
                        if cuUserManagement.GetSalesCustomer(recInternetCustomer) = '' then begin
                            if CONFIRM(
                                 TEXT003 +
                                 TEXT004, true,
                                 Customer.TABLENAME,
                                 InternetCustomer.TABLENAME)
                            then
                                CustNo := cuUserManagement.CreateCustomerFromOrder(Rec)
                            else
                                CustNo := UseInternetCustomer
                        end
                        else begin
                            CustNo := UseExistingCustomerEx(recInternetCustomer);

                        end;
                    end;

                InternetShopSetup."Use Internet Customer EXP"::Never:
                    begin
                        if cuUserManagement.GetSalesCustomer(recInternetCustomer) = '' then begin
                            CustNo := cuUserManagement.CreateCustomerFromOrder(Rec)
                        end
                        else begin
                            CustNo := UseExistingCustomerEx(recInternetCustomer);
                        end;
                    end;
            end;
        end;


        if CustNo = '' then
            ERROR(TEXT005, Customer.TABLENAME);
        exit(CustNo);

    end;

    local procedure UseInternetCustomer(): Code[20];
    begin
        InternetShopSetup.TESTFIELD("Internet Customer EXP");
        exit(InternetShopSetup."Internet Customer EXP");
    end;

    local procedure CreateNewCustomer(): Code[20];
    begin
        InternetCustomer.CreateCustomer;
        exit(InternetCustomer.GetSalesCustomer);
    end;

    local procedure UseExistingCustomer(): Code[20];
    begin
        exit(InternetCustomer.GetSalesCustomer);
    end;

    local procedure UseExistingCustomerEx(Var recInternetCustomer: Record "Internet Customer EXP"): Code[20];
    var
        cuUserManagement: Codeunit "User Management DTP";
    begin
        exit(cuUserManagement.GetSalesCustomer(recInternetCustomer));
    end;

    /// <summary>
    /// SendNotifyMail.
    /// </summary>
    procedure SendNotifyMail();
    begin
    end;
}

