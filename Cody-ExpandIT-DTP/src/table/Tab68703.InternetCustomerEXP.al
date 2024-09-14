/// <summary>
/// Table Internet Customer EXP (ID 68703).
/// </summary>
table 68703 "Internet Customer EXP"
{
    // version EIS6.0.12

    // EIS2.01  2006-09-25  RSP * Extended "B2B Enable" function to update Table 18 Customer also (Enable Shop Login)
    //                          * Corrected Danish label (Text006)
    //                          * Added transfer of currency code when creating a Customer
    // 
    // EIS3.00  2009-01-09  JR  * Bug fix in function FindCustomer where phone numbers were compared to email addresses.
    // 
    // EIS3.02  2009-03-11  JR  * The currency code is cleared if it matches the default currency when a
    //                            customer is created from an Internet customer in function CreateCustomer2.
    // 
    // EIS4.01  2010-08-10  JR  * Testfield added to Createcustomer function to ensuer that this function is not used on B2B customers.
    // 
    // EIS4.01.01  2010-12-14  PB  * Use of MARK replaced with us of temporary records as MARK is not supported by the RTC.
    //                         PB  * FINDFIRST changed to FIND('-') for backwards compatibility.
    // EIS4.02.01  2012-05-14  PB * Length of Login changed to 50
    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EIS6.0.12 2020-09-10 FAM * Get ExpandIT Setup record

    Caption = 'Internet Customer', Comment = 'DAN="Internet-kunde",DEU="Internet Kunde",ESP="Cliente Internet",FRA="Client Internet",SVE="Internet kund"';
    DataCaptionFields = "Name EXP";
    DrillDownPageID = "Internet Customer List EXP";
    LookupPageID = "Internet Customer List EXP";

    fields
    {
        field(1; "Customer No. EXP"; Code[20])
        {
            Caption = 'Customer No.', Comment = 'DAN="Kundenummer",DEU="Kunden Nr.",ESP="No. Cliente",FRA="N° client",SVE="Kundnr"';
            TableRelation = Customer;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (CurrFieldNo <> 0) and (xRec."Customer No. EXP" <> "Customer No. EXP") and (xRec."Customer No. EXP" <> '') then begin
                    if not CONFIRM(Text000, false, FIELDNAME("Customer No. EXP")) then
                        ERROR('')
                    else
                        UpdateToCustomerYesNo;
                end;
            end;

        }
        field(2; "Name EXP"; Text[100])
        {
            Caption = 'Name', Comment = 'DAN="Navn",DEU="Name",ESP="Nombre",FRA="Nom",SVE="Namn"';
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(5; "Address EXP"; Text[100])
        {
            Caption = 'Address', Comment = 'DAN="Adresse",DEU="Adresse",ESP="Dirección",FRA="Adresse",SVE="Adress"';
            DataClassification = CustomerContent;
        }
        field(6; "Address 2 EXP"; Text[50])
        {
            Caption = 'Address 2', Comment = 'DAN="Adresse 2",DEU="Adresse 2",ESP="Dirección 2",FRA="Adresse (2ème ligne)",SVE="Adress 2"';
            DataClassification = CustomerContent;
        }
        field(7; "City EXP"; Text[30])
        {
            Caption = 'City', Comment = 'DAN="By",DEU="Stadt",ESP="Provincia",FRA="Ville",SVE="Ort"';
            DataClassification = CustomerContent;
        }
        field(8; "Contact EXP"; Text[30])
        {
            Caption = 'Contact', Comment = 'DAN="Attention",DEU="Kontakt",ESP="Contacto",FRA="Contact",SVE="Kontaktperson"';
            DataClassification = CustomerContent;
        }
        field(9; "Phone No. EXP"; Text[30])
        {
            Caption = 'Phone No.', Comment = 'DAN="Telefon",DEU="Telfon Nr.",ESP="No. Teléfono",FRA="N° téléphone",SVE="Telefonnr"';
            DataClassification = CustomerContent;
        }
        field(35; "Country Code EXP"; Code[10])
        {
            Caption = 'Country Code', Comment = 'DAN="Landekode",DEU="Ländercode",ESP="Código País",FRA="Code pays/région",SVE="Landkod"';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(54; "Last Date Modified EXP"; Date)
        {
            Caption = 'Last Date Modified', Comment = 'DAN="Rettet den",DEU="Letztes Datum der Veränderung",ESP="Fecha Última Modificación",FRA="Date dern. modification",SVE="Uppdateringsdatum"';
            DataClassification = CustomerContent;
        }
        field(91; "Post Code EXP"; Code[20])
        {
            Caption = 'Post Code', Comment = 'DAN="Postnr.",DEU="Versandcode",ESP="Código postal",FRA="Code postal",SVE="Postnr"';
            TableRelation = "Post Code";
            DataClassification = CustomerContent;
        }
        field(92; "County EXP"; Text[30])
        {
            Caption = 'Country', Comment = 'DAN="Amt",DEU="Land",ESP="País",FRA="Pays/région",SVE="Land"';
            DataClassification = CustomerContent;
        }
        field(102; "E-Mail EXP"; Text[80])
        {
            Caption = 'E-Mail', Comment = 'DAN="E-mail",DEU="E-Mail",ESP="E-Mail",FRA="E-mail",SVE="E-post"';
            DataClassification = CustomerContent;
        }
        field(78700; "No. EXP"; Text[38])
        {
            Caption = 'No.', Comment = 'DAN="Nummer",DEU="Nr.",ESP="No.",FRA="N°",SVE="Nr"';
            DataClassification = CustomerContent;
            Description = 'EIS5.04.01';
        }
        field(78701; "Login EXP"; Text[50])
        {
            Caption = 'Login', Comment = 'DAN="Login",DEU="Anmeldung",ESP="Usuario",FRA="Login",SVE="Inloggning"';
            Description = 'EIS5.04.01';
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                InternetCustomer: Record "Internet Customer EXP";
            begin
            end;
        }
        field(78702; "Password EXP"; Text[20])
        {
            Caption = 'Password', Comment = 'DAN="Kodeord",DEU="Passwort",ESP="Contraseña",FRA="Mot de passe",SVE="Lösenord"';
            Description = 'EIS5.04.01';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(78703; "Created EXP"; Date)
        {
            Caption = 'Created', Comment = 'DAN="Oprettet",DEU="Erzeugt",ESP="Creado",FRA="Créé",SVE="Skapad"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(78704; "B2B Customer EXP"; Boolean)
        {
            CalcFormula = Exist("Internet Customer B2B EXP" WHERE("No. EXP" = FIELD("No. EXP")));
            Caption = 'B2B Customer', Comment = 'DAN="B2B Kunde",DEU="B2B Kunde",ESP="Cliente B2B ",FRA="Client B2B",SVE="B2B Kund"';
            Description = 'EIS5.04.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(78705; "Currency Code EXP"; Code[10])
        {
            Caption = 'Currency Code', Comment = 'DAN="Valuta kode",DEU="Währungscode",ESP="Código Divisa ",FRA="Code devise",SVE="Valutakod"';
            Description = 'EIS5.04.01';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(78706; "Secondary Currency Code EXP"; Code[10])
        {
            Caption = 'Secondary Currency Code', Comment = 'DAN="Alternativ Valuta kode",DEU="Zweiter Währungscode",ESP="Código Divisa Secundaria",FRA="Code devise secondaire",SVE="Andra valutakoden"';
            Description = 'EIS5.04.01';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(78707; "State EXP"; Text[30])
        {
            Caption = 'State', Comment = 'DAN="Stat",DEU="Status",ESP="Provincia",FRA="Etat",SVE="State Stat"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No. EXP")
        {
        }
        key(Key2; "Customer No. EXP")
        {
        }
        key(Key3; "Login EXP")
        {
        }
        key(Key4; "Name EXP")
        {
        }
        key(Key5; "Country Code EXP")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ExpandITUtil: Codeunit "ExpandIT Util";
        Customer: Record Customer;
        InternetCustomer: Record "Internet Customer EXP";
        InternetShopSetup: Record "ExpandIT Setup EXP";
        InternetCustomerB2B: Record "Internet Customer B2B EXP";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        Text000: Label 'Do you want to change %1?', Comment = 'DAN="Vil du ændre %1?",DEU="Wollen Sie %1 ändern?",ESP="Desea cambiar %1?",FRA="Souhaitez-vous modifier la valeur du champ %1?",SVE="Vill du ändra %1?"';
        //TextConst DAN='Vil du ændre %1?',DEU='Wünschen Sie zu verändern %1?',ENU='Do you want to change %1?',ESP='Desea cambiar %1?',FRA='Souhaitez-vous modifier la valeur du champ %1?',SVE='Vill du ändra %1?';
        Text001: Label 'The system found one or more %1 matching the %2.\', Comment = 'DAN="Systemet har fundet en eller flere %1 som matcher %2.\",DEU="Das System hat ein oder mehrere %1 gefunden die %2 entsprechen.",ESP="El sistema ha encontrado  %1 coincidencias con %2.\",FRA="Le système a trouvé un ou plusieurs %1 correspondant au %2.",SVE="Systemet hittade en eller flera %1 som passar mot %2.\"';
        //TextConst DAN='Systemet har fundet en eller flere %1 som matcher %2.\',DEU='Das System fand eine oder mehrere %1 passend zu %2.\',ENU='The system found one or more %1 matching the %2.\',ESP='El sistema ha encontrado  %1 coincidencias con %2.\',FRA='Le système a trouvé un ou plusieurs %1 correspondant au %2.',SVE='Systemet hittade en eller flera %1 som passar mot %2.\';
        Text002: Label 'Do you want to assign one of those instead of creating a new %1?', Comment = 'DAN="Vil du tilknytte en af dem i stedet for at oprette en ny?",DEU="Wünschen Sie eines dieser festzulegen anstatt ein neues %1 anzulegen?",ESP="¿Desea asignar uno de estos en lugar de crear un nuevo %1?",FRA="Voulez-vous l''attribuer au lieu de créer un nouveau %1 ?",SVE="Vill du tilldela en av dess istället för att skapa en ny %1?"';
        //TextConst DAN='Vil du tilknytte en af dem i stedet for at oprette en ny?',DEU='Wünschen Sie eines dieser festzulegen anstatt ein neues %1 anzulegen?',ENU='Do you want to assign one of those instead of creating a new %1?',ESP='¿Desea asignar uno de estos en lugar de crear un nuevo %1?',FRA='Voulez-vous l''attribuer au lieu de créer un nouveau %1 ?',SVE='Vill du tilldela en av dess istället för att skapa en ny %1?';
        Text003: Label 'No %1 was assigned to the %2.', Comment = 'DAN="Der blev ikke knyttet nogen %1 til %2.",DEU="Nein %1 war festgelegt für %2.",ESP="No %1 fue asignado a %2.",FRA="Aucun %1 n''a été attribué au %2.",SVE="Ingen %1 blev tilldelad till %2."';
        //TextConst DAN='Der blev ikke knyttet nogen %1 til %2.',DEU='Nein %1 war festgelegt für %2.',ENU='No %1 was assigned to the %2.',ESP='No %1 fue asignado a %2.',FRA='Aucun %1 n''a été attribué au %2.',SVE='Ingen %1 blev tilldelad till %2.';
        Text004: Label 'Do you want to update information on %3 %2 from this %1?', Comment = 'DAN="Ønsker du at opdatere information på %3 %2 fra denne %1?",DEU="Wünschen Sie zu aktualisieren die Informationen für %3 %2 von %1?",ESP="Desea actualizar información en %3 %2 desde %1?",FRA="Voulez-vous mettre l''information à jour ?",SVE="Vill du uppdatera information om %3 %2 från denna %1?"';
        //TextConst DAN='Ønsker du at opdatere information på %3 %2 fra denne %1?',DEU='Wünschen Sie zu aktualisieren die Informationen für %3 %2 von %1?',ENU='Do you want to update information on %3 %2 from this %1?',ESP='Desea actualizar información en %3 %2 desde %1?',FRA='Voulez-vous mettre l''information à jour ?',SVE='Vill du uppdatera information om %3 %2 från denna %1?';
        Text005: Label 'No %1 is associated with this %2.', Comment = 'DAN="Ingen %1 er knyttet til denne %2.",DEU="Nein %1 ist verbunden mit %2.",ESP="No %1 está asociado con este %2.",FRA="Aucun %1 n''est associé au %2.",SVE="Ingen %1 är associerad med denna %2."';
        //TextConst DAN='Ingen %1 er knyttet til denne %2.',DEU='Nein %1 ist verbunden mit %2.',ENU='No %1 is associated with this %2.',ESP='No %1 está asociado con este %2.',FRA='Aucun %1 n''est associé au %2.',SVE='Ingen %1 är associerad med denna %2.';
        Text006: Label 'You are about to create an B2B Login for this Internet Customer\Do you want to continue?', Comment = 'DAN="Denne funktion vil oprette et nyt B2B Login til denne internet kunde\Ønsker du at fortsætte?",DEU="Sie sind dabei eine B2B-Anmeldung für diesen Internet-Kunden anzulegen\Möchten Sie fortfahren?",ESP="Está a punto de crear un Usuario B2B para este Cliente\¿Desea continuar?",FRA="Vous allez créer un login B2B pour ce client Internet. Voulez-vous continuer ?",SVE="Du håller på att skapa en B2 Login för denna Internetkund\Vill du fortsätta?"';
    //TextConst DAN='Denne funktion vil oprette et nyt B2B Login til denne internet kunde\Ønsker du at fortsætte?',DEU='Sie sind dabei eine B2B-Anmeldung für diesen Internet-Kunden anzulegen\Möchten Sie fortfahren?',ENU='You are about to create an B2B Login for this Internet Customer\Do you want to continue?',ESP='Está a punto de crear un Usuario B2B para este Cliente\¿Desea continuar?',FRA='Vous allez créer un login B2B pour ce client Internet. Voulez-vous continuer ?',SVE='Du håller på att skapa en B2 Login för denna Internetkund\Vill du fortsätta?';

    /// <summary>
    /// CreateCustomer.
    /// </summary>
    procedure CreateCustomer();
    begin
        Customer.RESET;

        if not FindCustomer(Rec) then
            CreateCustomer2;
    end;

    local procedure CreateCustomer2();
    begin
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            TESTFIELD("B2B Customer EXP", false);

            Customer.GET(InternetShopSetup."Internet Customer Template EXP");

            InternetShopSetup.TESTFIELD("New Customer Nos. EXP");
            CLEAR(NoSeriesMgt);
            Customer."No." := NoSeriesMgt.GetNextNo(InternetShopSetup."New Customer Nos. EXP", 0D, true);
            Customer."No. Series" := InternetShopSetup."New Customer Nos. EXP";

            "Customer No. EXP" := Customer."No.";
            MODIFY;

            //Customer.TRANSFERFIELDS(Rec);
            //
            Customer.Name := "Name EXP";
            Customer.Address := "Address EXP";
            Customer."Address 2" := "Address 2 EXP";
            Customer.City := "City EXP";
            Customer.Contact := "Contact EXP";
            Customer."Phone No." := "Phone No. EXP";
            Customer."Country/Region Code" := "Country Code EXP";
            //"Last Date Modified EXP";
            Customer."Post Code" := "Post Code EXP";
            Customer.County := "County EXP";
            Customer."E-Mail" := "E-Mail EXP";
            //"No. EXP";
            //"Login EXP";
            //"Password EXP";
            //"Created EXP";
            //"B2B Customer EXP";
            //"Currency Code EXP";
            //"Secondary Currency Code EXP";
            //"State EXP";

            // >> EIS3.02
            if "Currency Code EXP" = InternetShopSetup."Internet Default Curr Code EXP" then
                Customer.VALIDATE("Currency Code", '')
            else
                // << EIS3.02
                // >> EIS2.01
                Customer.VALIDATE("Currency Code", "Currency Code EXP");
            // << EIS2.01

            Customer.INSERT;
        end;
    end;

    local procedure FindCustomer(var InternetCustomer: Record "Internet Customer EXP"): Boolean;
    var
        CustToFind: Record Customer;
        TempCustFound: Record Customer temporary;
        Found: Boolean;
        OK: Boolean;
    begin
        CLEAR(CustToFind);
        CLEAR(TempCustFound);

        Found := false;
        OK := false;

        // Match on Phone No.
        if InternetCustomer."Phone No. EXP" <> '' then begin
            CustToFind.SETRANGE("Phone No.", InternetCustomer."Phone No. EXP");
            Found := Found or Match(CustToFind, TempCustFound);
            CustToFind.SETRANGE("Phone No.");
        end;

        // Match on E-Mail
        if InternetCustomer."E-Mail EXP" <> '' then begin
            CustToFind.SETRANGE("E-Mail", InternetCustomer."E-Mail EXP");
            Found := Found or Match(CustToFind, TempCustFound);
            CustToFind.SETRANGE("E-Mail");
        end;

        if Found then begin
            if CONFIRM(
                 Text001 +
                 Text002,
                 true, CustToFind.TABLENAME, TABLENAME)
            then begin
                TempCustFound.FIND('-');
                if PAGE.RUNMODAL(PAGE::"Customer List", TempCustFound) = ACTION::LookupOK then begin
                    VALIDATE("Customer No. EXP", TempCustFound."No.");
                    MODIFY;
                    OK := true;
                end else
                    ERROR(Text003, CustToFind.TABLENAME, TABLENAME);
            end;
        end;

        exit(OK);
    end;

    local procedure Match(var CustToFind: Record Customer; var TempCustFound: Record Customer temporary): Boolean;
    var
        Found: Boolean;
    begin
        if CustToFind.FIND('-') then begin
            repeat
                TempCustFound := CustToFind;
                if TempCustFound.INSERT then;
            until CustToFind.NEXT = 0;
            Found := true;
        end;

        exit(Found);
    end;

    /// <summary>
    /// UpdateToCustomer.
    /// </summary>
    procedure UpdateToCustomer();
    begin
        if "Customer No. EXP" <> '' then
            if Customer.GET("Customer No. EXP") then begin
                //Customer.TRANSFERFIELDS(Rec);
                //
                Customer.Name := "Name EXP";
                Customer.Address := "Address EXP";
                Customer."Address 2" := "Address 2 EXP";
                Customer.City := "City EXP";
                Customer.Contact := "Contact EXP";
                Customer."Phone No." := "Phone No. EXP";
                Customer."Country/Region Code" := "Country Code EXP";
                //"Last Date Modified EXP";
                Customer."Post Code" := "Post Code EXP";
                Customer.County := "County EXP";
                Customer."E-Mail" := "E-Mail EXP";
                //"No. EXP";
                //"Login EXP";
                //"Password EXP";
                //"Created EXP";
                //"B2B Customer EXP";
                //"Currency Code EXP";
                //"Secondary Currency Code EXP";
                //"State EXP";
                Customer.MODIFY;
            end;
    end;

    /// <summary>
    /// UpdateToCustomerYesNo.
    /// </summary>
    procedure UpdateToCustomerYesNo();
    begin
        TESTFIELD("B2B Customer EXP", false);

        if "Customer No. EXP" <> '' then begin
            if CONFIRM(Text004,
                       true,
                       Rec.TABLENAME,
                       "Customer No. EXP",
                       Customer.TABLENAME)
            then begin
                UpdateToCustomer;
            end;
        end else begin
            MESSAGE(Text005, Customer.TABLENAME, Rec.TABLENAME);
        end;
    end;

    /// <summary>
    /// B2B Enable.
    /// </summary>
    procedure "B2B Enable"();
    begin
        TESTFIELD("Customer No. EXP");
        Customer.GET("Customer No. EXP");

        if CONFIRM(Text006) then begin
            InternetCustomerB2B.INIT;
            InternetCustomerB2B."No. EXP" := "No. EXP";
            InternetCustomerB2B."Customer No. EXP" := "Customer No. EXP";
            InternetCustomerB2B."Contact EXP" := "Contact EXP";
            InternetCustomerB2B."E-Mail EXP" := "E-Mail EXP";
            InternetCustomerB2B."Login EXP" := "Login EXP";
            InternetCustomerB2B."Password EXP" := "Password EXP";
            InternetCustomerB2B.INSERT;
            // >> EIS2.01
            if (not Customer."Enable Shop Logins EXP") then begin
                Customer."Enable Shop Logins EXP" := true;
                Customer.MODIFY(true);
            end
            // << EIS2.01
        end;
    end;

    /// <summary>
    /// GetSalesCustomer.
    /// </summary>
    /// <returns>Return value of type Code[20].</returns>
    procedure GetSalesCustomer(): Code[20];
    begin
        if "Customer No. EXP" <> '' then
            exit("Customer No. EXP")
        else
            if InternetCustomerB2B.GET("No. EXP") then
                exit(InternetCustomerB2B."Customer No. EXP")
            else
                exit('');
    end;
}

