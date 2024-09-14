/// <summary>
/// Codeunit Int Shop Create Demodata EXP (ID 68703).
/// </summary>
codeunit 68703 "Int Shop Create Demodata EXP"
{
    // version EIS5.04.01
    // EIS2.0.1   2006-11-14  JR  * Check for existence of account 2910 added when creating payment methods.
    // 
    // EIS3.01    2008-05-21  JR  * EIS Version is set to 3.x.
    // 
    // EIS3.02    2009-01-14  JR  * Payment type COP was added in the creation of demo data.
    // 
    // EIS4.00    2010-09-03  JR  * Regions added for backward compatibility.
    // 
    // EIS4.00.02 2012-01-04  PB  * EUR currency prefix changed from euro sign to EUR because of dificulties handling the special character
    // 
    // EIS4.00.03 2013-08-22  PB  * Base Unit of Measure set on items.
    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM18.0.6.137 2020-07-27 FAM * Add FindFirst check for ExpandIT Setup
    trigger OnRun();
    begin
        if not CONFIRM('Do you want to create demodata for the ExpandIT Internet Shop?', false) then
            exit;
        Window.OPEN('Working. . . \#1#######################');

        Window.UPDATE(1, 'Creating demo data...');

        if not EPaymentProvider.GET('DIBS') then begin
            EPaymentProvider.INIT;
            EPaymentProvider."Code EXP" := 'DIBS';
            EPaymentProvider."Name EXP" := 'Architrade A/S';
            EPaymentProvider."Address EXP" := 'Toldbodgade 49';
            EPaymentProvider."Post Code EXP" := 'DK-1253';
            EPaymentProvider."City EXP" := 'København K';
            EPaymentProvider."Phone No. EXP" := '+45 7020 3077';
            EPaymentProvider."Fax No. EXP" := '+45 7020 3087';
            EPaymentProvider."E-Mail EXP" := 'info@architrade.com';

            EPaymentProvider."Merchant ID EXP" := '1234';
            EPaymentProvider."Login User ID EXP" := 'Login';
            EPaymentProvider."Password EXP" := 'Pass';

            EPaymentProvider."Home Page EXP" := 'http://www.architrade.com';
            EPaymentProvider."Administration Page EXP" := 'http://payment.architrade.com/admin';
            EPaymentProvider."Provider Type EXP" := EPaymentProvider."Provider Type EXP"::Architrade;
            EPaymentProvider."Clearing Validity Period EXP" := '7D';
            EPaymentProvider.INSERT;
        end;

        if not EPaymentProvider.GET('AUTH_NET') then begin
            EPaymentProvider.INIT;
            EPaymentProvider."Code EXP" := 'AUTH_NET';
            EPaymentProvider."Name EXP" := 'Authorize.Net Corporation';
            EPaymentProvider."Address EXP" := '3311 N. University Ave.';
            EPaymentProvider."Post Code EXP" := 'UT 84604-4445';
            EPaymentProvider."City EXP" := 'Provo';
            EPaymentProvider."Country Code EXP" := 'US';
            EPaymentProvider."Phone No. EXP" := '+1 801-818-3311';
            EPaymentProvider."Fax No. EXP" := '+1 801-818-3312';
            EPaymentProvider."E-Mail EXP" := 'support@authorize.net';

            EPaymentProvider."Merchant ID EXP" := '1234';
            EPaymentProvider."Login User ID EXP" := 'Login';
            EPaymentProvider."Password EXP" := 'Pass';

            EPaymentProvider."Home Page EXP" := 'www.authorizenet.com';
            EPaymentProvider."Administration Page EXP" := 'https://secure.authorize.net';
            EPaymentProvider."Provider Type EXP" := EPaymentProvider."Provider Type EXP"::"Authorize.Net";
            EPaymentProvider."Clearing Validity Period EXP" := '7D';
            EPaymentProvider.INSERT;
        end;

        if not PaymentMethod.GET('DIBS') then begin
            PaymentMethod.INIT;
            PaymentMethod.Code := 'DIBS';
            PaymentMethod.Description := 'Architrade Internet Payment';
            PaymentMethod."Bal. Account Type" := PaymentMethod."Bal. Account Type"::"G/L Account";
            if GLAccount.GET('2910') then PaymentMethod.VALIDATE("Bal. Account No.", '2910');
            PaymentMethod."e-payment Provider Code EXP" := 'DIBS';
            PaymentMethod.INSERT;
        end;

        if not PaymentMethod.GET('AUTH_NET') then begin
            PaymentMethod.INIT;
            PaymentMethod.Code := 'AUTH_NET';
            PaymentMethod.Description := 'Authorize.Net Internet Payment';
            PaymentMethod."Bal. Account Type" := PaymentMethod."Bal. Account Type"::"G/L Account";
            if GLAccount.GET('2910') then PaymentMethod.VALIDATE("Bal. Account No.", '2910');
            PaymentMethod."e-payment Provider Code EXP" := 'AUTH_NET';
            PaymentMethod.INSERT;
        end;

        if not PaymentMethod.GET('COD') then begin
            PaymentMethod.INIT;
            PaymentMethod.Code := 'COD';
            PaymentMethod.Description := 'Cash on delivery';
            PaymentMethod."Bal. Account Type" := PaymentMethod."Bal. Account Type"::"G/L Account";
            if GLAccount.GET('2910') then PaymentMethod.VALIDATE("Bal. Account No.", '2910');
            PaymentMethod.INSERT;
        end;

        if not PaymentMethod.GET('COP') then begin
            PaymentMethod.INIT;
            PaymentMethod.Code := 'COP';
            PaymentMethod.Description := 'Cash on pickup';
            PaymentMethod."Bal. Account Type" := PaymentMethod."Bal. Account Type"::"G/L Account";
            if GLAccount.GET('2910') then PaymentMethod.VALIDATE("Bal. Account No.", '2910');
            PaymentMethod.INSERT;
        end;

        if not Customer.GET('INET') then begin
            Customer.INIT;
            Customer.VALIDATE("No.", 'INET');
            Customer.VALIDATE(Name, 'Internet Customer');
            Customer.VALIDATE("Customer Posting Group", 'DOMESTIC');
            Customer.VALIDATE("Gen. Bus. Posting Group", 'NATIONAL');
            Customer."Payment Method Code" := 'COD';
            Customer.INSERT(true);
        end;

        if not Customer.GET('INETTEMPLATE') then begin
            Customer.INIT;
            Customer.VALIDATE("No.", 'INETTEMPLATE');
            Customer.VALIDATE(Name, 'Internet Customer Template');
            Customer.VALIDATE("Customer Posting Group", 'DOMESTIC');
            Customer.VALIDATE("Gen. Bus. Posting Group", 'NATIONAL');
            Customer."Payment Method Code" := 'COD';
            Customer.INSERT(true);
        end;

        if not Salesperson.GET('INTERNET') then begin
            Salesperson.INIT;
            Salesperson.VALIDATE(Code, 'INTERNET');
            Salesperson.VALIDATE(Name, 'ExpandIT Internet Shop');
            Salesperson.INSERT(true);
        end;

        if not NoSeries.GET('NETCUST') then begin
            NoSeries.INIT;
            NoSeries.VALIDATE(Code, 'NETCUST');
            NoSeries.VALIDATE(Description, 'Customer from Internet');
            NoSeries.INSERT(true);

            NoSeriesLine.INIT;
            NoSeriesLine.VALIDATE("Series Code", 'NETCUST');
            NoSeriesLine.VALIDATE("Line No.", 10000);
            NoSeriesLine.VALIDATE("Starting No.", 'NET00010');
            NoSeriesLine.VALIDATE("Ending No.", 'NET99990');
            NoSeriesLine.VALIDATE("Increment-by No.", 10);
            NoSeriesLine.VALIDATE(Open, true);
            NoSeriesLine.INSERT(true);
        end;

        if not NoSeries.GET('NETDOC') then begin
            NoSeries.INIT;
            NoSeries.VALIDATE(Code, 'NETDOC');
            NoSeries.VALIDATE(Description, 'Quote from Internet');
            NoSeries.INSERT(true);

            NoSeriesLine.INIT;
            NoSeriesLine.VALIDATE("Series Code", 'NETDOC');
            NoSeriesLine.VALIDATE("Line No.", 10000);
            NoSeriesLine.VALIDATE("Starting No.", 'NET00010');
            NoSeriesLine.VALIDATE("Ending No.", 'NET99990');
            NoSeriesLine.VALIDATE("Increment-by No.", 10);
            NoSeriesLine.VALIDATE(Open, true);
            NoSeriesLine.INSERT(true);
        end;

        if not Currency.GET('GBP') then begin
            Currency.INIT();
            Currency.Code := 'GBP';
            Currency.Description := 'Great British Pounds';

            Currency.VALIDATE("Realized Gains Acc.", '9330');
            Currency.VALIDATE("Realized Losses Acc.", '9340');

            Currency.VALIDATE("Unrealized Gains Acc.", '9310');
            Currency.VALIDATE("Unrealized Losses Acc.", '9320');

            Currency.VALIDATE("Invoice Rounding Precision", 0.01);
            Currency.VALIDATE("Unit-Amount Rounding Precision", 0.001);

            Currency."Suffix EXP" := '';
            Currency."Prefix EXP" := '£';
            Currency."Enabled EXP" := true;
            Currency."Number Of Decimals EXP" := 2;

            Currency.INSERT(true);
        end;

        if Currency.GET('DKK') then begin
            Currency."Suffix EXP" := ' kr.';
            Currency."Prefix EXP" := '';
            Currency."Enabled EXP" := true;
            Currency."Number Of Decimals EXP" := 2;

            Currency.MODIFY;
        end;

        if Currency.GET('USD') then begin
            Currency."Prefix EXP" := '$ ';
            Currency."Suffix EXP" := '';
            Currency."Enabled EXP" := true;
            Currency."Number Of Decimals EXP" := 2;

            Currency.MODIFY;
        end;

        if Currency.GET('EUR') then begin
            Currency."Prefix EXP" := 'EUR';
            Currency."Suffix EXP" := '';
            Currency."Enabled EXP" := true;
            Currency."Number Of Decimals EXP" := 2;

            Currency.MODIFY;
        end;

        if not InternetCurrencyExchage.GET('DKK', 'USD') then begin
            InternetCurrencyExchage.INIT;

            InternetCurrencyExchage."From Currency EXP" := 'DKK';
            InternetCurrencyExchage."To Currency EXP" := 'USD';
            InternetCurrencyExchage."Exchange Rate EXP" := 636.57;

            InternetCurrencyExchage.INSERT;
        end;

        if not InternetCurrencyExchage.GET('DKK', 'EUR') then begin
            InternetCurrencyExchage.INIT;

            InternetCurrencyExchage."From Currency EXP" := 'DKK';
            InternetCurrencyExchage."To Currency EXP" := 'EUR';
            InternetCurrencyExchage."Exchange Rate EXP" := 742.81;

            InternetCurrencyExchage.INSERT;
        end;

        if not InternetCurrencyExchage.GET('DKK', 'GBP') then begin
            InternetCurrencyExchage.INIT;

            InternetCurrencyExchage."From Currency EXP" := 'DKK';
            InternetCurrencyExchage."To Currency EXP" := 'GBP';
            InternetCurrencyExchage."Exchange Rate EXP" := 1062.6;

            InternetCurrencyExchage.INSERT;
        end;

        if not InternetCurrencyExchage.GET('EUR', 'USD') then begin
            InternetCurrencyExchage.INIT;

            InternetCurrencyExchage."From Currency EXP" := 'EUR';
            InternetCurrencyExchage."To Currency EXP" := 'USD';
            InternetCurrencyExchage."Exchange Rate EXP" := 85.7;

            InternetCurrencyExchage.INSERT;
        end;

        if not InternetCurrencyExchage.GET('EUR', 'GBP') then begin
            InternetCurrencyExchage.INIT;

            InternetCurrencyExchage."From Currency EXP" := 'EUR';
            InternetCurrencyExchage."To Currency EXP" := 'GBP';
            InternetCurrencyExchage."Exchange Rate EXP" := 143.05;

            InternetCurrencyExchage.INSERT;
        end;

        if not InternetCurrencyExchage.GET('USD', 'GBP') then begin
            InternetCurrencyExchage.INIT;

            InternetCurrencyExchage."From Currency EXP" := 'USD';
            InternetCurrencyExchage."To Currency EXP" := 'GBP';
            InternetCurrencyExchage."Exchange Rate EXP" := 166.93;

            InternetCurrencyExchage.INSERT;
        end;

        // if not UserGroup.GET('NET-USER') then begin
        // InsertUserGroup('NET-USER', 'Internet Shop User');
        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::"Internet Customer EXP",
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::" ",
        //   Permission."Modify Permission"::Yes,
        //   Permission."Delete Permission"::" ",
        //   Permission."Execute Permission"::" ");

        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::"ExpandIT Order Header EXP",
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::" ",
        //   Permission."Modify Permission"::Yes,
        //   Permission."Delete Permission"::Yes,
        //   Permission."Execute Permission"::" ");

        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::"ExpandIT Order Line EXP",
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::" ",
        //   Permission."Modify Permission"::Yes,
        //   Permission."Delete Permission"::Yes,
        //   Permission."Execute Permission"::" ");

        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::"ExpandIT Setup EXP",
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::" ",
        //   Permission."Modify Permission"::Yes,
        //   Permission."Delete Permission"::" ",
        //   Permission."Execute Permission"::" ");

        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::"e-payment Provider EXP",
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::Yes,
        //   Permission."Modify Permission"::Yes,
        //   Permission."Delete Permission"::Yes,
        //   Permission."Execute Permission"::" ");

        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::"e-payment Entry EXP",
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::Yes,
        //   Permission."Modify Permission"::Yes,
        //   Permission."Delete Permission"::Yes,
        //   Permission."Execute Permission"::" ");
        // end;

        // if not UserGroup.GET('NET-CONNECTORS') then begin
        // InsertUserGroup('NET-CONNECTORS', 'Internet Shop Connectors');
        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::"Internet Customer EXP",
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::Yes,
        //   Permission."Modify Permission"::Yes,
        //   Permission."Delete Permission"::" ",
        //   Permission."Execute Permission"::" ");

        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::"ExpandIT Order Header EXP",
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::Yes,
        //   Permission."Modify Permission"::" ",
        //   Permission."Delete Permission"::" ",
        //   Permission."Execute Permission"::" ");

        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::"ExpandIT Order Line EXP",
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::Yes,
        //   Permission."Modify Permission"::" ",
        //   Permission."Delete Permission"::" ",
        //   Permission."Execute Permission"::" ");

        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::"Country/Region",
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::" ",
        //   Permission."Modify Permission"::" ",
        //   Permission."Delete Permission"::" ",
        //   Permission."Execute Permission"::" ");

        // InsertPermission(
        //   Permission."Object Type"::"Table Data",
        //   DATABASE::Item,
        //   Permission."Read Permission"::Yes,
        //   Permission."Insert Permission"::" ",
        //   Permission."Modify Permission"::" ",
        //   Permission."Delete Permission"::" ",
        //   Permission."Execute Permission"::" ");
        // end;


        WriteSetup := true;

        if InternetShopSetup.GET() then
            if CONFIRM('Overwrite internet settings?', true) then
                InternetShopSetup.DELETE
            else
                WriteSetup := false;

        if WriteSetup then begin
            //with InternetShopSetup do begin
            InternetShopSetup.INIT;
            InternetShopSetup."Primary Key EXP" := '';
            InternetShopSetup.VALIDATE(InternetShopSetup."Sales Person Code EXP", 'INTERNET');
            InternetShopSetup.VALIDATE("Prices Include VAT EXP", false);
            InternetShopSetup.VALIDATE("VAT % EXP", 0);
            InternetShopSetup.VALIDATE("Internet Customer EXP", 'INET');
            InternetShopSetup.VALIDATE("Internet Customer Template EXP", 'INETTEMPLATE');
            InternetShopSetup.VALIDATE("Remote Shop URL EXP", 'http://localhost/shop');
            InternetShopSetup.VALIDATE("New Customer Nos. EXP", 'NETCUST');
            InternetShopSetup.VALIDATE("New Sales Document Nos. EXP", 'NETDOC');
            InternetShopSetup.VALIDATE("Show Doc After Conversion EXP", false);
            InternetShopSetup.VALIDATE("Notify on Conv to Doc. EXP", true);
            InternetShopSetup.VALIDATE("Notify on Rejt of Order EXP", true);
            InternetShopSetup.VALIDATE("Use Internet Customer EXP", InternetShopSetup."Use Internet Customer EXP"::"If No Customer Relation");
            InternetShopSetup.VALIDATE("Convert To Document Type", InternetShopSetup."Convert To Document Type"::Order);
            InternetShopSetup.VALIDATE("Renew Clearing on Conv EXP", false);
            InternetShopSetup.VALIDATE("Batch Capture EXP", true);
            InternetShopSetup.VALIDATE("Simulation EXP", true);
            InternetShopSetup.VALIDATE("Test Clearing on Conv. EXP", false);
            InternetShopSetup.VALIDATE("Get Card Type on Conv. EXP", false);
            InternetShopSetup.VALIDATE("Internet Default Curr Code EXP", 'GBP');
            InternetShopSetup.VALIDATE("EIS Version EXP", InternetShopSetup."EIS Version EXP"::"3.x");
            InternetShopSetup.INSERT;
            //end;
        end;

        if not ShippingAgent.GET('NONE') then begin
            ShippingAgent.INIT;
            ShippingAgent.Code := 'NONE';
            ;
            ShippingAgent.Name := 'Pickup';
            ShippingAgent."Internet Address" := '';
            ShippingAgent.INSERT();
        end;

        if not ShippingAgent.GET('PD') then begin
            ShippingAgent.INIT;
            ShippingAgent.Code := 'PD';
            ;
            ShippingAgent.Name := 'Post Danmark';
            ShippingAgent."Internet Address" := 'www.postdanmark.dk/gtt/owa/packgtt.list?i_stregkode=%1';
            ShippingAgent.INSERT();
        end;

        if not ShippingAgent.GET('UPS') then begin
            ShippingAgent.INIT;
            ShippingAgent.Code := 'UPS';
            ;
            ShippingAgent.Name := 'United Parcel Services';
            ShippingAgent."Internet Address" := 'wwwapps.ups.com/tracking/tracking.cgi?tracknum=%1';
            ShippingAgent.INSERT();
        end;

        CreateDemoItems;

        Window.CLOSE;

        MESSAGE('ExpandIT Internet Shop demodata were created.');
    end;

    var
        InternetShopSetup: Record "ExpandIT Setup EXP";
        Customer: Record Customer;
        Salesperson: Record "Salesperson/Purchaser";
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
        Company: Record Company;
        Country: Record "Country/Region";
        EPaymentProvider: Record "e-payment Provider EXP";
        PaymentMethod: Record "Payment Method";
        Currency: Record Currency;
        InternetCurrencyExchage: Record "Internet Exchange Rate EXP";
        ShippingAgent: Record "Shipping Agent";
        LastUserGroupID: Code[20];
        Window: Dialog;
        WriteSetup: Boolean;
        TEXT0001: Label 'I will collect', Comment = 'DAN="Henter selv ",DEU="Selbstabholung",ESP="Recogeré personalmente",FRA="Je récupère mes articles",SVE="Jag vill välja"';
        GLAccount: Record "G/L Account";
    //Commented out as it fails the App validation for App Source, due to new write restrictions to Permission table.

    // procedure InsertUserGroup(ID: Code[20]; Name: Text[30]);
    // begin
    // UserGroup.INIT;
    // UserGroup."Role ID" := ID;
    // UserGroup.Name := Name;
    // UserGroup.INSERT;
    // LastUserGroupID := ID;

    // end;

    // procedure InsertPermission(ObjectType: Option; ObjectID: Integer; Read: Option; Insert: Option; Modify: Option; Delete: Option; Execute: Option);
    // begin
    // if LastUserGroupID = '' then
    //     ERROR('You must define a User Group before inserting permissions.');

    // Permission.INIT;
    // Permission."Role ID" := LastUserGroupID;
    // Permission."Object Type" := ObjectType;
    // Permission."Object ID" := ObjectID;
    // Permission."Read Permission" := Read;
    // Permission."Insert Permission" := Insert;
    // Permission."Modify Permission" := Modify;
    // Permission."Delete Permission" := Delete;
    // Permission."Execute Permission" := Execute;
    // Permission.INSERT;

    // end;

    /// <summary>
    /// CreateDemoItems.
    /// </summary>
    procedure CreateDemoItems();
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        InventoryPostingGroup: Record "Inventory Posting Group";
        ItemDiscountGroup: Record "Item Discount Group";
        ItemTranslation: Record "Item Translation";
    begin
        if not InventoryPostingGroup.GET('Action') then begin
            InventoryPostingGroup.INIT;
            InventoryPostingGroup.Code := 'Action';
            // #STARTREGION: REMOVE IN 2.60
            InventoryPostingGroup.Description := 'Action';
            // #ENDREGION: REMOVE IN 2.60
            InventoryPostingGroup.INSERT(true);
        end;

        if not InventoryPostingGroup.GET('Comedy') then begin
            InventoryPostingGroup.INIT;
            InventoryPostingGroup.Code := 'Comedy';
            // #STARTREGION: REMOVE IN 2.60
            InventoryPostingGroup.Description := 'Comedy';
            // #ENDREGION: REMOVE IN 2.60
            InventoryPostingGroup.INSERT(true);
        end;

        if not InventoryPostingGroup.GET('Drama') then begin
            InventoryPostingGroup.INIT;
            InventoryPostingGroup.Code := 'Drama';
            // #STARTREGION: REMOVE IN 2.60
            InventoryPostingGroup.Description := 'Drama';
            // #ENDREGION: REMOVE IN 2.60
            InventoryPostingGroup.INSERT(true);
        end;

        if not InventoryPostingGroup.GET('Horror') then begin
            InventoryPostingGroup.INIT;
            InventoryPostingGroup.Code := 'Horror';
            // #STARTREGION: REMOVE IN 2.60
            InventoryPostingGroup.Description := 'Horror';
            // #ENDREGION: REMOVE IN 2.60
            InventoryPostingGroup.INSERT(true);
        end;

        if not InventoryPostingGroup.GET('Love Story') then begin
            InventoryPostingGroup.INIT;
            InventoryPostingGroup.Code := 'Love Story';
            // #STARTREGION: REMOVE IN 2.60
            InventoryPostingGroup.Description := 'Love Story';
            // #ENDREGION: REMOVE IN 2.60
            InventoryPostingGroup.INSERT(true);
        end;

        if not InventoryPostingGroup.GET('SciFi') then begin
            InventoryPostingGroup.INIT;
            InventoryPostingGroup.Code := 'SciFi';
            // #STARTREGION: REMOVE IN 2.60
            InventoryPostingGroup.Description := 'SciFi';
            // #ENDREGION: REMOVE IN 2.60
            InventoryPostingGroup.INSERT(true);
        end;

        if not InventoryPostingGroup.GET('Thriller') then begin
            InventoryPostingGroup.INIT;
            InventoryPostingGroup.Code := 'Thriller';
            // #STARTREGION: REMOVE IN 2.60
            InventoryPostingGroup.Description := 'Thriller';
            // #ENDREGION: REMOVE IN 2.60
            InventoryPostingGroup.INSERT(true);
        end;


        // --
        // -- Generate Inventory Posting Groups
        // --

        CreateInvtPostingSetup('Action');
        CreateInvtPostingSetup('Comedy');
        CreateInvtPostingSetup('Drama');
        CreateInvtPostingSetup('Horror');
        CreateInvtPostingSetup('Love Story');
        CreateInvtPostingSetup('SciFi');
        CreateInvtPostingSetup('Thriller');

        // --
        // -- Generate Item Discount Groups
        // --

        if not ItemDiscountGroup.GET('Comedy') then begin
            ItemDiscountGroup.INIT;
            ItemDiscountGroup.Code := 'Comedy';
            // #STARTREGION: REMOVE IN 2.60
            ItemDiscountGroup.Description := 'Comedy';
            // #ENDREGION: REMOVE IN 2.60
            ItemDiscountGroup.INSERT(true);
        end;

        if not ItemDiscountGroup.GET('Drama') then begin
            ItemDiscountGroup.INIT;
            ItemDiscountGroup.Code := 'Drama';
            // #STARTREGION: REMOVE IN 2.60
            ItemDiscountGroup.Description := 'Drama';
            // #ENDREGION: REMOVE IN 2.60
            ItemDiscountGroup.INSERT(true);
        end;

        if not ItemDiscountGroup.GET('SciFi') then begin
            ItemDiscountGroup.INIT;
            ItemDiscountGroup.Code := 'SciFi';
            // #STARTREGION: REMOVE IN 2.60
            ItemDiscountGroup.Description := 'SciFi';
            // #ENDREGION: REMOVE IN 2.60
            ItemDiscountGroup.INSERT(true);
        end;

        // --
        // -- Generate Item and variant demo data.
        // --
        if not Item.GET('7838-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '7838-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.82);
            Item.VALIDATE(Description, 'Robocop 3');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8054-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8054-05');
            Item.VALIDATE("Inventory Posting Group", 'Thriller');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 8.75);
            Item.VALIDATE(Description, 'The Net');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8101-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8101-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.22);
            Item.VALIDATE(Description, '12 Monkeys');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8102-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8102-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 4.71);
            Item.VALIDATE(Description, 'Alien');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8103-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8103-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.03);
            Item.VALIDATE(Description, 'Alien 3');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8104-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8104-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 4.71);
            Item.VALIDATE(Description, 'Blade Runner');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8105-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8105-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.35);
            Item.VALIDATE(Description, 'The Matrix');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8107-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8107-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.07);
            Item.VALIDATE(Description, 'Memento');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8108-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8108-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 4.71);
            Item.VALIDATE(Description, 'Men in Black');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8109-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8109-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.41);
            Item.VALIDATE(Description, 'Mission: Impossible 2');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8110-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8110-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.22);
            Item.VALIDATE(Description, 'The Crow');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8111-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8111-05');
            Item.VALIDATE("Inventory Posting Group", 'Thriller');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.79);
            Item.VALIDATE(Description, 'The Game');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8112-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8112-05');
            Item.VALIDATE("Inventory Posting Group", 'Horror');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 5.18);
            Item.VALIDATE(Description, 'The Haunting');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8113-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8113-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.22);
            Item.VALIDATE(Description, 'Dark City');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8114-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8114-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 8.94);
            Item.VALIDATE(Description, 'Exit Wounds');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8115-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8115-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.16);
            Item.VALIDATE(Description, 'Final Destination');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8116-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8116-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.88);
            Item.VALIDATE(Description, 'Planet of the Apes');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8117-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8117-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.22);
            Item.VALIDATE(Description, 'Platoon');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8118-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8118-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 4.71);
            Item.VALIDATE(Description, 'Titans (Remember the Titans)');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8119-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8119-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.13);
            Item.VALIDATE(Description, 'Ronin');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8120-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8120-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.41);
            Item.VALIDATE(Description, 'Shaft');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8121-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8121-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.22);
            Item.VALIDATE(Description, 'Snatch');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8122-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8122-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.79);
            Item.VALIDATE(Description, 'The Art of War');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8123-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8123-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.16);
            Item.VALIDATE(Description, 'The Presidio');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8124-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8124-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 8.66);
            Item.VALIDATE(Description, 'The Virgin Suicides');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8125-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8125-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 5.18);
            Item.VALIDATE(Description, 'U-571');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8210-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8210-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.22);
            Item.VALIDATE(Description, 'Fight Club');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8211-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8211-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 12.05);
            Item.VALIDATE(Description, 'Gladiator');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8212-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8212-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.6);
            Item.VALIDATE(Description, 'Saving Private Ryan');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8213-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8213-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 5.18);
            Item.VALIDATE(Description, 'The Deer Hunter');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8214-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8214-05');
            Item.VALIDATE("Inventory Posting Group", 'Thriller');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.16);
            Item.VALIDATE(Description, 'The Devil''s Own');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8215-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8215-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.6);
            Item.VALIDATE(Description, 'The Skulls');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8216-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8216-05');
            Item.VALIDATE("Inventory Posting Group", 'Comedy');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Comedy');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.69);
            Item.VALIDATE(Description, 'The Whole Nine Yards');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8217-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8217-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.41);
            Item.VALIDATE(Description, 'Three Kings');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8218-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8218-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 5.18);
            Item.VALIDATE(Description, 'Savior');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8219-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8219-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 5.18);
            Item.VALIDATE(Description, 'Spawn');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8220-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8220-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.41);
            Item.VALIDATE(Description, 'Arlington Road');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8614-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8614-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.82);
            Item.VALIDATE(Description, 'Romeo & Juliet');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8762-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8762-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 11.29);
            Item.VALIDATE(Description, 'Volcano');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('8782-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '8782-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 11.48);
            Item.VALIDATE(Description, 'Jackie Brown');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9020-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9020-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 8.66);
            Item.VALIDATE(Description, 'The Shawshank Redemption');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9021-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9021-05');
            Item.VALIDATE("Inventory Posting Group", 'Horror');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 4.71);
            Item.VALIDATE(Description, 'The Sixth Sense');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9022-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9022-05');
            Item.VALIDATE("Inventory Posting Group", 'Thriller');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.35);
            Item.VALIDATE(Description, 'The Usual Suspects');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9023-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9023-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.16);
            Item.VALIDATE(Description, 'American History X');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9024-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9024-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.22);
            Item.VALIDATE(Description, 'One Flew over the Cuckoos Nest');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9025-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9025-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.41);
            Item.VALIDATE(Description, 'Cast Away');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9026-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9026-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 4.71);
            Item.VALIDATE(Description, 'Gone in Sixty Seconds');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9027-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9027-05');
            Item.VALIDATE("Inventory Posting Group", 'Comedy');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Comedy');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.6);
            Item.VALIDATE(Description, 'Monty Python the Holy Grail');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9028-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9028-05');
            Item.VALIDATE("Inventory Posting Group", 'Comedy');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Comedy');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.6);
            Item.VALIDATE(Description, 'Monty Python Meaning of Life');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9029-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9029-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 8.75);
            Item.VALIDATE(Description, 'Reservoir Dogs');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9030-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9030-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.13);
            Item.VALIDATE(Description, 'Romeo Must Die');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9031-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9031-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 8.94);
            Item.VALIDATE(Description, 'X-Men');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9032-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9032-05');
            Item.VALIDATE("Inventory Posting Group", 'Comedy');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Comedy');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 5.18);
            Item.VALIDATE(Description, 'Bedazzled');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9033-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9033-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.88);
            Item.VALIDATE(Description, 'The Fifth Element');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9034-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9034-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.32);
            Item.VALIDATE(Description, 'Hollow Man');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9035-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9035-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.07);
            Item.VALIDATE(Description, 'Cube');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9036-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9036-05');
            Item.VALIDATE("Inventory Posting Group", 'Horror');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.22);
            Item.VALIDATE(Description, 'Stigmata');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9037-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9037-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 5.18);
            Item.VALIDATE(Description, 'The Insider');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9038-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9038-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.6);
            Item.VALIDATE(Description, 'The Last Starfighter');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9039-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9039-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.16);
            Item.VALIDATE(Description, 'Cruel Intentions');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9040-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9040-05');
            Item.VALIDATE("Inventory Posting Group", 'Thriller');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.98);
            Item.VALIDATE(Description, '8mm');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9041-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9041-05');
            Item.VALIDATE("Inventory Posting Group", 'Comedy');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Comedy');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.07);
            Item.VALIDATE(Description, 'American Pie');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9042-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9042-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.16);
            Item.VALIDATE(Description, 'Awakenings');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9043-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9043-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 5.18);
            Item.VALIDATE(Description, 'Blue Streak');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9044-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9044-05');
            Item.VALIDATE("Inventory Posting Group", 'Comedy');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Comedy');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.6);
            Item.VALIDATE(Description, 'Bring It On');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9045-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9045-05');
            Item.VALIDATE("Inventory Posting Group", 'Comedy');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Comedy');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.22);
            Item.VALIDATE(Description, 'Chicken Run');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9046-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9046-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.35);
            Item.VALIDATE(Description, 'Enemy at the Gates');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9206-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9206-05');
            Item.VALIDATE("Inventory Posting Group", 'Comedy');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Comedy');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.22);
            Item.VALIDATE(Description, 'Still Crazy');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9209-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9209-05');
            Item.VALIDATE("Inventory Posting Group", 'Thriller');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.35);
            Item.VALIDATE(Description, 'The Thirteenth Floor');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9313-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9313-05');
            Item.VALIDATE("Inventory Posting Group", 'Horror');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 8.66);
            Item.VALIDATE(Description, 'The Blair Witch Project');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9442-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9442-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.63);
            Item.VALIDATE(Description, 'Big Daddy');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9463-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9463-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 10.35);
            Item.VALIDATE(Description, 'Universal Soldier');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9584-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9584-05');
            Item.VALIDATE("Inventory Posting Group", 'SciFi');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'SciFi');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 11.29);
            Item.VALIDATE(Description, 'The X-Files');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9590-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9590-05');
            Item.VALIDATE("Inventory Posting Group", 'Love Story');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 4.71);
            Item.VALIDATE(Description, 'Ever After');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9646-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9646-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 11.48);
            Item.VALIDATE(Description, 'Die Hard');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9647-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9647-05');
            Item.VALIDATE("Inventory Posting Group", 'Action');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", '');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 12.23);
            Item.VALIDATE(Description, 'Die Hard 2 - Die harder');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9952-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9952-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.03);
            Item.VALIDATE(Description, 'EdTV');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9953-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9953-05');
            Item.VALIDATE("Inventory Posting Group", 'Comedy');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Comedy');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 9.6);
            Item.VALIDATE(Description, 'The Flintstones');
            EnterItemDefaultValues(Item);
        end;

        if not Item.GET('9959-05') then begin
            Item.INIT;
            Item.VALIDATE("No.", '9959-05');
            Item.VALIDATE("Inventory Posting Group", 'Drama');
            // #STARTREGION: REMOVE IN 3.10
            Item.VALIDATE("Item Disc. Group", 'Drama');
            // #ENDREGION: REMOVE IN 3.10
            Item.VALIDATE("Allow Invoice Disc.", true);
            Item.VALIDATE("Unit Price", 4.71);
            Item.VALIDATE(Description, 'Carmen');
            EnterItemDefaultValues(Item);
        end;

        if not ItemVariant.GET('8103-05', 'REG-1') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '8103-05');
            ItemVariant.VALIDATE(Code, 'REG-1');
            ItemVariant.VALIDATE(Description, 'Region 1');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('8103-05', 'REG-2') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '8103-05');
            ItemVariant.VALIDATE(Code, 'REG-2');
            ItemVariant.VALIDATE(Description, 'Region 2');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('8103-05', 'REG-3') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '8103-05');
            ItemVariant.VALIDATE(Code, 'REG-3');
            ItemVariant.VALIDATE(Description, 'Region 3');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('8103-05', 'REG-4') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '8103-05');
            ItemVariant.VALIDATE(Code, 'REG-4');
            ItemVariant.VALIDATE(Description, 'Region 4');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('8103-05', 'REG-5') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '8103-05');
            ItemVariant.VALIDATE(Code, 'REG-5');
            ItemVariant.VALIDATE(Description, 'Region 5');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('8104-05', 'REG-1') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '8104-05');
            ItemVariant.VALIDATE(Code, 'REG-1');
            ItemVariant.VALIDATE(Description, 'Region 1');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('8104-05', 'REG-2') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '8104-05');
            ItemVariant.VALIDATE(Code, 'REG-2');
            ItemVariant.VALIDATE(Description, 'Region 2');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('9647-05', 'REG-0') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '9647-05');
            ItemVariant.VALIDATE(Code, 'REG-0');
            ItemVariant.VALIDATE(Description, 'Region 0');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('9647-05', 'REG-1') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '9647-05');
            ItemVariant.VALIDATE(Code, 'REG-1');
            ItemVariant.VALIDATE(Description, 'Region 1');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('9647-05', 'REG-2') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '9647-05');
            ItemVariant.VALIDATE(Code, 'REG-2');
            ItemVariant.VALIDATE(Description, 'Region 2');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('9647-05', 'REG-3') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '9647-05');
            ItemVariant.VALIDATE(Code, 'REG-3');
            ItemVariant.VALIDATE(Description, 'Region 3');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('9647-05', 'REG-4') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '9647-05');
            ItemVariant.VALIDATE(Code, 'REG-4');
            ItemVariant.VALIDATE(Description, 'Region 4');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('9647-05', 'REG-5') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '9647-05');
            ItemVariant.VALIDATE(Code, 'REG-5');
            ItemVariant.VALIDATE(Description, 'Region 5');
            ItemVariant.INSERT(true);
        end;

        if not ItemVariant.GET('9647-05', 'REG-6') then begin
            ItemVariant.INIT;
            ItemVariant.VALIDATE("Item No.", '9647-05');
            ItemVariant.VALIDATE(Code, 'REG-6');
            ItemVariant.VALIDATE(Description, 'Region 6');
            ItemVariant.INSERT(true);
        end;

        if not ItemTranslation.GET('7838-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '7838-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Robocop 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('7838-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '7838-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Robocop 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('7838-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '7838-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Robocop 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('7838-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '7838-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Robocop 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('7838-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '7838-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Robocop 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8054-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8054-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Nettet');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8054-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8054-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Das Netz');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8054-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8054-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Net');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8054-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8054-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'La Red');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8054-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8054-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'A Rede');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8101-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8101-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, '12 Monkeys');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8101-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8101-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, '12 Monkeys');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8101-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8101-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, '12 Monkeys');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8101-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8101-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, '12 Monos');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8101-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8101-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, '12 Macacos');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8102-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8102-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Alien den 8. passager');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8102-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8102-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Alien');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8102-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8102-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Alien');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8102-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8102-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Alien');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8102-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8102-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Alien - 8º Passageiro');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Alien 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Alien 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Alien 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Alien 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Alien 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Blade Runner');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Der Blade Runner');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Blade Runner');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Blade Runner');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Blade Runner');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8105-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8105-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Matrix');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8105-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8105-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Matrix');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8105-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8105-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Matrix');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8105-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8105-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Matrix');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8105-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8105-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Matrix');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8107-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8107-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Memento');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8107-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8107-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Memento');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8107-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8107-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Memento');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8107-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8107-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Memento');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8107-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8107-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Memento');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8108-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8108-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Men in Black');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8108-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8108-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Men in Black');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8108-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8108-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Men in Black');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8108-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8108-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Men in Black');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8108-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8108-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'MIB: Homens de Negro');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8109-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8109-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Mission: Impossible 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8109-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8109-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Mission: Impossible 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8109-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8109-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Mission: Impossible 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8109-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8109-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Mission: Imposible 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8109-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8109-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Missão Impossível  2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8110-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8110-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Crow');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8110-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8110-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Die Krähe');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8110-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8110-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Crow');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8110-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8110-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El Cuervo');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8110-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8110-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Corvo');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8111-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8111-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Game');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8111-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8111-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Game');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8111-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8111-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Game');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8111-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8111-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'The Game');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8111-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8111-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Jogo');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8112-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8112-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Haunting - Hjemsøgt');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8112-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8112-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Das Geisterschloss');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8112-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8112-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Haunting');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8112-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8112-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'La Guarida');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8112-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8112-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'A Mansão');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8113-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8113-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Dark City');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8113-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8113-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Dark City');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8113-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8113-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Dark City');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8113-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8113-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Dark City');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8113-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8113-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Cidade Misteriosa');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8114-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8114-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Exit Wounds - Skudhuller');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8114-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8114-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Exit Wounds - Die Copjäger');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8114-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8114-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Exit Wounds');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8114-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8114-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Herida Abierta');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8114-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8114-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Fogo Cerrado');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8115-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8115-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Final Destination');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8115-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8115-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Final Destination');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8115-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8115-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Final Destination');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8115-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8115-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Destino Final');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8115-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8115-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Último Destino');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8116-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8116-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Abernes planet');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8116-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8116-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Planet der Affen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8116-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8116-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Planet of the Apes');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8116-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8116-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El Planeta de los Simios');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8116-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8116-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Planeta dos Macacos');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8117-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8117-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Platoon');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8117-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8117-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Platoon');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8117-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8117-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Platoon');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8117-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8117-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Platoon');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8117-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8117-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Platoon - Os Bravos do Pelotão');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8118-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8118-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Titans (Remember the Titans)');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8118-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8118-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Gegen jede Regel');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8118-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8118-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Titans (Remember the Titans)');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8118-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8118-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Titanes');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8118-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8118-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Duelo de Titãs');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8119-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8119-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Ronin');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8119-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8119-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Ronin');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8119-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8119-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Ronin');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8119-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8119-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Ronin');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8119-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8119-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Ronin');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8120-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8120-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Shaft');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8120-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8120-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Shaft - Noch Fragen?');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8120-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8120-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Shaft Returns');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8120-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8120-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Shaft');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8120-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8120-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Shaft');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8121-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8121-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Snatch');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8121-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8121-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Snatch, Schweine und Diamanten');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8121-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8121-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Snatch');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8121-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8121-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Snatch, Cerdos y Diamantes');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8121-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8121-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Snatch, Porcos e Diamantes');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8122-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8122-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Art of War');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8122-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8122-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Art of War');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8122-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8122-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Art of War');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8122-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8122-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El arte de la Guerra');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8122-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8122-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'A Arte da Guerra');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8123-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8123-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Presidio');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8123-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8123-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Presidio');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8123-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8123-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Presidio');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8123-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8123-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Mas Fuerte que el Odio');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8123-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8123-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Mias Forte que o Ódio');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8124-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8124-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Virgin Suicides');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8124-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8124-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'The Virgin Suicides');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8124-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8124-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Virgin Suicides');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8124-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8124-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Las Vírgenes Suicidas');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8124-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8124-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'As Virgens Suicidas');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8125-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8125-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'U-571');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8125-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8125-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'U-571');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8125-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8125-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'U-571');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8125-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8125-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'U-571');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8125-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8125-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'U-571');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8210-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8210-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Fight Club');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8210-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8210-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Fight Club');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8210-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8210-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Fight Club');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8210-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8210-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El Club de la Lucha');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8210-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8210-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Clube de Combate');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8211-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8211-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Gladiator');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8211-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8211-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Gladiator');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8211-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8211-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Gladiator');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8211-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8211-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Gladiator');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8211-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8211-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Gladiador');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8212-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8212-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Saving Private Ryan');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8212-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8212-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Der Soldat James Ryan');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8212-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8212-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Saving Private Ryan');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8212-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8212-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Salvar al Soldado Ryan');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8212-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8212-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Resgate do Soldado Ryan');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8213-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8213-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Deer Hunter');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8213-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8213-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Die durch die Hölle gehen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8213-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8213-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Deer Hunter');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8213-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8213-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El Cazador');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8213-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8213-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Caçador');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8214-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8214-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Devil''s Own');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8214-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8214-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Vertrauter Feind');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8214-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8214-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Devil''s Own');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8214-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8214-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'La Sombra del Diablo');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8214-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8214-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Perigo Intímo');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8215-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8215-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Skulls');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8215-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8215-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Skulls, Alle Macht der Welt');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8215-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8215-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Skulls');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8215-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8215-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'The Skulls, Sociedad Secreto');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8215-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8215-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Sociedade Secreta');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8216-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8216-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Ni fod under');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8216-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8216-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Keine halben Sachen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8216-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8216-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Whole Nine Yards');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8216-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8216-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Falsas Apariencias');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8216-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8216-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Falsas Aparências');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8217-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8217-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Three Kings');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8217-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8217-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Three Kings');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8217-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8217-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Three Kings');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8217-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8217-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Tres Reyes');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8217-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8217-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Três Reis');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8218-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8218-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Savior');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8218-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8218-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Savior');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8218-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8218-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Savior');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8218-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8218-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Savior');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8218-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8218-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Savior');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8219-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8219-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Spawn');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8219-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8219-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Spawn');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8219-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8219-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Spawn');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8219-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8219-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Spawn');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8219-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8219-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Justiceiro das Trevas');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8220-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8220-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Arlington Road');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8220-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8220-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Arlington Road');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8220-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8220-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Arlington Road');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8220-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8220-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Arlington Road');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8220-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8220-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Arlington Road');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8614-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8614-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Romeo & Julie');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8614-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8614-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Romeo & Juliet');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8614-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8614-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Romeo & Juliet');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8614-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8614-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Romeo y Julieta');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8614-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8614-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Romeu e Julieta');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8762-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8762-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Volcano');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8762-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8762-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Vulkan - Berg in Flammen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8762-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8762-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Volcano - Fire on the Mountain');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8762-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8762-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Volcano');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8762-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8762-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Vulcão');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8782-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8782-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Jackie Brown');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8782-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8782-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Jackie Brown');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8782-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8782-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Jackie Brown');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8782-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8782-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Jackie Brown');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8782-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8782-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Jackie Brown');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9020-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9020-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'En verden udenfor');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9020-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9020-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Die Verurteilten');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9020-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9020-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Shawshank Redemption');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9020-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9020-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Cadena Perpetua');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9020-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9020-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Condenados de Shawshank');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9021-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9021-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Den sjette sans');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9021-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9021-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Der sechste Sinn');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9021-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9021-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Sixth Sense');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9021-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9021-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El Sexto Sentido');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9021-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9021-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Sexto Sentido');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9022-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9022-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Usual Suspects');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9022-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9022-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Die üblichen Verdächtigen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9022-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9022-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Usual Suspects');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9022-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9022-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Sospechosos Habituales');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9022-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9022-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Os Suspeitos do Costume');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9023-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9023-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'American History X');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9023-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9023-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'American History X');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9023-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9023-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'American History X');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9023-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9023-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'American History X');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9023-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9023-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'América Proibida');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9024-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9024-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Gøgereden');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9024-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9024-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Einer Flog über''s Kuckucksnest');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9024-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9024-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'One Flew over the Cuckoos Nest');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9024-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9024-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El Nido del Cuco');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9024-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9024-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Voando Sobre um Ninho de Cucos');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9025-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9025-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Cast Away');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9025-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9025-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Cast Away - Verschollen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9025-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9025-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Cast Away');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9025-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9025-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Náufrago');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9025-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9025-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Naúfrago');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9026-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9026-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, '60 sekunder');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9026-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9026-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Nur noch 60 Sekunden');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9026-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9026-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Gone in Sixty Seconds');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9026-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9026-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, '60 Segundos');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9026-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9026-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, '60 Segundos');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9027-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9027-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Monty Python The Holy Grail');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9027-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9027-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Ritter der Kokosnuss');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9027-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9027-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Monty Python The Holy Grail');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9027-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9027-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Los caballeros');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9027-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9027-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Em Busca do Cálice Sagrado');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9028-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9028-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Monty Python''s Meaning of life');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9028-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9028-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Monty Python''s Sinn des Lebens');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9028-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9028-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Monty Python''s Meaning of life');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9028-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9028-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El Sentido de la Vida');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9028-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9028-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Sentido da Vida');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9029-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9029-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Håndlangerne');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9029-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9029-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Reservoir Dogs - Wilde Hunde');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9029-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9029-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Reservoir Dogs');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9029-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9029-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Reservoir Dogs');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9029-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9029-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Cães Danados');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9030-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9030-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Romeo Must Die');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9030-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9030-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Romeo Must Die');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9030-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9030-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Romeo Must Die');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9030-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9030-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Romeo Debe Morir');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9030-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9030-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Romeu Deve Morrer');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9031-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9031-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'X-Men');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9031-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9031-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'X-Men');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9031-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9031-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'X-Men');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9031-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9031-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'X-Men');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9031-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9031-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'X-Men');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9032-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9032-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Forhekset');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9032-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9032-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Teuflisch');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9032-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9032-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Bedazzled');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9032-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9032-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Al Diablo con el Diablo');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9032-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9032-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Sedutora Endiabrada');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9033-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9033-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Det femte element');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9033-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9033-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Das fünfte Element');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9033-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9033-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Fifth Element');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9033-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9033-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El Quinto elemento');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9033-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9033-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Quinto Elemento');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9034-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9034-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Hollow Man');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9034-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9034-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Unsichtbare Gefahr');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9034-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9034-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Hollow Man');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9034-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9034-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El Hombre Sin Sombra');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9034-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9034-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Homem Transparente');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9035-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9035-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Cube');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9035-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9035-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Cube');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9035-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9035-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Cube');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9035-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9035-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Cube');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9035-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9035-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Cubo');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9036-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9036-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Stigmata');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9036-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9036-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Stigmata');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9036-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9036-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Stigmata');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9036-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9036-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Stigmata');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9036-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9036-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Estigma');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9037-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9037-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Insider');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9037-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9037-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Insider');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9037-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9037-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Insider');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9037-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9037-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'El Dilema');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9037-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9037-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O Informador');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9038-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9038-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Last Starfighter');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9038-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9038-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Starfight');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9038-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9038-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Last Starfighter');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9038-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9038-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Starfighter');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9038-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9038-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Starfighter');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9039-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9039-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Cruel Intentions');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9039-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9039-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Eiskalte Engel');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9039-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9039-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Cruel Intentions');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9039-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9039-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Cruelas Intenciones');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9039-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9039-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Intenções Crueis');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9040-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9040-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, '8mm');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9040-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9040-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, '8 MM');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9040-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9040-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, '8mm');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9040-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9040-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Asesinato en 8mm');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9040-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9040-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, '8 mm');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9041-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9041-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'American Pie');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9041-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9041-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'American Pie');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9041-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9041-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'American Pie');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9041-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9041-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'American Pie');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9041-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9041-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'American Pie - A Primeira Vez');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9042-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9042-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Livet længe leve');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9042-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9042-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Zeit des Erwachens');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9042-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9042-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Awakenings');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9042-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9042-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Despertares');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9042-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9042-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Despertares');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9043-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9043-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Blue Streak');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9043-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9043-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Der Diamantencop');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9043-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9043-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Blue Streak');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9043-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9043-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'De Ladrón a Policía');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9043-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9043-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Ladrão e Polícia');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9044-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9044-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Bring It On');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9044-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9044-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Girls United');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9044-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9044-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Bring It On');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9044-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9044-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'A Por Todas');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9044-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9044-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Tudo Por Elas');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9045-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9045-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Flugten fra hønsegården');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9045-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9045-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Chicken Run - Hennen rennen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9045-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9045-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Chicken Run');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9045-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9045-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Chicken Run');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9045-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9045-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'A Fuga Das Galinhas');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9046-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9046-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Enemy at the Gates');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9046-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9046-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Duell - Enemy at the Gates');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9046-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9046-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Enemy at the Gates');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9046-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9046-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Enemigo a las Puertas');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9046-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9046-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Inimigo às Portas');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9206-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9206-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Still Crazy');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9206-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9206-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Still Crazy');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9206-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9206-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Still Crazy');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9206-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9206-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Siempre Locos');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9206-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9206-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Still Crazy');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9209-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9209-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Thirteenth Floor');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9209-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9209-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, '13th Floor');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9209-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9209-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Thirteenth Floor');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9209-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9209-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Nivel 13');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9209-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9209-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'O 13º Andar');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9313-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9313-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Blair Witch Project');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9313-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9313-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Blair Witsch Project');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9313-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9313-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Blair Witch Project');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9313-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9313-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'La Bruja de Blair');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9313-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9313-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Projecto Blair Witch');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9442-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9442-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Big Daddy');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9442-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9442-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Big Daddy');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9442-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9442-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Big Daddy');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9442-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9442-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Un Papa Genial');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9442-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9442-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Um Pai à Maneira');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9463-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9463-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Universal Soldier');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9463-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9463-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Universal Soldier');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9463-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9463-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Universal Soldier');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9463-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9463-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Soldado Universal');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9463-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9463-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Soldado Universal');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9584-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9584-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'X-Files - strengt fortroligt');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9584-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9584-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Akte X');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9584-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9584-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The X-Files');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9584-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9584-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Expendiente X');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9584-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9584-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Ficheiros Secretos');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9590-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9590-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'For evigt');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9590-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9590-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Auf immer und ewig');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9590-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9590-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Ever After');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9590-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9590-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Por Siempre Jamás');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9590-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9590-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Para Sempre Cinderela');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9646-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9646-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Die Hard');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9646-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9646-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Stirb langsam');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9646-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9646-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Die Hard');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9646-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9646-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'La Jungla de Cristal');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9646-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9646-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Assalto ao Arranha-Céus');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Die Hard 2 - Die harder');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Stirb langsam 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Die Hard 2 - Die harder');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'La Jungla de Cristal 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Assalto ao Aeroporto');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9952-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9952-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'EdTV');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9952-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9952-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'EdTV');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9952-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9952-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'EdTV');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9952-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9952-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'EdTV');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9952-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9952-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'EdTV');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9953-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9953-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'The Flintstones');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9953-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9953-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Die Familie Feuerstein');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9953-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9953-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'The Flintstones');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9953-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9953-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Los Picapiedras');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9953-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9953-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Os Flintstones');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9959-05', '', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9959-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Carmen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9959-05', '', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9959-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Karmen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9959-05', '', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9959-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Carmen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9959-05', '', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9959-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Carmen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9959-05', '', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9959-05');
            ItemTranslation.VALIDATE("Variant Code", '');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Carmen');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-1', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-1', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-1', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-1', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-1', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-2', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-2', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-2', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-2', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-2', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-3', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-3');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-3', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-3');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-3', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-3');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-3', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-3');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-3', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-3');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-4', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-4');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 4');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-4', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-4');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 4');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-4', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-4');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 4');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-4', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-4');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 4');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-4', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-4');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 4');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-5', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-5');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 5');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-5', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-5');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 5');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-5', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-5');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 5');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-5', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-5');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 5');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8103-05', 'REG-5', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8103-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-5');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 5');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', 'REG-1', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', 'REG-1', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', 'REG-1', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', 'REG-1', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', 'REG-1', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', 'REG-2', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', 'REG-2', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', 'REG-2', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', 'REG-2', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('8104-05', 'REG-2', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '8104-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-0', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-0');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 0');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-0', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-0');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 0');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-0', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-0');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 0');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-0', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-0');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 0');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-0', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-0');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 0');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-1', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-1', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-1', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-1', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-1', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-1');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 1');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-2', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-2', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-2', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-2', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-2', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-2');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 2');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-3', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-3');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-3', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-3');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-3', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-3');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-3', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-3');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-3', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-3');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 3');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-4', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-4');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 4');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-4', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-4');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 4');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-4', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-4');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 4');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-4', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-4');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 4');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-4', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-4');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 4');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-5', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-5');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 5');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-5', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-5');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 5');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-5', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-5');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 5');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-5', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-5');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 5');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-5', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-5');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 5');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-6', 'DAN') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-6');
            ItemTranslation.VALIDATE("Language Code", 'DAN');
            ItemTranslation.VALIDATE(Description, 'Regionskode 6');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-6', 'DEU') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-6');
            ItemTranslation.VALIDATE("Language Code", 'DEU');
            ItemTranslation.VALIDATE(Description, 'Region-Code 6');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-6', 'ENG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-6');
            ItemTranslation.VALIDATE("Language Code", 'ENG');
            ItemTranslation.VALIDATE(Description, 'Regioncode 6');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-6', 'ESP') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-6');
            ItemTranslation.VALIDATE("Language Code", 'ESP');
            ItemTranslation.VALIDATE(Description, 'Código de zona 6');
            ItemTranslation.INSERT(true);
        end;

        if not ItemTranslation.GET('9647-05', 'REG-6', 'PTG') then begin
            ItemTranslation.INIT;
            ItemTranslation.VALIDATE("Item No.", '9647-05');
            ItemTranslation.VALIDATE("Variant Code", 'REG-6');
            ItemTranslation.VALIDATE("Language Code", 'PTG');
            ItemTranslation.VALIDATE(Description, 'Código de região 6');
            ItemTranslation.INSERT(true);
        end;
    end;

    /// <summary>
    /// EnterItemDefaultValues.
    /// </summary>
    /// <param name="Item">VAR Record Item.</param>
    procedure EnterItemDefaultValues(var Item: Record Item);
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        Item.VALIDATE("VAT Prod. Posting Group", 'VAT25');
        Item.VALIDATE("Gen. Prod. Posting Group", 'RETAIL');
        Item.INSERT(true);

        if not ItemUnitOfMeasure.GET(Item."No.", 'PCS') then begin
            ItemUnitOfMeasure.INIT;
            ItemUnitOfMeasure.VALIDATE("Item No.", Item."No.");
            ItemUnitOfMeasure.VALIDATE(Code, 'PCS');
            ItemUnitOfMeasure.VALIDATE("Qty. per Unit of Measure", 1);
            ItemUnitOfMeasure.INSERT(true);
        end;

        Item.VALIDATE("Base Unit of Measure", 'PCS');
        Item.MODIFY(true);
    end;

    /// <summary>
    /// CreateInvtPostingSetup.
    /// </summary>
    /// <param name="InvtPostingGrpCode">Code[10].</param>
    procedure CreateInvtPostingSetup(InvtPostingGrpCode: Code[10]);
    var
        InvtPostingSetup: Record "Inventory Posting Setup";
        InvtPostingSetup2: Record "Inventory Posting Setup";
    begin
        InvtPostingSetup.SETRANGE("Invt. Posting Group Code", 'FINISHED');
        if InvtPostingSetup.FINDFIRST then
            repeat
                InvtPostingSetup2 := InvtPostingSetup;
                InvtPostingSetup2."Invt. Posting Group Code" := InvtPostingGrpCode;
                if not InvtPostingSetup2.FIND then
                    InvtPostingSetup2.INSERT(true);
            until InvtPostingSetup.NEXT = 0;
    end;
}

