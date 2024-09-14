/// <summary>
/// Page ExpandITSrvTimeLines FactBox (ID 68785).
/// </summary>
page 68785 "ExpandITSrvTimeLines FactBox"
{
    PageType = CardPart;
    SourceTable = "ExpandITServiceOrderCue EXP";
    Caption = 'EMSM Inc. Srv. Inv. Lin (Time)', Comment = 'DAN="EMSM Indk. Srv Fakt Lin (Tid)",DEU="EMSM Eingehende SRV. RECHN. ZL (ZEIT)",ESP="EMSM Inc. Srv. Inv. Lin (Time)",SVE="EMSM Inc. Srv. Inv. Lin (Time)",FRA="EMSM Inc. Srv. Inv. Lin (Time)"';
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {

            cuegroup(NewServiceOrders)
            {
                Caption = 'ExpandIT Service Time Lines', Comment = 'DAN="ExpandIT Service Timelinjer",DEU="ExpandIT Service Zeitzeilen",ESP="",SVE="",FRA="ExpandIT Service Lignes de temps"';

                field("TimeLines"; Rec."ServiceTimeLines EXP")
                {
                    DrillDownPageId = "EMSM Inc. Srv. Inv.(Time) EXP";
                    ToolTip = 'New ExpandIT Time Lines', Comment = 'DAN="Nye ExpandIT Timelinjer",DEU="Neue ExpandIT Zeitenzeilen",ESP="",SVE="",FRA=""';
                    Image = Document;
                    // StyleExpr = ColorTime;
                    // Style = Unfavorable;
                    ApplicationArea = All;
                }

            }
            cuegroup(WError)
            {

                Caption = 'Conversion Failed', Comment = 'DAN="Konvertering Fejlet",DEU="Konvertierung fehlgeschlagen",ESP="",SVE="",FRA="Échec de la conversion"';
                field("TimeLinesWError"; Rec."ServiceTimeLinesWError EXP")
                {
                    DrillDownPageId = "EMSM Inc. Srv. Inv.(Time) EXP";
                    ToolTip = 'New ExpandIT Time Lines - With Error', Comment = 'DAN="Nye ExpandIT Timelinjer - Med Fejl",DEU="Neue ExpandIT Zeit Zeilen - Mit Fehler",ESP="",SVE="",FRA="Nouvelles lignes de temps d''ExpandIT - avec erreur"';
                    Image = Document;
                    StyleExpr = ColorTimeError;
                    Style = Unfavorable;
                    ApplicationArea = All;
                }
            }
            cuegroup(Converted)
            {

                Caption = 'Converted', Comment = 'DAN="Konverteret",DEU="Konvertiert",ESP="",SVE="",FRA=""';
                field("TimeLinesConverted"; Rec."ServiceTimeLinesConverted EXP")
                {
                    DrillDownPageId = "EMSM Inc. Srv. Inv.(Time) EXP";
                    ToolTip = 'The number of converted service time lines', Comment = 'DAN="Antallet af Konverterede Service Timelinjer",DEU="Die Anzahl von konvertierten Service Zeit Zeilen.",ESP="",SVE="",FRA="Le nombre de lignes de temps de service converties"';
                    Image = Document;
                    StyleExpr = ColorTimeConverted;
                    Style = favorable;
                    ApplicationArea = All;
                }

            }

        }
    }
    var
        ColorTime: Boolean;
        ColorTimeError: Boolean;
        ColorTimeConverted: Boolean;



    trigger OnAfterGetRecord();
    begin
        if (Rec."ServiceTimeLines EXP" > 20) then begin
            ColorTime := true;
        end;
        if (Rec."ServiceTimeLinesWError EXP" > 0) then begin
            ColorTimeError := true;
        end;
        if (Rec."ServiceTimeLinesConverted EXP" > 0) then begin
            ColorTimeConverted := true;
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