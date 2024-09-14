/// <summary>
/// Codeunit Int Order to Sales-Doc. EXP (ID 68702).
/// </summary>
codeunit 68702 "Int Order to Sales-Doc. EXP"
{
    // version EIS6.0.12,EMI2.13,EPAY1.3
    // EIS2.02     2007-05-25  JR  * Manual transfer of e-payment fields after the field numbers were changed in table 36.
    //                             * Quantities on sales lines are now reserved. Call to Salesline.Autoreserve added.
    // 
    // EIS3.00     2008-04-21  JR  * Clear the currency code on the salesheader if it matches the default currency.
    //                             * A key is set when transferring the lines so that the order of the lines is preserved.
    //                             * The "Quantity to Ship" is no longer set by default.
    //                             * Setting the product variant has been moved up in the code.
    //                             * Order lines without item number is handled as a comment line.
    // 
    // EIS3.01     2009-01-14  JR  * Salesline.Autoreserve was not called as stated in comment from 2007-05-25.
    //                               In case it was removed by accident it has now been reintroduced as a comment.
    // EIS3.02     2009-04-08  JR  * SalesHeader."Prices Including VAT" is now set by the ExpandIT Sales Order record.
    //                             * Unit prices and line amounts are set based on the "Prices Including VAT" setting on the header.
    //                             * Amount field is no longer set. Line Amount is set instead to fix a rounding problem.
    // 
    // EIS4.00     2010-06-23  JR  * Only calculate sales line discount if the line count is greater than zero.
    //                             * Fix: Shipping, handling, and e-payment fees failed if no lines existed on the order.
    // 
    // EIS4.01.02  2011-03-25  PB  * Added "Shipping Amount Including Tax","Handling Amount Including Tax",
    //                               "Payment Fee Amount Incl. Tax" in order to support VAT on finance changes.
    //             2011-05-06  PB  * Changed a TRANSFERFIELDS into a funktion in order to avoid texts too long from
    //                               ExpandIT Order Header.
    // 
    // NEXT        2011-10-06  PB *  Fill in Bill-to address from the ExpandIT Order only if it is a B2C customer
    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EIS5.04.03  2018-02-23  FAM * Unit Of Measure fix added (Tag EIS5.04.03).
    // EIS5.04.04  2018-02-23  FAM * SalesPerson Code fix. (Tag EIS5.04.04).
    // EIS5.04.05  2018-07-18  FAM * Your Reference must be set after the order and the order line are created.
    //                               This is to make sure that the order isn't sent before the complete content is on the sales order.
    // EIS6.0.10  2020-04-17 FAM * Sales origin added
    // EIS6.0.11 2020-07-20 FAM * New Epayment Service implemented
    // EIS6.0.12 2020-09-10 FAM * Get ExpandIT Setup record

    TableNo = "ExpandIT Order Header EXP";

    trigger OnRun();
    var
        i: Integer;
        ExpandITUtil: Codeunit "ExpandIT Util";
    begin
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin  // EIS6.0.12
            LastError := '';
            if (Rec."Customer Reference No. EXP" = '') then doError(Rec.FIELDNAME("Customer Reference No. EXP") + TEXT000);
            if (Rec."Status EXP" <> Rec."Status EXP"::New) then doError(Rec.FIELDNAME("Status EXP") + TEXT001);
            if (Rec."Sell-to Customer No. EXP" = '') then doError(TEXT002 + Rec.FIELDNAME("Sell-to Customer No. EXP") + '.');
            //
            // Create Sales Header
            //
            SalesHeader.INIT;
            // Select Document Type.
            case Rec."Document Type EXP" of
                '':
                    SalesHeader."Document Type" := InternetShopSetup."Convert To Document Type";
                //'Quote':
                '0':
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
                //'Order':
                '1':
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                //'Invoice':
                '2':
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                else
                    LastError := TEXT003 + Rec."Document Type EXP";
                    ERROR(LastError);
            end;
            // Create new number for Sales Order
            InternetShopSetup.TESTFIELD("New Sales Document Nos. EXP");
            CLEAR(NoSeriesMgt);
            SalesHeader."No." := NoSeriesMgt.GetNextNo(InternetShopSetup."New Sales Document Nos. EXP", 0D, true);
            SalesHeader."No. Series" := InternetShopSetup."New Sales Document Nos. EXP";
            SalesLine.LOCKTABLE;
            SalesHeader.INSERT(true);
            SalesHeader.VALIDATE("Sell-to Customer No.", Rec."Sell-to Customer No. EXP");
            CopyExpOrderAddrToSalesHdr(Rec, SalesHeader);
            SalesHeader."Prices Including VAT" := Rec."Prices Including VAT EXP";
            // Make sure that Validataion dialogs are not shown when changing dates.
            SalesHeader.SetHideValidationDialog(true);
            // Remove the currency code from the imported order if it matches the default NAV currency
            if Rec."Currency Code EXP" = InternetShopSetup."Internet Default Curr Code EXP" then
                CLEAR(SalesHeader."Currency Code");
            SalesHeader.VALIDATE("Posting Date", Rec."Order Date EXP");
            SalesHeader.VALIDATE("Order Date", Rec."Order Date EXP");
            SalesHeader.VALIDATE("Document Date", Rec."Order Date EXP");
            SalesHeader.VALIDATE("Shipment Date", Rec."Shipment Date EXP");
            // Set the location code.
            if Rec."Inventory Location EXP" <> '' then
                SalesHeader.VALIDATE("Location Code", Rec."Inventory Location EXP");
            //EIS5.04.04 begin
            if Rec."Salesperson Code EXP" = '' then begin
                if SalesHeader."Salesperson Code" = '' then
                    SalesHeader.VALIDATE("Salesperson Code", InternetShopSetup."Sales Person Code EXP");
            end
            else
                SalesHeader.VALIDATE("Salesperson Code", Rec."Salesperson Code EXP");
            //EIS5.04.04 end

            //Modifications for Sales Tax
            SalesHeader.Validate("Tax Area Code", rec."Tax Area Code DTP");
            SalesHeader.Validate("Tax Liable", rec."Tax Liable DTP");

            // The following line was removed in EIS3.01 because this field is now
            // transferred from the ExpandIT Sales Order record.
            SalesHeader."Prices Including VAT" := FALSE;
            if Rec."Currency Code EXP" = InternetShopSetup."Internet Default Curr Code EXP" then
                SalesHeader.VALIDATE("Currency Code", '')
            else
                SalesHeader.VALIDATE("Currency Code", Rec."Currency Code EXP");

            if Rec."Payment Type EXP" <> '' then begin
                PaymentMethod.GET(Rec."Payment Type EXP");
                SalesHeader.VALIDATE("Payment Method Code", PaymentMethod.Code);
            end;

            If (rec."Shipping Handling Provider EXP" <> '') and (rec."Shipping Handling Provider EXP" <> 'NONE') THEN
                SalesHeader.VALIDATE("Shipping Agent Code", Rec."Shipping Handling Provider EXP");

            IF Rec."Shipping Handling Provider EXP" <> '' THEN BEGIN
                SalesHeader.VALIDATE("Shipping Agent Code", Rec."Shipping Handling Provider EXP");
                //SalesHeader.VALIDATE("Shipping Agent Service Code", ParmRec."Shipping Service code");

            END;
        END;

        SalesHeader."External Document No." := rec."Customer P.O. No. EXP";
        SalesHeader."Web Order No. DTP" := Rec."Customer Reference No. EXP";
        SalesHeader.Validate(SalesHeader."Sales Origin EXP", Rec."Sales Origin EXP"); // EIS6.0.10 

        // Transfer e-payment fields
        if rec."Payment Type EXP" = 'AUTHNET' THEN begin
            SalesHeader."e-payment Provider Code EXP" := Rec."e-payment Provider Code EXP";
            SalesHeader."e-payment Clearing OK EXP" := Rec."e-payment Clearing OK EXP";
        end;

        SalesHeader.MODIFY;
        //
        // Create Sales Lines
        //
        LineNo := 0;
        InternetOrderLine.RESET;
        InternetOrderLine.SETRANGE("Order Guid EXP", Rec."Order Guid EXP");
        InternetOrderLine.SETCURRENTKEY("Order Guid EXP", "Line No. EXP");
        if InternetOrderLine.FIND('-') then
            repeat
                clear(SalesLine);
                LineNo += 10000;
                SalesLine."Line No." := SalesLine."Line No." + LineNo;
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";

                if (InternetOrderLine."Item No. EXP" <> '') and item.get(InternetOrderLine."Variant Code EXP") then begin
                    SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                    //Handle Master Items
                    SalesLine.Validate("No.", InternetOrderLine."Variant Code EXP");
                end else
                    if SalesLine."No." = '' then
                        if InternetOrderLine."Item No. EXP" <> '' then begin
                            if Item.GET(InternetOrderLine."Item No. EXP") then begin
                                SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                                Salesline.Validate("No.", InternetOrderLine."Item No. EXP");
                                if ItemVariant.get(InternetOrderLine."Item No. EXP", InternetOrderLine."Variant Code EXP") then
                                    SalesLine.Validate("Variant Code", InternetOrderLine."Variant Code EXP");
                            end;
                        end;

                if SalesLine."No." <> '' then begin

                    IF (InternetOrderLine."Variant Code EXP" <> '') THEN BEGIN
                        IF NOT Item.GET(InternetOrderLine."Variant Code EXP") THEN
                            doError(STRSUBSTNO(LTXT004, InternetOrderLine."Variant Code EXP",
                                                        InternetOrderLine."Item No. EXP",
                                                        Rec."Customer Reference No. EXP"));
                    END
                    ELSE BEGIN
                        IF NOT Item.GET(InternetOrderLine."Item No. EXP") THEN
                            doError(STRSUBSTNO(LTXT003, InternetOrderLine."Item No. EXP",
                                                        Rec."Customer Reference No. EXP"));
                    END;
                    // >> EXP03
                    IF ItemUOM.GET(Item."No.", InternetOrderLine."Unit of Measure Code EXP") THEN
                        SalesLine.VALIDATE("Unit of Measure Code", InternetOrderLine."Unit of Measure Code EXP")
                    ELSE
                        SalesLine.VALIDATE("Unit of Measure Code", Item."Sales Unit of Measure");
                    // << EXP03
                    //EIS5.04.03 begin
                    //SalesLine.VALIDATE("Unit of Measure Code", InternetOrderLine."Unit of Measure Code EXP");
                    //EIS5.04.03 end

                    SalesLine.VALIDATE(Quantity, InternetOrderLine."Quantity EXP");

                    //EXP02 - START
                    IF InternetOrderLine."Location Code DTP" <> '' THEN
                        SalesLine.VALIDATE("Location Code", InternetOrderLine."Location Code DTP")
                    ELSE
                        IF InternetShopSetup."Default Location Code" = '' THEN
                            SalesLine.VALIDATE("Location Code", InternetShopSetup."Default Location Code");
                    //EXP02 - END

                    // Set the Qty. to Ship based on "Quantity Shipped" if it is a Mobile Sales order
                    if Rec."Bill-to Net Customer No. EXP" = '' then
                        SalesLine.VALIDATE(SalesLine."Qty. to Ship", InternetOrderLine."Quantity Shipped EXP");

                    SalesLine.Validate("Unit Price", InternetOrderLine."Unit Price EXP");

                    IF InternetOrderLine."Line Discount % EXP" <> 0 then
                        SalesLine.VALIDATE(SalesLine."Line Discount %", InternetOrderLine."Line Discount % EXP");
                    //if Rec."Prices Including VAT EXP" then begin
                    //    if InternetOrderLine."Amount Including Tax EXP" <> 0 then begin
                    //        if SalesLine."Unit Price" = 0 then
                    //            SalesLine.Validate("Unit Price", Round(InternetOrderLine."Amount Including Tax EXP" / SalesLine.Quantity, 0.01));
                    //        SalesLine.VALIDATE("Line Amount", InternetOrderLine."Amount Including Tax EXP");
                    //    end
                    //end else begin
                    //    if InternetOrderLine."Amount EXP" <> 0 then begin
                    //        if SalesLine."Unit Price" = 0 then
                    //            SalesLine.Validate("Unit Price", Round(InternetOrderLine."Amount EXP" / SalesLine.Quantity, 0.01));
                    //        SalesLine.VALIDATE("Line Amount", InternetOrderLine."Amount EXP");
                    //    end;
                    //end;
                end
                else begin // When no item number is specified the line is treated as a comment.
                    SalesLine.VALIDATE(Type, SalesLine.Type::" ");
                    SalesLine.VALIDATE(Description, InternetOrderLine."Description EXP");
                    case true of
                        (InternetOrderLine."Item No. EXP" <> '') and (InternetOrderLine."Variant Code EXP" <> ''):
                            SalesLine."Description 2" := InternetOrderLine."Item No. EXP" + ' ' + InternetOrderLine."Variant Code EXP";
                        (InternetOrderLine."Item No. EXP" <> ''):
                            SalesLine."Description 2" := InternetOrderLine."Item No. EXP";
                        (InternetOrderLine."Variant Code EXP" <> ''):
                            SalesLine."Description 2" := InternetOrderLine."Variant Code EXP";
                    end;
                end;

                SalesLine.INSERT(true);
            // SalesLine.AutoReserve();
            until InternetOrderLine.NEXT = 0;
        // Shipping
        //if (Rec."Shipping Amount EXP" <> 0) then begin
        //    CustPostingGr.GET(SalesHeader."Customer Posting Group");
        //    CustPostingGr.TESTFIELD("Additional Fee Account");
        //    SalesLine.RESET;
        //    SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        //    SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        //    if SalesLine.FIND('+') then lastLineNo := SalesLine."Line No." else lastLineNo := 0;
        //    SalesLine.INIT;
        //    SalesLine."Document Type" := SalesHeader."Document Type";
        //    SalesLine."Document No." := SalesHeader."No.";
        //    SalesLine."Line No." := lastLineNo + 10000;
        //    SalesLine.Type := SalesLine.Type::"G/L Account";
        //    SalesLine.VALIDATE("No.", CustPostingGr."Additional Fee Account");
        //    SalesLine.Description := TEXT007;
        //    SalesLine.VALIDATE(Quantity, 1);
        //    if Rec."Prices Including VAT EXP" then
        //        SalesLine.VALIDATE("Unit Price", Rec."Shipping Amt Including Tax EXP")
        //    else
        //        SalesLine.VALIDATE("Unit Price", Rec."Shipping Amount EXP");
        //    SalesLine."Allow Invoice Disc." := false;
        //    SalesLine.INSERT;
        //  end;
        if (Rec."Shipping Amount EXP" <> 0) then begin
            CustPostingGr.GET(SalesHeader."Customer Posting Group");
            //CustPostingGr.TESTFIELD("Additional Fee Account");
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            if SalesLine.FIND('+') then
                lastLineNo := SalesLine."Line No."
            else
                lastLineNo := 0;
            SalesLine.INIT;
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := lastLineNo + 10000;
            //
            Case InternetShopSetup."Freight Account Type" of
                InternetShopSetup."Freight Account Type"::"Charge (Item)":
                    SalesLine.Type := "Sales Line Type"::"Charge (Item)";
                InternetShopSetup."Freight Account Type"::"G/L Account":
                    SalesLine.Type := "Sales Line Type"::"G/L Account";
                InternetShopSetup."Freight Account Type"::Item:
                    SalesLine.Type := "Sales Line Type"::Item;
                InternetShopSetup."Freight Account Type"::Resource:
                    SalesLine.Type := "Sales Line Type"::Resource;
            End;
            SalesLine.VALIDATE("No.", InternetShopSetup."Freight Account No.");
            SalesLine.Validate("Shortcut Dimension 1 Code", InternetShopSetup."Freight Dimension 1 Value");
            SalesLine.Validate("Shortcut Dimension 2 Code", InternetShopSetup."Freight Dimension 2 Value");
            //
            SalesLine.Description := TEXT007;
            SalesLine.VALIDATE(Quantity, 1);
            if Rec."Prices Including VAT EXP" then
                SalesLine.VALIDATE("Unit Price", Rec."Shipping Amt Including Tax EXP")
            else
                SalesLine.VALIDATE("Unit Price", Rec."Shipping Amount EXP");
            SalesLine."Allow Invoice Disc." := false;
            SalesLine.INSERT;
        end;
        // Handling
        if (Rec."Handling Amount EXP" <> 0) then begin
            CustPostingGr.GET(SalesHeader."Customer Posting Group");
            CustPostingGr.TESTFIELD("Service Charge Acc.");
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            if SalesLine.FIND('+') then
                lastLineNo := SalesLine."Line No."
            else
                lastLineNo := 0;
            SalesLine.INIT;
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := lastLineNo + 10000;
            SalesLine.Type := SalesLine.Type::"G/L Account";
            SalesLine.VALIDATE("No.", CustPostingGr."Service Charge Acc.");
            SalesLine.Description := TEXT006;
            SalesLine.VALIDATE(Quantity, 1);
            if Rec."Prices Including VAT EXP" then
                SalesLine.VALIDATE("Unit Price", Rec."Handling Amt Including Tax EXP")
            else
                SalesLine.VALIDATE("Unit Price", Rec."Handling Amount EXP");
            SalesLine."Allow Invoice Disc." := false;
            SalesLine.INSERT;
        end;
        // e-Payment fee
        if (Rec."Payment Fee Amount EXP" <> 0) then begin
            CustPostingGr.GET(SalesHeader."Customer Posting Group");
            CustPostingGr.TESTFIELD("Service Charge Acc.");
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            if SalesLine.FIND('+') then
                lastLineNo := SalesLine."Line No."
            else
                lastLineNo := 0;
            SalesLine.INIT;
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := lastLineNo + 10000;
            SalesLine.Type := SalesLine.Type::"G/L Account";
            SalesLine.VALIDATE("No.", CustPostingGr."Additional Fee Account");
            SalesLine.Description := Rec.FIELDCAPTION("Payment Fee Amount EXP");
            SalesLine.VALIDATE(Quantity, 1);
            if Rec."Prices Including VAT EXP" then
                SalesLine.VALIDATE("Unit Price", Rec."Payment Fee Amt Incl. Tax EXP")
            else
                SalesLine.VALIDATE("Unit Price", Rec."Payment Fee Amount EXP");
            SalesLine."Allow Invoice Disc." := false;
            SalesLine.INSERT;
        end;
        // Calculate Invoice Discounts and Service Charges
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        if SalesLine.FIND('-') then SalesCalcDisc.RUN(SalesLine);
        //
        // Create Clearing Entry
        //
        if Rec."Payment Type EXP" <> '' then
            if PaymentMethod."e-payment Provider Code EXP" <> '' then begin
                // EIS6.0.11 begin
                EpaymentService.InsertClearedSalesHeader(SalesHeader, Rec."Order Date EXP", Rec."Customer Reference No. EXP",
                                                         Rec."Transaction ID EXP", Rec."Amount Including Tax EXP", Rec."Transaction Signature EXP");
                if InternetShopSetup."Test Clearing on Conv. EXP" then
                    EpaymentService.TestClearingSalesHeader(SalesHeader);
                if InternetShopSetup."Get Card Type on Conv. EXP" then
                    EpaymentService.GetCardTypeSalesHeader(SalesHeader);
                if InternetShopSetup."Renew Clearing on Conv EXP" then
                    EpaymentService.RenewClearingSalesHeader(SalesHeader, TODAY);
                // EIS6.0.11 end
                Rec."e-payment Provider Code EXP" := SalesHeader."e-payment Provider Code EXP";
                Rec."e-payment Clearing OK EXP" := SalesHeader."e-payment Clearing OK EXP";
            end;
        Rec."Converted-To Document Type EXP" := SalesHeader."Document Type";
        Rec."Converted-To Document No. EXP" := SalesHeader."No.";
        Rec."Status EXP" := Rec."Status EXP"::Converted;
        InternetOrderLine.MODIFYALL("Status EXP", InternetOrderLine."Status EXP"::Converted);
        Rec.MODIFY;
        if Rec."Comment EXP" <> '' then begin
            SalesCommentLine.SetUpNewLine;
            SalesCommentLine."Document Type" := SalesHeader."Document Type";
            SalesCommentLine."No." := SalesHeader."No.";
            SalesCommentLine.Date := Rec."Order Date EXP";
            SalesCommentLine.SETRANGE(SalesCommentLine."No.", SalesHeader."No.");
            SalesCommentLine."Line No." := (SalesCommentLine.COUNT + 1) * 10000;
            SalesCommentLine.Comment := Rec."Comment EXP";
            SalesCommentLine.INSERT;
        end;
        //EIS5.04.05 - begin
        //SalesHeader."Your Reference" := Rec."Customer P.O. No. EXP";
        SalesHeader.MODIFY;
        //EIS5.04.05 - end

        COMMIT;
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        InternetOrderLine: Record "ExpandIT Order Line EXP";
        InternetShopSetup: Record "ExpandIT Setup EXP";
        PaymentMethod: Record "Payment Method";
        EPaymentProviderCode: Record "e-payment Provider EXP";
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        SalesCommentLine: Record "Sales Comment Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        SalesCalcDisc: Codeunit "Sales-Calc. Discount";
        CustPostingGr: Record "Customer Posting Group";
        LastError: Text[50];
        TEXT000: Label ' must not be empty.', Comment = 'DAN=" må ikke være tomt.",DEU=" sind nicht angemeldet.",ESP="No debe estar vacío.",FRA=" ne doit pas être vide.",SVE=" får inte vara tom."';
        TEXT001: Label '', Comment = 'DAN=" skal være "';
        TEXT002: Label 'Unable to determin ', Comment = 'DAN="Kunne ikke bestemme ",DEU="Kann nicht bestimmt werden. ",ESP="Imposible determinar ",FRA="Impossible à identifier",SVE="Saknas "';
        TEXT003: Label 'Unsupported Document Type ', Comment = 'DAN="Ukendt dokumenttype ",DEU="Nicht unterstützter Dokumententyp. ",ESP="Tipo de Documento no Soportado ",FRA="Type document non connu",SVE="Felaktig dokumenttyp "';
        TEXT004: Label 'Item %1 not found.', Comment = 'DAN="Vare %1 kunne ikke findes.",DEU="Artikel %1 nicht gefunden.",ESP="Producto %1 no Encontrado.",FRA="Article %1 non trouvé.",SVE="Artikel %1 saknas."';
        TEXT005: Label 'Service Charge', Comment = 'DAN="Opkrævningsgebyr",DEU="Servicekosten",ESP="Cargo Servicio",FRA="Frais forfaitaires",SVE="Faktureringsavgift"';
        TEXT006: Label 'Handling Amount', Comment = 'DAN="Ekspeditionsgebyr 2",DEU="Bearbeitungsbetrag",ESP="Importe Manipulado",FRA="Frais traitement",SVE="Köpt belopp"';
        TEXT007: Label 'Shipping Amount', Comment = 'DAN="Leveringgebyr",DEU="Versandbetrag",ESP="Importe Envío",FRA="Frais livraison",SVE="Leveransbelopp"';
        lastLineNo: Integer;
        EpaymentService: Codeunit "E-payment Service EXP";
        ItemUOM: Record "Item Unit of Measure";
        LTXT003: LABEL 'Item %1 requested on order %2, but item not found.';
        LTXT004: LABEL 'Item %1 requested as a linked item to %2 on order %3, but item not found.';


    /// <summary>
    /// GetLastError.
    /// </summary>
    /// <returns>Return value of type Text[50].</returns>
    procedure GetLastError(): Text[50];
    begin
        exit(LastError);
    end;

    /// <summary>
    /// doError.
    /// </summary>
    /// <param name="ErrorText">Text[50].</param>
    procedure doError(ErrorText: Text[50]);
    begin
        LastError := ErrorText;
        ERROR(ErrorText);
    end;

    /// <summary>
    /// CopyExpOrderAddrToSalesHdr.
    /// </summary>
    /// <param name="ExpandITOrderHeader">Record "ExpandIT Order Header EXP".</param>
    /// <param name="ToSalesHeader">VAR Record "Sales Header".</param>
    procedure CopyExpOrderAddrToSalesHdr(ExpandITOrderHeader: Record "ExpandIT Order Header EXP"; var ToSalesHeader: Record "Sales Header");
    begin
        //with ToSalesHeader do begin
        //Fill in Bill-to address from the ExpandIT Order if it is a B2C customer
        //(If the B2B customer does not have an alternative Bill-to Customer No., the address is
        //not chaged in the ExpandIT Order anyway.)
        if ToSalesHeader."Bill-to Customer No." = ToSalesHeader."Sell-to Customer No." then begin
            ToSalesHeader."Bill-to Name" := COPYSTR(ExpandITOrderHeader."Bill-to Name EXP", 1, MAXSTRLEN(ToSalesHeader."Bill-to Name"));
            ToSalesHeader."Bill-to Address" := COPYSTR(ExpandITOrderHeader."Bill-to Address EXP", 1, MAXSTRLEN(ToSalesHeader."Bill-to Address"));
            ToSalesHeader."Bill-to Address 2" := COPYSTR(ExpandITOrderHeader."Bill-to Address 2 EXP", 1, MAXSTRLEN(ToSalesHeader."Bill-to Address 2"));
            ToSalesHeader."Bill-to Post Code" := COPYSTR(ExpandITOrderHeader."Bill-to Post Code EXP", 1, MAXSTRLEN(ToSalesHeader."Bill-to Post Code"));
            ToSalesHeader."Bill-to City" := COPYSTR(ExpandITOrderHeader."Bill-to City EXP", 1, MAXSTRLEN(ToSalesHeader."Bill-to City"));
            ToSalesHeader."Bill-to County" := COPYSTR(ExpandITOrderHeader."Bill-to County EXP", 1, MAXSTRLEN(ToSalesHeader."Bill-to County"));
            ToSalesHeader."Bill-to Country/Region Code" :=
              COPYSTR(ExpandITOrderHeader."Bill-to Country Code EXP", 1, MAXSTRLEN(ToSalesHeader."Bill-to Country/Region Code"));
            ToSalesHeader."Bill-to Contact" := COPYSTR(ExpandITOrderHeader."Bill-to Contact EXP", 1, MAXSTRLEN(ToSalesHeader."Bill-to Contact"));
        end;
        ToSalesHeader."Ship-to Name" := COPYSTR(ExpandITOrderHeader."Ship-to Name EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to Name"));
        ToSalesHeader."Ship-to Address" := COPYSTR(ExpandITOrderHeader."Ship-to Address EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to Address"));
        ToSalesHeader."Ship-to Address 2" := COPYSTR(ExpandITOrderHeader."Ship-to Address 2 EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to Address 2"));
        ToSalesHeader."Ship-to Post Code" := COPYSTR(ExpandITOrderHeader."Ship-to Post Code EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to Post Code"));
        ToSalesHeader."Ship-to City" := COPYSTR(ExpandITOrderHeader."Ship-to City EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to City"));
        ToSalesHeader."Ship-to County" := COPYSTR(ExpandITOrderHeader."Ship-to County EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to County"));
        ToSalesHeader."Ship-to Country/Region Code" :=
          COPYSTR(ExpandITOrderHeader."Ship-to Country Code EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to Country/Region Code"));
        ToSalesHeader."Ship-to Contact" := COPYSTR(ExpandITOrderHeader."Ship-to Contact EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to Contact"));
        //end;
    end;
}