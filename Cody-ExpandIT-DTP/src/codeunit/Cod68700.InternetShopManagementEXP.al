/// <summary>
/// Codeunit Internet Shop Management EXP (ID 68700).
/// </summary>
codeunit 68700 "Internet Shop Management EXP"
{
    // version EIS6.0.12
    // EIS3.01   2008-05-16  JR  * Call to ASP pages was changed to handle ASPX for EIS versions later than 2.x
    //           2008-05-16  JR  * ImpersonateB2B and Impersonate functions added.
    //                           * CustomerImpersonate modified to use the Impersonate function.
    // 
    // EIS5.04.01   2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EIS5.04.05   2018-04-23  FAM * Clear(mail) is added.
    // EIS6.0.11 2020-08-12 FAM * Send login information as Email 
    // EIS6.0.12 2020-09-10 FAM * Get ExpandIT Setup record
    trigger OnRun();
    begin
    end;

    var
        ExpandITUtil: Codeunit "ExpandIT Util";
        InternetShopSetup: Record "ExpandIT Setup EXP";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        //Mail: Codeunit "SMTP Mail";
        MailMessage: Codeunit "Email Message";
        Mail: Codeunit "Email";
        NewLine: Text[2];
        chr13: Char;
        chr10: Char;
        RandomizeCalled: Boolean;
        TEXT000: Label 'ExpandIT Internet Shop: Rejected, Order no. ', Comment = 'DAN="ExpandIT Internet Shop : Afvist, Ordrenummer ",DEU="ExpandIT Internetshop: abgelehnt, Bestell Nr. ",ESP="ExpandIT Internet Shop: Rechazado, Pedido no. ",FRA="ExpandIT Internet Shop: Rejetée, N° commande",SVE="ExpandIT Internet Shop: Avvisade ordernr"';
        TEXT001: Label 'A problem occured during processing of your order.', Comment = 'DAN="Der opstod et problem under ordrebehandlingen.",DEU="Es ist ein Problem während der Bearbeitung Ihrer Bestellung aufgetreten.",ESP="Su pedido no pudo ser procesado.  ",FRA="Un problème est survenu pendant le traitement de votre commande.",SVE="Ett problem uppstod vid bearbetaning av din order."';
        TEXT002: Label 'Please see this page for details:', Comment = 'DAN="Se venligst denne side:",DEU="Bitte sehen Sie diese Seite für Details:",ESP="Por favor vea esta Página para detalles:",FRA="Consulter cette page pour plus d"';
        TEXT003: Label 'Best regards,', Comment = 'DAN="Venlig hilsen,",DEU="Mit freundlichen Grüssen,",ESP="Atentamente,",FRA="Cordialement,",SVE="Med vänlig hälsning"';
        TEXT004: Label ' ExpandIT Internet Shop', Comment = 'DAN=" ExpandIT Internet Shop",DEU=" ExpandIT Internetshop",ESP="ExpandIT Internet Shop",FRA=" ExpandIT Internet Shop",SVE=" ExpandIT Internet Shop"';
        TEXT005: Label 'ExpandIT Internet Shop: Received, Order no. ', Comment = 'DAN="ExpandIT Internet Shop : Modtaget, Ordrenummer ",DEU="ExpandIT Internetshop: empfangen, Bestell Nr. ",ESP="ExpandIT Internet Shop: Recibido, Pedido no. ",FRA="ExpandIT Internet Shop: Reçue, N° commande",SVE="ExpandIT Internet Shop: Mottagna ordernr. "';
        TEXT006: Label 'We have received your order', Comment = 'DAN="Vi har modtaget din ordre",DEU="Wir haben Ihre Bestellung empfangen",ESP="Hemos recibido su pedido",FRA="Nous avons reçu votre commande",SVE="Vi har mottagit din order"';
        TEXT007: Label 'Detailed information available at', Comment = 'DAN="Mere information på",DEU="Detailinformation verfügbar bei",ESP="Información detallada disponible en",FRA="Information détaillée sur",SVE="Detaljerad information finns på"';
        TEXT008: Label 'Thank You', Comment = 'DAN="Mange tak",DEU="Vielen Dank",ESP="Gracias",FRA="Merci",SVE="Tack så mycket"';
        TEXT009: Label 'ExpandIT Internet Shop : Login information: ', Comment = 'DAN="ExpandIT Internet Shop : Login information: ",DEU="ExpandIT Internetshop : Anmeldungsinformation: ",ESP="ExpandIT Internet Shop : Información de acceso: ",FRA="ExpandIT Internet Shop : Login :",SVE="ExpandIT Internet Shop : Inloggningsinformation: "';
        TEXT010: Label 'Your login information for ExpandIT Internet Shop is:', Comment = 'DAN="Brugerid og adgangskode til ExpandIT Internet Shop.",DEU="Ihre Anmeldeinformation für den ExpandIT Internetshop ist:",ESP="Su información de acceso para ExpandIT Internet Shop es:",FRA="Votre login pour ExpandIT Internet Shop est :",SVE="Din inloggning för ExpandIT Internet Shop är:"';
        TEXT011: Label 'Login    : ', Comment = 'DAN="Bruger ID : ",DEU="Anmeldung: ",ESP="Login    : ",FRA="Login    :",SVE="Inloggning    : "';
        TEXT012: Label 'Password : ', Comment = 'DAN="Adgangskode : ",DEU="Passwort : ",ESP="Password : ",FRA="Mot de passe :",SVE="Lösenord : "';
        TEXT013: Label 'Please change your password the next time you login at: ', Comment = 'DAN="Du bedes venligst ændre adgangskoden ved næste besøg i butikken.",DEU="Bitte ändern Sie bei der nächsten Anmeldung Ihr Passwort: ",ESP="Cambie su password la próxima que acceda a: ",FRA="S"';

    /// <summary>
    /// ChooseCustomer.
    /// </summary>
    procedure ChooseCustomer();
    begin
    end;

    /// <summary>
    /// CustomerImpersonate.
    /// </summary>
    /// <param name="InternetCustomer">Record "Internet Customer EXP".</param>
    procedure CustomerImpersonate(InternetCustomer: Record "Internet Customer EXP");
    begin
        InternetCustomer.TESTFIELD("Login EXP");
        Impersonate(InternetCustomer."No. EXP");
    end;

    /// <summary>
    /// ImpersonateB2B.
    /// </summary>
    /// <param name="InternetCustomerB2B">Record "Internet Customer B2B EXP".</param>
    procedure ImpersonateB2B(InternetCustomerB2B: Record "Internet Customer B2B EXP");
    begin
        InternetCustomerB2B.TESTFIELD("Login EXP");
        Impersonate(InternetCustomerB2B."No. EXP");
    end;

    /// <summary>
    /// Impersonate.
    /// </summary>
    /// <param name="UserGuid">Text[40].</param>
    procedure Impersonate(UserGuid: Text[40]);
    var
        URL: Text[250];
    begin
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            URL := InternetShopSetup."Remote Shop URL EXP" + '/admin/impersonate.' + InternetShopSetup.ASPExtension() + '?UserGuid=%1';
            HYPERLINK(STRSUBSTNO(URL, URLEncode(UserGuid)));
        end;
    end;

    /// <summary>
    /// CustomerChangePassword.
    /// </summary>
    /// <param name="InternetCustomer">Record "Internet Customer EXP".</param>
    procedure CustomerChangePassword(InternetCustomer: Record "Internet Customer EXP");
    var
        URL: Text[250];
    begin
        InternetCustomer.TESTFIELD("Login EXP");
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12          
            URL := InternetShopSetup."Remote Shop URL EXP" + '/admin/password.' + InternetShopSetup.ASPExtension() + '?UserGuid=%1';
            HYPERLINK(STRSUBSTNO(URL, URLEncode(InternetCustomer."No. EXP")));
        end;
    end;

    /// <summary>
    /// FormatURL.
    /// </summary>
    /// <param name="URL">VAR Text[80].</param>
    procedure FormatURL(var URL: Text[80]);
    begin
        if URL <> '' then begin
            URL := LOWERCASE(URL);
            while COPYSTR(URL, STRLEN(URL), 1) = '/' do begin
                URL := COPYSTR(URL, 1, STRLEN(URL) - 1);
            end;
        end;
    end;

    /// <summary>
    /// URLEncode.
    /// </summary>
    /// <param name="URL">Text[250].</param>
    /// <returns>Return value of type Text[250].</returns>
    procedure URLEncode(URL: Text[250]): Text[250];
    begin
        // This fuction replaces { and } with the corrospondning HTML codes'
        URL := Replace(URL, '{', '%7B');
        URL := Replace(URL, '}', '%7D');
        exit(URL);
    end;

    /// <summary>
    /// InternetOrderRejected.
    /// </summary>
    /// <param name="E-mail">Text[80].</param>
    /// <param name="Internet Order No.">Text[38].</param>
    procedure InternetOrderRejected("E-mail": Text[80]; "Internet Order No.": Text[38]);
    var
        Subject: Text[250];
        Body: Text[250];
        Recipients: List of [Text];
        UserVar: Record User;
    begin
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            //EIS5.04.05 begin
            CLEAR(Mail);
            //EIS5.04.05 end
            chr13 := 13;
            chr10 := 10;
            NewLine := FORMAT(chr13) + FORMAT(chr10);
            Subject := TEXT000 + "Internet Order No.";
            Body := TEXT001 + NewLine +
                    NewLine +
                    TEXT002 + NewLine +
                    InternetShopSetup."Remote Shop URL EXP" + '/history_detail.' + InternetShopSetup.ASPExtension()
                      + '?HeaderGuid=' + URLEncode("Internet Order No.") +
                    NewLine +
                    NewLine +
                    TEXT003 + NewLine +
                    TEXT004;
            // EIS6.0.11 begin 
            CreateAndSendMail("E-mail", Subject, Body);
            // EIS6.0.11 end
        end;
    end;

    /// <summary>
    /// InternetOrderConverted.
    /// </summary>
    /// <param name="E-mail">Text[80].</param>
    /// <param name="Internet Order No.">Text[38].</param>
    procedure InternetOrderConverted("E-mail": Text[80]; "Internet Order No.": Text[38]);
    var
        Subject: Text[250];
        Body: Text[250];
        recipients: List of [Text];
        UserVar: Record User;
    begin
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            chr13 := 13;
            chr10 := 10;
            NewLine := FORMAT(chr13) + FORMAT(chr10);
            Subject := TEXT005 + "Internet Order No.";
            Body := TEXT006 + NewLine +
                    NewLine +
                    TEXT007 + NewLine +
                    InternetShopSetup."Remote Shop URL EXP" +
                    '/history_detail.' + InternetShopSetup.ASPExtension() + '?HeaderGuid=' + URLEncode("Internet Order No.") +
                    NewLine +
                    NewLine +
                    TEXT008 + NewLine +
                    TEXT004;
            // EIS6.0.11 begin 
            CreateAndSendMail("E-mail", Subject, Body);
            // EIS6.0.11 end
        end;
    end;

    /// <summary>
    /// InternetNewLoginInfo.
    /// </summary>
    /// <param name="E-mail">Text[80].</param>
    /// <param name="Login">Text[20].</param>
    /// <param name="Password">Text[20].</param>
    procedure InternetNewLoginInfo("E-mail": Text[80]; Login: Text[20]; Password: Text[20]);
    var
        Subject: Text[250];
        Body: Text[250];
        recipients: List of [Text];
        UserVar: Record User;
    begin
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            chr13 := 13;
            chr10 := 10;
            NewLine := FORMAT(chr13) + FORMAT(chr10);
            Subject := TEXT009 + Login;
            Body := TEXT010 + NewLine +
                    NewLine +
                    TEXT011 + Login + NewLine +
                    TEXT012 + Password + NewLine +
                    NewLine +
                    TEXT013 + NewLine +
                    InternetShopSetup."Remote Shop URL EXP" +
                    NewLine +
                    NewLine +
                    TEXT008 + NewLine +
                    TEXT004;
            // EIS6.0.10 begin
            CreateAndSendMail("E-mail", Subject, Body);
            // EIS6.0.10 end
        end;
    end;
    // EIS6.0.10 begin 
    /// <summary>
    /// CreateAndSendMail.
    /// </summary>
    /// <param name="ToEmail">Text[80].</param>
    /// <param name="Subject">Text[250].</param>
    /// <param name="Body">Text[250].</param>
    // procedure CreateAndSendMail(ToEmail: Text[80]; Subject: Text[250]; Body: Text[250])
    // var
    //     UserVar: Record User;
    //     SmtpMailSetup: Record "SMTP Mail Setup";
    //     recipients: List of [Text];
    //     ErrorEmptySMTPSetup: Label 'SMTP Mail Setup is empty', comment = 'ESP="", DAN="SMTP Mail Opsætning er tom", SVE="", FRA="", DEU=""';
    // begin
    //     recipients.Add(ToEmail);
    //     if SmtpMailSetup.GetSetup() then begin
    //         if SmtpMailSetup."Send As" <> '' then begin
    //             //Find user based on Email address entered in "Send As" field in SMTP Mail Setup
    //             UserVar.SetRange("Contact Email", SmtpMailSetup."Send As");
    //             if UserVar.FindFirst() then
    //                 SendMail(Subject, Body, recipients, UserVar)
    //             //if user can't be found, we'll use the UserId from the user who is logged in
    //             else begin
    //                 UserVar.SetRange("User Name", UserId());
    //                 if UserVar.FindFirst() then
    //                     SendMail(Subject, Body, recipients, UserVar);
    //             end;
    //         end else begin
    //             //If "Send As" field in SMTP Mail Setup is blank we'll use the email address from the user who is logged in
    //             UserVar.SetRange("User Name", UserId());
    //             if UserVar.FindFirst() then
    //                 SendMail(Subject, Body, recipients, UserVar);
    //         end;
    //     end else
    //         Error(ErrorEmptySMTPSetup);
    // end;
    // // EIS6.0.10 end
    // // EIS6.0.10 begin
    // procedure SendMail(Subject: Text[250]; Body: Text[250]; recipients: List of [Text]; UserParam: Record User)
    // var
    //     ErrorBlankUserMail: Label 'From Email(Users Contact Mail) is blank', comment = 'DAN="Fra E-mail (Brugerens Email) er blank", ESP="", DEU="",FRA="",SVE=""';
    // begin
    //     if (UserParam."Contact Email" <> '') then begin
    //         //Mail.CreateMessage(UserParam."Full Name", UserParam."Contact Email", recipients, Subject, Body);
    //         // Mail.Send();
    //         Mail.Create(recipients, Subject, Body);
    //         //Mail.CreateMessage(recipients, Subject, Body, true);
    //         //Mail.Run();
    //     end else
    //         Error(ErrorBlankUserMail);
    // end;
    // EIS6.0.10 end
    /// <returns>Return variable var UserVar of type Record User.</returns>
    procedure CreateAndSendMail(ToEmail: Text[80]; Subject: Text[250]; Body: Text[250])
    var
        UserVar: Record User;
        //SmtpMailSetup: Record "SMTP Mail Setup";
        EmailAcc: Page "Email Accounts";
        recipients: List of [Text];
        ErrorEmptySMTPSetup: Label 'SMTP Mail Setup is empty', comment = 'ESP="", DAN="SMTP Mail Opsætning er tom", SVE="", FRA="", DEU=""';
    begin
        recipients.Add(ToEmail);
        UserVar.SetRange("User Name", UserId());
        if UserVar.FindFirst() then
            SendMail(Subject, Body, recipients, UserVar);
    end;
    // EIS6.0.10 end
    // EIS6.0.10 begin
    /// <summary>
    /// SendMail.
    /// </summary>
    /// <param name="Subject">Text[250].</param>
    /// <param name="Body">Text[250].</param>
    /// <param name="recipients">List of [text].</param>
    /// <param name="UserParam">Record User.</param>
    procedure SendMail(Subject: Text[250]; Body: Text[250]; recipients: List of [text]; UserParam: Record User)
    var
        ErrorBlankUserMail: Label 'From Email(Users Contact Mail) is blank', comment = 'DAN="Fra E-mail (Brugerens Email) er blank", ESP="", DEU="",FRA="",SVE=""';
    begin
        MailMessage.Create(recipients, Subject, Body, false);
        Mail.Send(MailMessage);
    end;
    // EIS6.0.10 end
    /// <summary>
    /// GenerateShopperID.
    /// </summary>
    /// <returns>Return value of type Text[24].</returns>
    procedure GenerateShopperID(): Text[24];
    var
        InternetShopSetup: Record "ExpandIT Setup EXP";
    begin
        if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
            InternetShopSetup.LOCKTABLE;
            if (InternetShopSetup."Last Used ShopperID EXP" = '') then InternetShopSetup."Last Used ShopperID EXP" := '000000000000';
            InternetShopSetup."Last Used ShopperID EXP" := INCSTR(InternetShopSetup."Last Used ShopperID EXP");
            InternetShopSetup.MODIFY;
            exit(InternetShopSetup."Last Used ShopperID EXP" + GenerateRandom(12));
        end;
    end;

    local procedure GenerateRandom(Length: Integer): Text[250];
    begin
        exit(GenerateRandomGeneral(Length, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
    end;

    /// <summary>
    /// GenerateRandomAlphaNum.
    /// </summary>
    /// <param name="Length">Integer.</param>
    /// <returns>Return value of type Text[250].</returns>
    procedure GenerateRandomAlphaNum(Length: Integer): Text[250];
    var
        Result: Text[250];
        InStr: Text[250];
        i: Integer;
    begin
        exit(GenerateRandomGeneral(Length, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'));
    end;

    local procedure GenerateRandomGeneral(Length: Integer; InStr: Text[250]): Text[250];
    var
        Result: Text[250];
        i: Integer;
        MaxRand: Integer;
        r: Decimal;
        r2: Integer;
    begin
        MaxRand := 1073741824;
        if Length < 250 then begin
            Result := '';
            for i := 1 to Length do begin
                r := RANDOM(MaxRand);
                r2 := ROUND((r / MaxRand) * (STRLEN(InStr) - 1), 1) + 1;
                Result := Result + FORMAT(InStr[r2]);
            end;
            exit(Result);
        end;
    end;

    /// <summary>
    /// GenerateGuid.
    /// </summary>
    /// <returns>Return value of type Text[38].</returns>
    procedure GenerateGuid(): Text[38];
    begin
        exit(GenerateRandomGeneral(8, '0123456789ABCDEF') + '-' +
             GenerateRandomGeneral(4, '0123456789ABCDEF') + '-' +
             GenerateRandomGeneral(4, '0123456789ABCDEF') + '-' +
             GenerateRandomGeneral(4, '0123456789ABCDEF') + '-' +
             GenerateRandomGeneral(12, '0123456789ABCDEF'));
    end;

    /// <summary>
    /// Randomize.
    /// </summary>
    procedure Randomize();
    var
        number: Integer;
    begin
        if not RandomizeCalled then begin
            System.Randomize();
            RandomizeCalled := TRUE;
        end;
    end;

    /// <summary>
    /// Encrypt.
    /// </summary>
    /// <param name="s">Text[125].</param>
    /// <returns>Return value of type Text[250].</returns>
    procedure Encrypt(s: Text[125]): Text[250];
    var
        i: Integer;
        r: Text[250];
        ch: Char;
    begin
        for i := 1 to STRLEN(s) do begin
            ch := s[i];
            ch := intXOR(ch, 111);
            r := r + toHex(ch);
        end;
        exit(r);
    end;

    /// <summary>
    /// Decrypt.
    /// </summary>
    /// <param name="s">Text[125].</param>
    /// <returns>Return value of type Text[250].</returns>
    procedure Decrypt(s: Text[125]): Text[250];
    var
        i: Integer;
        r: Text[250];
        str: Text[10];
        ch: Char;
    begin
        for i := 1 to STRLEN(s) / 2 do begin
            str := COPYSTR(s, (i - 1) * 2 + 1, 2);
            ch := fromHex(str);
            ch := intXOR(ch, 111);
            r := r + FORMAT(ch);
        end;
        exit(r);
    end;

    local procedure intXOR(a: Integer; b: Integer): Integer;
    var
        c: Integer;
        n: Integer;
    begin
        c := 0;
        n := 0;
        while (a > 0) or (b > 0) do begin
            c := c + BoolNum(BoolVal(a mod 2) xor BoolVal(b mod 2)) * POWER(2, n);
            a := a div 2;
            b := b div 2;
            n := n + 1;
        end;
        exit(c);
    end;

    local procedure BoolVal(int: Integer): Boolean;
    begin
        if int <> 0 then
            exit(true)
        else
            exit(false);
    end;

    local procedure BoolNum(bool: Boolean): Integer;
    begin
        if bool then
            exit(1)
        else
            exit(0);
    end;

    local procedure toHex(Char: Char): Text[2];
    var
        Ascii: Integer;
        a: Integer;
        b: Integer;
        Hex: Text[3];
    begin
        Ascii := Char;
        repeat
            a := Ascii div 16;
            b := Ascii mod 16;
            Ascii := a;
            Hex := COPYSTR('0123456789ABCDEF', b + 1, 1) + Hex;
        until Ascii = 0;
        if STRLEN(Hex) < 2 then
            Hex := '0' + Hex;
        exit(Hex);
    end;

    local procedure fromHex(hex: Text[2]): Char;
    var
        Ascii: Integer;
        a: Integer;
        b: Integer;
    begin
        a := STRPOS('0123456789ABCDEF', COPYSTR(hex, 1, 1)) - 1;
        b := STRPOS('0123456789ABCDEF', COPYSTR(hex, 2, 1)) - 1;
        exit(a * 16 + b)
    end;

    /// <summary>
    /// Replace.
    /// </summary>
    /// <param name="expression">Text[250].</param>
    /// <param name="find">Text[250].</param>
    /// <param name="replacewith">Text[250].</param>
    /// <returns>Return value of type Text[250].</returns>
    procedure Replace(expression: Text[250]; find: Text[250]; replacewith: Text[250]): Text[250];
    var
        pos: Integer;
        pos2: Integer;
    begin
        pos := STRPOS(expression, find);
        while pos > 0 do begin
            expression := COPYSTR(expression, 1, pos - 1) + replacewith + COPYSTR(expression, pos + STRLEN(find));
            pos2 := STRPOS(COPYSTR(expression, pos + STRLEN(replacewith)), find);
            if pos2 > 0 then
                pos := pos + STRLEN(replacewith) + pos2 - 1
            else
                pos := 0;
        end;
        exit(expression);
    end;
}

