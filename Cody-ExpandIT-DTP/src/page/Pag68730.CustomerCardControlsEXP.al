/// <summary>
/// Page Customer Card - Controls EXP (ID 68730).
/// </summary>
page 68730 "Customer Card - Controls EXP"
{
    // version EIS4.02.02,COPYPASTE

    // EIS4.01     2010-09-08 JR  * The purpose of this form is to hold controls that you
    //                              can copy and paste to forms using the same source table.
    // 
    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS4.02.02  2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&ExpandIT")
            {
                Caption = '&ExpandIT', Comment = 'DAN="&ExpandIT",DEU="&ExpandIT",ESP="&ExpandIT",FRA="&ExpandIT",SVE="&ExpandIT"';
                action("&Logins")
                {
                    Caption = '&Logins', Comment = 'DAN="&Logins",DEU="&Anmeldungen",ESP="&Logins",FRA="&Identifiants",SVE="&Inloggningar"';
                    Image = ICPartner;
                    RunObject = Page "Internet Customer B2B List EXP";
                    RunPageLink = "Customer No. EXP" = FIELD("No.");
                    ApplicationArea = All;
                }
                action("&Internet customer list")
                {
                    Caption = '&Internet customer list', Comment = 'DAN="&Internet Kundeoversigt",DEU="&Internet Kundenliste",ESP="&Lista Clientes Internet ",FRA="List de clients &Internet",SVE="&Internet kundlista"';
                    Image = Customer;
                    RunObject = Page "Internet Customer List EXP";
                    RunPageLink = "Customer No. EXP" = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }
}

