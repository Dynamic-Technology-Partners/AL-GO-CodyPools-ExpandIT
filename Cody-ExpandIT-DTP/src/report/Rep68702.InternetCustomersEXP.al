/// <summary>
/// Report Internet Customers EXP (ID 68702).
/// </summary>
report 68702 "Internet Customers EXP"
{
    // version EIS4.02.02

    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    DefaultLayout = RDLC;
    RDLCLayout = './Internet Customers.rdlc';

    Caption = 'Internet Customers', Comment = 'DAN="Internet-kunder",DEU="Internet Kunden",ESP="Clientes Internet",FRA="Clients Internet",SVE="Internet Kunder"';
    UsageCategory = Documents;
    ApplicationArea = All;
    AccessByPermission = tabledata "Internet Customer EXP" = RIMD;


    dataset
    {
        dataitem("Internet Customer"; "Internet Customer EXP")
        {
            DataItemTableView = SORTING("No. EXP");
            RequestFilterFields = "No. EXP", "Customer No. EXP", "Name EXP";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            // column(CurrReport_PAGENO;CurrReport.PAGENO)
            // {
            // //TODO: FIX PageNo
            // }
            column(USERID; USERID)
            {
            }
            column(Internet_Customer_Name; "Name EXP")
            {
            }
            column(Internet_Customer_Address; "Address EXP")
            {
            }
            column(Internet_Customer__Address_2_; "Address 2 EXP")
            {
            }
            column(Internet_Customer__Post_Code_; "Post Code EXP")
            {
            }
            column(Internet_Customer_City; "City EXP")
            {
            }
            column(Internet_Customer_Contact; "Contact EXP")
            {
            }
            column(Internet_Customer__No__; "No. EXP")
            {
            }
            column(Internet_Customer__Phone_No__; "Phone No. EXP")
            {
            }
            column(Internet_Customer__E_Mail_; "E-Mail EXP")
            {
            }
            column(Internet_Customer_Login; "Login EXP")
            {
            }
            column(Internet_CustomersCaption; Internet_CustomersCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Internet_Customer__No__Caption; FIELDCAPTION("No. EXP"))
            {
            }
            column(Internet_Customer_ContactCaption; FIELDCAPTION("Contact EXP"))
            {
            }
            column(Internet_Customer__Phone_No__Caption; FIELDCAPTION("Phone No. EXP"))
            {
            }
            column(Internet_Customer__E_Mail_Caption; FIELDCAPTION("E-Mail EXP"))
            {
            }
            column(Internet_Customer_LoginCaption; FIELDCAPTION("Login EXP"))
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Internet_CustomersCaptionLbl: Label 'Internet Customers', Comment = 'DAN="Internet-kunder",DEU="Internet Kunden",ESP="Clientes Internet",FRA="Clients Internet",SVE="Internet kunder"';
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'DAN="Side",DEU="Seite",ESP="Página",FRA="Page",SVE="Sida"';
}

