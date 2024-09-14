/// <summary>
/// Table e-payment Provider EXP (ID 68706).
/// </summary>
table 68706 "e-payment Provider EXP"
{
    // version EIS5.04.01,EPAY1.1

    // EIS4.00   2010-08-23 JR   * Extended datatype properties added for email and url fields.
    // EIS5.04.01   2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'e-payment Provider', Comment = 'DAN="e-betalings Udbyder",DEU="e-payment Anbieter",ESP="Código Proveedor de pago",FRA="Fournisseur de paiement en ligne",SVE="e-betalning provider"';
    DrillDownPageID = "e-payment Providers EXP";
    LookupPageID = "e-payment Providers EXP";

    fields
    {
        field(1; "Code EXP"; Code[10])
        {
            Caption = 'Code', Comment = 'DAN="Kode",DEU="Code",ESP="Código",FRA="Code",SVE="Kod"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(2; "Name EXP"; Text[30])
        {
            Caption = 'Name', Comment = 'DAN="Navn",DEU="Name",ESP="Nombre",FRA="Nom",SVE="Namn"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Search Name EXP" = UPPERCASE(xRec."Name EXP")) or ("Search Name EXP" = '') then
                    "Search Name EXP" := "Name EXP";
            end;
        }
        field(3; "Merchant ID EXP"; Text[80])
        {
            Caption = 'Merchant ID', Comment = 'DAN="Merchant ID",DEU="Kaufmann ID",ESP="ID Mercantil",FRA="ID marchand",SVE="SäljID"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(4; "Login User ID EXP"; Text[30])
        {
            Caption = 'Login User ID', Comment = 'DAN="Login",DEU="Anwenderanmeldungs ID",ESP="Login User ID",FRA="Login",SVE="Inloggning användarID"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(5; "Password EXP"; Text[30])
        {
            Caption = 'Password', Comment = 'DAN="Password",DEU="Passwort",ESP="Contraseña",FRA="Mot de passe",SVE="Lösenord"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(6; "Home Page EXP"; Text[250])
        {
            Caption = 'Home Page', Comment = 'DAN="Hjemmeside",DEU="Home Page",ESP="Página Web",FRA="Page d''accueil",SVE="Hemsida"';
            Description = 'EIS5.04.01';
            ExtendedDatatype = URL;
            DataClassification = CustomerContent;
        }
        field(7; "Administration Page EXP"; Text[250])
        {
            Caption = 'Administration Page', Comment = 'DAN="Administrationsside",DEU="Administrations-Seite",ESP="Página Administración",FRA="Page d''administration",SVE="Administrationsida"';
            Description = 'EIS5.04.01';
            ExtendedDatatype = URL;
            DataClassification = CustomerContent;
        }
        field(8; "Provider Type EXP"; Option)
        {
            Caption = 'Provider Type', Comment = 'DAN="Udbyder Type",DEU="Anbietertyp",ESP="Tipo Proveedor",FRA="Type fournisseur de paiement en ligne",SVE="Providertyp"';
            Description = 'EIS5.04.01';
            OptionCaption = ' ,Architrade,Cybercity,Authorize.Net', Comment = 'DAN=" ,Architrade,Cybercity,Authorize.Net",DEU=" ,Architrade,Cybercity,Authorize.Net",ESP=",Architrade,Cybercity,Authorize.Net",FRA=" ,Architrade,Cybercity,Authorize.Net",SVE=" ,Architrade,Cybercity,Authorize.Net"';
            OptionMembers = " ",Architrade,Cybercity,"Authorize.Net";
            DataClassification = CustomerContent;
        }
        field(9; "Clearing Validity Period EXP"; Code[10])
        {
            Caption = 'Clearing Validity Period', Comment = 'DAN="Clearing Validitets Periode",DEU="Verrechnung der gültigen Periode",ESP="Periodo de validación",FRA="Période de validité de l''acceptation",SVE="Clearing giltighetsperiod"';
            DateFormula = true;
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(10; "Shared Secret EXP"; Text[250])
        {
            Caption = 'Shared Secret', Comment = 'DAN="Delt hemmelighed",DEU="teilweise sicher",ESP="Shared Secret",FRA="Secret partagé",SVE="Delad säkerhet"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(11; "Search Name EXP"; Code[30])
        {
            Caption = 'Search Name', Comment = 'DAN="Søgenavn",DEU="Suchname",ESP="Buscar nombre",FRA="Nom de recherche",SVE="Söknamn"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(12; "Name 2 EXP"; Text[30])
        {
            Caption = 'Name 2', Comment = 'DAN="Navn 2",DEU="Name 2",ESP="Nombre 2",FRA="Nom 2",SVE="Namn 2"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(13; "Address EXP"; Text[30])
        {
            Caption = 'Address', Comment = 'DAN="Adresse",DEU="Adresse",ESP="Dirección",FRA="Adresse",SVE="Adress"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(14; "Address 2 EXP"; Text[30])
        {
            Caption = 'Address 2', Comment = 'DAN="Adresse 2",DEU="Adresse 2",ESP="Dirección 2",FRA="Adresse (2ème ligne)",SVE="Adress 2"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(15; "Post Code EXP"; Code[20])
        {
            Caption = 'Post Code', Comment = 'DAN="Postnr.",DEU="PLZ",ESP="Código Postal",FRA="Code postal",SVE="Postnr"';
            Description = 'EIS5.04.01';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if PostCode.GET("Post Code EXP") then
                    "City EXP" := PostCode.City;
            end;
        }
        field(16; "City EXP"; Text[30])
        {
            Caption = 'City', Comment = 'DAN="By",DEU="Stadt",ESP="Provincia",FRA="Ville",SVE="Ort"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(17; "County EXP"; Text[30])
        {
            Caption = 'County', Comment = 'DAN="Amt",DEU="Land",ESP="País",FRA="Région",SVE="Delstat"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(18; "Country Code EXP"; Code[10])
        {
            Caption = 'Country Code', Comment = 'DAN="Landekode",DEU="Ländercode",ESP="Cod. País",FRA="Code pays/région",SVE="Postnr"';
            Description = 'EIS5.04.01';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(19; "Contact EXP"; Text[30])
        {
            Caption = 'Contact', Comment = 'DAN="Attention",DEU="Kontakt",ESP="Contacto",FRA="Contact",SVE="Kontaktperson"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(20; "Phone No. EXP"; Text[30])
        {
            Caption = 'Phone No.', Comment = 'DAN="Telefon",DEU="Telefon Nr.",ESP="Nº Teléfono",FRA="N° téléphone",SVE="Telefonnr"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(21; "Fax No. EXP"; Text[30])
        {
            Caption = 'Fax No.', Comment = 'DAN="Telefax",DEU="Fax Nr.",ESP="Nº Fax",FRA="N° télécopie",SVE="Faxnr"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(22; "Picture EXP"; BLOB)
        {
            Caption = 'Picture', Comment = 'DAN="Billed",DEU="Bild",ESP="Imágen",FRA="Image",SVE="Bild"';
            Description = 'EIS5.04.01';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(23; "E-Mail EXP"; Text[80])
        {
            Caption = 'E-Mail', Comment = 'DAN="E-Mail",DEU="E-Mail",ESP="E-Mail",FRA="E-mail",SVE="E-post"';
            Description = 'EIS5.04.01';
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;
        }
        field(75000; "API URL"; Text[120])
        {
            Caption = 'API URL';
            DataClassification = ToBeClassified;
            Description = 'API URL - DTP';
        }
    }

    keys
    {
        key(Key1; "Code EXP")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
}

