/// <summary>
/// Page ExpandITSrvDldHeader FactBox (ID 68784).
/// </summary>
page 68784 "ExpandITSrvDldHeader FactBox"
{
    PageType = CardPart;
    SourceTable = "ExpandITServiceOrderCue EXP";
    Caption = 'EMSM Inc. Srv. Inv. Lin (Srv)', Comment = 'DAN="EMSM Indk. Srv Fakt Lin (Srv)",DEU="EMSM Inc. Srv. Inv. Lin (Srv)",ESP="EMSM Inc. Srv. Inv. Lin (Srv)",SVE="EMSM Inc. Srv. Inv. Lin (Srv)",FRA="EMSM Inc. Srv. Inv. Lin (Srv)"';
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {

            cuegroup(NewServiceOrders)
            {
                Caption = 'ExpandIT Service Lines With Delayed Header', Comment = 'DAN="ExpandIt Servicelinjer Med Forsinket Ordrehoved",DEU="ExpandIT Service Zeilen mit Verzögerten Kopf",ESP="",SVE="",FRA="Lignes de service ExpandIT avec en-tête retardé"';

                field("ServiceLinesWDldHdr"; Rec."ServiceLinesDlyHdr EXP")
                {
                    DrillDownPageId = "EMSM Inc. Srv. Inv.(Srv) EXP";
                    ToolTip = 'New ExpandIT Service Lines With Delayed Header. The header is not approved yet.', Comment = 'DAN="Nye ExpandIT Servicelinjer Med Forsinket Ordrehoved. Ordrehovedet er ikke godkendt endnu. ",DEU="ExpandIT Service Zeilen mit verzögerten Kopf. Der Kopf ist noch nicht genehmigt.",ESP="",SVE="",FRA="Nouvelles lignes de service ExpandIT avec en-tête retardé. L''en-tête n''est pas encore approuvé."';
                    Image = Document;
                    // StyleExpr = ColorServiceWH;
                    // Style = Unfavorable;
                    ApplicationArea = All;
                }

            }
            cuegroup(WError)
            {

                Caption = 'Conversion Failed', Comment = 'DAN="Konvertering Fejlet",DEU="Konvertierung fehlgeschlagen",ESP="",SVE="",FRA="Échec de la conversion"';
                field("ServiceLinesWDldHdrError"; Rec."ServiceLinesDlyHdrWError EXP")
                {
                    DrillDownPageId = "EMSM Inc. Srv. Inv.(Srv) EXP";
                    ToolTip = 'Service Orders that failed the conversion', Comment = 'DAN="Serviceordrer, som fejlede under konvertering",DEU="Service Aufträge die nicht konvertiert werden konnten",ESP="",SVE="",FRA="Ordres de service qui ont échoué à la conversion"';
                    Image = Document;
                    StyleExpr = ColorServiceWHError;
                    Style = Unfavorable;
                    ApplicationArea = All;
                }

            }

            cuegroup(Converted)
            {

                Caption = 'Converted', Comment = 'DAN="Konverteret",DEU="Konvertiert",ESP="",SVE="",FRA=""';
                field("ServiceLinesWDldHdrConverted"; Rec."ServiceLinesDlyHdrConv EXP")
                {
                    DrillDownPageId = "EMSM Inc. Srv. Inv.(Srv) EXP";
                    ToolTip = 'The number of converted service lines with delayed header', Comment = 'DAN="Antallet af konverterede servicelinjer med forsinket ordrehoved",DEU="Die Anzahl von konvertierten Service Zeilen mit verzögerten Kopf.",ESP="",SVE="",FRA="Le nombre de lignes de service converties avec un en-tête retardé"';
                    Image = Document;
                    StyleExpr = ColorServiceConverted;
                    Style = favorable;
                    ApplicationArea = All;
                }

            }

        }
    }
    var
        ColorServiceWH: Boolean;
        ColorServiceWHError: Boolean;
        ColorServiceConverted: Boolean;



    trigger OnAfterGetRecord();
    begin
        if (Rec."ServiceLinesDlyHdr EXP" > 20) then begin
            ColorServiceWH := true;
        end;
        if (Rec."ServiceLinesDlyHdrConv EXP" > 0) then begin
            ColorServiceConverted := true;
        end;
        if (Rec."ServiceLinesDlyHdrWError EXP" > 0) then begin
            ColorServiceWHError := true;
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