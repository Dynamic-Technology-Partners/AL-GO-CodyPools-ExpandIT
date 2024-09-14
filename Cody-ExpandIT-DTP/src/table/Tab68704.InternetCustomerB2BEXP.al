/// <summary>
/// Table Internet Customer B2B EXP (ID 68704).
/// </summary>
table 68704 "Internet Customer B2B EXP"
{
    // version EIS5.04.01

    // EIS4.02.01  2012-05-14  PB * @ is a meta-character in NAV filters. Problem fixed in the Login.OnValidate
    //                         PB * Length of Login changed to 50
    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'Internet Customer B2B', Comment = 'DAN="Internet-kunde B2B",DEU="Internetkunde B2B",ESP="Cliente B2B",FRA="Client Internet B2B",SVE="Internet kund B2B"';
    DrillDownPageID = "Internet Customer List EXP";
    LookupPageID = "Internet Customer List EXP";

    fields
    {
        field(1; "Customer No. EXP"; Code[20])
        {
            Caption = 'Customer No.', Comment = 'DAN="Kundenummer.",DEU="Kunden Nr.",ESP="No. Cliente",FRA="N° client",SVE="Kundnr"';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(8; "Contact EXP"; Text[30])
        {
            Caption = 'Contact', Comment = 'DAN="Attention",DEU="Kontakt",ESP="Contacto",FRA="Contact",SVE="Kontaktperson"';
            DataClassification = CustomerContent;
        }
        field(102; "E-Mail EXP"; Text[80])
        {
            Caption = 'E-Mail', Comment = 'DAN="E-mail",DEU="e-mail",ESP="E-Mail",FRA="E-mail",SVE="E-post"';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(78700; "No. EXP"; Text[38])
        {
            Caption = 'No.', Comment = 'DAN="Nummer",DEU="Nr.",ESP="No.",FRA="N°",SVE="Nr"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(78701; "Login EXP"; Text[50])
        {
            Caption = 'Login', Comment = 'DAN="Login",DEU="Anmeldung",ESP="Login",FRA="Login",SVE="Inloggning"';
            Description = 'EIS5.04.01';
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CLEAR(InternetCustomerB2B);
                CLEAR(InternetCustomer);

                //Avoid duplicate logins without case sensitivity.
                //
                //@ is a meta-character in NAV filters.
                //If the login contains a '@', the '@' in the filter is replaced with a '?'. If this was not done, the
                //filter 'support@expandit.com' will find 'supportexpandit.com', which would have been wrong.
                //With the filter 'support?expandit.com', the find command will find 'support@expandit.com' and for example
                //'support.expandit.com' the login with the '@' is found by looping trough the logins found by the filter.
                //This reduced set of records is compared to the new login by simple string compare, which does not
                //have the problem having the '@' as a meta character.

                InternetCustomer.SETCURRENTKEY("Login EXP");
                InternetCustomer.SETFILTER("Login EXP", '@' + CONVERTSTR("Login EXP", '@', '?'));
                if "No. EXP" <> '' then
                    InternetCustomer.SETFILTER("No. EXP", '<>%1', "No. EXP");

                if InternetCustomer.FIND('-') then
                    repeat
                        if LOWERCASE("Login EXP") = LOWERCASE(InternetCustomer."Login EXP") then
                            ERROR(TEXT000, "Login EXP");
                    until InternetCustomer.NEXT = 0;

                InternetCustomerB2B.SETCURRENTKEY("Login EXP", "No. EXP");
                InternetCustomerB2B.SETFILTER("Login EXP", '@' + CONVERTSTR("Login EXP", '@', '?'));
                if "No. EXP" <> '' then
                    InternetCustomerB2B.SETFILTER("No. EXP", '<>%1', "No. EXP");

                if InternetCustomerB2B.FIND('-') then
                    repeat
                        if LOWERCASE("Login EXP") = LOWERCASE(InternetCustomerB2B."Login EXP") then
                            ERROR(TEXT000, "Login EXP");
                    until InternetCustomerB2B.NEXT = 0;
            end;
        }
        field(78702; "Password EXP"; Text[20])
        {
            Caption = 'Password', Comment = 'DAN="Kodeord",DEU="Passwort",ESP="Password",FRA="Mot de passe",SVE="Lösenord"';
            Description = 'EIS5.04.01';
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (InternetShopMgt.Encrypt("Password EXP") <> xRec."Password EXP") and (CurrFieldNo <> 0) then begin
                    MailLoginYesNo("E-Mail EXP", "Login EXP", "Password EXP");
                end;

                InternetShopMgt.Randomize;
                "Password Version EXP" := InternetShopMgt.GenerateGuid();
                if "Password Version EXP" = xRec."Password Version EXP" then
                    ERROR(TEXT001);

                "Password EXP" := InternetShopMgt.Encrypt("Password EXP");
            end;
        }
        field(78710; "Password Version EXP"; Text[38])
        {
            Caption = 'Password Version', Comment = 'DAN="Kodeord Version",DEU="Passwort Version",ESP="Versión de Password",FRA="Version mot de passe",SVE="Lösenordversion"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(78711; Enable; Boolean)
        {
            Caption = 'Enable', Comment = 'DAN="Aktiv",DEU="Möglich",ESP="Activo",FRA="Activer",SVE="Aktivera"';
            Description = 'EIS5.04.01';
            InitValue = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Enable then
                    CheckCustomerEnabled;
            end;
        }

        field(78712; "DummyTimeStamp"; BigInteger)
        {
            Caption = 'Dummy Timestamp', Comment = 'DAN="Dummy Tidsstempel",DEU="Pseudo Zeitmarke",ESP="",FRA="Horodatage factice ",SVE=""';
            ;
            SqlTimestamp = true;
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
        key(Key3; "Login EXP", "No. EXP")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        InternetShopMgt.Randomize;
        if "No. EXP" = '' then
            "No. EXP" := InternetShopMgt.GenerateGuid;

        TESTFIELD("Login EXP");
        TESTFIELD("Password EXP");
        TESTFIELD("E-Mail EXP");
    end;

    var
        Customer: Record Customer;
        InternetCustomer: Record "Internet Customer EXP";
        InternetShopSetup: Record "Sales & Receivables Setup";
        InternetCustomerB2B: Record "Internet Customer B2B EXP";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        WarningShown: Boolean;
        TEXT000: Label 'Login %1 is already in use.', Comment = 'DAN="Login %1 er allerede i brug.",DEU="Anmeldung %1 ist bereits aktiv.",ESP="Login %1 ya está en uso.",FRA="Login n''est pas disponible.",SVE="Inloggad %1 används redan."';
        //TextConst DAN='Login %1 er allerede i brug.',DEU='Anmeldung %1 ist bereits aktiv.',ENU='Login %1 is already in use.',ESP='Login %1 ya está en uso.',FRA='Login n''est pas disponible.',SVE='Inloggad %1 används redan.';
        TEXT001: Label 'Error encrypting password. Please try again.', Comment = 'DAN="Fejl ved kryptering af kodeord. Prøv igen.",DEU="Fehler beim entschlüsseln des Passworts. Bitte versuchen Sie es nochmals.",ESP="Error encriptando password. Inténtelo de nuevo.",FRA="Cryptage de mot de passe échoué. Veuillez réessayer.",SVE="Felaktigt lösenord. V.g försök igen."';
        //TextConst DAN='Fejl ved kryptering af kodeord. Prøv igen.',DEU='Fehler beim entschlüsseln des Passworts. Bitte versuchen Sie es nochmals.',ENU='Error encrypting password. Please try again.',ESP='Error encriptando password. Inténtelo de nuevo.',FRA='Cryptage de mot de passe échoué. Veuillez réessayer.',SVE='Felaktigt lösenord. V.g försök igen.';
        TEXT002: Label 'The password has been changed. Would you like\', Comment = 'DAN="Der er blevet skiftet kodeord på Kunden. Ønsker du at sende\",DEU="Das Passwort wurde verändert. Wünsche Sie das\",ESP="La password ha cambiado. ¿Desea\",FRA="Le mote de passe a été changé.",SVE="Lösenordet har ändrats. Vill ni\"';
        //TextConst DAN='Der er blevet skiftet kodeord på Kunden. Ønsker du at sende\',DEU='Das Passwort wurde verändert. Wünsche Sie das\',ENU='The password has been changed. Would you like\',ESP='La password ha cambiado. ¿Desea\',FRA='Le mote de passe a été changé.',SVE='Lösenordet har ändrats. Vill ni\';
        TEXT003: Label 'to send the new login information to the customer?', Comment = 'DAN="en mail med det nye kodeord til kunden?",DEU="Neue Anmeldeinformationen dem Kunden senden?",ESP="enviar la nueva información de acceso al cliente?",FRA="Voulez-vous envoyer le login au client ?",SVE="skicka den nya inloggningsinformationen till kunden?"';
        //TextConst DAN='en mail med det nye kodeord til kunden?',DEU='Neue Anmeldeinformationen dem Kunden senden?',ENU='to send the new login information to the customer?',ESP='enviar la nueva información de acceso al cliente?',FRA='Voulez-vous envoyer le login au client ?',SVE='skicka den nya inloggningsinformationen till kunden?';
        TEXT004: Label 'Warning: Shop Logins are not enabled for %1 %2.', Comment = 'DAN="Advarsel: %1 er slået fra på %2 %3.",DEU="Warnung: Shop Anmeldung ist nicht möglich für %1 %2.",ESP="Atención: Accesos a tienda no activados para %1 %2.",FRA="Attention : Logins Internet n''est pas activés pour %1 %2.",SVE="Varning: Shop inloggning är inte aktiverade för %1 %2."';
    //TextConst DAN='Advarsel: %1 er slået fra på %2 %3.',DEU='Warnung: Shop Anmeldung ist nicht möglich für %1 %2.',ENU='Warning: Shop Logins are not enabled for %1 %2.',ESP='Atención: Accesos a tienda no activados para %1 %2.',FRA='Attention : Logins Internet n''est pas activés pour %1 %2.',SVE='Varning: Shop inloggning är inte aktiverade för %1 %2.';

    /// <summary>
    /// MailLoginYesNo.
    /// </summary>
    /// <param name="E-Mail">Text[80].</param>
    /// <param name="Login">Text[20].</param>
    /// <param name="Password">Text[20].</param>
    procedure MailLoginYesNo("E-Mail": Text[80]; Login: Text[20]; Password: Text[20]);
    begin
        if CONFIRM(TEXT002 +
                    TEXT003
                    , true, TABLENAME)
        then
            InternetShopMgt.InternetNewLoginInfo("E-Mail", Login, Password);
    end;

    /// <summary>
    /// CheckCustomerEnabled.
    /// </summary>
    procedure CheckCustomerEnabled();
    begin
        if Customer.GET("Customer No. EXP") then
            if not Customer."Enable Shop Logins EXP" then
                MESSAGE(TEXT004, Customer.TABLENAME, Customer."No.");
    end;

}

