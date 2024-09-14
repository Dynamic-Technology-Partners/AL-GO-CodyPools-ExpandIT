/// <summary>
/// PageExtension ExpandIT ServiceDispAct EXP (ID 68782) extends Record Service Dispatcher Activities.
/// </summary>
pageextension 68782 "ExpandIT ServiceDispAct EXP" extends "Service Dispatcher Activities"
{
    layout
    {
        /*         addfirst("My User Tasks")
                {
                    cuegroup("ServiceActionContainer EXP")
                    {
                        Caption = 'ExpandIT Service';

                        field("ServiceOrders EXP"; Rec."ServiceOrders EXP")
                        {
                            DrillDownPageId = "EMSM Incoming Serv Orders EXP";
                            ToolTip = 'New Incoming ExpandIT Service Orders', Comment = 'DAN="Nye Indkommende ExpandIT Serviceordrer",DEU="Neue eingehende ExpandIT Serviceaufträge - Mit Fehler",ESP="",SVE="",FRA="Nouvelles commandes de services ExpandIT entrantes"';
                            Image = Document;

                            // StyleExpr = ColorService;
                            // Style = Unfavorable;
                            ApplicationArea = All;

                        }
                        field("ServiceLinesDldHdr EXP"; Rec."ServiceLinesDlyHdr EXP")
                        {
                            DrillDownPageId = "EMSM Inc. Srv. Inv.(Srv) EXP";
                            ToolTip = 'New ExpandIT Service Lines with delayed header', Comment = 'DAN="Nye ExpandIT Servicelinjer Med Forsinket Ordrehoved",DEU="Neue ExpandIT Zeit Zeilen - Mit Fehler",ESP="",SVE="",FRA=""';
                            Image = Document;
                            // StyleExpr = ColorServiceWH;
                            // Style = Unfavorable;
                            ApplicationArea = All;
                        }
                        field("timeLines EXP"; Rec."ServiceTimeLines EXP")
                        {
                            DrillDownPageId = "EMSM Inc. Srv. Inv.(Time) EXP";
                            ToolTip = 'New ExpandIT Time Lines', Comment = 'DAN="Nye ExpandIT Timelinjer",DEU="Neue ExpandIT Zeit Zeilen",ESP="",SVE="",FRA="", DEU="Neue ExpandIT Zeitenzeilen"';
                            Image = Document;
                            // StyleExpr = ColorTime;
                            // Style = Unfavorable;
                            ApplicationArea = All;
                        }

                    }
                    cuegroup("WError EXP")
                    {
                        Caption = 'ExpandIT Lists With Error', Comment = 'DAN="ExpandIT Liste Med Fejl",DEU="ExpandIT Übersichten mit Fehler",ESP="",FRA="",SVE="Les listes d''ExpandIT sont erronées"';

                        field("ServiceOrdersWError EXP"; Rec."ServiceOrdersWError EXP")
                        {
                            DrillDownPageId = "EMSM Incoming Serv Orders EXP";
                            ToolTip = 'New Incoming ExpandIT Service Orders - With Error', Comment = 'DAN="Nye Indkommende ExpandIT Serviceordrer -  Med Fejl",DEU="Neue eingehende ExpandIT Serviceaufträge - Mit Fehler",ESP="",SVE="",FRA="Nouvelles commandes de services ExpandIT entrantes"';
                            Image = Document;

                            StyleExpr = ColorServiceError;
                            Style = Unfavorable;
                            ApplicationArea = All;
                        }
                        field("ServiceLinesDldHdrWError EXP"; Rec."ServiceLinesDlyHdrWError EXP")
                        {
                            DrillDownPageId = "EMSM Inc. Srv. Inv.(Srv) EXP";
                            ToolTip = 'New ExpandIT Service Lines with delayed header - With Error', Comment = 'DAN="Nye ExpandIT Servicelinjer Med Forsinket Ordrehoved - Med Fejl",DEU="Neue ExpandIT Servicezeilen mit verzögerten Kopfdaten - Mit Fehler",ESP="",SVE="",FRA=""';
                            Image = Document;
                            StyleExpr = ColorServiceWHError;
                            Style = Unfavorable;
                            ApplicationArea = All;
                        }
                        field("TimeLinesWError EXP"; Rec."ServiceTimeLinesWError EXP")
                        {
                            DrillDownPageId = "EMSM Inc. Srv. Inv.(Time) EXP";
                            ToolTip = 'New ExpandIT Time Lines - With Error', Comment = 'DAN="Nye ExpandIT Timelinjer - Med Fejl",DEU="Neue ExpandIT Zeitenzeilen - Mit Fehler",ESP="",SVE="",FRA="Nouvelles lignes de temps d''ExpandIT - avec erreur"';
                            Image = Document;
                            StyleExpr = ColorTimeError;
                            Style = Unfavorable;
                            ApplicationArea = All;
                        }

                    }
                    cuegroup(ExpandITDepartment)
                    {
                        Caption = 'ExpandIT Department';
                        actions
                        {
                            action("ExpDepartment")
                            {
                                RunObject = page 50089;
                                Image = TileSettings;
                                ToolTip = 'ExpandIT Department Page for Sales, Service and Setup', Comment = 'DAN="ExpandIT Department Side for Salg, Service og Opsætning",DEU="ExpandIT Abteilung Seite für Vertrieb, Service und Einrichtung",ESP="",SVE="",FRA="Page du département ExpandIT pour les ventes, le service et l''installation"';
                                Caption = 'ExpandIT Department', Comment = 'DAN="ExpandIt Department",DEU="ExpandIT Abteilung",ESP="",SVE="",FRA="Département ExpandIT"';
                                ApplicationArea = All;


                                trigger OnAction()
                                begin

                                end;
                            }

                        }
                    }
                }
         */
    }

    var
        ColorService: Boolean;
        ColorServiceWH: Boolean;
        ColorTime: Boolean;
        ColorServiceError: Boolean;
        ColorServiceWHError: Boolean;
        ColorTimeError: Boolean;

    /// <summary>
    /// refreshCues.
    /// </summary>
    procedure refreshCues()
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


    trigger OnAfterGetRecord();
    begin
        refreshCues();
    end;

}