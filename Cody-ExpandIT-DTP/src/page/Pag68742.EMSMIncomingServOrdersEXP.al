/// <summary>
/// Page EMSM Incoming Serv Orders EXP (ID 68742).
/// </summary>
page 68742 "EMSM Incoming Serv Orders EXP"
{
    // version EMSM3.01.01

    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    // EMSM3.01.01  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EMSM3.01.01  2018-02-02  FAM * DAN is now added to labels and textConstants.
    // EMSM18.0.6.43  2018-03-27  FAM * Job No. is added
    // EMSM18.0.6.45  2020-04-02 FAM * ExpandIT attachment functionality is implemented
    // EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record 
    UsageCategory = Documents;
    ApplicationArea = All;
    Caption = 'EMSM Incoming Service Orders', Comment = 'DAN="EMSM Indkommende serviceordrer",ESP="Pedidos de servicio realizados",FRA=" EMSM Nouvelles Commandes de Service",DEU="Eingehende Serviceaufträge"';
    CardPageID = "EMSM Service Item Worksht EXP";
    Editable = true;
    PageType = List;
    DeleteAllowed = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    SourceTable = "EMSM Service Item Line EXP";

    layout
    {
        area(content)
        {
            repeater(Control1160840000)
            {
                field("Convert Status"; Rec."Convert Status EXP")
                {
                    ApplicationArea = All;
                }
                field("BAS Guid"; Rec."BAS Guid EXP")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Error Message"; Rec."Error Message EXP")
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
                field("Rejected Description"; Rec."Rejected Description EXP")
                {
                    ApplicationArea = All;
                }
                field("Service Item No."; Rec."Service Item No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec."Description EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Repair Status Code"; Rec."Repair Status Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Priority; Rec."Priority EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Response Time (Hours)"; Rec."Response Time (Hours) EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Response Date"; Rec."Response Date EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Response Time"; Rec."Response Time EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Time EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Finishing Date"; Rec."Finishing Date EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Finishing Time"; Rec."Finishing Time EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Saved Date"; Rec."Saved Date EXP")
                {
                    Editable = true;
                    ApplicationArea = All;
                    Description = 'EMSM18.0.6.36';
                    Visible = false;
                }
                field("Saved Time"; Rec."Saved Time EXP")
                {
                    Editable = true;
                    ApplicationArea = All;

                    Visible = false;
                }
                field("Fault Reason Code"; Rec."Fault Reason Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fault Area Code"; Rec."Fault Area Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Symptom Code"; Rec."Symptom Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fault Code"; Rec."Fault Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Resolution Code"; Rec."Resolution Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
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
                field("Ship-to Name"; Rec."Ship-to Name EXP")
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
                field("Contract No."; Rec."Contract No. EXP")
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
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fault Comment"; Rec."Fault Comment EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Processed By User ID"; Rec."Processed By User ID EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Service Order Type"; Rec."Service Order Type EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                field("Convert To Service Order"; Rec."Converted To Service Order EXP")
                {
                    TableRelation = "Service Header"."No.";
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("UserGuid"; Rec."UserGuid EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Convert To Sales Order"; Rec."Converted To Sales Order EXP")
                {
                    TableRelation = "Sales Header"."No.";
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            part(EMSMServiceOrders; "ExpandItSrvOrder FactBox EXP")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Order")
            {
                Caption = '&Order', Comment = 'DAN="&Ordre", DEU="Auftrag",ESP="&Pedido",FRA="&Commande"';
                action("&Reject Selected")
                {
                    Caption = '&Reject Selected', Comment = 'DAN="&Afvis markerede",DEU="Ausgewählte ablehnen",ESP="&Rechazar seleccionado",FRA="&Rejeter sélectionné"';
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
                action("&Process Selected")
                {
                    Caption = '&Process Selected', Comment = 'DAN="&Behandl markerede",DEU="Ausgewählte bearbeiten",ESP="&Procesar seleccionado",FRA="&Procédé sélectionné"';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ProcessSelected;
                    end;
                }
                action("Re&set Selected")
                {
                    Caption = 'Re&set Selected', Comment = 'DAN="&Nulstil markerede",DEU="Ausgewählte zurücksetzen",ESP="&Reset seleccionado",FRA="&Remettre Sélectionné"';
                    Image = NewSparkle;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        ResetSelected;
                    end;
                }
            }
        }
        // EMSM18.0.6.45 begin
        area(Processing)
        {
            action("Open In ExpandIT EXP")
            {
                Caption = 'Open in ExpandIT', comment = 'ESP="", DAN="Åbn i ExpandIT", DEU="", SVE="", FRA=""';
                ToolTip = 'Opens BAS Edit Order with the list of all attachments for this order', comment = 'DAN="Åbner BAS Edit Order med en liste over alle de vedhæftninger, der er til denne ordre.", ESP="", DEU="", SVE="", FRA="Ouvre l''ordre d''édition BAS avec la liste de toutes les pièces jointes pour cet ordre"';
                visible = true;
                ApplicationArea = All;
                Image = Attachments;

                trigger OnAction()
                var
                    ExpandITSetup: Record "ExpandIT Setup EXP";
                    EMSMServiceITemLine: Record "EMSM Service Item Line EXP";
                    ExpandITUtil: Codeunit "ExpandIT Util";
                begin
                    if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
                        CurrPage.SetSelectionFilter(EMSMServiceITemLine);
                        if EMSMServiceITemLine.FindFirst() then begin
                            repeat
                                Hyperlink(ExpandITUtil.TrimExpandITURL(ExpandITSetup."ExpandIT URL EXP") + 'Modules/emsm_NewServiceOrder/NewServiceOrder.asp?ServiceOrderGuid=' + EMSMServiceITemLine."Order No. EXP");
                            until EMSMServiceITemLine.next() = 0;
                        end;
                    end;
                end;
            }
        }
        // EMSM18.0.6.45 end
    }

    var
        Txt00001: Label 'You are about to process %1 lines.\Do you want to proceed?', Comment = 'DAN="Systemet vil nu behandle %1 linje(r).\Vil du fortsætte?",ESP="Está a punto de procesar %1 lineas. \¿Desea continuar?",DEU="Sie sind dabei %1 Zeilen zu verarbeiten.\Wollen Sie forfahren?",SVE=""';
        Txt00002: Label 'WARNING!\This function should only be used by advanced users.\\You are about to RESET %1 lines and its related invoice and comment lines.\Do you want to proceed?', Comment = 'DAN="ADVARSEL!\Denne funktion bør kun bruges af avancerede brugere.\Hvis funktionen ikke bruges korrekt, kan data ødelægges.\\Systemet vil NULSTILLE %1 linier og deres relaterede faktura- og kommentarlinier.\Ønsker du at fortsætte?",DEU="Warnung: Diese Funktion sollte nur von erfahren Benutzern verwendet werden.\\ Sie sind dabei %1 Zeilen und die zugehörigen Rechnungen und Kommentare zurückzusetzen.\Wollen Sie fortfahren?",ESP="ADVERTENCIA!\Esta función sólo debe ser utilizada por usuarios avanzados.\\Está a punto de BORRAR las líneas %1 así como las facturas y comentarios relacionados. ¿Desea continuar?",SVE="WARNING!\This function should only be used by advanced users.\\You are about to RESET %1 lines and its related invoice and comment lines.\Do you want to proceed?",FRA="WARNING!\This function should only be used by advanced users.\\You are about to RESET %1 lines and its related invoice and comment lines.\Do you want to proceed?"';
        Txt00003: Label 'Processing:\', Comment = 'DAN="Behandler:\",DEU="Verarbeiten:\",ESP="Procesando:\",FRA="Traitement :\",SVE=""';
        Txt00004: Label 'Some lines have failed the conversion.\To find out more please check the factbox\ Number of lines with error: %1', Comment = 'DAN="Nogle linjer fejlede under konvertering. \For at finde mere info, tjek venligst factbox''en\Antal linjer med fejl: %1",ESP="",DEU="Einige Zeilen konnten nicht konvertiert werdne.\Mehr erfahren Sie im Infofenster\ Anzahl Zeilen mit Fehler: %1",SVE=""';

    local procedure RejectSelected();
    var
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        EnterRejectedDescription: Page "Enter Rejected Description EXP";
    begin
        CurrPage.SETSELECTIONFILTER(EMSMServiceItemLine);
        //with EMSMServiceItemLine do begin
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
        //end;

        CurrPage.UPDATE;
    end;

    local procedure ProcessSelected();
    var
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        EMSMProcessOrder: Codeunit "EMSM Process Order EXP";
        NumberOfErrors: Integer;
    begin
        CurrPage.SETSELECTIONFILTER(EMSMServiceItemLine);
        //with EMSMServiceItemLine do begin
        if CONFIRM(Txt00001, false, EMSMServiceItemLine.COUNT) then
            if EMSMServiceItemLine.FIND('-') then
                repeat
                    EMSMProcessOrder.RunWithErrorMessage(false);
                    EMSMProcessOrder.RUN(EMSMServiceItemLine);
                until EMSMServiceItemLine.NEXT() = 0;
        // end;
        //Finds the number of lines with error
        // EMSMServiceItemLine.Reset();
        // NumberOfErrors := 0;
        // EMSMServiceItemLine.SetRange(EMSMServiceItemLine."Convert Status", EMSMServiceItemLine."Convert Status"::Error);
        // if EMSMServiceItemLine.FindFirst() then begin
        //     NumberOfErrors := EMSMServiceItemLine.Count();
        //     Message(Txt00004, NumberOfErrors);
        // end;
        NumberOfErrors := 0;
        EMSMServiceItemLine.SetRange("Convert Status EXP", EMSMServiceItemLine."Convert Status EXP"::Error);
        if not EMSMServiceItemLine.IsEmpty() then begin
            repeat
                NumberOfErrors := NumberOfErrors + 1;
            //Message(Txt00004, EMSMServiceItemLine.Count());
            until Rec.Next() = 0;
            Message(Txt00004, NumberOfErrors);
        end;


        CurrPage.UPDATE;
    end;

    local procedure ResetSelected();
    var
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
        EMSMServiceCommentLine: Record "EMSM Service Comment Line EXP";
        d: Dialog;
    begin
        CurrPage.SETSELECTIONFILTER(EMSMServiceItemLine);
        // with EMSMServiceItemLine do begin
        if CONFIRM(Txt00002, false, EMSMServiceItemLine.COUNT) then
            if EMSMServiceItemLine.FIND('-') then
                repeat

                    d.OPEN(
                      Txt00003 +
                      '  #####################################1#\' +
                      '  #####################################2#\' +
                      '  #####################################3#\' +
                      '  #####################################4#\' +
                      '  #####################################5#');

                    d.UPDATE(1, EMSMServiceItemLine.TABLECAPTION);
                    d.UPDATE(2, STRSUBSTNO('%1: %2', EMSMServiceItemLine.FIELDCAPTION("BAS Guid EXP"), EMSMServiceItemLine."BAS Guid EXP"));
                    d.UPDATE(3, STRSUBSTNO('%1: %2', EMSMServiceItemLine.FIELDCAPTION("Order No. EXP"), EMSMServiceItemLine."Order No. EXP"));
                    d.UPDATE(4, STRSUBSTNO('%1: %2', EMSMServiceItemLine.FIELDCAPTION("Line No. EXP"), EMSMServiceItemLine."Line No. EXP"));


                    //Loop through Invoice Lines and process them
                    d.UPDATE(1, EMSMServiceInvoiceLine.TABLECAPTION);
                    EMSMServiceInvoiceLine.RESET;
                    EMSMServiceInvoiceLine.SETRANGE("Order No. EXP", EMSMServiceItemLine."Order No. EXP");
                    EMSMServiceInvoiceLine.SETRANGE("Service Item Line No. EXP", EMSMServiceItemLine."Line No. EXP");
                    EMSMServiceInvoiceLine.SETRANGE("JobPlanningGuid EXP", EMSMServiceItemLine."JobPlanningGuid EXP");
                    if EMSMServiceInvoiceLine.FIND('-') then
                        repeat
                            d.UPDATE(2, STRSUBSTNO('%1: %2', EMSMServiceInvoiceLine.FIELDCAPTION("BAS Guid EXP"), EMSMServiceInvoiceLine."BAS Guid EXP"));
                            d.UPDATE(3, STRSUBSTNO('%1: %2', EMSMServiceInvoiceLine.FIELDCAPTION("Order No. EXP"), EMSMServiceInvoiceLine."Order No. EXP"));
                            d.UPDATE(
                              4,
                              STRSUBSTNO(
                                '%1: %2',
                                EMSMServiceInvoiceLine.FIELDCAPTION("Service Item Line No. EXP"),
                                EMSMServiceInvoiceLine."Service Item Line No. EXP"));
                            d.UPDATE(5, STRSUBSTNO('%1: %2', EMSMServiceInvoiceLine.FIELDCAPTION("Line No. EXP"), EMSMServiceInvoiceLine."Line No. EXP"));

                            EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::New;
                            EMSMServiceInvoiceLine.MODIFY;
                        until EMSMServiceInvoiceLine.NEXT = 0;

                    //Loop through Comment Lines and process them
                    d.UPDATE(1, EMSMServiceCommentLine.TABLECAPTION);
                    EMSMServiceCommentLine.RESET;
                    EMSMServiceCommentLine.SETRANGE("No. EXP", EMSMServiceItemLine."Order No. EXP");
                    EMSMServiceCommentLine.SETRANGE("Table Line No. EXP", EMSMServiceItemLine."Line No. EXP");
                    EMSMServiceCommentLine.SETRANGE("JobPlanningGuid EXP", EMSMServiceItemLine."JobPlanningGuid EXP");
                    if EMSMServiceCommentLine.FIND('-') then
                        repeat
                            d.UPDATE(2, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("BAS Guid EXP"), EMSMServiceCommentLine."BAS Guid EXP"));
                            d.UPDATE(3, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("No. EXP"), EMSMServiceCommentLine."No. EXP"));
                            d.UPDATE(
                              4,
                              STRSUBSTNO(
                                '%1: %2',
                                EMSMServiceCommentLine.FIELDCAPTION("Table Line No. EXP"),
                                EMSMServiceCommentLine."Table Line No. EXP"));
                            d.UPDATE(5, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("Line No. EXP"), EMSMServiceCommentLine."Line No. EXP"));

                            EMSMServiceCommentLine."Convert Status EXP" := EMSMServiceCommentLine."Convert Status EXP"::New;
                            EMSMServiceCommentLine.MODIFY;
                        until EMSMServiceCommentLine.NEXT = 0;

                    EMSMServiceItemLine."Convert Status EXP" := EMSMServiceItemLine."Convert Status EXP"::New;
                    EMSMServiceItemLine.MODIFY;
                until EMSMServiceItemLine.NEXT() = 0;
        // end;

        CurrPage.UPDATE;
    end;
}

