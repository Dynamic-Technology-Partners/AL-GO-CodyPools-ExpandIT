/// <summary>
/// Page ExpandItServiceOrderCue EXP (ID 68781).
/// </summary>
page 68781 "ExpandItServiceOrderCue EXP"
{
    PageType = CardPart;
    SourceTable = "ExpandITServiceOrderCue EXP";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {

            cuegroup(ServiceActionContainer)
            {
                Caption = 'ExpandIT Service';

                field("ServiceOrders"; Rec."ServiceOrders EXP")
                {
                    DrillDownPageId = "EMSM Incoming Serv Orders EXP";
                    ToolTip = 'New Incoming ExpandIT Service Orders', Comment = 'DAN="Nye Indkommende ExpandIT Serviceordrer",DEU="Neue eingehende ExpandIT Serviceaufträge",ESP="",SVE="",FRA="Nouvelles commandes de services ExpandIT entrantes"';
                    //Caption = 'Open Service Orders', Comment = 'DAN="Åbne Serviceordrer",DEU="Offene Serviceaufträge",ESP="",SVE="",FRA=""';
                    Image = Document;

                    StyleExpr = ColorService;
                    Style = Unfavorable;
                    ApplicationArea = All;

                }
                field("ServiceLinesDldHdr"; Rec."ServiceLinesDlyHdr EXP")
                {
                    DrillDownPageId = "EMSM Inc. Srv. Inv.(Srv) EXP";
                    ToolTip = 'New ExpandIT Service Lines with delayed header', Comment = 'DAN="Nye ExpandIT Servicelinjer Med Forsinket Ordrehoved",DEU="New ExpandIT Service Lines with delayed header",ESP="New ExpandIT Service Lines with delayed header",SVE="New ExpandIT Service Lines with delayed header",FRA="New ExpandIT Service Lines with delayed header"';
                    //Caption = 'Service Lines with delayed header', Comment = 'DAN="Servicelinjer Med Forsinket Ordrehoved",DEU="Service Lines with delayed header",ESP="Service Lines with delayed header",SVE="Service Lines with delayed header",FRA="Service Lines with delayed header"';
                    Image = Document;
                    StyleExpr = ColorServiceWH;
                    Style = Unfavorable;
                    ApplicationArea = All;
                }
                field("timeLines"; Rec."ServiceTimeLines EXP")
                {
                    DrillDownPageId = "EMSM Inc. Srv. Inv.(Time) EXP";
                    ToolTip = 'New ExpandIT Time Lines', Comment = 'DAN="Nye ExpandIT Timelinjer",DEU="Neue ExpandIT Zeitenzeilen",ESP="New ExpandIT Time Lines",SVE="New ExpandIT Time Lines",FRA="New ExpandIT Time Lines"';
                    //Caption = 'Time Lines', Comment = 'DAN="Timelinjer",DEU="Time Lines",ESP="Time Lines",SVE="Time Lines",FRA="Time Lines"';
                    Image = Document;
                    StyleExpr = ColorTime;
                    Style = Unfavorable;
                    ApplicationArea = All;
                }

            }
            cuegroup(WError)
            {


                field("ServiceOrdersWError"; Rec."ServiceOrdersWError EXP")
                {
                    DrillDownPageId = "EMSM Incoming Serv Orders EXP";
                    ToolTip = 'New Incoming ExpandIT Service Orders - With Error', Comment = 'DAN="Nye Indkommende ExpandIT Serviceordrer - Med Fejl",DEU="Neue eingehende ExpandIT Serviceaufträge - Mit Fehler",ESP="",SVE="",FRA="Nouvelles commandes de services ExpandIT entrantes"';
                    Image = Document;
                    //Caption = 'ExpandIT Lists With Error', Comment = 'DAN="ExpandIT Liste Med Fejl",DEU="ExpandIT Übersichten mit Fehler",ESP="",SVE="",FRA=""';
                    StyleExpr = ColorServiceError;
                    Style = Unfavorable;
                    ApplicationArea = All;
                }

                field("ServiceLinesDldHdrWError"; Rec."ServiceLinesDlyHdrWError EXP")
                {
                    DrillDownPageId = "EMSM Inc. Srv. Inv.(Srv) EXP";
                    ToolTip = 'New ExpandIT Service Lines with delayed header - With Error', Comment = 'DAN="Nye ExpandIT Servicelinjer Med Forsinket  Ordrehoved - Med Fejl",DEU="Neue ExpandIT Servicezeilen mit verzögerten Kopfdaten - Mit Fehler",ESP="",SVE="",FRA=""';
                    //Caption = 'Service Lines with delayed header - With Error', Comment = 'DAN="Servicelinjer Med Forsinket Ordrehoved",DEU="Servicezeilen mit verzögerten Kopfdaten - Mit Fehler",ESP="",SVE="",FRA=""';
                    Image = Document;
                    StyleExpr = ColorServiceWHError;
                    Style = Unfavorable;
                    ApplicationArea = All;
                }
                field("timeLinesWError"; Rec."ServiceTimeLinesWError EXP")
                {
                    DrillDownPageId = "EMSM Inc. Srv. Inv.(Time) EXP";
                    ToolTip = 'New ExpandIT Time Lines - With Error', Comment = 'DAN="Nye ExpandIT Timelinjer - Med Fejl",DEU="Neue ExpandIT Zeit Zeilen - Mit Fehler",ESP="",SVE="",FRA="Nouvelles lignes de temps d''ExpandIT - avec erreur"';
                    //Caption = 'Time Lines - With Error', Comment = 'DAN="Timelinjer - Med Fejl", DEU="Zeit Zeilen - Mit Fehler",SVE="",FRA="",ESP=""';
                    Image = Document;
                    StyleExpr = ColorTimeError;
                    Style = Unfavorable;
                    ApplicationArea = All;
                }

            }

        }
    }
    var
        ColorService: Boolean;
        ColorServiceWH: Boolean;
        ColorTime: Boolean;
        ColorServiceError: Boolean;
        ColorServiceWHError: Boolean;
        ColorTimeError: Boolean;


    trigger OnAfterGetRecord();
    begin
        if (Rec."ServiceOrders EXP" > 20) then begin
            ColorService := true;
        end;
        if (Rec."ServiceLinesDlyHdr EXP" > 20) then begin
            ColorServiceWH := true;
        end;
        if (Rec."ServiceTimeLines EXP" > 20) then begin
            ColorTime := true;
        end;
        if (Rec."ServiceOrdersWError EXP" > 0) then begin
            ColorServiceError := true;
        end;
        if (Rec."ServiceLinesDlyHdrWError EXP" > 0) then begin
            ColorServiceWHError := true;
        end;
        if (Rec."ServiceTimeLinesWError EXP" > 0) then begin
            ColorTimeError := true;
        end;

    end;

    trigger OnOpenPage();
    begin
        Rec.RESET;
        if not Rec.get then begin
            Rec.INIT;
            Rec.INSERT;
        end;
    end;
}