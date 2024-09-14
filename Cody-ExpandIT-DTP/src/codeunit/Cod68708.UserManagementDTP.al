/// <summary>
/// Codeunit User Management DTP (ID 68708).
/// </summary>
codeunit 68708 "User Management DTP"
{
    /// <summary>
    /// CreateCustomer.
    /// </summary>
    /// <param name="recInternetCustomer">VAR Record "Internet Customer EXP".</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure CreateCustomer(var recInternetCustomer: Record "Internet Customer EXP"): Code[20];
    begin
        If not FindCustomer(recInternetCustomer) then begin
            exit(CreateCustomerEx(recInternetCustomer));
        end else begin
            recInternetCustomer."B2B Enable"();
            recInternetCustomer.Modify();
            exit(recInternetCustomer."Customer No. EXP");
        end;
    end;

    /// <summary>
    /// CreateCustomerEx.
    /// </summary>
    /// <param name="recInternetCustomer">VAR Record "Internet Customer EXP".</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure CreateCustomerEx(var recInternetCustomer: Record "Internet Customer EXP"): Code[20];
    var
        recEESetup: Record "ExpandIT Setup EXP";
        recCustomer: Record Customer;
        cuNoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        recEESetup.GET;
        recEESetup.TestField("New Customer Nos. EXP");

        Clear(cuNoSeriesMgt);

        //Created Customer Record
        recEESetup.TestField("Internet Customer Template EXP");
        IF recInternetCustomer."Customer No. EXP" <> 'INET2' then
            recCustomer.GET(recEESetup."Internet Customer Template EXP")
        else
            recCustomer.GET(recEESetup."Internet Customer Template 2");

        //recCustomer.TransferFields(recInternetCustomer);
        //
        recCustomer.Name := recInternetCustomer."Name EXP";
        recCustomer.Address := recInternetCustomer."Address EXP";
        recCustomer."Address 2" := recInternetCustomer."Address 2 EXP";
        recCustomer.City := recInternetCustomer."City EXP";
        recCustomer.Contact := recInternetCustomer."Contact EXP";
        recCustomer."Phone No." := recInternetCustomer."Phone No. EXP";
        recCustomer."Country/Region Code" := recInternetCustomer."Country Code EXP";
        //"Last Date Modified EXP";
        recCustomer."Post Code" := recInternetCustomer."Post Code EXP";
        recCustomer.County := recInternetCustomer."County EXP";
        recCustomer."E-Mail" := recInternetCustomer."E-Mail EXP";
        //"No. EXP";
        //"Login EXP";
        //"Password EXP";
        //"Created EXP";
        //"B2B Customer EXP";
        //"Currency Code EXP";
        //"Secondary Currency Code EXP";
        //"State EXP";
        recCustomer."No." := cuNoSeriesMgt.GetNextNo(recEESetup."New Customer Nos. EXP", 0D, TRUE);
        recCustomer."No. Series" := recEESetup."New Customer Nos. EXP";

        if recInternetCustomer."Currency Code EXP" = recEESetup."Internet Default Curr Code EXP" then
            recCustomer.Validate("Currency Code", '')
        else
            recCustomer.Validate("Currency Code", recInternetCustomer."Currency Code EXP");

        recCustomer.Insert();

        //Modify Internet Customer Record to Reflect
        recInternetCustomer."Customer No. EXP" := recCustomer."No.";
        recInternetCustomer."B2B Enable"();
        recInternetCustomer.Modify();
        exit(recCustomer."No.");
    end;

    /// <summary>
    /// CreateCustomerFromOrder.
    /// </summary>
    /// <param name="recExpandITOrderHeader">VAR Record "ExpandIT Order Header EXP".</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure CreateCustomerFromOrder(var recExpandITOrderHeader: Record "ExpandIT Order Header EXP"): Code[20];
    var
        recTempInternetCustomer: record "Internet Customer EXP" temporary;
        recInternetCustomer: Record "Internet Customer EXP";
        cdeReturn: Code[20];
    begin
        cdeReturn := '';

        if not recInternetCustomer.Get(recExpandITOrderHeader."Bill-to Net Customer No. EXP") then begin
            //Anonymous Users
            recTempInternetCustomer.Reset();
            recTempInternetCustomer.Init();
            recTempInternetCustomer."No. EXP" := recExpandITOrderHeader."Bill-to Net Customer No. EXP";
            recTempInternetCustomer."Name EXP" := recExpandITOrderHeader."Bill-to Name EXP";
            recTempInternetCustomer."Address EXP" := recExpandITOrderHeader."Bill-to Address EXP";
            recTempInternetCustomer."Address 2 EXP" := recExpandITOrderHeader."Bill-to Address 2 EXP";
            recTempInternetCustomer."City EXP" := recExpandITOrderHeader."Bill-to City EXP";
            recTempInternetCustomer."County EXP" := recExpandITOrderHeader."Bill-to County EXP";
            recTempInternetCustomer."State EXP" := recExpandITOrderHeader."Bill-to State EXP";
            recTempInternetCustomer."Post Code EXP" := recExpandITOrderHeader."Bill-to Post Code EXP";
            recTempInternetCustomer."Contact EXP" := recExpandITOrderHeader."Bill-to Contact EXP";
            recTempInternetCustomer."E-Mail EXP" := recExpandITOrderHeader."Bill-to E-Mail EXP";
            recTempInternetCustomer.Insert();

            cdeReturn := CreateCustomer(recTempInternetCustomer);

        end else begin
            //B2B and B2C Users
            cdeReturn := CreateCustomer(recInternetCustomer);
        end;
        exit(cdeReturn);
    end;

    /// <summary>
    /// FindCustomer.
    /// </summary>
    /// <param name="recInternetCustomer">VAR Record "Internet Customer EXP".</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure FindCustomer(var recInternetCustomer: Record "Internet Customer EXP"): Boolean;
    var
        blnFound: Boolean;
        blnReturn: Boolean;
        recCustomer: Record Customer;
        LTXT001: Label 'The system found one or more %1 matching the %2. \';
        LTXT002: Label 'Do you want to assign one of those instead of creating a new %1?';
        LTXT003: Label 'No %1 was assigned to the %2.';
    begin
        blnFound := False;
        blnReturn := false;

        recCustomer.ClearMarks();

        //Match on Phone No.
        if recInternetCustomer."Phone No. EXP" <> '' then begin
            recCustomer.SetRange("Phone No.", recInternetCustomer."Phone No. EXP");
            blnFound := blnFound or MatchCustomer(recCustomer);
            recCustomer.SetRange("Phone No.");
        end;
        //Match on E-Mail
        if recInternetCustomer."E-Mail EXP" <> '' then begin
            recCustomer.SetRange("E-Mail", recInternetCustomer."E-Mail EXP");
            blnFound := blnFound or MatchCustomer(recCustomer);
            recCustomer.SetRange("E-Mail");
        end;

        if blnFound then begin
            if Confirm(LTXT001 + LTXT002, TRUE, recCustomer.TableName, recInternetCustomer.TableName) then begin
                recCustomer.MarkedOnly(TRUE);
                if CustomerLookupModal(recCustomer) then begin
                    recInternetCustomer.Validate("Customer No. EXP", recCustomer."No.");
                    recInternetCustomer.Modify();
                    blnReturn := true;
                end else
                    Error(LTXT003, recCustomer.TableName, recInternetCustomer.TableName);
            end;
        end;
        recCustomer.ClearMarks();
        exit(blnReturn);
    end;

    /// <summary>
    /// MatchCustomer.
    /// </summary>
    /// <param name="recCustomer">VAR Record Customer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure MatchCustomer(var recCustomer: Record Customer): Boolean
    var
        blnReturn: Boolean;
    begin
        blnReturn := false;

        if recCustomer.FindFirst() then begin
            repeat
                recCustomer.Mark(TRUE);
            until recCustomer.next = 0;

            blnReturn := True;
        end;
        exit(blnReturn);
    end;

    /// <summary>
    /// GetSalesCustomer.
    /// </summary>
    /// <param name="recInternetCustomer">Record "Internet Customer EXP".</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure GetSalesCustomer(recInternetCustomer: Record "Internet Customer EXP"): Code[20];
    var
        recInternetCustomerB2b: Record "Internet Customer B2B EXP";
    begin
        If (recInternetCustomer."Customer No. EXP" <> '') or (recInternetCustomer."Customer No. EXP" <> 'INET') or
            (recInternetCustomer."Customer No. EXP" <> 'INET2') then
            exit(recInternetCustomer."Customer No. EXP")
        else begin
            IF recInternetCustomerB2b.Get(recInternetCustomer."No. EXP") then
                exit(recInternetCustomerB2b."Customer No. EXP")
            else
                exit('');
        end;
    end;

    /// <summary>
    /// CustomerLookupModal.
    /// </summary>
    /// <param name="recCustomer">VAR Record Customer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CustomerLookupModal(var recCustomer: Record Customer): Boolean;
    var
        pgeCustomerList: Page "Customer List";
    begin
        pgeCustomerList.SetTableView(recCustomer);
        pgeCustomerList.LookupMode(TRUE);

        if pgeCustomerList.RunModal = Action::LookupOK then begin
            pgeCustomerList.GetRecord(recCustomer);
            exit(true);
        end
        else begin
            exit(false);
        end;
    end;
}
