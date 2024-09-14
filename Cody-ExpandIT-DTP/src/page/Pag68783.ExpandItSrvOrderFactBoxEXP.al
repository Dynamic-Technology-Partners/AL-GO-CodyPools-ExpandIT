/// <summary>
/// Page ExpandItSrvOrder FactBox EXP (ID 68783).
/// </summary>
page 68783 "ExpandItSrvOrder FactBox EXP"
{
    PageType = CardPart;
    SourceTable = "ExpandITServiceOrderCue EXP";
    Caption = 'ExpandIT Service Orders', Comment = 'DAN="ExpandIT Serviceordrer",DEU="ExpandIT Serviceaufträge",ESP="",SVE="",FRA="Ordre de service ExpandIT"';
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {

            cuegroup(NewServiceOrders)
            {
                Caption = 'New Service Orders', Comment = 'DAN="Nye ExpandIT Serviceordrer",DEU="Neue Service Aufträge",ESP="",SVE="",FRA="Nouvel ordre de service"';

                field("ServiceOrders"; Rec."ServiceOrders EXP")
                {
                    DrillDownPageId = "EMSM Incoming Serv Orders EXP";
                    ToolTip = 'New Incoming ExpandIT Service Orders', Comment = 'DAN="Nye Inkommende ExpandIT Serviceordrer",DEU="Neu erstellte ExpandIT Serviceaufträge",ESP="",SVE="",FRA="Nouvelles commandes de services ExpandIT entrantes"';
                    Image = Document;
                    // StyleExpr = ColorService;
                    // Style = Unfavorable;
                    ApplicationArea = All;
                }

            }
            cuegroup(WError)
            {

                Caption = 'Conversion Failed', Comment = 'DAN="Konvertering Fejlet",DEU="Konvertierung fehlgeschlagen",ESP="",SVE="",FRA="Échec de la conversion"';
                field("ServiceOrdersWError"; Rec."ServiceOrdersWError EXP")
                {
                    DrillDownPageId = "EMSM Incoming Serv Orders EXP";
                    ToolTip = 'Service Orders that failed the conversion', Comment = 'DAN="Serviceordrer, som fejlede under konvertering",DEU="Service Aufträge die nicht konvertiert werden konnten",ESP="",SVE="",FRA="Ordres de service qui ont échoué à la conversion"';
                    Image = Document;
                    StyleExpr = ColorServiceError;
                    Style = Unfavorable;
                    ApplicationArea = All;
                }

            }

            cuegroup(Converted)
            {

                Caption = 'Converted', Comment = 'DAN="Konverteret",DEU="Konvertiert",ESP="",SVE="",FRA=""';
                field("ServiceOrdersConverted"; Rec."ServiceOrdersConverted EXP")
                {
                    DrillDownPageId = "EMSM Incoming Serv Orders EXP";
                    ToolTip = 'The number of converted service orders', Comment = 'DAN="Antallet af konverterede serviceordrer",DEU="Die Anzahl konvertierte Serviceaufträge",ESP="",SVE="",FRA="Puis nombre d''ordres de service convertis"';
                    Image = Document;
                    StyleExpr = ColorServiceConverted;
                    Style = Favorable;
                    ApplicationArea = All;
                }

            }

        }
    }
    var
        ColorService: Boolean;
        ColorServiceError: Boolean;
        ColorServiceConverted: Boolean;



    trigger OnAfterGetRecord();
    begin
        if (Rec."ServiceOrders EXP" > 20) then begin
            ColorService := true;
        end;
        if (Rec."ServiceOrdersWError EXP" > 0) then begin
            ColorServiceError := true;
        end;
        if (Rec."ServiceOrdersConverted EXP" > 0) then begin
            ColorServiceConverted := true;
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