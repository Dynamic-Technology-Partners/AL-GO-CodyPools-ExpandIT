/// <summary>
/// Report EMSM Proc SrvLinesWOHeader EXP (ID 68780).
/// </summary>
report 68780 "EMSM Proc SrvLinesWOHeader EXP"
{

    Caption = 'EMSM Process Service Lines Without Header', Comment = 'DAN="EMSM Behandl Servicelinjer Uden Ordrehoved",DEU="",ESP="",FRA="EMSM Traitement des lignes de service sans en-tête",SVE=""';
    ProcessingOnly = true;
    UseRequestPage = true;


    dataset
    {
        dataitem("EMSM Service Invoice Line"; "EMSM Service Invoice Line EXP")
        {
            DataItemTableView = SORTING("BAS Guid EXP") WHERE("Convert Status EXP" = CONST(New));
            RequestFilterFields = "BAS Guid EXP";

            trigger OnAfterGetRecord();
            begin
                EMSMProcessSrvLineWOHeader.PrcsEMSMSrvInvLinsWtDlyedItLin("EMSM Service Invoice Line", false);
                if "Convert Status EXP" = "Convert Status EXP"::Error then
                    NoOfErrors := NoOfErrors + 1;
            end;

            trigger OnPostDataItem();
            begin
                if NoOfErrors > 0 then
                    ERROR(TEXT0002, NoOfErrors);
            end;

            trigger OnPreDataItem();
            begin
                NoOfErrors := 0;
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

    trigger OnPostReport();
    begin
        // If you use ExpandIT Launch Utility un rem the next line - and remove the other status message
        // MESSAGE('ExpandIT Launch Utility Finished');

        // Status (remove if using ExpandIT Launch Utility)
        MESSAGE(TEXT0001);
    end;

    var
        ServiceItemLine: Record "Service Item Line";
        EMSMProcessSrvLineWOHeader: Codeunit "Proc. EMSM Srv. Inv.(Srv.) EXP";
        StatusDialog: Dialog;
        TEXT0001: Label 'Done', Comment = 'DAN="Færdig",DEU="Erledigt",ESP="Hecho",FRA="Le traitement des commandes service est terminé.",SVE="Klart"';
        NoOfErrors: Integer;
        TEXT0002: Label 'Errors (%1) occurred while running "EMSM Process Orders". See error details in EMSM Incomming Service Orders', Comment = 'DAN="Der opstod fejl (%1) da ordrebehandlingen kørte. Se fejlbeskrivelser i EMSM Indkommende serviceordrer.",ESP="Ha habido errores (%1) al ejecutar "Procesar pedidos". Vea el detalle del error en "Pedidos de servicio realizados".",FRA="Erreurs (%1) se sont produites lors de l"';
}

