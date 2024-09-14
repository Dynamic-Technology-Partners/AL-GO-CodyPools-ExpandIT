/// <summary>
/// Report Bat. Conv. ExpandIT Orders EXP (ID 68701).
/// </summary>
report 68701 "Bat. Conv. ExpandIT Orders EXP"
{
    // version EIS4.02.02
    // EIS4.02.02  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS6.0.12 2020-09-10 FAM * Get ExpandIT Setup record
    DefaultLayout = RDLC;
    RDLCLayout = './Batch Convert ExpandIT Orders.rdlc';

    Caption = 'Batch Convert ExpandIT Orders', Comment = 'DAN="Batch Konvert. Ordrer",DEU="Stapel in ExpandIT Bestellungen umwandeln",ESP="Conversión Batch Pedidos ExpandIT",FRA="Convertir commandes ExpandIT",SVE="Batch överför ExpandIT order"';
    UsageCategory = Documents;
    ApplicationArea = All;
    AccessByPermission = tabledata "ExpandIT Order Header EXP" = RIMD;

    dataset
    {
        dataitem("ExpandIT Order Header"; "ExpandIT Order Header EXP")
        {
            DataItemTableView = SORTING("Status EXP", "Order Date EXP") WHERE("Status EXP" = CONST(New));
            RequestFilterFields = "Customer Reference No. EXP", "Customer P.O. No. EXP", "Order Date EXP";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            // column(CurrReport_PAGENO;CurrReport.PageNo )
            // {
            // //TODO: FIX PageNo.
            // }
            column(USERID; USERID)
            {
            }
            column(ExpandIT_Order_Header__Customer_Reference_No__; "Customer Reference No. EXP")
            {
            }
            column(ExpandIT_Order_Header__Bill_to_Net_Customer_No__; "Bill-to Net Customer No. EXP")
            {
            }
            column(ExpandIT_Order_Header__Sell_to_Customer_No__; "Sell-to Customer No. EXP")
            {
            }
            column(ExpandIT_Order_Header__Order_Date_; "Order Date EXP")
            {
            }
            column(ExpandIT_Order_Header_Amount; "Amount EXP")
            {
            }
            column(ResultText; ResultText)
            {
            }
            column(Internet_Order_HeaderCaption; Internet_Order_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ExpandIT_Order_Header__Customer_Reference_No__Caption; FIELDCAPTION("Customer Reference No. EXP"))
            {
            }
            column(ExpandIT_Order_Header__Bill_to_Net_Customer_No__Caption; FIELDCAPTION("Bill-to Net Customer No. EXP"))
            {
            }
            column(ExpandIT_Order_Header__Sell_to_Customer_No__Caption; FIELDCAPTION("Sell-to Customer No. EXP"))
            {
            }
            column(ExpandIT_Order_Header__Order_Date_Caption; FIELDCAPTION("Order Date EXP"))
            {
            }
            column(ExpandIT_Order_Header_AmountCaption; FIELDCAPTION("Amount EXP"))
            {
            }
            column(ResultTextCaption; ResultTextCaptionLbl)
            {
            }
            column(ExpandIT_Order_Header_Order_Guid; "Order Guid EXP")
            {
            }

            trigger OnAfterGetRecord();
            begin
                if ExpandITUtil.GetExpandITSetupRecord(InternetShopSetup) then begin // EIS6.0.12
                    if "Sell-to Customer No. EXP" = '' then begin
                        if not InternetCustomer.GET("Bill-to Net Customer No. EXP") then begin
                            if (InternetShopSetup."Use Internet Customer EXP" = InternetShopSetup."Use Internet Customer EXP"::Always) or
                               (InternetShopSetup."Use Internet Customer EXP" = InternetShopSetup."Use Internet Customer EXP"::"If No Customer Relation")
                            then begin
                                InternetShopSetup.TESTFIELD("Internet Customer EXP");
                                "Sell-to Customer No. EXP" := InternetShopSetup."Internet Customer EXP";
                            end else
                                ResultText := TEXT000;
                        end else
                            "Sell-to Customer No. EXP" := InternetCustomer."Customer No. EXP";
                    end;

                    CLEAR(InternetOrdertoSalesDoc);
                    if InternetOrdertoSalesDoc.RUN("ExpandIT Order Header") then begin
                        ResultText :=
                          STRSUBSTNO(
                            TEXT001,
                            "Converted-To Document Type EXP", "Converted-To Document No. EXP");

                        if SendMails then begin
                            //
                            // Send Confirmation Mail
                            //
                            if InternetShopSetup."Notify on Conv to Doc. EXP" then
                                if "Bill-to E-Mail EXP" <> '' then
                                    InternetShopMgt.InternetOrderConverted("Bill-to E-Mail EXP", "Customer Reference No. EXP")
                                else begin
                                    InternetCustomer.TESTFIELD("E-Mail EXP");
                                    InternetShopMgt.InternetOrderConverted(InternetCustomer."E-Mail EXP", "Customer Reference No. EXP");
                                end;
                        end;
                    end else begin
                        ResultText := InternetOrdertoSalesDoc.GetLastError;

                        if ResultText = '' then
                            ResultText := TEXT002;
                    end;
                end;
            end;

            trigger OnPreDataItem();
            begin

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
        ExpandITUtil: Codeunit "ExpandIT Util";
        InternetCustomer: Record "Internet Customer EXP";
        InternetShopSetup: Record "ExpandIT Setup EXP";
        InternetShopMgt: Codeunit "Internet Shop Management EXP";
        InternetOrdertoSalesDoc: Codeunit "Int Order to Sales-Doc. EXP";
        ResultText: Text[50];
        SendMails: Boolean;
        TEXT000: Label 'Unable to determine Customer.', Comment = 'DAN="Kunne ikke bestemme debitor.",DEU="Unmöglich den Kunden zu bestimmen.",ESP="Imposible Determinar Cliente.",FRA="Imposible d"';
        TEXT001: Label 'Converted to %1 %2', Comment = 'DAN="Konverteret til %1 %2",DEU="Umgewandelt zu %1 %2",ESP="Convertido a %1 %2",FRA="Converti de %1 %2",SVE="Omvandlad till %1 %2"';
        TEXT002: Label 'Couldn', Comment = 'DAN="Kan ikke konverteres.",DEU="Konnte nicht umgewandelt werden."';
        Internet_Order_HeaderCaptionLbl: Label 'Internet Order Header', Comment = 'DAN="Internet Ordre Hoved",DEU="Internet Bestellkopf",ESP="Cabecera Pedido Internet ",FRA="Commande Internet",SVE="Internet orderhuvud"';
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'DAN="Side",DEU="Seite",ESP="Página",FRA="Page",SVE="Sida"';
        ResultTextCaptionLbl: Label 'Conversion Result', Comment = 'DAN="Konverterings Resultat",DEU="Umwandlungsresultat",ESP="Resultado de Conversión",FRA="Résultat de la transformation",SVE="Överföringsresultat"';
}

