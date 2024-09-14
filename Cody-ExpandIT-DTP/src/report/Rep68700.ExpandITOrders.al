/// <summary>
/// Report ExpandIT Orders (ID 68700).
/// </summary>
report 68700 "ExpandIT Orders"
{
    // version EIS4.02.02

    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    DefaultLayout = RDLC;
    RDLCLayout = './ExpandIT Orders.rdlc';

    Caption = 'ExpandIT Orders', Comment = 'DAN="ExpandIT-ordrer",DEU="ExpandIT Bestellungen",ESP="Pedidos ExpandIT",FRA="Commandes ExpandIT",SVE="ExpandIT order"';
    UsageCategory = Documents;
    ApplicationArea = All;
    AccessByPermission = tabledata "ExpandIT Order Header EXP" = RIMD;


    dataset
    {
        dataitem("ExpandIT Order Header"; "ExpandIT Order Header EXP")
        {
            DataItemTableView = SORTING("Customer Reference No. EXP");
            RequestFilterFields = "Customer Reference No. EXP", "Status EXP";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            // column(CurrReport_PAGENO;CurrReport.PageNo)
            // {
            // }
            //TODO PageNO
            column(USERID; USERID)
            {
            }
            column(ExpandIT_Order_Header__Customer_Reference_No__; "Customer Reference No. EXP")
            {
            }
            column(ExpandIT_Order_Header__Order_Date_; "Order Date EXP")
            {
            }
            column(ExpandIT_Order_Header__Bill_to_Net_Customer_No__; "Bill-to Net Customer No. EXP")
            {
            }
            column(ExpandIT_Order_Header__Bill_to_Name_; "Bill-to Name EXP")
            {
            }
            column(ExpandIT_Order_Header_Amount; "Amount EXP")
            {
            }
            column(ExpandIT_Order_Header_Status; "Status EXP")
            {
            }
            column(ExpandIT_Order_Header__Converted_To_Document_No__; "Converted-To Document No. EXP")
            {
            }
            column(Internet_OrdersCaption; Internet_OrdersCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ExpandIT_Order_Header__Customer_Reference_No__Caption; FIELDCAPTION("Customer Reference No. EXP"))
            {
            }
            column(ExpandIT_Order_Header__Order_Date_Caption; FIELDCAPTION("Order Date EXP"))
            {
            }
            column(ExpandIT_Order_Header__Bill_to_Net_Customer_No__Caption; FIELDCAPTION("Bill-to Net Customer No. EXP"))
            {
            }
            column(ExpandIT_Order_Header__Bill_to_Name_Caption; FIELDCAPTION("Bill-to Name EXP"))
            {
            }
            column(ExpandIT_Order_Header_AmountCaption; FIELDCAPTION("Amount EXP"))
            {
            }
            column(ExpandIT_Order_Header_StatusCaption; FIELDCAPTION("Status EXP"))
            {
            }
            column(ExpandIT_Order_Header__Converted_To_Document_No__Caption; FIELDCAPTION("Converted-To Document No. EXP"))
            {
            }
            column(ExpandIT_Order_Header_Order_Guid; "Order Guid EXP")
            {
            }

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO("Customer Reference No. EXP");
            end;
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Internet_OrdersCaptionLbl: Label 'Internet Orders', Comment = 'DAN="Internet ordrer",DEU="Internet Bestellungen",ESP="Pedidos Internet",FRA="Commandes Internet",SVE="Internet order"';
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'DAN="Side",DEU="Seite",ESP="Página",FRA="Page",SVE="Sida"';
}

