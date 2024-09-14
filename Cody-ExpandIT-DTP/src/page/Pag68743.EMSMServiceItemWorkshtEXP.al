/// <summary>
/// Page EMSM Service Item Worksht EXP (ID 68743).
/// </summary>
page 68743 "EMSM Service Item Worksht EXP"
{
    // version EMSM3.01.01

    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    // EMSM3.01.01  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EMMS3.01.01  2018-02-02  FAM * DA is added to controls and actions.
    // EMMS3.01.02  2018-08-01  FAM * Service Order Type is added
    // EMSM18.0.6.36 2020-03-17  FAM * Job No. and Saved Date added
    // EMSM18.0.6.45 2020-04-02 FAM * ExpandIT attachment functionality is implemented
    // EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record
    // EMSM18.0.6.205 2021-02-26 FAM * Related Service Item Worksheet opens the related service order.  

    Caption = 'EMSM Service Item Worksheet', Comment = 'DAN="EMSM Serviceartikelkladde",DEU="EMSM Arbeitsblatt für Serviceelemente",ESP="Hoja de trabajo producto servicio",FRA="EMSM Feuille de travail pour Article de Service"';
    DataCaptionExpression = Caption;
    Editable = true;
    DeleteAllowed = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    PageType = Document;
    SourceTable = "EMSM Service Item Line EXP";


    layout
    {
        area(content)
        {
            group("Processing Details")
            {
                Caption = 'Processing Details', Comment = 'DAN="Behandlingsdetaljer",DEU="Verarbeitungsdetails",ESP="Procesando detalles",FRA="Traitement de détails"';
                field("BAS Guid"; Rec."BAS Guid EXP")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Convert Status"; Rec."Convert Status EXP")
                {
                    ApplicationArea = All;
                }
                field("Convert To Service Order"; Rec."Converted To Service Order EXP")
                {
                    TableRelation = "Service Header"."No.";
                    ApplicationArea = All;
                }
                field("Convert To Sales Order"; Rec."Converted To Sales Order EXP")
                {
                    TableRelation = "Sales Header"."No.";
                    ApplicationArea = All;
                }
                field("Processed By User ID"; Rec."Processed By User ID EXP")
                {
                    ApplicationArea = All;
                }
                field("Processed Date Time"; Rec."Processed Date Time EXP")
                {
                    ApplicationArea = All;
                }
                field("Rejected By User ID"; Rec."Rejected By User ID EXP")
                {
                    ApplicationArea = All;
                }
                field("Rejected Date Time"; Rec."Rejected Date Time EXP")
                {
                    ApplicationArea = All;
                }
                field("Error Message"; Rec."Error Message EXP")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Rejected Description"; Rec."Rejected Description EXP")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Service Order Type"; Rec."Service Order Type EXP")
                {
                    ApplicationArea = All;
                }
                field("Customer Reference No."; Rec."Customer Reference No. EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order By Contact Name"; Rec."Order By Contact Name EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("IsUrgent"; Rec."IsUrgent EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ShiptoDoCallBeforeVisit"; Rec."ShiptoDoCallBeforeVisit EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("UserGuid"; Rec."UserGuid EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }

            }
            part(ServInvLines; "EMSM Serv Item Worksht Sb EXP")
            {
                SubPageLink = "Order No. EXP" = FIELD("Order No. EXP"),
                              "Service Item Line No. EXP" = FIELD("Line No. EXP"),
                              "JobPlanningGuid EXP" = FIELD("JobPlanningGuid EXP");
                ApplicationArea = All;
            }
            group(General)
            {
                Caption = 'General', Comment = 'DAN="Generelt",DEU="",ESP="General",FRA="Général"';
                field(OrderNo2; Rec."Order No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Service Item No."; Rec."Service Item No. EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No. EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No. EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Fault Reason Code"; Rec."Fault Reason Code EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type EXP")
                {
                    Caption = 'Document Type', Comment = 'DAN="Bilagstype",DEU="Dokumentenart",ESP="Tipo de documento",FRA="Type de document"';
                    Editable = true;
#pragma warning disable AL0600
                    OptionCaption = 'Quote,Order', Comment = 'DAN="Tilbud,Ordre",DEU="Angebote,Aufträge",ESP="Oferta,Pedido",FRA="Devis,Commande"';
#pragma warning restore AL0600
                    ApplicationArea = All;
                }
                field("Fault Area Code"; Rec."Fault Area Code EXP")
                {
                    ApplicationArea = All;
                }
                field("Symptom Code"; Rec."Symptom Code EXP")
                {
                    ApplicationArea = All;
                }
                field("Fault Code"; Rec."Fault Code EXP")
                {
                    ApplicationArea = All;
                }
                field("Resolution Code"; Rec."Resolution Code EXP")
                {
                    ApplicationArea = All;
                }
                field("Fault Comment"; Rec."Fault Comment EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Repair Status Code"; Rec."Repair Status Code EXP")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }

            }
            group(Details)
            {
                Caption = 'Details', Comment = 'DAN="Detaljer",DEU="",ESP="Detalles",FRA="Détails"';
                field("Contract No."; Rec."Contract No. EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Response Date"; Rec."Response Date EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Response Time"; Rec."Response Time EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Priority; Rec."Priority EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Time EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Finishing Date"; Rec."Finishing Date EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Finishing Time"; Rec."Finishing Time EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                }

                field("Saved Date"; Rec."Saved Date EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                    Description = 'EMSM18.0.6.36';
                }
                field("Saved Time"; Rec."Saved Time EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Service Header Guid"; Rec."Service Header Guid EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Service Item Line Guid"; Rec."Service Item Line Guid EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(RecordAction; Rec."RecordAction EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(JobPlanningGuid; Rec."JobPlanningGuid EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name 2 EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to County"; Rec."Ship-to County EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/RegCode EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(AddressType; Rec."AddressType EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ItemType; Rec."ItemType EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No. EXP")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("W&orksheet")
            {
                Caption = 'W&orksheet', Comment = 'DAN="&Serviceartikelkladde",DEU="",ESP="&Hoja de trabajo",FRA="&Feuille de travail"';
                action("Related Service Item W&orksheet")
                {
                    Caption = 'Open Related Document', Comment = 'DAN="Åbn Relateret Dokument",DEU="Öffnen Sie das zugehörige Dokument",ESP="Abrir documento relacionado",FRA="Ouvrir le document associé",SVE="Öppna relaterat dokument"';
                    Image = Reconcile;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;

                    // EMSM18.0.6.205 begin 
                    trigger OnAction()
                    var
                        ServiceOrderPage: Page "Service Order";
                        ServiceHdrRec: Record "Service Header";
                        SalesHdrRec: Record "Sales Header";
                        SalesOrderPage: Page "Sales Order";
                        JobRec: Record "Job";
                        JobCard: Page "Job Card";
                    begin
                        if Rec."Service Header Guid EXP" <> '' then begin
                            ServiceHdrRec.SetRange("No.", Rec."Service Header Guid EXP");
                            if ServiceHdrRec.FindFirst() then begin
                                ServiceOrderPage.SetTableView(ServiceHdrRec);
                                ServiceOrderPage.Run();
                            end else begin
                                SalesHdrRec.SetRange("No.", Rec."Service Header Guid EXP");
                                if SalesHdrRec.FindFirst() then begin
                                    SalesOrderPage.SetTableView(SalesHdrRec);
                                    SalesOrderPage.Run();
                                end;
                            end;
                        end else begin
                            JobRec.SetRange("No.", Rec."Job No. EXP");
                            if JobRec.FindFirst() then begin
                                JobCard.SetTableView(JobRec);
                                JobCard.Run();
                            end;
                        end;

                    end;
                    // EMSM18.0.6.205 end
                }
                separator(Separator1160840029)
                {
                }
                action("EMSM Comments")
                {
                    Caption = 'EMSM Comments', Comment = 'DAN="EMSM Kommentarer",DEU="",ESP="Comentarios de servicio",FRA="EMSM Commentaires"';
                    Image = ViewComments;
                    RunObject = Page "EMSM Service Comment Sheet EXP";
                    RunPageLink = "No. EXP" = FIELD("Order No. EXP"),
                                  "Table Line No. EXP" = FIELD("Line No. EXP"),
                                  "JobPlanningGuid EXP" = FIELD("JobPlanningGuid EXP");
                    ApplicationArea = All;
                }
                separator(Separator1160840028)
                {
                }
                action("&Reject")
                {
                    Caption = '&Reject', Comment = 'DAN="A&fvis",DEU="&Ablehnen",ESP="&Rechazar",FRA="&Rejeter"';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RejectSelected;
                    end;
                }
                action("&Process")
                {
                    Caption = '&Process', Comment = 'DAN="&Behandl",DEU="Prozess",ESP="&Procesar",FRA="&Procédé"';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        EMSMProcessOrder: Codeunit "EMSM Process Order EXP";
                    begin
                        EMSMProcessOrder.RunWithErrorMessage(false);
                        EMSMProcessOrder.RUN(Rec);
                    end;
                }
                action("Process with &Error Message")
                {
                    Caption = 'Process with &Error Message', Comment = 'DAN="Behandl med &fejlmeddelelse",DEU="Prozess mit Fehlermeldung",ESP="&Procesar con mensaje de error.",FRA="Procédé avec &Message d''erreur"';
                    Image = MakeAgreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        EMSMProcessOrder: Codeunit "EMSM Process Order EXP";
                    begin
                        EMSMProcessOrder.RunWithErrorMessage(true);
                        EMSMProcessOrder.RUN(Rec);
                    end;
                }
                // EMSM18.0.6.45 begin
                action("Open In ExpandIT")
                {
                    Caption = 'Open in ExpandIT', comment = 'ESP="", DAN="Åbn i ExpandIT", DEU="", SVE="", FRA=""';
                    ToolTip = 'Opens BAS Edit Order with the list of all attachments for this order', comment = 'DAN="Åbner BAS Edit Order med en liste over alle de vedhæftninger, der er til denne ordre.", ESP="", DEU="", SVE="", FRA="Ouvre l''ordre d''édition BAS avec la liste de toutes les pièces jointes pour cet ordre"';
                    visible = true;
                    ApplicationArea = All;
                    Image = Attachments;

                    trigger OnAction()
                    var
                        ExpandITSetup: Record "ExpandIT Setup EXP";
                        ExpandITUtil: Codeunit "ExpandIT Util";
                    begin
                        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then // EMSM18.0.6.155
                            Hyperlink(ExpandITUtil.TrimExpandITURL(ExpandITSetup."ExpandIT URL EXP") + 'Modules/emsm_NewServiceOrder/NewServiceOrder.asp?ServiceOrderGuid=' + Rec."Order No. EXP");
                    end;
                }
                // EMSM18.0.6.45 end
            }
        }
    }

    /// <summary>
    /// Caption.
    /// </summary>
    /// <returns>Return value of type Text[80].</returns>
    procedure Caption(): Text[80];
    begin
        if Rec."Service Item No. EXP" <> '' then
            exit(STRSUBSTNO('%1 %2', Rec."Service Item No. EXP", Rec."Description EXP"));
        if Rec."Item No. EXP" <> '' then
            exit(STRSUBSTNO('%1 %2', Rec."Item No. EXP", Rec."Description EXP"));
        exit(STRSUBSTNO('%1 %2', Rec."Serial No. EXP", Rec."Description EXP"));
    end;

    /// <summary>
    /// RejectSelected.
    /// </summary>
    procedure RejectSelected();
    var
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        EnterRejectedDescription: Page "Enter Rejected Description EXP";
    begin
        CurrPage.SETSELECTIONFILTER(EMSMServiceItemLine);
        // with EMSMServiceItemLine do begin
        if EnterRejectedDescription.RUNMODAL = ACTION::LookupOK then
            if EMSMServiceItemLine.FINDSET(true) then
                repeat
                    EMSMServiceItemLine.TESTFIELD("Convert Status EXP", EMSMServiceItemLine."Convert Status EXP"::Error);
                    EMSMServiceItemLine."Convert Status EXP" := EMSMServiceItemLine."Convert Status EXP"::Rejected;
                    EMSMServiceItemLine."Rejected By User ID EXP" := USERID;
                    EMSMServiceItemLine."Rejected Date Time EXP" := CURRENTDATETIME;
                    EMSMServiceItemLine."Rejected Description EXP" := EnterRejectedDescription.GetDescription;
                    EMSMServiceItemLine.MODIFY();
                until EMSMServiceItemLine.NEXT() = 0;
        // end;
    end;
}

