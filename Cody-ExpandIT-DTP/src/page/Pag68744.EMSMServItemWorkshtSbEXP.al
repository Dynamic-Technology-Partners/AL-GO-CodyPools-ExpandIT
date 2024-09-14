/// <summary>
/// Page EMSM Serv Item Worksht Sb EXP (ID 68744).
/// </summary>
page 68744 "EMSM Serv Item Worksht Sb EXP"
{
    // version EMSM3.01.02

    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    // EMSM3.01.01  2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EMMS3.01.02  2018-02-02  FAM * DA is added to controls and actions.
    // EMMS3.01.03  2018-08-01  FAM * Work Type Code is visible now.
    // EMSM18.0.6.52 2020-04-20  FAM * Cost price added (Smart item) 
    // EMSM18.0.6.139  2020-07-27  FAM * Create an Item Tracking Line if SerialNo and Item Tracking Code is set for an Item.


    AutoSplitKey = true;
    Caption = 'Service Item Worksheet Subform', Comment = 'DAN="Underform. til serviceart.kld.",DEU="Unterformular für das Arbeitsblatt für Serviceelemente",ESP="Subf. hoja trabajo prod. serv.",FRA="Sous-formulaire pour Feuille de travail d''Article de Service"';
    DelayedInsert = true;
    Editable = true;
    DeleteAllowed = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "EMSM Service Invoice Line EXP";

    layout
    {
        area(content)
        {
            repeater(Control1)
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
                    Visible = true;

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
                field("Type EXP"; Rec."Type EXP")
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
                field("SerialNo."; Rec."Serial No. EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = true;
                    Description = 'EMSM18.0.6.139';
                }
                field("LotNo."; Rec."Lot No. EXP")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = true;
                    Description = 'EMSM18.0.6.139';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line', Comment = 'DAN="&Linje",DEU="&Linie",ESP="&Línea",FRA="&Ligne"';
                action("&Reject Selected")
                {
                    Caption = '&Reject Selected', Comment = 'DAN="&Afvis markerede",DEU="Ausgewählte ablehnen",ESP="&Rechazar seleccionado",FRA="&Rejeter sélectionné"';
                    Image = Reject;
                    ShortCutKey = 'Shift+Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #78743. Unsupported part was commented. Please check it.
                        /*CurrPage.ServInvLines.FORM.*/
                        RejectSelected;

                    end;
                }
            }
        }
    }

    /// <summary>
    /// RejectSelected.
    /// </summary>
    procedure RejectSelected();
    var
        EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
        EnterRejectedDescription: Page "Enter Rejected Description EXP";
    begin
        CurrPage.SETSELECTIONFILTER(EMSMServiceInvoiceLine);
        // with EMSMServiceInvoiceLine do begin
        if EnterRejectedDescription.RUNMODAL = ACTION::LookupOK then
            if EMSMServiceInvoiceLine.FINDSET(true) then
                repeat
                    EMSMServiceInvoiceLine.TESTFIELD("Convert Status EXP", EMSMServiceInvoiceLine."Convert Status EXP"::New);
                    EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::Rejected;
                    EMSMServiceInvoiceLine."Rejected By User ID EXP" := USERID;
                    EMSMServiceInvoiceLine."Rejected Date Time EXP" := CURRENTDATETIME;
                    EMSMServiceInvoiceLine."Rejected Description EXP" := EnterRejectedDescription.GetDescription;
                    EMSMServiceInvoiceLine.MODIFY();
                until EMSMServiceInvoiceLine.NEXT() = 0;
        // end;
    end;
}

