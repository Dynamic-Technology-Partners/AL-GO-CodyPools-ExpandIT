/// <summary>
/// Page EMSM Inc. Srv. Inv.(Srv) EXP (ID 68747).
/// </summary>
page 68747 "EMSM Inc. Srv. Inv.(Srv) EXP"
{
    // version EMSM3.03

    Caption = 'EMSM Inc. Srv. Inv. Lin (Srv)', Comment = 'DAN="EMSM Indk. Srv Fakt Lin (Srv)",ESP="Líneas hoja de trabajo (Servicios)",FRA="EMSM Nouv. Lign. Fac. (Srv)"';

    UsageCategory = Documents;
    ApplicationArea = All;
    PageType = List;
    DeleteAllowed = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    Editable = true;
    SourceTable = "EMSM Service Invoice Line EXP";
    SourceTableView = WHERE("HasEMSMSrvItemLine EXP" = CONST(false),
                            "Order No. EXP" = FILTER(<> ''));

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
            part(EMSMServiceOrders; "ExpandITSrvDldHeader FactBox")
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
                Caption = '&Order', Comment = 'DAN="&Ordre",ESP="&Pedido",FRA="&Commande"';
                action("<Action1160840094>")
                {
                    Caption = '&Reject Selected', Comment = 'DAN="&Afvis markerede",ESP="&Rechazar seleccionado",FRA="&Rejeter sélectionné", DEU="Beschreibung abgelehnte"';
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
                    Caption = '&Process Selected', Comment = 'DAN="&Behandl markerede",DEU="Ausgewählte bearbeiten",ESP="&Procesar seleccionado",FRA="&Procédé sélectionné",DEU="Ausgewählte bearbeiten"';
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
                    Caption = 'Re&set Selected', Comment = 'DAN="&Nulstil markerede",ESP="&Reset seleccionado",FRA="&Remettre Sélectionné"';
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
                Caption = '&Order', Comment = 'DAN="&Ordre",ESP="&Pedido",FRA="&Commande"';
                action("<Action1160840023>")
                {
                    Caption = 'Related Service Item W&orksheet', Comment = 'DAN="Relateret &serviceartikelkladde",DEU="Zugehöriges Serviceartikel-Arbeitsblatt",ESP="&Hoja de trabajo de productos de servicio relacionados",FRA="&Feuille de travaille pour Article de Service apparanté"';
                    RunObject = Page "Service Item Worksheet";
                    RunPageLink = "Document Type" = FIELD("Document Type EXP"),
                                  "Document No." = FIELD("Order No. EXP"),
                                  "Line No." = FIELD("Service Item Line No. EXP");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        Txt00001: Label 'You are about to process %1 lines.\Do you want to proceed?', Comment = 'DAN="Systemet vil nu behandle %1 linier.\Vil du fortsætte?",DEU="Sie sind dabei %1 Zeilen zu verarbeiten.\Wollen Sie forfahren?",ESP="Está a punto de procesar %1 lineas. \¿Desea continuar?",FRA="Vous êtes sur le point de traiter %1 de lignes. \Voulez-vous procéder?",SVE=""';
        //TextConst DAN = 'Systemet vil nu behandle %1 linier.\Vil du fortsætte?', ENU = 'You are about to process %1 lines.\Do you want to proceed?',ESP = 'Está a punto de procesar %1 lineas. \¿Desea continuar?',FRA = 'Vous êtes sur le point de traiter %1 de lignes. \Voulez-vous procéder?';
        Txt00002: Label 'WARNING!\This function should only be used by advanced users.\\You are about to RESET %1 lines and its related invoice and comment lines.\Do you want to proceed?', Comment = 'DAN="ADVARSEL!\Denne funktion bør kun bruges af avancerede brugere.\Hvis funktionen ikke bruges korrekt, kan data ødelægges.\\Systemet vil NULSTILLE %1 linier og deres relaterede faktura- og kommentarlinier.\Ønsker du at fortsætte?",DEU="Warnung: Diese Funktion sollte nur von erfahren Benutzern verwendet werden.\\ Sie sind dabei %1 Zeilen und die zugehörigen Rechnungen und Kommentare zurückzusetzen.\Wollen Sie fortfahren?",ESP="ADVERTENCIA!\Esta función sólo debe ser utilizada por usuarios avanzados.\\Está a punto de BORRAR las líneas %1 así como las facturas y comentarios relacionados. ¿Desea continuar?",FRA="Alerte!\Cette fonction ne doit être utilisée par des utilisateurs expérimentés.\\Vous êtes sur le point de remettre %1 de lignes et ça facture correspondante ainsi que les lignes de commentaires.\Voulez-vous continuer? ",SVE=""';
        //TextConst DAN = 'ADVARSEL!\Denne funktion bør kun bruges af avancerede brugere.\Hvis funktionen ikke bruges korrekt, kan data ødelægges.\\Systemet vil NULSTILLE %1 linier og deres relaterede faktura- og kommentarlinier.\Ønsker du at fortsætte?', ENU = 'WARNING!\This function should only be used by advanced users.\\You are about to RESET %1 lines and its related invoice and comment lines.\Do you want to proceed?',ESP = 'ADVERTENCIA!\Esta función sólo debe ser utilizada por usuarios avanzados.\\Está a punto de BORRAR las líneas %1 así como las facturas y comentarios relacionados. ¿Desea continuar?',FRA = 'Alerte!\Cette fonction ne doit être utilisée par des utilisateurs expérimentés.\\Vous êtes sur le point de remettre %1 de lignes et ça facture correspondante ainsi que les lignes de commentaires.\Voulez-vous continuer? ';
        Txt00003: Label 'Processing:\', Comment = 'DAN="Behandler:\",DEU="Verarbeiten:\",ESP="Procesando:\",FRA="Traitement en cours:\",SVE=""';
        //TextConst DAN = 'Behandler:\', ENU = 'Processing:\',ESP = 'Procesando:\',FRA = 'Traitement en cours:\';
        Txt00004: Label 'The line(s) can not be converted.\Service Header does not exist or is not approved yet', Comment = 'DAN="Linjerne kan ikke konverteres.\Servicehoved  eksisterer ikke eller er ikke blevet godkendt endnu.",DEU="Die Zeilen können nicht konvertiert werden.\Der Service Kopf existiert nicht oder ist noch nicht genehmigt.",ESP="",FRA="La ou les lignes ne peuvent pas être converties.\L''en-tête du service n''existe pas ou n''est pas encore approuvé",SVE=""';

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
        ProcessEMSMServiceInvLine: Codeunit "Proc. EMSM Srv. Inv.(Srv.) EXP";
    begin
        CurrPage.SETSELECTIONFILTER(EMSMServiceInvoiceLine);
        //with EMSMServiceInvoiceLine do begin
        if CONFIRM(Txt00001, false, EMSMServiceInvoiceLine.COUNT) then begin
            if EMSMServiceInvoiceLine.FIND('-') then
                repeat
                    ProcessEMSMServiceInvLine.PrcsEMSMSrvInvLinsWtDlyedItLin(EMSMServiceInvoiceLine, false)
                until EMSMServiceInvoiceLine.NEXT() = 0;
        end;
        CurrPage.UPDATE;
    end;

    local procedure ResetSelected();
    var
        EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
        EMSMServiceCommentLine: Record "EMSM Service Comment Line EXP";
        d: Dialog;
    begin
        CurrPage.SETSELECTIONFILTER(EMSMServiceInvoiceLine);
        //with EMSMServiceInvoiceLine do begin
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
        //end;

        CurrPage.UPDATE;
    end;
}

