/// <summary>
/// Page EMSM Inc. Srv. Inv.(Time) EXP (ID 68748).
/// </summary>
page 68748 "EMSM Inc. Srv. Inv.(Time) EXP"
{
    // version EMSM3.00.02

    // EMSM3.00.01  2014-03-06  PB  * New service time reporting feature
    // EMSM3.00.02  2018-02-21  FAM * DA/SVE/ESP/DEU/FRA is added to controls.
    // EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record 
    UsageCategory = Documents;
    ApplicationArea = All;
    Caption = 'EMSM Inc. Srv. Inv. Lin (Time)', Comment = 'DAN="EMSM Indk. Srv Fakt Lin (Tid)",ESP="Líneas hoja de trabajo (Proyectos)",FRA="EMSM Nouv. Lign. Fac. Srv. (Temps)",DEU="SRV. RECHN. ZL (ZEIT)"';
    PageType = List;

    DeleteAllowed = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    Editable = true;
    SourceTable = "EMSM Service Invoice Line EXP";
    SourceTableView = WHERE("Order No. EXP" = CONST(''));


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("BAS Guid"; Rec."BAS Guid EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;

                }
                field("RecordAction"; Rec."RecordAction EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;

                }
                field("Order No."; Rec."Order No. EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;

                }
                field("Convert Status"; Rec."Convert Status EXP")
                {
                    ApplicationArea = All;
                    Editable = true;

                }
                field("Service Item Line No."; Rec."Service Item Line No. EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;

                }
                field("Service Item No."; Rec."Service Item No. EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;

                }
                field("Service Item Serial No."; Rec."Service Item Serial No. EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;

                }
                field("Line No."; Rec."Line No. EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Type; Rec."Type EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("No."; Rec."No. EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Job No."; Rec."Job No. EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Job Task No."; Rec."Job Task No. EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("JobPlanningGuid"; Rec."JobPlanningGuid EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Error Message"; Rec."Error Message EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Description; Rec."Description EXP")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2 EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rejected Description"; Rec."Rejected Description EXP")
                {
                    Caption = 'Rejected Description', Comment = 'DAN="Afvisningsbeskrivelse",DEU="Abgelehnte Beschreibung",ESP="Descripción de rechazo",FRA="Description Rejeté", DEU="Beschreibung abgelehnte"';
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Work Type Code"; Rec."Work Type Code EXP")
                {
                    Visible = true;
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Location Code"; Rec."Location Code EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Quantity; Rec."Quantity EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Quantity To Invoice"; Rec."Qty. to Invoice EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Fault Reason Code"; Rec."Fault Reason Code EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Fault Area Code"; Rec."Fault Area Code EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Symptom Code"; Rec."Symptom Code EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Fault Code"; Rec."Fault Code EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Resolution Code"; Rec."Resolution Code EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Unit Price"; Rec."Unit Price EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Amount"; Rec."Amount EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Total Amount"; Rec."Total Amount EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Cost Price"; Rec."Cost Price EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Description = 'EMSM18.0.6.52';
                }
                field("Shipment Date"; Rec."Shipment Date EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Saved Date"; Rec."Saved Date EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Saved Time"; Rec."Saved Time EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Deleted"; Rec."Deleted EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Service Item Line Guid"; Rec."Service Item Line Guid EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Service Invoice Line Guid"; Rec."Service Invoice Line Guid EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Processed Date Time"; Rec."Processed Date Time EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Rejected By User ID "; Rec."Rejected By User ID EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Rejected Date Time"; Rec."Rejected Date Time EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Processed By User ID"; Rec."Processed By User ID EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Processed With Delayed Item Li"; Rec."Proc With Delayed Item Li EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("HasEMSMSrvItemLine"; Rec."HasEMSMSrvItemLine EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("ServiceHeaderExist"; Rec."ServiceHeaderExist EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            part(EMSMServiceOrders; "ExpandITSrvTimeLines FactBox")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1160840091>")
            {
                Caption = '&Order', Comment = 'DAN="&Ordre",ESP="&Pedido",FRA="&Procédé sélectionné"';
                action("<Action1160840094>")
                {
                    Caption = '&Reject Selected', Comment = 'DAN="&Afvis markerede",ESP="&Rechazar seleccionado",FRA="&Remettre Sélectionné",DEU="Beschreibung abgelehnte"';
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
                action("<Action1160840096>")
                {
                    Caption = '&Process Selected', Comment = 'DAN="&Behandl markerede",ESP="&Procesar seleccionado",DEU="Ausgewählte bearbeiten",DEU="Ausgewählte bearbeiten"';
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
                action("<Action1160840097>")
                {
                    Caption = 'Re&set Selected', Comment = 'DAN="&Nulstil markerede",ESP="&",FRA="&Commande"';
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
        area(navigation)
        {
            group("<Action1160840024>")
            {
                Caption = '&Order', Comment = 'ESP="&"';
                action("<Action1160840023>")
                {
                    Caption = 'Related Job Journal', Comment = 'ESP="Diario de trabajo relacionado"';
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ExpandITSetup: Record "ExpandIT Setup EXP";
                        JobJnlLine: Record "Job Journal Line";
                        JobJournalPage: Page "Job Journal";
                        ExpandITUtil: Codeunit "ExpandIT Util";
                    begin
                        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
                            ExpandITSetup.TESTFIELD("Job Jnl. Template Name EXP");
                            ExpandITSetup.TESTFIELD("Job Jnl. Batch Name EXP");
                            JobJnlLine."Journal Template Name" := ExpandITSetup."Job Jnl. Template Name EXP";
                            JobJnlLine."Journal Batch Name" := ExpandITSetup."Job Jnl. Batch Name EXP";
                            JobJnlLine.SETRANGE("Journal Template Name", ExpandITSetup."Job Jnl. Template Name EXP");
                            JobJnlLine.SETRANGE("Journal Batch Name", ExpandITSetup."Job Jnl. Batch Name EXP");

                            JobJournalPage.SETRECORD(JobJnlLine);
                            JobJournalPage.RUN;
                        end;
                    end;
                }
            }
        }
    }

    var
        Txt00001: Label 'You are about to process %1 lines.\Do you want to proceed?';
        //TextConst DAN = 'Systemet vil nu behandle %1 linier.\Vil du fortsætte?', ENU = 'You are about to process %1 lines.\Do you want to proceed?',ESP = 'Está a punto de procesar %1 lineas.\¿Desea continuar?',FRA = 'Vous êtes sur le point de traiter %1 de lignes. \Voulez-vous procéder?';
        Txt00002: Label 'WARNING!\This function should only be used by advanced users.\\You are about to RESET %1 lines and its related invoice and comment lines.\Do you want to proceed?';
        //TextConst DAN = 'ADVARSEL!\Denne funktion bør kun bruges af avancerede brugere.\Hvis funktionen ikke bruges korrekt, kan data ødelægges.\\Systemet vil NULSTILLE %1 linier og deres relaterede faktura- og kommentarlinier.\Ønsker du at fortsætte?', ENU = 'WARNING!\This function should only be used by advanced users.\\You are about to RESET %1 lines and its related invoice and comment lines.\Do you want to proceed?',ESP = 'ADVERTENCIA!\Esta función sólo debe ser utilizada por usuarios avanzados.\\Está a punto de BORRAR las líneas %1 así como las facturas y comentarios relacionados. ¿Desea continuar?',FRA = 'Alerte!\Cette fonction ne doit être utilisée par des utilisateurs expérimentés.\\Vous êtes sur le point de remettre %1 de lignes et ça facture correspondante ainsi que les lignes de commentaires.\Voulez-vous continuer? ';
        Txt00003: Label 'Processing:\';
    //TextConst DAN = 'Behandler:\', ENU = 'Processing:\',ESP = '',FRA = 'Traitement en cours:\';

    local procedure RejectSelected();
    var
        EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
        EnterRejectedDescription: Page "Enter Rejected Description EXP";
    begin
        CurrPage.SETSELECTIONFILTER(EMSMServiceInvoiceLine);
        //with EMSMServiceInvoiceLine do begin
        if EnterRejectedDescription.RUNMODAL = ACTION::LookupOK then
            if EMSMServiceInvoiceLine.FIND('-') then
                repeat
                    EMSMServiceInvoiceLine.TESTFIELD("Convert Status EXP", EMSMServiceInvoiceLine."Convert Status EXP"::Error);
                    EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::Rejected;
                    EMSMServiceInvoiceLine."Rejected By User ID EXP" := USERID;
                    EMSMServiceInvoiceLine."Rejected Date Time EXP" := CURRENTDATETIME;
                    EMSMServiceInvoiceLine."Rejected Description EXP" := EnterRejectedDescription.GetDescription;
                    EMSMServiceInvoiceLine.MODIFY();
                until EMSMServiceInvoiceLine.NEXT() = 0;
        //end;

        CurrPage.UPDATE;
    end;

    local procedure ProcessSelected();
    var
        EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
        ProcessEMSMServiceInvLineTime: Codeunit "Proc. EMSM Srv. Inv.(Time) EXP";
    begin
        CurrPage.SETSELECTIONFILTER(EMSMServiceInvoiceLine);
        //with EMSMServiceInvoiceLine do begin
        if CONFIRM(Txt00001, false, EMSMServiceInvoiceLine.COUNT) then
            if EMSMServiceInvoiceLine.FIND('-') then
                repeat
                    ProcessEMSMServiceInvLineTime.PrcsEMSMSrvInvLinsWtTimeReg(EMSMServiceInvoiceLine, false)
                until EMSMServiceInvoiceLine.NEXT() = 0;
        // end;

        CurrPage.UPDATE;
    end;

    local procedure ResetSelected();
    var
        EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
        EMSMServiceCommentLine: Record "EMSM Service Comment Line EXP";
        d: Dialog;
    begin
        CurrPage.SETSELECTIONFILTER(EMSMServiceInvoiceLine);
        // with EMSMServiceInvoiceLine do begin
        if CONFIRM(Txt00002, false, EMSMServiceInvoiceLine.COUNT) then
            if EMSMServiceInvoiceLine.FIND('-') then
                repeat

                    d.OPEN(
                      Txt00003 +
                      '  #####################################1#\' +
                      '  #####################################2#\' +
                      '  #####################################3#\' +
                      '  #####################################4#\' +
                      '  #####################################5#');

                    d.UPDATE(1, EMSMServiceInvoiceLine.TABLECAPTION);
                    d.UPDATE(2, STRSUBSTNO('%1: %2', EMSMServiceInvoiceLine.FIELDCAPTION("BAS Guid EXP"), EMSMServiceInvoiceLine."BAS Guid EXP"));
                    d.UPDATE(3, STRSUBSTNO('%1: %2', EMSMServiceInvoiceLine.FIELDCAPTION("Order No. EXP"), EMSMServiceInvoiceLine."Order No. EXP"));
                    d.UPDATE(4, STRSUBSTNO('%1: %2', EMSMServiceInvoiceLine.FIELDCAPTION("Line No. EXP"), EMSMServiceInvoiceLine."Line No. EXP"));

                    EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::New;
                    EMSMServiceInvoiceLine.MODIFY;
                until EMSMServiceInvoiceLine.NEXT() = 0;
        // end;

        CurrPage.UPDATE;
    end;
}

