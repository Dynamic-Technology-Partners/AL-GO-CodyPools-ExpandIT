/// <summary>
/// Page ExpandIT EXP (ID 68778).
/// </summary>
page 68778 "ExpandIT EXP"
{
    PageType = Document;
    UsageCategory = Documents;
    ApplicationArea = All;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;



    Caption = 'ExpandIT Department';
    SourceTable = "ExpandITServiceOrderCue EXP";
    //SourceTable = "Service Cue";
    RefreshOnActivate = false;

    layout
    {
        area(Content)
        {

            group(Service)
            {
                grid("ServiceGrid")
                {
                    Caption = '';
                    cuegroup(ServiceActionContainer)
                    {
                        Caption = 'Lists', Comment = 'DAN="Lister",DEU="Übersichten",ESP="",SVE="",FRA="Listes"';
                        actions
                        {
                            action("Open Service Orders")
                            {
                                Image = TileCloud;
                                Caption = 'Open Service Orders', Comment = 'DAN="Åbne Serviceordrer",DEU="Offene Serviceaufträge",ESP="",SVE="",FRA=""';
                                ToolTip = 'New Incoming ExpandIT Service Orders', Comment = 'DAN="Nye Indkommende ExpandIT Serviceordrer",DEU="Neue eingehende ExpandIT Serviceaufträge",ESP="",SVE="",FRA="Nouvelles commandes de services ExpandIT entrantes"';
                                ApplicationArea = All;


                                trigger OnAction()
                                var
                                    EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
                                    EMSMIncomingOrderPage: page "EMSM Incoming Serv Orders EXP";
                                begin
                                    EMSMServiceItemLine.Reset();
                                    EMSMServiceItemLine.SetFilter("Order No. EXP", '<>%1', '');
                                    EMSMServiceItemLine.SetFilter("Convert Status EXP", '%1', EMSMServiceItemLine."Convert Status EXP"::New);
                                    EMSMIncomingOrderPage.SetTableView(EMSMServiceItemLine);

                                    EMSMIncomingOrderPage.Run();
                                end;
                            }

                            action("ServiceLinesDlyHdr")
                            {
                                Image = TileCloud;
                                Caption = 'Service Lines with delayed header', Comment = 'DAN="Servicelinjer Med Forsinket Ordrehoved",DEU="ExpandIT Service Zeilen mit verzögerten Kopf. Der Kopf ist noch nicht genehmigt.",ESP="",SVE="",FRA="Lignes de service avec en-tête retardé"';
                                ToolTip = 'New ExpandIT Service Lines with delayed header', Comment = 'DAN="Nye ExpandIT Servicelinjer Med Forsinket Ordrehoved",DEU="Neue ExpandIT Servicezeilen mit verzögerten Kopfdaten",ESP="",SVE="",FRA=""';
                                ApplicationArea = All;


                                trigger OnAction()
                                var
                                    EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
                                    EMSMSrvInvLineDlyHdr: page "EMSM Inc. Srv. Inv.(Srv) EXP";
                                begin
                                    EMSMServiceInvoiceLine.Reset();
                                    EMSMServiceInvoiceLine.SetFilter("Order No. EXP", '<>%1', '');
                                    EMSMServiceInvoiceLine.SetFilter("Convert Status EXP", '%1', EMSMServiceInvoiceLine."Convert Status EXP"::New);
                                    EMSMServiceInvoiceLine.SetFilter("ServiceHeaderExist EXP", '%1', false);
                                    EMSMSrvInvLineDlyHdr.SetTableView(EMSMServiceInvoiceLine);

                                    EMSMSrvInvLineDlyHdr.Run();
                                end;
                            }
                            action("ServiceTimeLines")
                            {
                                Image = TileCloud;
                                Caption = 'Time Lines', Comment = 'DAN="Timelinjer",DEU="ExpandIT Service Zeit Zeilen",ESP="",SVE="",FRA="Lignes de temps"';
                                ToolTip = 'New ExpandIT Time Lines', Comment = 'DAN="Nye ExpandIT Timelinjer",DEU="Neue ExpandIT Zeitenzeilen",ESP="",SVE="",FRA=""';
                                ApplicationArea = All;


                                trigger OnAction()
                                var
                                    EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
                                    EMSMSrvInvLineTime: page "EMSM Inc. Srv. Inv.(Time) EXP";
                                begin
                                    EMSMServiceInvoiceLine.Reset();
                                    EMSMServiceInvoiceLine.SetFilter("Order No. EXP", '%1', '');
                                    EMSMServiceInvoiceLine.SetFilter("Convert Status EXP", '%1', EMSMServiceInvoiceLine."Convert Status EXP"::New);
                                    EMSMServiceInvoiceLine.SetFilter("Job No. EXP", '<>%1', '');
                                    EMSMSrvInvLineTime.SetTableView(EMSMServiceInvoiceLine);

                                    EMSMSrvInvLineTime.Run();
                                end;
                            }
                            action("ServiceOrdersWError")
                            {
                                Image = TileInfo;
                                Caption = 'Open Service Orders - With Error', Comment = 'DAN="Åbne Serviceordrer - Med Fejl",DEU="Service Aufträge - Mit Fehler",ESP="",SVE="",FRA="Ordres de service ouverts - avec erreur"';
                                ToolTip = 'New Incoming ExpandIT Service Orders - With Error', Comment = 'DAN="Nye Indkommende Serviceordrer - Med Fejl",DEU="Neue eingehende ExpandIT Serviceaufträge",ESP="",SVE="",FRA="Nouvelles commandes de services ExpandIT entrantes"';
                                ApplicationArea = All;


                                trigger OnAction()
                                var
                                    EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
                                    EMSMIncomingOrderPage: page "EMSM Incoming Serv Orders EXP";
                                begin
                                    EMSMServiceItemLine.Reset();
                                    EMSMServiceItemLine.SetFilter("Order No. EXP", '<>%1', '');
                                    EMSMServiceItemLine.SetFilter("Convert Status EXP", '%1', EMSMServiceItemLine."Convert Status EXP"::Error);
                                    EMSMIncomingOrderPage.SetTableView(EMSMServiceItemLine);

                                    EMSMIncomingOrderPage.Run();
                                end;
                            }
                            action("ServiceLinesDlyHdrWError")
                            {
                                Image = TileInfo;
                                Caption = 'Service Lines with delayed header - With Error', Comment = 'DAN="Servicelinjer Med Forsinket Ordrehoved - Med Fejl",DEU="Servicezeilen mit verzögerten Kopfdaten - Mit Fehler",ESP="",SVE="",FRA="Lignes de service avec en-tête retardé - avec erreur"';
                                ToolTip = 'New ExpandIT Service Lines with delayed header - With Error', Comment = 'DAN="Nye ExpandIT Servicelinjer Med Forsinket Ordrehoved - Med Fejl",DEU="Neue ExpandIT Servicezeilen mit verzögerten Kopfdaten - Mit Fehler",ESP="",SVE="",FRA=""';
                                ApplicationArea = All;


                                trigger OnAction()
                                var
                                    EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
                                    EMSMSrvInvLineDlyHdr: page "EMSM Inc. Srv. Inv.(Srv) EXP";
                                begin
                                    EMSMServiceInvoiceLine.Reset();
                                    EMSMServiceInvoiceLine.SetFilter("Order No. EXP", '<>%1', '');
                                    EMSMServiceInvoiceLine.SetFilter("Convert Status EXP", '%1', EMSMServiceInvoiceLine."Convert Status EXP"::Error);
                                    EMSMServiceInvoiceLine.SetFilter("ServiceHeaderExist EXP", '%1', false);
                                    EMSMSrvInvLineDlyHdr.SetTableView(EMSMServiceInvoiceLine);

                                    EMSMSrvInvLineDlyHdr.Run();
                                end;
                            }
                            action("ServiceTimeLinesWError")
                            {
                                Image = TileInfo;
                                Caption = 'Time Lines - With Error', Comment = 'DAN="Timelinjer - Med Fejl",DEU="Service Zeitzeile - Mit Fehler",ESP="",SVE="",FRA="Les lignes du temps - avec erreurs"';
                                ToolTip = 'New ExpandIT Time Lines - With Error', Comment = 'DAN="Nye ExpandIT Timelinjer - Med Fejl",DEU="Neue ExpandIT Zeitenzeilen - Mit Fehler",ESP="",SVE="",FRA="Nouvelles lignes de temps d''ExpandIT - avec erreur"';
                                ApplicationArea = All;


                                trigger OnAction()
                                var
                                    EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
                                    EMSMSrvInvLineTime: page "EMSM Inc. Srv. Inv.(Time) EXP";
                                begin
                                    EMSMServiceInvoiceLine.Reset();
                                    EMSMServiceInvoiceLine.SetFilter("Order No. EXP", '%1', '');
                                    EMSMServiceInvoiceLine.SetFilter("Convert Status EXP", '%1', EMSMServiceInvoiceLine."Convert Status EXP"::Error);
                                    EMSMServiceInvoiceLine.SetFilter("Job No. EXP", '<>%1', '');
                                    EMSMSrvInvLineTime.SetTableView(EMSMServiceInvoiceLine);

                                    EMSMSrvInvLineTime.Run();
                                end;
                            }

                        }

                    }

                }




                grid(serviceActionGrid)
                {
                    Caption = '';
                    cuegroup(ServiceActionContainerReport)
                    {
                        Caption = 'Reports', Comment = 'DAN="Rapporter",DEU="Berichte",ESP="",SVE="",FRA="Rapports"';

                        actions
                        {
                            action("Batch Process Orders")
                            {
                                RunObject = report "EMSM Process Orders EXP";
                                Image = TileReport;
                                Caption = 'ExpandIT Orders', Comment = 'DAN="ExpandIT Ordrer",DEU="ExpandIT Aufträge",ESP="",SVE="",FRA="Commandes d''ExpandIT"';
                                ToolTip = 'Process New ExpandIT Service Orders in Batch', Comment = 'DAN="Behandl Nye ExpandIT Service Ordrer i Batch",DEU="Neue ExpandIT-Serviceaufträge stapelweise bearbeiten",ESP="",SVE="",FRA="Traitement par lots des nouvelles commandes de services ExpandIT"';
                                ApplicationArea = All;


                                trigger OnAction()
                                begin

                                end;
                            }

                            action("Batch Process Service Lines Without Header")
                            {
                                RunObject = report "EMSM Proc SrvLinesWOHeader EXP";
                                Image = TileReport;
                                //Caption = 'ExpandIT Orders', Comment = 'DAN="ExpandIT Ordrer",DEU="ExpandIT Aufträge",ESP="",SVE="",FRA=""';
                                ToolTip = 'Process Service Lines Without Header', Comment = 'DAN="Behandl Servicelinjer Uden Ordrehoved",DEU="",ESP="",SVE="",FRA="Traitement des lignes de service sans en-tête"';
                                ApplicationArea = All;


                                trigger OnAction()
                                begin

                                end;
                            }
                        }
                    }

                }


            }
            group(Sales)
            {
                Caption = 'Sales', Comment = 'DAN="Salg",DEU="Verkauf",ESP="",SVE="",FRA=""';

                grid(SalesGrid)
                {
                    Caption = '';
                    cuegroup(SalesContainer)
                    {
                        Caption = 'Lists', Comment = 'DAN="Lister",DEU="Übersichten",ESP="",SVE="",FRA="Listes"';

                        actions
                        {
                            action("SalesOrders")
                            {
                                Image = TileCloud;
                                Caption = 'Sales Orders', Comment = 'DAN="Salgsordrer",DEU="Verkaufsaufträge",ESP="",SVE="",FRA="Commandes de vente"';
                                ToolTip = 'New ExpandIT Sales Orders', Comment = 'DAN="Nye ExpandIT Salgsordrer",DEU="Neue ExpandIT Verkaufsaufträge",ESP="",SVE="",FRA=""';
                                ApplicationArea = All;


                                trigger OnAction()
                                var
                                    ExpandITOrderHeader: Record "ExpandIT Order Header EXP";
                                    ExpandITSalesList: page "ExpandIT Sales List EXP";
                                begin
                                    ExpandITOrderHeader.Reset();
                                    ExpandITOrderHeader.SetFilter("Status EXP", '%1', ExpandITOrderHeader."Status EXP"::New);
                                    ExpandITSalesList.SetTableView(ExpandITOrderHeader);
                                    ExpandITSalesList.Run();
                                end;
                            }
                        }

                    }
                }


                grid(SalesList)
                {
                    Caption = '';
                    cuegroup(CustomerList)
                    {
                        Caption = '';
                        actions
                        {
                            action("Internet Customer List")
                            {
                                RunObject = page "Internet Customer List EXP";
                                Image = TileReport;
                                Caption = 'Internet Customer List', Comment = 'DAN="Internet Kundeliste",DEU="Internet Kundenliste",ESP="",SVE="",FRA=""';
                                ToolTip = 'A list of ExpandIT Internet Shop Customers', Comment = 'DAN="En liste over ExpandIT Internet Shop kunder",DEU="Eine Liste der ExpandIT Internetshop Kunden",ESP="",SVE="",FRA="Une liste de clients de la boutique Internet ExpandIT"';
                                ApplicationArea = All;


                                trigger OnAction()
                                begin

                                end;
                            }

                            action("E-payment Providers")
                            {
                                RunObject = page "e-payment Providers EXP";
                                Image = TileReport;
                                Caption = 'e-payment Providers', Comment = 'DAN="e-betalings udbydere",DEU="E-Payment-Anbieter",ESP="",SVE="",FRA="Une liste de fournisseurs de paiements électroniques"';
                                ToolTip = 'A list of e-Payment Providers', Comment = 'DAN="En liste over e-betalings udbydere",DEU="Eine Liste der E-Payment-Anbieter",ESP="",SVE="",FRA=""';
                                ApplicationArea = All;


                                trigger OnAction()
                                begin

                                end;
                            }

                        }

                    }

                }

                cuegroup(SalesActionContainerSetup)
                {
                    Caption = 'Setup', Comment = 'DAN="Opsætning",DEU="Einstellungen",ESP="",SVE="",FRA="Configuration"';
                    actions
                    {
                        action("Internet Currencies")
                        {
                            RunObject = page "Internet Cur. Overview EXP";
                            Image = TileReport;
                            Caption = 'Internet Currencies Overview', Comment = 'DAN="Internet Valuta oversigt",DEU="Übersicht über Internetwährungen",ESP="",SVE="",FRA=""';
                            ToolTip = 'A list of currencies for ExpandIT Internet Shop', Comment = 'DAN="En liste over valutaer for ExpandIT Internet Shop",DEU="Eine Liste der Währungen für ExpandIT Internet Shop",ESP="",SVE="",FRA="Une liste de devises pour la boutique en ligne d''ExpandIT"';
                            ApplicationArea = All;


                            trigger OnAction()
                            begin

                            end;
                        }

                    }
                }

                cuegroup(SalesActionContainerReport)
                {
                    Caption = 'Reports and Analysis', Comment = 'DAN="Rapporter og Analyser",DEU="Berichte und Analysen",ESP="",SVE="",FRA="Rapports et analyses"';

                    actions
                    {
                        action("ExpandIT Sales Order Reports")
                        {
                            RunObject = report "ExpandIT Orders";
                            Image = TileReport;
                            ToolTip = 'ExpandIT Sales Order Reports', Comment = 'DAN="ExpandIT Salgsordre Rapporter",DEU="ExpandIT-Kundenauftragsberichte",ESP="",SVE="",FRA="Rapports sur les commandes de vente ExpandIT"';
                            Caption = 'ExpandIT Sales Order Reports', Comment = 'DAN="ExpandIT Salgsordre Rapporter",DEU="ExpandIT-Kundenauftragsberichte",ESP="",SVE="",FRA="Rapports sur les commandes de vente ExpandIT"';
                            ApplicationArea = All;


                            trigger OnAction()
                            begin

                            end;
                        }
                        action("Internet Customers")
                        {
                            RunObject = report "Internet Customers EXP";
                            Image = TileReport;
                            ToolTip = 'Internet Customers Report', Comment = 'DAN="Internet Kunders Rapport",DEU="Internet Kundenbericht",ESP="",SVE="",FRA="Rapport sur les clients Internet"';
                            Caption = 'Internet Customers Report', Comment = 'DAN="Internet Kunders Rapport",DEU="Internet Kundenbericht",ESP="",SVE="",FRA="Rapport sur les clients Internet"';
                            ApplicationArea = All;


                            trigger OnAction()
                            begin

                            end;
                        }
                    }
                }

                cuegroup(SalesActionContainerPeriodicActivities)
                {
                    Caption = 'Periodic Activities', Comment = 'DAN="Periodiske Aktiviteter",DEU="Regelmäßige Aktivitäten",ESP="",SVE="",FRA="Activités périodiques"';

                    actions
                    {
                        action("Convert Sales Orders")
                        {
                            RunObject = report "Bat. Conv. ExpandIT Orders EXP";
                            Image = TileReport;
                            Caption = 'Batch Convert ExpandIT Orders', Comment = 'DAN="Batch Behandling af ExpandIT Ordrer",DEU="Batch Konvertierung ExpandIT Aufträge",ESP="",SVE="",FRA="Conversion par lots des commandes ExpandIT"';
                            ToolTip = 'Convert New Sales Orders in Batch', Comment = 'DAN="Behandl Nye Salgsordrer i Batch",DEU="Neue Kundenaufträge stapelweise umwandeln",ESP="",SVE="",FRA="Convertir les nouvelles commandes de vente en lots"';
                            ApplicationArea = All;


                            trigger OnAction()
                            begin

                            end;
                        }
                        action("Renew e-Payment Clearings")
                        {
                            RunObject = report "Batch Renew e-payments EXP";
                            Image = TileReport;
                            Caption = 'Batch Renew e-payments', Comment = 'DAN="Batch Forny e-betalinger",DEU="Batch E-Zahlungen erneuern",ESP="",SVE="",FRA=""';
                            ToolTip = 'Batch Renew e-payments', Comment = 'DAN="Batch Forny e-betalinger",DEU="Batch E-Zahlungen erneuern",ESP="",SVE="",FRA=""';
                            ApplicationArea = All;


                            trigger OnAction()
                            begin

                            end;
                        }
                        action("Batch Capturing")
                        {
                            RunObject = report "Batch Capture e-payments EXP";
                            Image = TileReport;
                            Caption = 'Batch Capture e-payments', Comment = 'DAN="Batch Modtag e-betalinger",DEU="Erfassen Sie E-Zahlungen",ESP="",SVE="",FRA="Capture d''écran des paiements électroniques par lots"';
                            ToolTip = 'Batch Capture e-payments', Comment = 'DAN="Batch Modtag e-betalinger",DEU="Erfassen Sie E-Zahlungen",ESP="",SVE="",FRA="Capture d''écran des paiements électroniques par lots"';
                            ApplicationArea = All;


                            trigger OnAction()
                            begin

                            end;
                        }
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup', Comment = 'DAN="Opsætning",DEU="Einrichtung",ESP="",SVE="",FRA="Configuration"';
                cuegroup(ExpandITZup)
                {
                    Caption = 'ExpandIT Setup', Comment = 'DAN="ExpandIT Opsætning",DEU="ExpandIT Einrichtung",ESP="",SVE="",FRA="ExpandIT Configuration"';

                    actions
                    {
                        action("ExpandITSetup")
                        {
                            Image = TileSettings;
                            Caption = 'ExpandIT Setup', Comment = 'DAN="ExpandIT Opsætning",DEU="ExpandIT Einrichtung",ESP="",SVE="",FRA="ExpandIT Configuration"';
                            ToolTip = 'ExpandIT Setup Page', Comment = 'DAN="ExpandIT Opsætningsside",DEU="ExpandIT Einrichtung Seite",ESP="",SVE="",FRA="Page de configuration d''ExpandIT"';
                            ApplicationArea = All;


                            trigger OnAction()
                            var
                                ExpandITSetup: Record "Sales & Receivables Setup";
                                ExpandITSetupPage: page "Sales & Receivables Setup";
                            begin
                                ExpandITSetup.Reset();
                                ExpandITSetupPage.SetTableView(ExpandITSetup);
                                ExpandITSetupPage.Run();
                            end;
                        }

                    }
                }

            }
        }

    }
    actions
    {
        area(Navigation)
        {
            group("Jobs")
            {
                action("Job Comments")
                {
                    Caption = 'Job Comments', Comment = 'DAN="Job Kommentarer",DEU="Job Kommentare",ESP="",SVE="",FRA="Commentaires de tâches"';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        jobCommentList: Page "Comment List";
                    begin
                        jobCommentList.Run();
                    end;
                }
            }
        }

        area(Processing)
        {
            group("Job")
            {
                action("Job Create Sales Invoice")
                {
                    Caption = 'Job Create Sales Invoice', Comment = 'DAN="Job Opret Salgsfakturaer",DEU="Job Verkaufsrechnung erstellen",ESP="",SVE="",FRA="Tâche création de facture"';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        jobCreateSalesInvoice: Report "Job Create Sales Invoice";
                    begin
                        jobCreateSalesInvoice.Run();
                    end;
                }
            }
        }
    }

}
