/// <summary>
/// Page ExpandIT Setup EXP (ID 68705).
/// </summary>
page 68705 "ExpandIT Setup EXP"
{
    // version EIS5.04.01,EMSM2.15
    // EIS3.01          2008-05-21  JR  * EIS Version field added.
    // EIS4.01          2010-09-03  JR  * EMCRM fields moved to new EMCRM Setup form.
    // EIS5.04.01       2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM18.0.6.32    2020-03-02  FAM * Smart Item No. added 
    // EMSM18.0.6.42    2020-03-20  FAM * Use Resource Name As Description
    // EMSM18.0.6.45    2020-04-02 FAM * ExpandIT attachment functionality is implemented
    // EMSM18.0.6.47    2020-04-06 FAM * Maintain B2B logic 
    // EMSM18.0.6.48    2020-04-07 FAM * New Job Nos. added.
    // EMSM18.0.6.50    2020-04-15 FAM * Maintain Related Items in BC
    // EMSM18.0.6.145 2020-07-15 FAM * Override replacementdialog (Component) from ExpandIT Setup 

    Caption = 'ExpandIT Setup', Comment = 'DAN="ExpandIT Opsætning",DEU="ExpandIT Einrichtung",ESP="Configuración ExpandIT ",FRA="Paramètres ExpandIT",SVE="ExpandIT Inställningar"';
    DeleteAllowed = true;
    InsertAllowed = false;
    PageType = Document;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "ExpandIT Setup EXP";
    ModifyAllowed = true;


    layout
    {
        area(content)
        {
            group("ExpandIT Setup")
            {
                Caption = 'ExpandIT Setup', Comment = 'DAN="ExpandIT Opsætning",DEU="ExpandIT Einrichtung",ESP="Configuración ExpandIT ",FRA="Paramètres ExpandIT",SVE="ExpandIT Inställningar"';
                field("Convert To Document Type"; Rec."Convert To Document Type")
                {
                    ApplicationArea = All;
                }
                field("Sales Person Code"; Rec."Sales Person Code EXP")
                {
                    ApplicationArea = All;
                }
                field("Show Document After Conversion"; Rec."Show Doc After Conversion EXP")
                {
                    ApplicationArea = All;
                }
                field("Internet Default Currency Code"; Rec."Internet Default Curr Code EXP")
                {
                    ApplicationArea = All;
                }
                field("ExpandIT URL"; Rec."ExpandIT URL EXP")
                {
                    ApplicationArea = All;
                    Description = 'EMSM18.0.6.45';
                }
            }
            group("Internet Shop")
            {
                Caption = 'Portal/Internet Shop', Comment = 'DAN="Portal/Internet Shop",DEU="Portal/Internetshop",ESP="",FRA="Boutique en ligne",SVE="Internet Shop"';
                field("Remote Shop URL"; Rec."Remote Shop URL EXP")
                {
                    ApplicationArea = All;
                }
                field("EIS Version"; Rec."EIS Version EXP")
                {
                    ApplicationArea = All;
                }
                field("Maintain B2B Logins in BC"; Rec."Maintain B2B Logins in BC EXP")
                {
                    ApplicationArea = All;
                    Description = 'EMSM18.0.6.47';
                }
                field("Maintain Related Items in BC"; Rec."Maintain Rel. Items In BC EXP")
                {
                    ApplicationArea = All;
                    Description = 'EMSM18.0.6.50';
                }
                field("Local Shop URL"; Rec."Local Shop URL EXP")
                {
                    ApplicationArea = All;
                }


            }
            group("e-Payment")
            {
                Caption = 'e-Payment', Comment = 'DAN="e-betaling",DEU="e-Payment",ESP="e-Pagos",FRA="Paiement en ligne",SVE="e-betalning"';
                field("Batch Capture"; Rec."Batch Capture EXP")
                {
                    ApplicationArea = All;
                }
                field("Test Clearing on Conversion"; Rec."Test Clearing on Conv. EXP")
                {
                    ApplicationArea = All;
                }
                field("Renew Clearing on Conversion"; Rec."Renew Clearing on Conv EXP")
                {
                    ApplicationArea = All;
                }
                field("Get Card Type on Conversion"; Rec."Get Card Type on Conv. EXP")
                {
                    ApplicationArea = All;
                }
                field(Simulation; Rec."Simulation EXP")
                {
                    ApplicationArea = All;
                }
                group("Portal Payments")
                {
                    field("Web Payment Jnl. Template"; Rec."Web Payment Jnl. Template")
                    {
                        ApplicationArea = all;
                    }
                    field("Web Payment Jnl. Batch"; Rec."Web Payment Jnl. Batch")
                    {
                        ApplicationArea = all;
                    }
                    field("Web Payment Bal. A/C Type"; Rec."Web Payment Bal. A/C Type")
                    {
                        ApplicationArea = all;
                    }
                    field("Web Payment Bal. A/C No."; Rec."Web Payment Bal. A/C No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Merchant Fee A/C Type"; Rec."Merchant Fee A/C Type")
                    {
                        ApplicationArea = all;
                    }
                    field("Merchant Fee A/C No."; Rec."Merchant Fee A/C No.")
                    {
                        ApplicationArea = all;
                    }
                }
            }
            group(Customers)
            {
                Caption = 'Customers', Comment = 'DAN="Kunder",DEU="Kunden",ESP="Clientes",FRA="Clients",SVE="kunder"';
                field("Internet Customer Template"; Rec."Internet Customer Template EXP")
                {
                    ApplicationArea = All;
                }
                field("Internet Customer"; Rec."Internet Customer EXP")
                {
                    ApplicationArea = All;
                }
                field("Use Internet Customer"; Rec."Use Internet Customer EXP")
                {
                    ApplicationArea = All;
                }
                field("Notify on Conversion to Doc."; Rec."Notify on Conv to Doc. EXP")
                {
                    ApplicationArea = All;
                }
                field("Notify on Rejection of Order"; Rec."Notify on Rejt of Order EXP")
                {
                    ApplicationArea = All;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering', Comment = 'DAN="Nummerering",DEU="Nummerierung",ESP="Numeración",FRA="Numérotation",SVE="Numrering"';
                field("New Customer Nos."; Rec."New Customer Nos. EXP")
                {
                    ApplicationArea = All;
                }
                field("New Sales Document Nos."; Rec."New Sales Document Nos. EXP")
                {
                    ApplicationArea = All;
                }
                field("New Job Document Nos."; Rec."New Job Document Nos. EXP")
                {
                    ApplicationArea = All;
                }
            }
            group(Time)
            {
                Caption = 'Time', Comment = 'DAN="Tid",ESP="HORA", DEU="Zeit"';
                field("Job Jnl. Template Name"; Rec."Job Jnl. Template Name EXP")
                {
                    ApplicationArea = All;
                }
                field("Job Jnl. Batch Name"; Rec."Job Jnl. Batch Name EXP")
                {
                    ApplicationArea = All;
                }
            }
            group("Service")
            {
                Caption = 'Service', Comment = 'DAN="", DEU=""';
                field("Use ExpandIT Number Series"; Rec."Use ExpandIT Number Series EXP")
                {
                    ApplicationArea = All;
                }
                field("Conversion Rule"; Rec."Conversion Rule EXP")
                {
                    ApplicationArea = All;
                }
                field("Smart Item No."; Rec."Smart Item No. EXP")
                {
                    ApplicationArea = All;
                    Description = 'EMSM18.0.6.32';
                }
                field("Replacement Dialog Values"; Rec."Replacement Dialog Values EXP")
                {
                    ApplicationArea = All;
                    Description = 'EMSM18.0.6.144';
                }

            }
            group("Job Journal Lines")
            {
                Caption = 'Job Journal Lines', Comment = 'DAN="Sagskladdelinjer",DEU="Projekt Buch.-Blatt",ESP="Job Journal Lines",FRA="",SVE=""';
                field("Line Type"; Rec."Line Type EXP")
                {
                    ApplicationArea = All;
                }
                field("UseResourceNameAsDescription"; Rec."UseResNameAsDescription EXP")
                {
                    ToolTip = 'By default, the work type description is transferred to the journal line. Enabling this setting will transfer the ressource name instead', comment = 'DAN="Som standard, lønart beskrivelsen bliver overført til sagskladdelinjer. Aktivering af denn indstilling vil overføre ressourcenavnet istedet.",ESP="", SVE="", FRA="Par défaut, la description du type de travail est transférée à la ligne de journal. En activant ce paramètre le nom de la ressource sera à sa place transféré", DEU="Normalerweise wird die Arbeitstyp-Beschreibung in die Journalzeile übertragen. Durch Aktivieren dieser Einstellung wird stattdessen der Ressourcenname übertragen"';
                    ApplicationArea = All;
                    Description = 'EMSM18.0.6.42';
                }
            }

            group("Sales")
            {
                Caption = 'Sales', Comment = 'DAN="Salg",DEU="Verkauf",ESP="Sales",FRA="Sales",SVE="Sales"';
                field("Override Sales Order Status"; Rec."Override SalesOrder Status EXP")
                {
                    ApplicationArea = All;
                    Description = 'EMSM18.0.6.135';
                }
                field("Sales Order Status"; Rec."Sales Order Status EXP")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.RESET;
        if not Rec.GET then begin
            Rec.INIT;
            Rec.INSERT;
        end;
    end;
}

