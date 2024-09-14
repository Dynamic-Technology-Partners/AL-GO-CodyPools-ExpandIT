/// <summary>
/// Page Internet Customer B2B List EXP (ID 68708).
/// </summary>
page 68708 "Internet Customer B2B List EXP"
{
    // version EIS5.04.01

    // EIS2.01  2006-10-06  RSP * Added Impersonate menu item
    // 
    // EIS3.01  2008-05-22  JR  * Call to different impersonate function.
    // 
    // EIS4.02.02
    //          2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS5.04.01  2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM18.0.6.47 2020-04-06 FAM * Maintain B2B logic 

    Caption = 'Internet Customer B2B List', Comment = 'DAN="Internet Kunde B2B Liste",DEU="Internet Kundeliste B2B",ESP="Lista Clientes B2B",FRA="Liste clients Internet B2B",SVE="Internet kund B2B lista"';
    DelayedInsert = true;
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "Internet Customer B2B EXP";


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Contact; Rec."Contact EXP")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail EXP")
                {
                    ApplicationArea = All;
                }
                field(Login; Rec."Login EXP")
                {
                    ApplicationArea = All;
                }
                field(Password; Rec."Password EXP")
                {
                    ExtendedDatatype = Masked;
                    ApplicationArea = All;
                }
                field(Enable; Rec.Enable)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'DAN="F&unktioner",DEU="F&unktionen",ESP="F&unciones",FRA="Fonction&s",SVE="Fu&nktion"';
                action("Mail Login information")
                {
                    Caption = 'Mail Login information', Comment = 'DAN="Send adgangsinformation",DEU="Mail Anmeldungsinformationen",ESP="Enviar Información de Acceso",FRA="Envoyer e-mail avec login",SVE="Epost inloggningsinformation"';
                    Image = SendTo;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        tmpPass: Text[10];
                    begin
                        Rec.TESTFIELD("No. EXP");

                        if CONFIRM('This function will create a random password for the Login.\Do you want to continue?') then begin
                            InternetShopMgt.Randomize;
                            tmpPass := InternetShopMgt.GenerateRandomAlphaNum(6);
                            InternetShopMgt.InternetNewLoginInfo(Rec."E-Mail EXP", Rec."Login EXP", tmpPass);
                            Rec.VALIDATE("Password EXP", tmpPass);
                            Rec.MODIFY;
                        end;
                    end;
                }
                action(Impersonate)
                {
                    Caption = 'Impersonate', Comment = 'DAN="Login som kunde",DEU="darstellen",ESP="Impersonalizar",FRA="Imiter client Internet",SVE="Personifiera"';
                    Image = CustomerLedger;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        InternetShopMgt: Codeunit "Internet Shop Management EXP";
                        InternetCustomer: Record "Internet Customer EXP";
                    begin
                        InternetShopMgt.ImpersonateB2B(Rec);
                        //IF(InternetCustomer.GET("No.")) THEN BEGIN
                        //    InternetShopMgt.Impersonateb2b(rec);
                        //    message('xx');
                        //END;
                    end;
                }
            }
        }
    }


    trigger OnAfterGetRecord();
    begin
        AfterGetCurrRecord;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec."Customer No. EXP" := CustomerNo;
        if not WarningShown then begin
            Rec.CheckCustomerEnabled;
            WarningShown := true;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        AfterGetCurrRecord;
    end;

    var
        InternetShopSetup: Record "Sales & Receivables Setup";
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        WarningShown: Boolean;
        CustomerNo: Code[20];

    local procedure AfterGetCurrRecord();
    begin
        xRec := Rec;
        if Rec."Customer No. EXP" <> xRec."Customer No. EXP" then
            WarningShown := false;
    end;
    // EMSM18.0.6.47 begin
    /// <summary>
    /// SetCustomerNo.
    /// </summary>
    /// <param name="CustomerNoLocal">Code[20].</param>
    procedure SetCustomerNo(CustomerNoLocal: Code[20])
    begin
        CustomerNo := CustomerNoLocal;
    end;
    // EMSM18.0.6.47 end
}

