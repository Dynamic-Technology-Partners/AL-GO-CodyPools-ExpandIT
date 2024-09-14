/// <summary>
/// Codeunit Proc. EMSM Srv. Inv.(Srv.) EXP (ID 68742).
/// </summary>
codeunit 68742 "Proc. EMSM Srv. Inv.(Srv.) EXP"
{
    // version EMSM3.04.03
    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    // EMSM3.04.01  2017-10-11  RSP * Validate on Work Type to trigger price calculation
    // EMSM3.04.02  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EMSM3.04.03  2018-02-01  FAM * New key is being used in IF ServiceInvoiceLine.GET("Document Type",  EMSMServiceItemLine."Service Header Guid", "Line No.")
    // EMSM3.04.04  2018-11-15  FAM * FindServiceHeader is used to get the serviceheader No.
    // EMSM3.05.10  2019-10-04  FAM * Set document type to Quote or Order 
    // EMSM3.0.5.15  2019-12-03  FAM * Set document type 
    // EMSM3.0.5.16  2019-12-10  FAM * Only items of type Inventoy can get converted
    // EMSM18.0.6.32 2020-03-02  FAM * Find and convert smart item
    // EMSM18.0.6.35 2020-03-17  FAM * Service Lines without header when conversion rule is set to Prefer Jobs. 
    // EMSM18.0.6.41 2020-03-20  FAM * Bug fixed 
    // EMSM18.0.6.52 2020-04-20  FAM * Cost price added (Smart item) 
    // EMSM18.0.6.61 2020-05-15  FAM * Add Location Code to conversion
    // EMSM18.0.6.133 2020-07-06  FAM * Use Order No. from Rec instead of Service Header Guid from EMSM Service Item Line. 
    // EMSM18.0.6.139  2020-07-27  FAM * Create an Item Tracking Line if SerialNo and Item Tracking Code is set for an Item. 
    // EMSM18.0.6.144 2020-08-17 FAM * Override replacementdialog (Component) from ExpandIT Setup
    // EMSM18.0.6.145 2020-08-21 FAM * Replacement Dialog changed -  NEW and Replace are removed
    // EMSM18.0.6.148 2020-09-10 FAM * Add FindFirst check for ExpandIT Setup 
    // EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record
    // EMSM18.0.6.185 2020-11-20 FAM * Service Location Code must be set before unit and cost price
    // EMSM18.0.6.193 2020-12-07 FAM * ExpandIT Setup is empty 
    // EMSM18.0.6.196 2020-12-15 FAM * Convert servicelines without header to job journal lines
    // EMSM18.0.6.198 2021-01-05 FAM * Set Location Code only for items with type = Inventory
    // EMSM18.0.6.209 2021-03-23 FAM * Event added for Service Line
    TableNo = "EMSM Service Invoice Line EXP";

    trigger OnRun();
    var
        ServiceInvoiceLine: Record "Service Line";
        ProcessEMSMServiceItemLine: Codeunit "Proc. EMSM Serv Item Line EXP";
        ProcessESMServiceInvLineTime: Codeunit "Proc. EMSM Srv. Inv.(Time) EXP";
        ExpandITSetup: Record "ExpandIT Setup EXP";
        ServiceHdr: Record "Service Header";
        ServiceHeaderNo: Code[20];
        item: Record Item;
        ExpandITUtil: Codeunit "ExpandIT Util";
        // EMSM18.0.6.139 begin
        RecVar: Variant;
        // EMSM18.0.6.139 end
        errorTxt: Label 'Only items of type Inventroy can be converted into Service Invoice Lines', Comment = 'DAN="Kun varer af typen Varelager kan blive konverteret til service linjer",DEU="Nur Artikel mit pos. Bestand können in Service Rechnungszeilen konvertiert werden.",ESP="",FRA="",SVE=""';
    begin
        //Processes one line and encapsulates possible errors from processing the line
        if not (Rec."Convert Status EXP" in [Rec."Convert Status EXP"::New, Rec."Convert Status EXP"::Error]) then
            exit;
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
            if ((ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Jobs") And (Rec."Job No. EXP" <> '')) then begin // EMSM18.0.6.133
                ProcessESMServiceInvLineTime.Run(Rec);
                exit;
            end;
            ServiceInvoiceLine.RESET;
            if ServiceInvoiceLine.GET(Rec."Document Type EXP", Rec."Order No. EXP", Rec."Line No. EXP") then begin // EMSM18.0.6.133
                if Rec."Deleted EXP" or (Rec."RecordAction EXP" = 'DELETE') then begin
                    ServiceInvoiceLine.DELETE(true);
                end else begin
                    if Rec."RecordAction EXP" <> 'DELETE' then begin
                        IF (Rec."Type EXP" = Rec."Type EXP"::Item) THEN
                            Item.GET(Rec."No. EXP");
                        // EMSM18.0.6.198 begin 
                        UpdateServiceInvoiceLine(ServiceInvoiceLine, Rec);
                        ServiceInvoiceLine.MODIFY(true);
                        // EMSM18.0.6.139 begin
                        RecVar := ServiceInvoiceLine;
                        ProcessEMSMServiceItemLine.InsertItemTrackingLine(Item, Rec, RecVar);
                        // EMSM18.0.6.139 end
                        // EMSM18.0.6.198 end
                    end;
                end;
            end else begin
                if Rec."RecordAction EXP" <> 'DELETE' then begin
                    // EMSM3.0.5.16 begin 
                    if (Rec."Type EXP" = Rec."Type EXP"::Item) then
                        item.Get(Rec."No. EXP");
                    ServiceInvoiceLine.INIT;
                    //EMSM3.04.04 begin 
                    ProcessEMSMServiceItemLine.FindServiceHeader(EMSMServiceItemLine, ServiceHdr, ServiceHeaderNo);
                    // EMSM3.05.10 begin 
                    if (ServiceHdr."Document Type" = ServiceHdr."Document Type"::Order) then
                        ServiceInvoiceLine.VALIDATE("Document Type", ServiceInvoiceLine."Document Type"::Order)
                    else
                        ServiceInvoiceLine.VALIDATE("Document Type", ServiceInvoiceLine."Document Type"::Quote);
                    // EMSM3.05.10 end 
                    ServiceInvoiceLine.VALIDATE("Document No.", ServiceHdr."No.");
                    //EMSM3.04.04 end 
                    ServiceInvoiceLine."Line No." := Rec."Line No. EXP";
                    UpdateServiceInvoiceLine(ServiceInvoiceLine, Rec);
                    OnBeforeInsertServiceLine(Rec, ServiceInvoiceLine); // EMSM16.0.6.209 
                    ServiceInvoiceLine.INSERT(true);
                    // EMSM18.0.6.139 begin
                    RecVar := ServiceInvoiceLine;
                    ProcessEMSMServiceItemLine.InsertItemTrackingLine(Item, Rec, RecVar);
                    // EMSM18.0.6.139 end                    
                end;
            end;
            Rec."Convert Status EXP" := Rec."Convert Status EXP"::Converted;
            Rec."Error Message EXP" := '';
            Rec.MODIFY;
        end else
            error(ExpandItSetupError); // EMSM18.0.6.193
    end;

    var
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        ExpandItSetupError: Label 'ExpandIT Setup is empty', comment = 'ESP="", DAN="ExpandIT Opsætning er tom", DEU="", FRA="", SVE=""';

    local procedure UpdateServiceInvoiceLine(var ServiceInvoiceLine: Record "Service Line"; EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP");
    var
        ExpandITSetup: Record "ExpandIT Setup EXP";
        ExpandITUtil: Codeunit "ExpandIT Util";
        Item: Record "Item";
    begin
        //with EMSMServiceInvoiceLine do begin
        ServiceInvoiceLine."Service Item Line No." := EMSMServiceInvoiceLine."Service Item Line No. EXP"; //EMSMServiceItemLine."Line No.";                        
        ServiceInvoiceLine."Service Item No." := EMSMServiceInvoiceLine."Service Item No. EXP";
        ServiceInvoiceLine."Service Item Serial No." := EMSMServiceInvoiceLine."Service Item Serial No. EXP";
        ServiceInvoiceLine.VALIDATE(Type, EMSMServiceInvoiceLine."Type EXP");
        ServiceInvoiceLine.SetHideReplacementDialog(true);
        ServiceInvoiceLine.VALIDATE("No.", EMSMServiceInvoiceLine."No. EXP");
        // EMSM18.0.6.145 begin
        Case ExpandITSetup."Replacement Dialog Values EXP" of
            ExpandITSetup."Replacement Dialog Values EXP"::Ask:
                ServiceInvoiceLine.SetHideReplacementDialog(false);
            ExpandITSetup."Replacement Dialog Values EXP"::Ignore:
                ServiceInvoiceLine.SetHideReplacementDialog(true);
        // EMSM18.0.6.145
        end;
        // EMSM18.0.6.145 end
        ServiceInvoiceLine."Fault Area Code" := EMSMServiceInvoiceLine."Fault Area Code EXP";
        ServiceInvoiceLine."Fault Reason Code" := EMSMServiceInvoiceLine."Fault Reason Code EXP";
        ServiceInvoiceLine."Symptom Code" := EMSMServiceInvoiceLine."Symptom Code EXP";
        ServiceInvoiceLine."Fault Code" := EMSMServiceInvoiceLine."Fault Code EXP";
        ServiceInvoiceLine."Resolution Code" := EMSMServiceInvoiceLine."Resolution Code EXP";
        ServiceInvoiceLine.VALIDATE("Work Type Code", EMSMServiceInvoiceLine."Work Type Code EXP"); // EMSM3.04.01
        ServiceInvoiceLine.Description := EMSMServiceInvoiceLine."Description EXP";
        ServiceInvoiceLine."Description 2" := EMSMServiceInvoiceLine."Description 2 EXP";
        ServiceInvoiceLine.VALIDATE(Quantity, EMSMServiceInvoiceLine."Quantity EXP");
        // EMSM18.0.6.198 begin
        if (ServiceInvoiceLine.Type = ServiceInvoiceLine.Type::Item) and (Item.Get(ServiceInvoiceLine."No.") and (Item.Type = Item.Type::Inventory)) then begin
            ServiceInvoiceLine.Validate("Location Code", EMSMServiceInvoiceLine."Location Code EXP");  // EMSM18.0.6.185
        end;
        // EMSM18.0.6.198 end
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin
            if (ServiceInvoiceLine.Type = ServiceInvoiceLine.Type::Item) and (ExpandITSetup."Smart Item No. EXP" = ServiceInvoiceLine."No.") then begin
                ServiceInvoiceLine.Validate("Unit Price", EMSMServiceInvoiceLine."Unit Price EXP");
                ServiceInvoiceLine.Validate("Unit Cost", EMSMServiceInvoiceLine."Cost Price EXP");
            end;
        end
        // If UOM functionality has been added, you can uncomment the next line to transfer the data
        // ServiceInvoiceLine.VALIDATE("Unit of Measure Code", "Unit of Measure Code");           
        //end;
    end;

    /// <summary>
    /// SetEMSMServiceItemLine.
    /// </summary>
    /// <param name="NewEMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    procedure SetEMSMServiceItemLine(NewEMSMServiceItemLine: Record "EMSM Service Item Line EXP");
    begin
        EMSMServiceItemLine := NewEMSMServiceItemLine;
    end;

    /// <summary>
    /// PrcsEMSMSrvInvLinsWtDlyedItLin.
    /// </summary>
    /// <param name="EMSMServiceInvoiceLine">VAR Record "EMSM Service Invoice Line EXP".</param>
    /// <param name="DoRunWithErrorMessage">Boolean.</param>
    procedure PrcsEMSMSrvInvLinsWtDlyedItLin(var EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP"; DoRunWithErrorMessage: Boolean);
    var
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        ServiceHdr: Record "Service Header";
        EarlierEMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        DummyEMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        ServiceItemLine: Record "Service Item Line";
        ProcessEMSMServiceInvLine: Codeunit "Proc. EMSM Srv. Inv.(Srv.) EXP";
        ServiceHdrIsFound: Boolean;
        "Error Message": Text;
        ExpandITSetup: Record "ExpandIT Setup EXP";
        ExpandITUtil: Codeunit "ExpandIT Util";
        //EMSM18.0.6.196 begin 
        transferToJobs: boolean;
        transferToService: boolean;
        ProcessEMSMSServiceTimeLine: Codeunit "Proc. EMSM Srv. Inv.(Time) EXP";
    //EMSM18.0.6.196 end
    begin
        // Process EMSMServiceInvoiceLines With Delayed EMSMServiceItemLines
        //with EMSMServiceInvoiceLine do begin
        if EMSMServiceInvoiceLine."Convert Status EXP" in [EMSMServiceInvoiceLine."Convert Status EXP"::New, EMSMServiceInvoiceLine."Convert Status EXP"::Error] then begin
            EMSMServiceItemLine.Init();
            EMSMServiceItemLine.SETRANGE("Order No. EXP", EMSMServiceInvoiceLine."Order No. EXP");
            EMSMServiceItemLine.SETRANGE("Line No. EXP", EMSMServiceInvoiceLine."Service Item Line No. EXP");
            EMSMServiceItemLine.SETRANGE("JobPlanningGuid EXP", EMSMServiceInvoiceLine."JobPlanningGuid EXP");
            if not EMSMServiceItemLine.FIND('-') then begin //This should only run if EMSMServiceItemLine does not exist yet.
                                                            //If the EMSMServiceItemLine does exist, the EMSMServiceInvoiceLine
                                                            //should be processed by processing the EMSMServiceItemLine first.
                ServiceHdr.RESET();
                ServiceHdr.SETRANGE("Document Type", EMSMServiceInvoiceLine."Document Type EXP");
                ServiceHdr.SETRANGE("No.", EMSMServiceInvoiceLine."Order No. EXP");
                if not ServiceHdr.FIND('-') then begin
                    //If a Service Header has been created earlier caused by a RecordAction = 'NEW"
                    //and the client send a modification to its Service Item Line before the line is
                    //extracted from the Back-end, the EMSM service Item line that caused the creation
                    //ealier must by found, as this line holds the No of the Service Header created
                    //in the field "Service Header Guid".
                    EarlierEMSMServiceItemLine.RESET();
                    EarlierEMSMServiceItemLine.SETFILTER("Order No. EXP", EMSMServiceInvoiceLine."Order No. EXP"); //Order No. created by the client
                    EarlierEMSMServiceItemLine.SETFILTER("Service Header Guid EXP", '<>%1', '');
                    if EarlierEMSMServiceItemLine.FIND('+') then begin
                        ServiceHdr.SETRANGE("No.", EarlierEMSMServiceItemLine."Service Header Guid EXP");
                        ServiceHdrIsFound := ServiceHdr.FIND('+');
                    end else
                        ServiceHdrIsFound := false;
                end else
                    ServiceHdrIsFound := true;
                // EMSM18.0.6.35 begin
                if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
                    //EMSM18.0.6.196 begin
                    transferToJobs := (ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Jobs") and (EMSMServiceInvoiceLine."Job No. EXP" <> '');
                    transferToService := ((not transferToJobs) and (ServiceHdrIsFound and (ServiceItemLine.GET(EMSMServiceInvoiceLine."Document Type EXP", ServiceHdr."No.", EMSMServiceInvoiceLine."Service Item Line No. EXP") or (EMSMServiceInvoiceLine."Service Item Line No. EXP" = 0))));
                    if (transferToService) then begin
                        DummyEMSMServiceItemLine."Service Header Guid EXP" := ServiceHdr."No.";
                        DummyEMSMServiceItemLine."Document Type EXP" := ServiceHdr."Document Type"; // EMSM3.0.5.15
                        ProcessEMSMServiceInvLine.SetEMSMServiceItemLine(DummyEMSMServiceItemLine);
                        if DoRunWithErrorMessage then begin
                            ProcessEMSMServiceInvLine.RUN(EMSMServiceInvoiceLine);
                            EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::Converted;
                            "Error Message" := '';
                        end else begin
                            if ProcessEMSMServiceInvLine.RUN(EMSMServiceInvoiceLine) then begin
                                EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::Converted;
                                "Error Message" := '';
                            end else begin
                                EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::Error;
                                "Error Message" := COPYSTR(GETLASTERRORTEXT, 1, MAXSTRLEN("Error Message"));
                            end;
                        end;
                    end;
                    if (transferToJobs) then begin
                        ProcessEMSMSServiceTimeLine.Run(EMSMServiceInvoiceLine);
                        EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::Converted;
                        "Error Message" := '';
                    end;
                    EMSMServiceInvoiceLine."Processed Date Time EXP" := CURRENTDATETIME;
                    EMSMServiceInvoiceLine."Processed By User ID EXP" := USERID;
                    EMSMServiceInvoiceLine."Proc With Delayed Item Li EXP" := true;
                    EMSMServiceInvoiceLine.MODIFY;
                    COMMIT;
                    //EMSM18.0.6.196 end
                end else
                    error(ExpandItSetupError); // EMSM18.0.6.193
            end;
        end;
    end;

    // EMSM16.0.6.209 begin 
    /// <summary>
    /// OnBeforeInsertServiceLine.
    /// </summary>
    /// <param name="VAR EMSMServiceInvLine">Record "EMSM Service Invoice Line EXP".</param>
    /// <param name="VAR ServiceLine">Record "Service Line".</param>
    [BusinessEvent(true)]
    procedure OnBeforeInsertServiceLine(VAR EMSMServiceInvLine: Record "EMSM Service Invoice Line EXP"; VAR ServiceLine: Record "Service Line")
    var
    begin
    end;
    // EMSM16.0.6.209 end
}

