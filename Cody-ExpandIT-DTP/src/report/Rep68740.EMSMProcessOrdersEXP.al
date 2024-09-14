/// <summary>
/// Report EMSM Process Orders EXP (ID 68740).
/// </summary>
report 68740 "EMSM Process Orders EXP"
{
    // version EMSM3.01.01

    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    // EMSM3.01.01  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)

    Caption = 'EMSM Process Orders', Comment = 'DAN="EMSM Behandl Ordre",DEU="EMSM Prozessaufträge",ESP="Procesar pedidos de servicio",FRA="Traitement commandes service EMSM",SVE="Expandit ESM överföringar"';
    ProcessingOnly = true;
    UseRequestPage = true;


    dataset
    {
        dataitem("EMSM Service Item Line"; "EMSM Service Item Line EXP")
        {
            DataItemTableView = SORTING("BAS Guid EXP") WHERE("Convert Status EXP" = CONST(New));
            RequestFilterFields = "BAS Guid EXP";

            trigger OnAfterGetRecord();
            begin
                EMSMProcessOrder.RUN("EMSM Service Item Line");
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
        EMSMProcessOrder: Codeunit "EMSM Process Order EXP";
        StatusDialog: Dialog;
        TEXT0001: Label 'Done', Comment = 'DAN="Færdig",DEU="Erledigt",ESP="Hecho",FRA="Le traitement des commandes service est terminé.",SVE="Klart"';
        NoOfErrors: Integer;
        TEXT0002: Label 'Errors (%1) occurred while running "EMSM Process Orders". See error details in EMSM Incomming Service Orders', Comment = 'DAN="Der opstod fejl (%1) da ordrebehandlingen kørte. Se fejlbeskrivelser i EMSM Indkommende serviceordrer.",ESP="Ha habido errores (%1) al ejecutar "Procesar pedidos". Vea el detalle del error en "Pedidos de servicio realizados".",FRA="Erreurs (%1) se sont produites lors de l"';
}

