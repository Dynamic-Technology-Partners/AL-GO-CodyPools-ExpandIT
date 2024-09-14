/// <summary>
/// Codeunit Proc. EMSM Serv Item Line EXP (ID 68741).
/// </summary>
codeunit 68741 "Proc. EMSM Serv Item Line EXP"
{
    // version EMSM18.0.6.210
    // 
    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    //                              * Handling of Service Order Type implemented.
    //                              * Validation of Repair Status Code moved in order to avoid a validation error.
    //                              * Better error message when the expandit setup is missing (used when a new customer is created)
    // EMSM3.02     2014-08-20  PB  * When a new order os created, the validate code is only run if the value is diffferent from the the va
    //                              * Added Salesperson Code.
    // EMSM3.02.01                  * Fixed error which was caused by the introduction of new serviceorder created from the planningboard
    //                                where strating date is empty.
    // EMSM3.03.01  2017-07-23  RSP * Only create/update Item Line if line number is <> 0
    //                                The "Multiple Service Items" feature of BAS will transmit multiple lines for the same
    //                                service order, and use Line Number=0 to indicate it is a header only.
    // EMSM3.04.01  2017-10-04  RSP * Only create new service header if an existing was not found.
    //                                Moved validation of repair status code to before start/finish time
    // EMSM3.04.02  2017-12-01  RSP * Only change serial no if the line is not related to a service item
    // EMSM3.04.03  2018-04-09  FAM * Adding "Your Reference", "Order By Contact Name", "JobDescription","Service Order Type"
    //                                "IsUrgent" and "ShipToDoCallBeforeVisit".
    // EMSM3.04.06  2018-05-09  FAM * Use Description instead of Jobdescription in ServiceHeader.
    // When IsUrgent is TRUE, Priority is set to HIGH.
    // EMSM3.04.08  2018-05-14  FAM * If ShipToDoCallBeforeVisit is TRUE, 'Notify Customer' will be set in Service Header.
    // EMSM3.04.09  2018-05-15  FAM * 'Order By contact Name' is added.
    // EMSM3.04.10  2018-06-15  FAM * Problem with empty line numbers fixed.
    // EMSM3.04.11  2018-06-19  FAM * Implementing the fix for header finishingdate that is before the serviceLines startdate.
    // EMSM3.04.12  2018-07-04  FAM * Implementing fix for create service header and service item line. And adding RecordAction DELETE.
    // EMSM3.04.13  2018-08-01  FAM * When we create the serviceorder in NAV and re-inject it from planningboard, the Service Order Guid will be empty
    //                                and instead it will be Ordre No. that is set. Therefore we check this field too.
    // EMSM3.04.14  2018-09-10  FAM * Errormessage(%1=BAS Guid and %2=EarlierEMSMServiceItemLine.BAS Guid).
    // EMSM3.04.15  2018-09-10  FAM * Override startingdate only if its not injected with date null.
    // EMSM3.04.16  2018-09-10  FAM * Override Serial No. only if it is not null.
    // EMSM3.04.17  2018-10-10  FAM * Prevent conversion if 'Link Service To Service Item' is set on Service Order.
    // EMSM3.05.01  2018-12-10  FAM * Check if ExpandIT Number series should be used instead of default number series. 
    // EMSM3.05.05  2019-05-06  FAM * Field "Converted To Service Order" is updated.
    // EMSM3.05.06  2019-05-27  FAM * Check if Service Item Line exists or not before insert.
    // EMSM3.05.07  2019-06-19  FAM * Choose between Jobs/Automatic in conversion rule.
    // EMSM3.05.09  2019-08-12  FAM * Convert the comments in correct order. 
    // EMSM3.05.09.01 2019-08-20 FAM * Check if Job Journal Tempaltes are selected.
    // EMSM3.05.09.02 2019-08-20 FAM * Run against Service Order or Jobs based conversion rule and if the Job No is set or not. 
    // EMSM3.05.09.03 2019-08-27 FAM * Run against Sales Order
    // EMSM3.06.02 2019-09-03 FAM * Set status for sales order
    // EMSM3.06.04 2019-09-09 FAM * Create comments for Jobs
    // EMSM3.06.10 2019-09-27 FAM * UpdateServiceHeader function
    // EMSM3.06.11 2019-10-03 FAM * Insert Quote if document type = quote
    // EMSM3.06.12 2019-10-07 FAM * Set starttingdate - New fix added
    // EMSM3.06.14 2019-11-22 FAM * Check for AddressType removed
    // EMSM3.06.16 2019-12-18 FAM * Handling attachments
    // EMSM18.0.6.19 2020-01-06 FAM * Events published and raised
    // EMSM18.0.6.20 2020-01-21 FAM * Insert Job Commentline code refactoring
    // EMSM18.0.6.22 2020-01-28 FAM * If Conversion Rule is set to "Prefer Salesorder" and Job No. is not empty, then we convert it to Service Order. 
    // EMSM18.0.6.25 2020-02-06 FAM * A workaround for an issue we have in BAS, where sometimes the Service Item No. in the EMSM Service Invoice Line is different than the one from EMSM Service Item Line.
    // EMSM18.0.6.26 2020-02-06 FAM * A workaround for an issue we have in BAS, where sometimes the JobPlanningGuid for EMSM Service Invoice Line is empty.
    // EMSM18.0.6.27 2020-02-20 FAM * Bug fixed for missing Service Header Guid
    // EMSM18.0.6.28 2020-02-21 FAM * Validate Posting No. Series and Service Invoice No. Series
    // EMSM18.0.6.44 2020-04-01 FAM * UpdateSalesLines is replaced by InsertSalesLines and check for Job No is added.
    // EMSM18.0.6.46 2020-04-02 FAM * Create new jobs when job No. is NEW
    // EMSM18.0.6.48 2020-04-07 FAM * New Job Nos. added.
    // EMSM18.0.6.49 2020-04-07 FAM * New Customer if Customer No. = NEW.
    // EMSM18.0.6.54 2020-04-22 FAM * Bugfix regarding processing job journal lines
    // EMSM18.0.6.64 2020-05-20 FAM * Change the order status from "Release To Ship" to "Open" and switch back to "Release To Ship" again when the conversion is done. 
    // EMSM18.0.6.135 2020-07-15 FAM * Added "Override Sales Order Status"     
    // EMSM18.0.6.139 2020-07-27 FAM * Create an Item Tracking Line if SerialNo and Item Tracking Code is set for an Item.
    // EMSM18.0.6.143 2020-08-14 FAM * Add ModifyHdrDatesIfInLinePeriod for Conversion Rule = Prefer Service Order (NEW) 
    // EMSM18.0.6.144 2020-08-20 FAM * Error fixed - Or instead of And must be used.
    // EMSM18.0.6.147 2020-09-02 FAM * EMSM Service Invoice Line added as parameter
    // EMSM18.0.6.148 2020-09-10 FAM * Add FindFirst check for ExpandIT Setup
    // EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record 
    // EMSM18.0.6.174 2020-10-26 FAM * New field (Location of Service Item) is added
    // EMSM18.0.6.183 2020-11-05 FAM * OnAfter and OnBefore events created and raised on service invoice line level
    // EMSM18.0.6.184 2020-11-17 FAM * Service Header Guid must be set before setting commentlines and service invoice lines.
    // EMSM18.0.6.187 2020-11-25 FAM * Add UpdateServiceHeader to MODIFY 
    // EMSM18.0.6.193 2020-12-07 FAM * ExpandIT Setup is empty
    // EMSM18.0.6.203 2021-02-19 FAM * (Sales Line) Set Location Code only for items with type = Inventory
    // EMSM18.0.6.204 2021-02-22 FAM * ServiceHdr parameter must be VAR
    // EMSM18.0.6.208 2021-03-16 FAM * Refactoring OnRun function
    // EMSM18.0.6.209 2021-03-23 FAM * Event added for Service Line
    // EMSM18.0.6.210 2021-03-31 FAM * Smart Item Claculation added for sales line
    TableNo = "EMSM Service Item Line EXP";

    trigger OnRun();
    var
        EarlierEMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        ServiceHdr: Record "Service Header";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ServiceItemLine: Record "Service Item Line";
        ServiceHeaderNo: Code[20];
        SalesHeaderNo: Code[20];
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        ExpandITSetup: Record "ExpandIT Setup EXP";
        EMSMServiceInvLine: Record "Service Invoice Line";
        EMSMServiceItemLineLocal: Record "EMSM Service Item Line EXP";
        EMSMServiceItemLinePage: Page "EMSM Service Item Worksht EXP";
        EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
        Job: Record "Job";
        JobTask: Record "Job Task";
        ProcEMSMsrvInvLine: Codeunit "Proc. EMSM Srv. Inv.(Time) EXP";
        ProcessEMSMServiceInvLine: Codeunit "Proc. EMSM Srv. Inv.(Srv.) EXP";
        JobJnlLine: Record "Job Journal Line";
        LastJobJnlLine: Record "Job Journal Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        OutStr: OutStream;
        Cust: Record "Customer";
        NoSeries: Record "No. Series";
        CreatedCustNo: Code[20];
        ReleaseServiceDoc: Codeunit "Release Service Document";
        ServiceHdrIsOpen: Boolean;
        ExpandITUtil: Codeunit "ExpandIT Util";
    begin
        //Processes one line and encapsulates possible errors from processing the
        //line and its related Invoice Lines and Comment Lines
        if not (Rec."Convert Status EXP" in [Rec."Convert Status EXP"::New, Rec."Convert Status EXP"::Error]) then
            exit;
        //EMSM18.0.6.19 begin
        Rec."Convert Status EXP" := Rec."Convert Status EXP"::New;
        OnProcessEMSMServiceItemLine(Rec);
        if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
            exit;
        //EMSM18.0.6.19 end
        //Raise error if there are unprocessed (New, Error) lines from earlier synkronizations
        EarlierEMSMServiceItemLine.RESET;
        EarlierEMSMServiceItemLine.SETRANGE("Document Type EXP", Rec."Document Type EXP");
        EarlierEMSMServiceItemLine.SETRANGE("Order No. EXP", Rec."Order No. EXP");
        EarlierEMSMServiceItemLine.SETRANGE("Line No. EXP", Rec."Line No. EXP");
        EarlierEMSMServiceItemLine.SETFILTER("Convert Status EXP", '%1|%2', Rec."Convert Status EXP"::New, Rec."Convert Status EXP"::Error);
        EarlierEMSMServiceItemLine := Rec;
        if EarlierEMSMServiceItemLine.FIND('<') then
            ERROR(TEXT0001,
              Rec.TABLECAPTION,
              //EMSM3.04.14 begin
              Rec."BAS Guid EXP",
              EarlierEMSMServiceItemLine."BAS Guid EXP");
        //EMSM3.04.14 end
        //Process the line
        d.OPEN(
          TEXT0002 +
          '  #####################################1#\' +
          '  #####################################2#\' +
          '  #####################################3#\' +
          '  #####################################4#\' +
          '  #####################################5#');

        d.UPDATE(1, Rec.TABLECAPTION);
        d.UPDATE(2, STRSUBSTNO('%1: %2', Rec.FIELDCAPTION("BAS Guid EXP"), Rec."BAS Guid EXP"));
        d.UPDATE(3, STRSUBSTNO('%1: %2', Rec.FIELDCAPTION("Order No. EXP"), Rec."Order No. EXP"));
        d.UPDATE(4, STRSUBSTNO('%1: %2', Rec.FIELDCAPTION("Line No. EXP"), Rec."Line No. EXP"));
        ServiceItemLine.RESET;
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
            case Rec."RecordAction EXP" of
                'NEW':
                    begin
                        //EMSM3.05.09.03 begin
                        //Case ExpandITSetup."Conversion Rule" of
                        if ((ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Sales Order") and (Rec."Job No. EXP" = '')) then begin // EMSM18.0.6.22
                            // EMSM18.0.6.208 begin 
                            // EMSM18.0.6.19 begin
                            OnBeforeProcessEMSMServiceItemLineToSalesOrder(Rec);
                            if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                exit;
                            // EMSM18.0.6.19 end
                            CreateSalesOrder(Rec, SalesHeader, ExpandITSetup, EMSMServiceInvoiceLine);
                            // EMSM18.0.6.19 begin
                            OnAfterProcessEMSMServiceItemLineToSalesOrder(Rec);
                            if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                exit;
                            // EMSM18.0.6.19 end
                            // EMSM18.0.6.208 end                                                                                                                                           // EMSM18.0.6.19 begin
                        end else begin
                            //EMSM3.05.07 begin                                        
                            if ((ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Jobs") Or (Rec."Order No. EXP" = '')) and (Rec."Job No. EXP" <> '') then begin // EMSM3.05.09.02                                                                                                                                                                           
                                                                                                                                                                                                   // EMSM18.0.6.208 begin
                                                                                                                                                                                                   // EMSM18.0.6.19 begin
                                OnBeforeProcessEMSMServiceItemLineToJobs(Rec);  // EMSM18.0.6.147
                                if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                    exit;
                                // EMSM18.0.6.19 end
                                CreateJobJnlLine(Rec, EMSMServiceInvoiceLine, ExpandITSetup);
                                // EMSM18.0.6.19 begin
                                OnAfterProcessEMSMServiceItemLineToJobs(Rec);  // EMSM18.0.6.147
                                if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                    exit;
                                // EMSM18.0.6.19 end
                                // EMSM18.0.6.208 end                               
                            end else begin
                                // EMSM18.0.6.208 begin
                                // EMSM3.05.07 end
                                // Create New Service Header Only if Service Header doesn't exist
                                // EMSM18.0.6.19 begin
                                OnBeforeProcessEMSMServiceItemLineToServiceOrder(Rec);
                                if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                    exit;
                                CreateServiceOrder(Rec, ServiceHdr, Job, ExpandITSetup);
                                // EMSM18.0.6.19 begin
                                OnAfterProcessEMSMServiceItemLineToServiceOrder(Rec); // EMSM18.0.6.19
                                if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                    exit;
                                // EMSM18.0.6.19 end
                                // EMSM18.0.6.208 end
                            end;
                        end; //EMSM3.03.01
                             //EMSM3.04.12 end                              
                    end;
                '':
                    begin
                        //This action is used by the Classic form based service solution.
                        if ServiceItemLine.GET(Rec."Document Type EXP", Rec."Order No. EXP", Rec."Line No. EXP") then begin
                            UpdateServiceItemLine(ServiceItemLine, Rec);
                            ServiceItemLine.MODIFY(true);
                        end else begin
                            //Create a service item line to an existing service order.
                            ServiceItemLine.INIT();
                            ServiceItemLine.VALIDATE("Document Type", Rec."Document Type EXP");
                            ServiceItemLine.VALIDATE("Document No.", Rec."Order No. EXP");
                            ServiceItemLine.VALIDATE("Line No.", Rec."Line No. EXP");
                            UpdateServiceItemLine(ServiceItemLine, Rec);
                            //EMSM3.05.06 begin
                            if not ServiceItemLine.GET(ServiceHdr."Document Type", ServiceHdr."No.", Rec."Line No. EXP") then begin
                                ServiceItemLine.INSERT(TRUE);
                            end;
                            // EMSM3.05.06 end
                        end;
                    end;
                'MODIFY':
                    begin
                        //EMSM3.05.09.03 begin
                        ExpandITSetup.FindFirst();
                        //Case ExpandITSetup."Conversion Rule" of
                        if ((ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Sales Order") and (Rec."Job No. EXP" = '')) then begin
                            // EMSM18.0.6.208 begin
                            // EMSM18.0.6.19 begin 
                            OnBeforeProcessEMSMServiceItemLineToSalesOrder(Rec);
                            if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                exit;
                            // EMSM18.0.6.19 end
                            UpdateSalesOrder(Rec, EMSMServiceInvoiceLine, ExpandITSetup, SalesHeader);
                            // EMSM18.0.6.19 begin 
                            OnAfterProcessEMSMServiceItemLineToSalesOrder(Rec);
                            if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                exit;
                            // EMSM18.0.6.19 end 
                            // EMSM18.0.6.208 end
                        end else begin
                            // //EMSM3.05.07 begin              
                            if ((ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Jobs") Or (Rec."Order No. EXP" = '')) and (Rec."Job No. EXP" <> '') then begin
                                // EMSM18.0.6.208 begin
                                // EMSM18.0.6.19 begin
                                OnBeforeProcessEMSMServiceItemLineToJobs(Rec);  // EMSM18.0.6.147
                                if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                    exit;
                                // EMSM18.0.6.19 end
                                UpdateJobJnlLine(Rec, EMSMServiceInvoiceLine, ExpandITSetup);
                                // EMSM18.0.6.19 begin
                                OnAfterProcessEMSMServiceItemLineToJobs(Rec);  // EMSM18.0.6.147
                                if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                    exit;
                                // EMSM18.0.6.19 end
                                // EMSM18.0.6.208 end
                            end else begin
                                // EMSM18.0.6.208 begin
                                // EMSM18.0.6.19 begin
                                OnBeforeProcessEMSMServiceItemLineToServiceOrder(Rec);
                                if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                    exit;
                                // EMSM18.0.6.19 end
                                UpdateServiceOrder(Rec, ServiceHdr, Job, ExpandITSetup);
                                // EMSM18.0.6.19 end
                                OnAfterProcessEMSMServiceItemLineToServiceOrder(Rec);
                                if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
                                    exit;
                                // EMSM18.0.6.19 end
                                // EMSM18.0.6.208 end
                            end;
                        end;
                        //end;
                    end;
                //EMSM3.04.12 end
                //EMSM3.04.12 begin
                'DELETE':
                    begin
                        //If we get a EMSMS service Item line with recordAction DELETE and line No. <>0.
                        //It means that its the service item line that must be deleted.
                        //Find the service header for the EMSM Service Item Line.
                        //The service header stores "Service Header Guid".
                        EMSMServiceItemLine.SETFILTER("Service Header Guid EXP", Rec."Service Header Guid EXP");
                        EMSMServiceItemLine.SETFILTER("Order No. EXP", Rec."Order No. EXP");
                        EMSMServiceItemLine.SETFILTER("JobPlanningGuid EXP", '=%1', '');
                        EMSMServiceItemLine.SETFILTER("Line No. EXP", '=%1', 0);
                        if (Rec."Line No. EXP" <> 0) then begin
                            //If we find a service header, then we must find the Service Item Line and delete it
                            if EMSMServiceItemLine.FIND('-') then begin
                                if ServiceItemLine.GET(Rec."Document Type EXP", EMSMServiceItemLine."Service Header Guid EXP", Rec."Line No. EXP") then begin
                                    ServiceItemLine.DELETE(true);
                                end;
                            end;
                        end else begin
                            //Else if EMSM Service Item Line "Line No." = 0, we have a service header.
                            //which means that the Service Header must be deleted.
                            if EMSMServiceItemLine.FIND('-') then begin
                                if ServiceHdr.GET(Rec."Document Type EXP", EMSMServiceItemLine."Service Header Guid EXP") then begin
                                    ServiceHdr.DELETE(true);
                                end;
                            end;
                        end;
                    end;
            //EMSM3.04.12 end
            end; //CASE       
            Rec.MODIFY;
            d.CLOSE;
        end else
            error(ExpandItSetupError); // EMSM18.0.6.193
    end;

    //Sales order - begin 
    /// <summary>
    /// CreateSalesOrder.
    /// </summary>
    /// <param name="VAR Rec">Record "EMSM Service Item Line EXP".</param>
    /// <param name="VAR SalesHeader">Record "Sales Header".</param>
    /// <param name="ExpandITSetup">Record "Sales and Receivables Setup".</param>
    /// <param name="EMSMServiceInvoiceLine">Record "EMSM Service Invoice Line EXP".</param>
    /// <returns>Return variable var SalesHeaderNo of type Code[20].</returns>
    procedure CreateSalesOrder(VAR Rec: Record "EMSM Service Item Line EXP"; VAR SalesHeader: Record "Sales Header"; ExpandITSetup: Record "ExpandIT Setup EXP"; EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP")
    var
        SalesHeaderNo: Code[20];
    begin
        // EMSM18.0.6.19 end
        if not FindSalesHeader(Rec, SalesHeader, SalesHeaderNo) then begin
            CreateSalesHeader(Rec, SalesHeader, ExpandITSetup);
        end;
        if (Rec."Line No. EXP" <> 0) then begin
            InsertSalesLines(Rec, EMSMServiceInvoiceLine, SalesHeader, ExpandITSetup);
            SetSalesOrderStatus(Rec, ExpandITSetup, SalesHeader);
            SalesHeader.MODIFY;
        end;
        Rec."Service Header Guid EXP" := SalesHeader."No.";
        Rec."Converted To Sales Order EXP" := SalesHeader."No.";
        InsertEMSMSalesCommentLines(Rec);
        ProcessEMSMServiceAttachments(Rec); // EMSM3.06.16
        //EMSM3.05.09.03 end   
        // EMSM18.0.6.19 begin
        OnAfterProcessEMSMServiceItemLineToSalesOrder(Rec);
        if not (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then
            exit;
        // EMSM18.0.6.19 end  
    end;

    /// <summary>
    /// CreateSalesHeader.
    /// </summary>
    /// <param name="VAR Rec">Record "EMSM Service Item Line EXP".</param>
    /// <param name="VAR SalesHeader">Record "Sales Header".</param>
    /// <param name="ExpandITSetup">Record "Sales and Receivables Setup".</param>
    /// <returns>Return variable var NoSeriesMgt of type Codeunit NoSeriesManagement.</returns>
    procedure CreateSalesHeader(VAR Rec: Record "EMSM Service Item Line EXP"; VAR SalesHeader: Record "Sales Header"; ExpandITSetup: Record "ExpandIT Setup EXP")
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        // EMSM18.0.6.19 end
        if (ExpandITSetup."Use ExpandIT Number Series EXP") then begin
            SalesHeader.INIT();
            // EMSM3.06.11 begin
            if (Rec."Document Type EXP" = Rec."Document Type EXP"::Quote) then
                SalesHeader.VALIDATE(SalesHeader."Document Type", SalesHeader."Document Type"::Quote)
            else
                SalesHeader.VALIDATE(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
            // EMSM3.06.11 end
            SalesHeader.VALIDATE(SalesHeader."No.", Rec."Order No. EXP");
            SalesHeader.INSERT(TRUE);
        end else begin
            // Create new number for Sales Order
            ExpandITSetup.TESTFIELD("New Sales Document Nos. EXP");
            CLEAR(NoSeriesMgt);
            // EMSM3.06.11 begin
            if (Rec."Document Type EXP" = Rec."Document Type EXP"::Quote) then
                SalesHeader.VALIDATE(SalesHeader."Document Type", SalesHeader."Document Type"::Quote)
            else
                SalesHeader.VALIDATE(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
            // EMSM3.06.11 end
            SalesHeader."No." := NoSeriesMgt.GetNextNo(ExpandITSetup."New Sales Document Nos. EXP", 0D, true);
            SalesHeader."No. Series" := ExpandITSetup."New Sales Document Nos. EXP";
            SalesHeader.INSERT(true);
        end;
        //Set Sales Order
        SalesHeader.VALIDATE("Sell-to Customer No.", Rec."Customer No. EXP");
        CopyExpOrderAddrToSalesHdr(Rec, SalesHeader);
        UpdateSalesHeader(Rec, SalesHeader);
        SalesHeader.MODIFY;
    end;

    /// <summary>
    /// UpdateSalesOrder.
    /// </summary>
    /// <param name="VAR Rec">Record "EMSM Service Item Line EXP".</param>
    /// <param name="EMSMServiceInvoiceLine">Record "EMSM Service Invoice Line EXP".</param>
    /// <param name="ExpandITSetup">Record "Sales and Receivables Setup".</param>
    /// <param name="VAR SalesHeader">Record "Sales Header".</param>
    /// <returns>Return variable var SalesHeaderNo of type Code[20].</returns>
    procedure UpdateSalesOrder(VAR Rec: Record "EMSM Service Item Line EXP"; EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP"; ExpandITSetup: Record "ExpandIT Setup EXP"; VAR SalesHeader: Record "Sales Header")
    var
        SalesHeaderNo: Code[20];
    begin
        if FindSalesHeader(Rec, SalesHeader, SalesHeaderNo) then begin
            //Update an existing Sales Header
            UpdateSalesHeader(Rec, SalesHeader);
            SalesHeader.Modify();
            //Insert Sales Lines                            
            InsertSalesLines(Rec, EMSMServiceInvoiceLine, SalesHeader, ExpandITSetup); //EMSM18.0.6.44
        end else begin
            ERROR(TEXT0006, Rec."Order No. EXP", SalesHeaderNo);
        end;
        Rec."Service Header Guid EXP" := SalesHeader."No.";
        Rec."Converted To Sales Order EXP" := Rec."Service Header Guid EXP";  //EMSM3.05.05 
        InsertEMSMSalesCommentLines(Rec);
        ProcessEMSMServiceAttachments(Rec); // EMSM3.06.16
                                            //EMSM3.05.09.03 end
    end;

    //Sales order - end
    //Service order - begin 
    /// <summary>
    /// CreateServiceOrder.
    /// </summary>
    /// <param name="VAR Rec">Record "EMSM Service Item Line EXP".</param>
    /// <param name="VAR ServiceHdr">Record "Service Header".</param>
    /// <param name="VAR Job">Record Job.</param>
    /// <param name="ExpandITSetup">Record "Sales and Receivables Setup".</param>
    procedure CreateServiceOrder(VAR Rec: Record "EMSM Service Item Line EXP"; VAR ServiceHdr: Record "Service Header"; VAR Job: Record Job; ExpandITSetup: Record "ExpandIT Setup EXP")
    var
        ReleaseServiceDoc: Codeunit "Release Service Document";
        ServiceHdrIsOpen: Boolean;
        ServiceItemLine: Record "Service Item Line";
        ServiceHeaderNo: Code[20];
    begin
        if not (FindServiceHeader(Rec, ServiceHdr, ServiceHeaderNo)) then begin
            // EMSM18.0.6.46 begin    
            if (not Job.Get(Rec."Job No. EXP")) and (Rec."Job No. EXP" = 'NEW') and (Rec."Line No. EXP" = 0) then begin
                CreateJob(Rec, Job, ExpandITSetup);
                Rec.Validate("Job No. EXP", Job."No.");
            end;
            CreateServiceHeader(Rec, ServiceHdr, ExpandITSetup);
            ModifyHdrDatesIfInLinePeriod(Rec, ServiceHdr);
        end;
        // Reopen Service Order to be able to work on it
        if (ServiceHdr."Release Status" = ServiceHdr."Release Status"::"Released to Ship") then begin
            ReleaseServiceDoc.Reopen(ServiceHdr);
            ServiceHdr.Modify();
            ServiceHdrIsOpen := true;
        end;
        // EMSM18.0.6.64 end
        //if NOT ServiceHdr."Link Service to Service Item" then begin
        ModifyHdrDatesIfInLinePeriod(Rec, ServiceHdr); // EMSM18.0.6.143
        if (Rec."Line No. EXP" <> 0) then begin //EMSM3.03.01
            ServiceItemLine.INIT();
            ServiceItemLine.VALIDATE("Document Type", Rec."Document Type EXP");
            ServiceItemLine.VALIDATE("Document No.", ServiceHdr."No.");
            ServiceItemLine.VALIDATE("Line No.", Rec."Line No. EXP");
            ModifyHdrDatesIfInLinePeriod(Rec, ServiceHdr); //EMSM3.06.12
            UpdateServiceItemLine(ServiceItemLine, Rec);
            //EMSM3.05.06 begin
            if not ServiceItemLine.GET(ServiceHdr."Document Type", ServiceHdr."No.", Rec."Line No. EXP") then begin
                ServiceItemLine.INSERT(TRUE);
            end;
            //EMSM3.05.06 end
        end;
        //end;
        Rec."Service Header Guid EXP" := ServiceHdr."No.";
        Rec."Converted To Service Order EXP" := Rec."Service Header Guid EXP";  //EMSM3.05.05
        ProcessEMSMServiceInvLines(Rec);
        ProcessEMSMServiceCommentLines(Rec);
        ProcessEMSMServiceAttachments(Rec); // EMSM3.06.16
        SetServiceItemLocation(Rec);  // EMSM18.0.6.174
        // EMSM18.0.6.64 begin                          
        if ServiceHdrIsOpen then begin
            ReleaseServiceDoc.PerformManualRelease(ServiceHdr);
            ServiceHdr.Modify();
        end;
        // EMSM18.0.6.64 end          
    end;

    /// <summary>
    /// UpdateServiceOrder.
    /// </summary>
    /// <param name="VAR Rec">Record "EMSM Service Item Line EXP".</param>
    /// <param name="VAR ServiceHdr">Record "Service Header".</param>
    /// <param name="VAR Job">Record Job.</param>
    /// <param name="ExpandITSetup">Record "Sales and Receivables Setup".</param>
    procedure UpdateServiceOrder(VAR Rec: Record "EMSM Service Item Line EXP"; VAR ServiceHdr: Record "Service Header"; VAR Job: Record Job; ExpandITSetup: Record "ExpandIT Setup EXP")
    var
        ReleaseServiceDoc: Codeunit "Release Service Document";
        ServiceHdrIsOpen: Boolean;
        ServiceItemLine: Record "Service Item Line";
        ServiceHeaderNo: Code[20];
    begin
        //EMSM3.04.12 begin
        if FindServiceHeader(Rec, ServiceHdr, ServiceHeaderNo) then begin
            // EMSM18.0.6.64 begin
            // Reopen Service Order to be able to work on it
            if (ServiceHdr."Release Status" = ServiceHdr."Release Status"::"Released to Ship") then begin
                ReleaseServiceDoc.Reopen(ServiceHdr);
                ServiceHdr.Modify();
                ServiceHdrIsOpen := true;
            end;
            // EMSM18.0.6.64 end
            ModifyHdrDatesIfInLinePeriod(Rec, ServiceHdr);
            if (Rec."Line No. EXP" <> 0) then begin
                ServiceItemLine.GET(ServiceHdr."Document Type", ServiceHdr."No.", Rec."Line No. EXP");
                UpdateServiceItemLine(ServiceItemLine, Rec);
                ServiceItemLine.MODIFY(true);
            end;
        end else begin
            ERROR(TEXT0003, Rec."Order No. EXP", ServiceHeaderNo);
        end;
        //EMSM18.0.6.184 begin
        Rec."Service Header Guid EXP" := ServiceHdr."No.";
        Rec."Converted To Service Order EXP" := Rec."Service Header Guid EXP";  //EMSM3.05.05 
        //EMSM18.0.6.184 end
        //EMSM18.0.6.20 begin
        ProcessEMSMServiceInvLines(Rec);
        ProcessEMSMServiceCommentLines(Rec);
        ProcessEMSMServiceAttachments(Rec); // EMSM3.06.16                                
        // EMSM18.0.6.20 end
        SetServiceItemLocation(Rec);  // EMSM18.0.6.174                       
        // EMSM18.0.6.64 begin                          
        if ServiceHdrIsOpen then begin
            UpdateServiceHeader(Rec, ServiceHdr);  //EMSM18.0.6.187
            ReleaseServiceDoc.PerformManualRelease(ServiceHdr);
            ServiceHdr.Modify();
        end;
        // EMSM18.0.6.64 end
    end;

    /// <summary>
    /// CreateServiceHeader.
    /// </summary>
    /// <param name="VAR Rec">Record "EMSM Service Item Line EXP".</param>
    /// <param name="VAR ServiceHdr">Record "Service Header".</param>
    /// <param name="ExpandITSetup">Record "Sales and Receivables Setup".</param>
    procedure CreateServiceHeader(VAR Rec: Record "EMSM Service Item Line EXP"; VAR ServiceHdr: Record "Service Header"; ExpandITSetup: Record "ExpandIT Setup EXP")
    var
    begin
        //EMSM3.05.01 - begin                        
        if (ExpandITSetup."Use ExpandIT Number Series EXP") then begin
            ServiceHdr.INIT();
            // EMSM3.06.11 begin
            if (Rec."Document Type EXP" = Rec."Document Type EXP"::Quote) then
                ServiceHdr.VALIDATE(ServiceHdr."Document Type", ServiceHdr."Document Type"::Quote)
            else
                ServiceHdr.VALIDATE(ServiceHdr."Document Type", ServiceHdr."Document Type"::Order);
            // EMSM3.06.11 end
            ServiceHdr.VALIDATE(ServiceHdr."No.", Rec."Order No. EXP");
            ServiceHdr.INSERT(TRUE);
        end else begin
            ServiceHdr.INIT();
            // EMSM3.06.11 begin
            if (Rec."Document Type EXP" = Rec."Document Type EXP"::Quote) then
                ServiceHdr.VALIDATE(ServiceHdr."Document Type", ServiceHdr."Document Type"::Quote)
            else
                ServiceHdr.VALIDATE(ServiceHdr."Document Type", ServiceHdr."Document Type"::Order);
            // EMSM3.06.11 end
            ServiceHdr.INSERT(TRUE);
        end;
        //EMSM3.05.01 - end                                
        // EMSM3.06.10 begin
        UpdateServiceHeader(Rec, ServiceHdr);
        // EMSM3.06.10 
        ServiceHdr.MODIFY(true);
    end;

    //Service order - end
    //Job - begin
    /// <summary>
    /// CreateJobJnlLine.
    /// </summary>
    /// <param name="VAR Rec">Record "EMSM Service Item Line EXP".</param>
    /// <param name="EMSMServiceInvoiceLine">Record "EMSM Service Invoice Line EXP".</param>
    /// <param name="ExpandITSetup">Record "Sales and Receivables Setup".</param>
    procedure CreateJobJnlLine(VAR Rec: Record "EMSM Service Item Line EXP"; EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP"; ExpandITSetup: Record "ExpandIT Setup EXP")
    var
        Job: Record "Job";
        ProcessEMSMServiceInvLine: Codeunit "Proc. EMSM Srv. Inv.(Srv.) EXP";
        ProcEMSMsrvInvLine: Codeunit "Proc. EMSM Srv. Inv.(Time) EXP";
        EMSMServiceItemLineLocal: Record "EMSM Service Item Line EXP";
    begin
        // EMSM18.0.6.46 begin    
        if (not Job.Get(Rec."Job No. EXP")) and (Rec."Job No. EXP" = 'NEW') and (Rec."Line No. EXP" = 0) then begin
            CreateJob(Rec, Job, ExpandITSetup);
        end;
        //Insert the newly created Job No. in EMSM Service Item line Rec. 
        //If empty, find the record where the job was created with Job No.= NEW, and get the newly created Job No. 
        if Job."No." <> '' then begin
            Rec.Validate("Job No. EXP", Job."No.");
        end else begin
            EMSMServiceItemLineLocal.SetRange("Order No. EXP", Rec."Order No. EXP");
            EMSMServiceItemLineLocal.SetFilter("Job No. EXP", '<>%1', '');
            EMSMServiceItemLineLocal.SetFilter("Job No. EXP", '<>%1', 'NEW');
            if EMSMServiceItemLineLocal.FindFirst() then begin
                Rec.Validate("Job No. EXP", EMSMServiceItemLineLocal."Job No. EXP");
            end;
        end;
        // EMSM18.0.6.46 end
        EMSMServiceInvoiceLine.RESET;
        EMSMServiceInvoiceLine.SETRANGE("Order No. EXP", Rec."Order No. EXP");
        EMSMServiceInvoiceLine.SETRANGE("Service Item Line No. EXP", Rec."Line No. EXP");
        EMSMServiceInvoiceLine.SETRANGE("JobPlanningGuid EXP", Rec."JobPlanningGuid EXP");
        ProcessEMSMServiceInvLine.SetEMSMServiceItemLine(Rec);
        if EMSMServiceInvoiceLine.Find('-') then begin // EMSM18.0.6.54
            repeat
                OnBeforeProcessEMSMServiceInvoiceLine(EMSMServiceInvoiceLine);  // EMSM18.0.6.183
                if (ExpandITSetup."Job Jnl. Batch Name EXP" = '') or (ExpandITSetup."Job Jnl. Template Name EXP" = '') then begin // EMSM3.05.09.01
                    Error(TXTExpandITTemplates);
                end else begin
                    if EMSMServiceInvoiceLine."Job No. EXP" = '' then begin
                        EMSMServiceInvoiceLine.Validate("Job No. EXP", Rec."Job No. EXP");
                    end;
                    //Create job journal lines 
                    ProcEMSMsrvInvLine.Run(EMSMServiceInvoiceLine);
                end;
                OnAfterProcessEMSMServiceInvoiceLine(EMSMServiceInvoiceLine);  // EMSM18.0.6.183
            until EMSMServiceInvoiceLine.Next = 0;
        end;
        InsertJobCommentLines(Rec);
        ProcessEMSMServiceAttachments(Rec); // EMSM3.06.16
        // // EMSM18.0.6.46 begin 
    end;

    /// <summary>
    /// UpdateJobJnlLine.  
    /// </summary>
    /// <param name="VAR Rec">Record "EMSM Service Item Line EXP".</param>
    /// <param name="EMSMServiceInvoiceLine">Record "EMSM Service Invoice Line EXP".</param>
    /// <param name="ExpandITSetup">Record "Sales and Receivables Setup".</param>
    procedure UpdateJobJnlLine(VAR Rec: Record "EMSM Service Item Line EXP"; EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP"; ExpandITSetup: Record "ExpandIT Setup EXP")
    var
        //Job: Record "Job";
        ProcessEMSMServiceInvLine: Codeunit "Proc. EMSM Srv. Inv.(Srv.) EXP";
        ProcEMSMsrvInvLine: Codeunit "Proc. EMSM Srv. Inv.(Time) EXP";
        EMSMServiceItemLineLocal: Record "EMSM Service Item Line EXP";
    begin
        //If empty or NEW, find the record where the job was created with Job No.= NEW, and get the newly created Job No. 
        if (Rec."Job No. EXP" = '') or (Rec."Job No. EXP" = 'NEW') then begin
            EMSMServiceItemLineLocal.SetRange("Order No. EXP", Rec."Order No. EXP");
            EMSMServiceItemLineLocal.SetFilter("Job No. EXP", '<>%1', '');
            EMSMServiceItemLineLocal.SetFilter("Job No. EXP", '<>%1', 'NEW');
            if EMSMServiceItemLineLocal.FindFirst() then begin
                Rec.Validate("Job No. EXP", EMSMServiceItemLineLocal."Job No. EXP");
            end;
        end;
        if (ExpandITSetup."Job Jnl. Batch Name EXP" = '') or (ExpandITSetup."Job Jnl. Template Name EXP" = '') then begin // EMSM3.05.09.0 1
            Error(TXTExpandITTemplates);
        end else begin
            EMSMServiceInvoiceLine.RESET;
            EMSMServiceInvoiceLine.SETRANGE("Order No. EXP", Rec."Order No. EXP");
            EMSMServiceInvoiceLine.SETRANGE("Service Item Line No. EXP", Rec."Line No. EXP");
            EMSMServiceInvoiceLine.SETRANGE("JobPlanningGuid EXP", Rec."JobPlanningGuid EXP");
            ProcessEMSMServiceInvLine.SetEMSMServiceItemLine(Rec);
            if EMSMServiceInvoiceLine.Find('-') then begin // EMSM14.0.6.54
                repeat
                    if (ExpandITSetup."Job Jnl. Batch Name EXP" = '') or (ExpandITSetup."Job Jnl. Template Name EXP" = '') then begin // EMSM3.05.09.01
                        Error(TXTExpandITTemplates);
                    end else begin
                        // When Job No. = NEW for EMSM Service Item Line record, the job No. for EMSM service invoice line record will be empty. 
                        // Therefore the Job No. must be set from the newly created Job. 
                        if EMSMServiceInvoiceLine."Job No. EXP" = '' then begin
                            EMSMServiceInvoiceLine.Validate("Job No. EXP", Rec."Job No. EXP");
                        end;
                        //Update Job Journal Line record
                        ProcEMSMsrvInvLine.Run(EMSMServiceInvoiceLine);
                    end;
                until EMSMServiceInvoiceLine.Next = 0;
            end;
        end;
        //EMSM14.0.6.27 begin
        // Rec."Service Header Guid EXP" := ServiceHdr."No.";
        // Rec."Converted To Service Order EXP" := Rec."Service Header Guid EXP";//EMSM3.05.05 
        //EMSM14.0.6.27 end
        InsertJobCommentLines(Rec);
        ProcessEMSMServiceAttachments(Rec); // EMSM3.06.16
    end;

    /// <summary>
    /// CreateJob.
    /// </summary>
    /// <param name="VAR Rec">Record "EMSM Service Item Line EXP".</param>
    /// <param name="VAR Job">Record Job.</param>
    /// <param name="ExpandITSetup">Record "Sales and Receivables Setup".</param>
    procedure CreateJob(VAR Rec: Record "EMSM Service Item Line EXP"; VAR Job: Record Job; ExpandITSetup: Record "ExpandIT Setup EXP")
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Record "No. Series";
        CreatedCustNo: Code[20];
        EMSMServiceItemLineLocal: Record "EMSM Service Item Line EXP";
    begin
        NoSeries.get(ExpandITSetup."New Job Document Nos. EXP");  // EMSM18.0.6.48
        Job.Reset();
        Job.Validate("No.", NoSeriesMgt.DoGetNextNo(NoSeries.Code, today(), true, true));
        //EMSM18.0.6.49 begin
        if Rec."Customer No. EXP" = 'NEW' then begin
            CreateNewCust(Rec, CreatedCustNo);
            Job.Validate("Bill-to Customer No.", CreatedCustNo);
        end else
            Job.Validate("Bill-to Customer No.", Rec."Customer No. EXP");
        //EMSM18.0.6.49 end
        if not Job.get(Job."No.") then
            Job.Insert();
    end;
    //Job - end

    var
        d: Dialog;
        TXTJobNo: Label 'Job No. must be selected for Line No. (%1) when conversion rule is set to "Prefer Jobs"', Comment = 'DAN="Sagsnr. skal være valgt for linjenr. (%1) når konverteringsregel er sat til ''Foretrækker Sager'',DEU="Projektnr. muss für Zeilen Nr. (%1) ausgewählt werden wenn die Konvertierungsregel "Projekte Bevorzugen" gewählt wurde",ESP="",FRA="N° de tâche doit être sélectionné pour la ligne n° (% 1) lorsque la règle de conversion est fixée sur "jobs préférés"",SVE=""';
        TXTExpandITTemplates: Label 'Job Journal Batch Name and Job Journal Template Name must be selected. ', Comment = 'DAN="",DEU="",ESP="",FRA="Le nom du lot et le nom du modèle de journal de bord doivent être sélectionnés.",SVE=""';
        TEXT0001: Label '%1 (%2) cannot be processed before %1 (%3)', Comment = 'DAN="%1 (%2) kan ikke behandles før %1 (%3)"';
        TEXT0002: Label 'Processing:\', Comment = 'DAN="Behandler:\", FRA="Traitement :\", DEU="", SVE="", ESP=""';
        TEXT0003: Label 'Unable to determine service header, for service order %1, Header %2', Comment = 'DAN="Servicehoved til serviceordre %1 kunne ikke findes. Servicehoved %2. "';
        TEXT0004: Label 'Unable to determine service header, for service order %1', Comment = 'DAN="Servicehoved til serviceordre %1 kunne ikke findes."';
        TEXT0005: Label 'Link Service To Service Item setting is checked on Service Order %1. Uncheck the setting to be able to convert the lines and finish the service order after the conversion is completed. ', Comment = 'DAN=""';
        ExpandItSetupError: Label 'EMSM Setup is empty', comment = 'ESP="", DAN="ExpandIT Opsætning er tom", DEU="", FRA="", SVE=""';
        TEXT0006: Label 'Unable to determine sales header, for sales order %1, Header %2', Comment = 'DAN="Salgsordrehovedet til salgsordre %1 kunne ikke findes. Salgsordrehoved %2. "';

    local procedure ModifyHdrDatesIfInLinePeriod(EMSMServItemLine: Record "EMSM Service Item Line EXP"; VAR ServHdr: Record "Service Header");  //EMSM18.0.6.204
    var
        ServHdrOld: Record "Service Header";
        HdrWasModified: Boolean;
    begin
        HdrWasModified := false;
        ServHdrOld := ServHdr;
        HdrWasModified :=
          HdrWasModified or
          MoveHdrDateBeforeLineDate(
            ServHdr."Order Date", ServHdr."Order Time",
            EMSMServItemLine."Response Date EXP", EMSMServItemLine."Response Time EXP");
        HdrWasModified :=
          HdrWasModified or
          MoveHdrDateBeforeLineDate(
            ServHdr."Order Date", ServHdr."Order Time",
            EMSMServItemLine."Starting Date EXP", EMSMServItemLine."Starting Time EXP");
        HdrWasModified :=
          HdrWasModified or
          MoveHdrDateBeforeLineDate(
            ServHdr."Starting Date", ServHdr."Starting Time",
            EMSMServItemLine."Starting Date EXP", EMSMServItemLine."Starting Time EXP");
        HdrWasModified :=
          HdrWasModified or
          MoveHdrDateAfterLineDate(
            ServHdr."Finishing Date", ServHdr."Finishing Time",
            EMSMServItemLine."Finishing Date EXP", EMSMServItemLine."Finishing Time EXP");
        if HdrWasModified then
            ServHdr.MODIFY;
    end;

    local procedure MoveHdrDateBeforeLineDate(var HdrDate: Date; var HdrTime: Time; LineDate: Date; LineTime: Time) WasModified: Boolean;
    begin
        if (LineDate <> 0D) and
           ((HdrDate > LineDate) or
            ((HdrDate = LineDate) and (HdrTime > LineTime) and (LineTime <> 000000T)))
        then begin
            HdrDate := LineDate;
            HdrTime := LineTime;
            WasModified := true;
        end;
    end;

    local procedure MoveHdrDateAfterLineDate(var HdrDate: Date; var HdrTime: Time; LineDate: Date; LineTime: Time) WasModified: Boolean;
    begin
        if (HdrDate < LineDate) or ((HdrDate = LineDate) and (HdrTime < LineTime)) then begin
            HdrDate := LineDate;
            HdrTime := LineTime;
            WasModified := true;
        end;
    end;

    local procedure CreateNewCust(EMSMServiceItemLine: Record "EMSM Service Item Line EXP"; var CreatedCustNo: Code[20]);
    var
        Cust: Record Customer;
        ExpandITSetup: Record "ExpandIT Setup EXP";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ExpandITUtil: Codeunit "ExpandIT Util";
    begin
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
            ExpandITSetup.TESTFIELD("Internet Customer Template EXP");
            Cust.GET(ExpandITSetup."Internet Customer Template EXP");
            ExpandITSetup.TESTFIELD("New Customer Nos. EXP");
            CLEAR(NoSeriesMgt);
            Cust."No." := NoSeriesMgt.GetNextNo(ExpandITSetup."New Customer Nos. EXP", 0D, true);
            Cust."No. Series" := ExpandITSetup."New Customer Nos. EXP";
            Cust.VALIDATE(Name, EMSMServiceItemLine."Ship-to Name EXP");
            Cust.VALIDATE(Address, EMSMServiceItemLine."Ship-to Address EXP");
            Cust.VALIDATE("Address 2", EMSMServiceItemLine."Ship-to Address 2");
            Cust.VALIDATE(City, EMSMServiceItemLine."Ship-to City EXP");
            Cust.VALIDATE("Post Code", EMSMServiceItemLine."Ship-to Post Code EXP");
            Cust.VALIDATE(County, EMSMServiceItemLine."Ship-to County EXP");
            Cust.VALIDATE("Country/Region Code", EMSMServiceItemLine."Ship-to Country/RegCode EXP");
            Cust.INSERT;
            CreatedCustNo := Cust."No.";
        end else
            Error(ExpandItSetupError);
    end;

    local procedure CreateNewShipToAddress(EMSMServiceItemLine: Record "EMSM Service Item Line EXP"; CustNo: Code[20]; var NewShipToAddrCode: Code[10]);
    var
        ShipToAddress: Record "Ship-to Address";
        TryNo: Integer;
        ShipToAddressCode: Code[10];
        ShipToAddressHasBeenInserted: Boolean;
    begin
        ShipToAddress."Customer No." := CustNo;
        if EMSMServiceItemLine."Ship-to City EXP" <> '' then
            ShipToAddressCode := FORMAT(EMSMServiceItemLine."Ship-to City EXP", -MAXSTRLEN(ShipToAddress.Code))
        else
            if EMSMServiceItemLine."Ship-to Post Code EXP" <> '' then
                ShipToAddressCode := FORMAT(EMSMServiceItemLine."Ship-to Post Code EXP", -MAXSTRLEN(ShipToAddress.Code))
            else
                if EMSMServiceItemLine."Ship-to Address EXP" <> '' then
                    ShipToAddressCode := FORMAT(EMSMServiceItemLine."Ship-to Address EXP", -MAXSTRLEN(ShipToAddress.Code))
                else
                    ShipToAddressCode := '000';
        ShipToAddress.Code := ShipToAddressCode;
        ShipToAddressHasBeenInserted := ShipToAddress.INSERT;
        if not ShipToAddressHasBeenInserted then begin
            TryNo := 0;
            ShipToAddressHasBeenInserted := false;
            while not ShipToAddressHasBeenInserted and (TryNo < 9) do begin
                TryNo += 1;
                ShipToAddress.Code := FORMAT(ShipToAddressCode, -(MAXSTRLEN(ShipToAddress.Code) - 1));
                ShipToAddress.Code := STRSUBSTNO('%1%2', ShipToAddress.Code, TryNo);
                ShipToAddressHasBeenInserted := ShipToAddress.INSERT;
            end;
        end;
        if not ShipToAddressHasBeenInserted then
            ShipToAddress.INSERT; //Error message
        ShipToAddress.VALIDATE(Name, EMSMServiceItemLine."Ship-to Name EXP");
        ShipToAddress.VALIDATE(Address, EMSMServiceItemLine."Ship-to Address EXP");
        ShipToAddress.VALIDATE("Address 2", EMSMServiceItemLine."Ship-to Address 2");
        ShipToAddress.VALIDATE(City, EMSMServiceItemLine."Ship-to City EXP");
        ShipToAddress.VALIDATE("Post Code", EMSMServiceItemLine."Ship-to Post Code EXP");
        ShipToAddress.VALIDATE(County, EMSMServiceItemLine."Ship-to County EXP");
        ShipToAddress.VALIDATE("Country/Region Code", EMSMServiceItemLine."Ship-to Country/RegCode EXP");
        ShipToAddress.MODIFY;
        NewShipToAddrCode := ShipToAddress.Code;
    end;

    local procedure UpdateServiceItemLine(var ServiceItemLine: Record "Service Item Line"; EMSMServiceItemLine: Record "EMSM Service Item Line EXP");
    begin
        //with EMSMServiceItemLine do begin
        if (EMSMServiceItemLine."Response Date EXP" <> 0D) and (ServiceItemLine."Response Date" <> EMSMServiceItemLine."Response Date EXP") then
            ServiceItemLine.VALIDATE("Response Date", EMSMServiceItemLine."Response Date EXP");
        if (EMSMServiceItemLine."Response Time EXP" <> 000000T) and (ServiceItemLine."Response Time" <> EMSMServiceItemLine."Response Time EXP") and
           (EMSMServiceItemLine."Response Date EXP" <> 0D)
        then
            ServiceItemLine.VALIDATE("Response Time", EMSMServiceItemLine."Response Time EXP");
        if (ServiceItemLine."Response Time (Hours)" <> EMSMServiceItemLine."Response Time (Hours) EXP") then
            ServiceItemLine.VALIDATE("Response Time (Hours)", EMSMServiceItemLine."Response Time (Hours) EXP");
        if (ServiceItemLine."Repair Status Code" <> EMSMServiceItemLine."Repair Status Code EXP") then //EMSM3.06.12
            ServiceItemLine.VALIDATE("Repair Status Code", EMSMServiceItemLine."Repair Status Code EXP");
        if (EMSMServiceItemLine."Starting Date EXP" <> 0D) and (ServiceItemLine."Starting Date" <> EMSMServiceItemLine."Starting Date EXP") then begin
            ServiceItemLine.VALIDATE("Finishing Date", 0D);
            ServiceItemLine.VALIDATE("Starting Date", EMSMServiceItemLine."Starting Date EXP");
        end;
        if (EMSMServiceItemLine."Starting Time EXP" <> 000000T) and
           (ServiceItemLine."Starting Time" <> EMSMServiceItemLine."Starting Time EXP") and
           (EMSMServiceItemLine."Starting Date EXP" <> 0D)
        then begin
            ServiceItemLine.VALIDATE("Finishing Date", 0D);
            ServiceItemLine.VALIDATE("Starting Time", EMSMServiceItemLine."Starting Time EXP");
        end;

        if (EMSMServiceItemLine."Finishing Date EXP" <> 0D) and (ServiceItemLine."Finishing Date" <> EMSMServiceItemLine."Finishing Date EXP") then
            ServiceItemLine.VALIDATE("Finishing Date", EMSMServiceItemLine."Finishing Date EXP");
        if (EMSMServiceItemLine."Finishing Time EXP" <> 000000T) and
           (ServiceItemLine."Finishing Time" <> EMSMServiceItemLine."Finishing Time EXP") and
           (EMSMServiceItemLine."Finishing Date EXP" <> 0D)
        then
            ServiceItemLine.VALIDATE("Finishing Time", EMSMServiceItemLine."Finishing Time EXP");
        if (ServiceItemLine."Service Item No." <> EMSMServiceItemLine."Service Item No. EXP") and (EMSMServiceItemLine."Service Item No. EXP" <> '') then
            ServiceItemLine.VALIDATE("Service Item No.", EMSMServiceItemLine."Service Item No. EXP");
        if (ServiceItemLine."Item No." <> EMSMServiceItemLine."Item No. EXP") and (EMSMServiceItemLine."Item No. EXP" <> '') then
            ServiceItemLine.VALIDATE("Item No.", EMSMServiceItemLine."Item No. EXP");
        if (ServiceItemLine.Description <> EMSMServiceItemLine."Description EXP") then
            ServiceItemLine.Description := EMSMServiceItemLine."Description EXP";
        //EMSM3.04.16 begin
        if (ServiceItemLine."Serial No." <> EMSMServiceItemLine."Serial No. EXP") AND (EMSMServiceItemLine."Serial No. EXP" <> '') then
            ServiceItemLine.VALIDATE("Serial No.", EMSMServiceItemLine."Serial No. EXP");
        //EMSM3.04.16 end
        if (ServiceItemLine.Priority <> EMSMServiceItemLine."Priority EXP") then
            ServiceItemLine.VALIDATE(Priority, EMSMServiceItemLine."Priority EXP");
        if (ServiceItemLine."Fault Reason Code" <> EMSMServiceItemLine."Fault Reason Code EXP") then
            ServiceItemLine.VALIDATE("Fault Reason Code", EMSMServiceItemLine."Fault Reason Code EXP");
        if (ServiceItemLine."Fault Area Code" <> EMSMServiceItemLine."Fault Area Code EXP") then
            ServiceItemLine.VALIDATE("Fault Area Code", EMSMServiceItemLine."Fault Area Code EXP");
        if (ServiceItemLine."Symptom Code" <> EMSMServiceItemLine."Symptom Code EXP") then
            ServiceItemLine.VALIDATE("Symptom Code", EMSMServiceItemLine."Symptom Code EXP");
        if (ServiceItemLine."Fault Code" <> EMSMServiceItemLine."Fault Code EXP") then
            ServiceItemLine.VALIDATE("Fault Code", EMSMServiceItemLine."Fault Code EXP");
        if (ServiceItemLine."Resolution Code" <> EMSMServiceItemLine."Resolution Code EXP") then
            ServiceItemLine.VALIDATE("Resolution Code", EMSMServiceItemLine."Resolution Code EXP");
        //end;
    end;

    local procedure ProcessEMSMServiceAttachments(EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
        EMSMServiceAttchments: Record "EMSM Service Attachments EXP";
        ProcessEMSMServiceAttchments: Codeunit "Proc. EMSM Serv Attachment EXP";
    begin
        //Loop through Invoice Lines and process them
        //with EMSMServiceItemLine do begin
        d.UPDATE(1, EMSMServiceAttchments.TABLECAPTION);
        EMSMServiceAttchments.RESET;
        EMSMServiceAttchments.SETRANGE("Order No. EXP", EMSMServiceItemLine."Order No. EXP");
        //EMSMServiceAttchments.SETRANGE("Service Header Guid", "Service Header Guid");                        
        if EMSMServiceAttchments.FIND('-') then
            repeat
                d.UPDATE(2, STRSUBSTNO('%1: %2', EMSMServiceAttchments.FIELDCAPTION("BAS Guid EXP"), EMSMServiceAttchments."BAS Guid EXP"));
                d.UPDATE(3, STRSUBSTNO('%1: %2', EMSMServiceAttchments.FIELDCAPTION("Order No. EXP"), EMSMServiceAttchments."Order No. EXP"));
                d.UPDATE(4, STRSUBSTNO('%1: %2', EMSMServiceAttchments.FIELDCAPTION("Service Item Line No. EXP"), EMSMServiceAttchments."Service Item Line No. EXP"));
                d.UPDATE(5, STRSUBSTNO('%1: %2', EMSMServiceAttchments.FIELDCAPTION("Line No. EXP"), EMSMServiceAttchments."Line No. EXP"));
                if EMSMServiceAttchments."Convert Status EXP" in [EMSMServiceAttchments."Convert Status EXP"::New, EMSMServiceAttchments."Convert Status EXP"::Error] then begin
                    ProcessEMSMServiceAttchments.processAttachments(EMSMServiceItemLine, EMSMServiceAttchments);
                    EMSMServiceAttchments."Processed Date Time EXP" := CURRENTDATETIME;
                    EMSMServiceAttchments."Processed By User ID EXP" := USERID;
                    EMSMServiceAttchments."Convert Status EXP" := EMSMServiceAttchments."Convert Status EXP"::Converted;
                    EMSMServiceAttchments.MODIFY;
                end;
            until EMSMServiceAttchments.NEXT = 0;
        //end;
    end;

    local procedure ProcessEMSMServiceInvLines(EMSMServiceItemLine: Record "EMSM Service Item Line EXP");
    var
        EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
        ProcessEMSMServiceInvLine: Codeunit "Proc. EMSM Srv. Inv.(Srv.) EXP";
    begin
        //Loop through Invoice Lines and process them
        //with EMSMServiceItemLine do begin
        d.UPDATE(1, EMSMServiceInvoiceLine.TABLECAPTION);
        EMSMServiceInvoiceLine.RESET;
        EMSMServiceInvoiceLine.SETRANGE("Order No. EXP", EMSMServiceItemLine."Order No. EXP");
        EMSMServiceInvoiceLine.SETRANGE("Service Item Line No. EXP", EMSMServiceItemLine."Line No. EXP");
        EMSMServiceInvoiceLine.SetFilter("JobPlanningGuid EXP", '%1|%2', EMSMServiceItemLine."JobPlanningGuid EXP", ''); // EMSM18.0.6.26
        ProcessEMSMServiceInvLine.SetEMSMServiceItemLine(EMSMServiceItemLine);
        if EMSMServiceInvoiceLine.FIND('-') then begin
            repeat
                OnBeforeProcessEMSMServiceInvoiceLine(EMSMServiceInvoiceLine);  // EMSM18.0.6.183
                d.UPDATE(2, STRSUBSTNO('%1: %2', EMSMServiceInvoiceLine.FIELDCAPTION("BAS Guid EXP"), EMSMServiceInvoiceLine."BAS Guid EXP"));
                d.UPDATE(3, STRSUBSTNO('%1: %2', EMSMServiceInvoiceLine.FIELDCAPTION("Order No. EXP"), EMSMServiceInvoiceLine."Order No. EXP"));
                d.UPDATE(4, STRSUBSTNO('%1: %2', EMSMServiceInvoiceLine.FIELDCAPTION("Service Item Line No. EXP"), EMSMServiceInvoiceLine."Service Item Line No. EXP"));
                d.UPDATE(5, STRSUBSTNO('%1: %2', EMSMServiceInvoiceLine.FIELDCAPTION("Line No. EXP"), EMSMServiceInvoiceLine."Line No. EXP"));
                if EMSMServiceInvoiceLine."Convert Status EXP" in [EMSMServiceInvoiceLine."Convert Status EXP"::New, EMSMServiceInvoiceLine."Convert Status EXP"::Error] then begin
                    CopyServiceItemNOFromEMSMServiceItemLine(EMSMServiceItemLine, EMSMServiceInvoiceLine); // EMSM18.0.6.25                     
                    ProcessEMSMServiceInvLine.RUN(EMSMServiceInvoiceLine);
                    EMSMServiceInvoiceLine."Processed Date Time EXP" := CURRENTDATETIME;
                    EMSMServiceInvoiceLine."Processed By User ID EXP" := USERID;
                    EMSMServiceInvoiceLine.MODIFY;
                end;
                OnAfterProcessEMSMServiceInvoiceLine(EMSMServiceInvoiceLine);  // EMSM18.0.6.183
            until EMSMServiceInvoiceLine.NEXT = 0;
        end;
        //end;
    end;

    local procedure ProcessEMSMServiceCommentLines(EMSMServiceItemLine: Record "EMSM Service Item Line EXP");
    var
        EMSMServiceCommentLine: Record "EMSM Service Comment Line EXP";
        ProcessEMSMServiceCommentLine: Codeunit "Proc. EMSM Serv Com Line EXP";
    begin
        //Loop through Comment Lines and process them
        //with EMSMServiceItemLine do begin
        EMSMServiceCommentLine.SETCURRENTKEY(EMSMServiceCommentLine."No. EXP", EMSMServiceCommentLine."Table Line No. EXP", EMSMServiceCommentLine."JobPlanningGuid EXP", EMSMServiceCommentLine."Type EXP", EMSMServiceCommentLine."Line No. EXP");  //EMSM3.05.09
        d.UPDATE(1, EMSMServiceCommentLine.TABLECAPTION);
        EMSMServiceCommentLine.RESET;
        EMSMServiceCommentLine.SETRANGE("No. EXP", EMSMServiceItemLine."Order No. EXP");
        EMSMServiceCommentLine.SETRANGE("Table Line No. EXP", EMSMServiceItemLine."Line No. EXP");
        EMSMServiceCommentLine.SETRANGE("JobPlanningGuid EXP", EMSMServiceItemLine."JobPlanningGuid EXP");
        ProcessEMSMServiceCommentLine.SetEMSMServiceItemLine(EMSMServiceItemLine);
        if EMSMServiceCommentLine.FIND('-') then
            repeat
                d.UPDATE(2, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("BAS Guid EXP"), EMSMServiceCommentLine."BAS Guid EXP"));
                d.UPDATE(3, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("No. EXP"), EMSMServiceCommentLine."No. EXP"));
                d.UPDATE(4, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("Table Line No. EXP"), EMSMServiceCommentLine."Table Line No. EXP"));
                d.UPDATE(5, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("Line No. EXP"), EMSMServiceCommentLine."Line No. EXP"));
                if EMSMServiceCommentLine."Convert Status EXP" in [EMSMServiceCommentLine."Convert Status EXP"::New, EMSMServiceCommentLine."Convert Status EXP"::Error] then begin
                    ProcessEMSMServiceCommentLine.RUN(EMSMServiceCommentLine);
                    EMSMServiceCommentLine."Processed Date Time EXP" := CURRENTDATETIME;
                    EMSMServiceCommentLine."Processed By User ID EXP" := USERID;
                    EMSMServiceCommentLine.MODIFY;
                end;
            until EMSMServiceCommentLine.NEXT = 0;
        //end;
    end;

    /// <summary>
    /// FindServiceHeader.
    /// </summary>
    /// <param name="EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    /// <param name="ServiceHdr">VAR Record "Service Header".</param>
    /// <param name="ServiceHeaderNo">VAR Code[20].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure FindServiceHeader(EMSMServiceItemLine: Record "EMSM Service Item Line EXP"; var ServiceHdr: Record "Service Header"; var ServiceHeaderNo: Code[20]): Boolean;
    var
        EMSMServiceItemLineLocal: Record "EMSM Service Item Line EXP";
        ServiceInvHdr: Record "Service Invoice Header";
        TextServiceHeaderError: Label 'Service Order: %1  has already been converted. ', Comment = 'DAN="Service Ordre. %1 er allerede blevet overført. "';
        TextEMSMServiceItemLineError: Label 'Service Order: %1 doen', Comment = 'DAN="Service Ordre: %1 findes ikke i tabellen Service Order, men er allerede blevet overført i tabellen EMSM Service Item Line"';
        TextServiceHeaderInvoicedError: Label 'Service Order: %1, is already posted.', Comment = 'DAN="Service Ordre: %1, er allerede blevet bogført. "';
    begin
        //EMSM3.04.12 - begin
        ServiceHeaderNo := EMSMServiceItemLine."Service Header Guid EXP";
        //Exit if service header already exists.
        if ServiceHdr.GET(EMSMServiceItemLine."Document Type EXP", ServiceHeaderNo) then begin
            exit(true);
        end;
        //EMSM3.04.13 - begin
        //If service header is created in NAV and re-injected from Planningboard
        if ServiceHdr.GET(EMSMServiceItemLine."Document Type EXP", EMSMServiceItemLine."Order No. EXP") then begin
            exit(true);
        end;
        //EMSM3.04.13 - begin
        //IF service header doesn't exists in Service Header table, we check if it has been converted in EMSM Service Item Line
        EMSMServiceItemLineLocal.SETFILTER("Service Header Guid EXP", '<>%1', '');
        EMSMServiceItemLineLocal.SETFILTER("Order No. EXP", EMSMServiceItemLine."Order No. EXP");
        if EMSMServiceItemLineLocal.FIND('+') then begin
            //ServiceHeaderNo := EMSMServiceItemLineLocal."Order No.";
            ServiceHeaderNo := EMSMServiceItemLineLocal."Service Header Guid EXP";
            if (ServiceHdr.GET(EMSMServiceItemLineLocal."Document Type EXP", ServiceHeaderNo)) then
                exit(true);
        end;
        //Error if the service order already has been posted and exists in Service Invoice Header table
        if ServiceInvHdr.GET(ServiceHeaderNo) then begin
            ERROR(TextServiceHeaderInvoicedError, ServiceHeaderNo);
        end;
        //EMSM3.04.12 end
        exit(false);
    end;

    /// <summary>
    /// CopyExpOrderAddrToSalesHdr.
    /// </summary>
    /// <param name="EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    /// <param name="ToSalesHeader">VAR Record "Sales Header".</param>
    procedure CopyExpOrderAddrToSalesHdr(EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
       var ToSalesHeader: Record "Sales Header");
    begin
        //with ToSalesHeader do begin
        ToSalesHeader."Ship-to Name" := COPYSTR(EMSMServiceItemLine."Ship-to Name EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to Name"));
        ToSalesHeader."Ship-to Address" := COPYSTR(EMSMServiceItemLine."Ship-to Address EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to Address"));
        ToSalesHeader."Ship-to Address 2" := COPYSTR(EMSMServiceItemLine."Ship-to Address 2", 1, MAXSTRLEN(ToSalesHeader."Ship-to Address 2"));
        ToSalesHeader."Ship-to Post Code" := COPYSTR(EMSMServiceItemLine."Ship-to Post Code EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to Post Code"));
        ToSalesHeader."Ship-to City" := COPYSTR(EMSMServiceItemLine."Ship-to City EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to City"));
        ToSalesHeader."Ship-to County" := COPYSTR(EMSMServiceItemLine."Ship-to County EXP", 1, MAXSTRLEN(ToSalesHeader."Ship-to County"));
        //end;
    end;

    /// <summary>
    /// FindSalesHeader.
    /// </summary>
    /// <param name="EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    /// <param name="SalesHdr">VAR Record "Sales Header".</param>
    /// <param name="SalesHeaderNo">VAR Code[20].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure FindSalesHeader(EMSMServiceItemLine: Record "EMSM Service Item Line EXP"; var SalesHdr: Record "Sales Header"; var SalesHeaderNo: Code[20]): Boolean;
    var
        EMSMServiceItemLineLocal: Record "EMSM Service Item Line EXP";
        SalesInvHdr: Record "Sales Invoice Header";
        TextSalesHeaderError: Label 'Sales Order: %1  has already been converted. ', Comment = 'DAN="Salgsordre: %1 er allerede blevet konverteret.",DEU="Verkaufsauftrag: %1, ist bereits konvertiert.",ESP="",FRA="Commande client : %1 a déjà été converti.",SVE=""';
        TextEMSMServiceItemLineError: Label 'Service Order: %1 does not exist in table Service Header, but is already converted in EMSM Service Item Line', Comment = 'DAN="Service Ordre: %1 findes ikke i tabellen Service Order, men er allerede blevet overført i tabellen EMSM Service Item Line"';
        TextServiceHeaderInvoicedError: Label 'Sales Order: %1, is already posted.', Comment = 'DAN="Salgsordre: %1, er allerede bogført.",DEU="Verkaufsauftrag: %1, ist bereits gebucht.",ESP="",FRA="Commande : %1, est déjà affiché.",SVE=""';
    begin
        SalesHeaderNo := EMSMServiceItemLine."Service Header Guid EXP";
        //Exit if Sales header already exists.
        if SalesHdr.GET(EMSMServiceItemLine."Document Type EXP", SalesHeaderNo) then begin
            exit(true);
        end;
        //If Sales header is created in NAV and re-injected from Planningboard
        if SalesHdr.GET(EMSMServiceItemLine."Document Type EXP", EMSMServiceItemLine."Order No. EXP") then begin
            exit(true);
        end;
        //IF Sales header doesn't exists in Sales Header table, we check if it has been converted in EMSM Service Item Line
        EMSMServiceItemLineLocal.SETFILTER("Service Header Guid EXP", '<>%1', '');
        EMSMServiceItemLineLocal.SETFILTER("Order No. EXP", EMSMServiceItemLine."Order No. EXP");
        EMSMServiceItemLine.SETFILTER("Line No. EXP", '=%1', 0);
        if EMSMServiceItemLineLocal.FIND('+') then begin
            SalesHeaderNo := EMSMServiceItemLineLocal."Service Header Guid EXP";
            if (SalesHdr.GET(EMSMServiceItemLineLocal."Document Type EXP", SalesHeaderNo)) then
                exit(true);
        end;
        //Error if the Sales order already has been posted and exists in Sales Invoice Header table
        if SalesInvHdr.GET(SalesHeaderNo) then begin
            ERROR(TextServiceHeaderInvoicedError, SalesHeaderNo);
        end;
        exit(false);
    end;

    local procedure InsertSalesLines(Rec: Record "EMSM Service Item Line EXP"; EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP"; var SalesHeader: Record "Sales Header"; ExpandITSetup: Record "ExpandIT Setup EXP")
    var
        SalesLine: Record "Sales Line";
        //EMSM18.0.6.139 begin        
        RecVar: Variant;
        Item: Record Item;
        ExpandITUtil: Codeunit "ExpandIT Util";
    // EMSM18.0.6.139 end
    begin
        EMSMServiceInvoiceLine.RESET;
        EMSMServiceInvoiceLine.SETRANGE("Order No. EXP", Rec."Order No. EXP");
        EMSMServiceInvoiceLine.SETRANGE("JobPlanningGuid EXP", Rec."JobPlanningGuid EXP");
        EMSMServiceInvoiceLine.SETFILTER("Convert Status EXP", '%1|%2', EMSMServiceInvoiceLine."Convert Status EXP"::New, EMSMServiceInvoiceLine."Convert Status EXP"::Error);
        if (EMSMServiceInvoiceLine.Find('-')) and (Rec."Line No. EXP" <> 0) then begin
            repeat
                OnBeforeProcessEMSMServiceInvoiceLine(EMSMServiceInvoiceLine); // EMSM18.0.6.183
                SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                SalesLine.SetRange("No.", SalesHeader."No.");
                SalesLine.SetRange("Line No.", EMSMServiceInvoiceLine."Line No. EXP");
                if not SalesLine.Find('-') then begin
                    //with EMSMServiceInvoiceLine do begin
                    SalesLine.Validate("Line No.", EMSMServiceInvoiceLine."Line No. EXP");
                    //EMSM3.06.11 begin
                    if (Rec."Document Type EXP" = rec."Document Type EXP"::Order) then
                        SalesLine.Validate("Document Type", SalesLine."Document Type"::Order)
                    else
                        SalesLine.Validate("Document Type", SalesLine."Document Type"::Quote);
                    //EMSM3.06.11 end
                    SalesLine.Validate("Document No.", SalesHeader."No.");
                    If (EMSMServiceInvoiceLine."Type EXP" = EMSMServiceInvoiceLine."Type EXP"::Resource) Then Begin
                        SalesLine.Validate(Type, SalesLine.Type::Resource);
                        SalesLine.Validate("No.", EMSMServiceInvoiceLine."No. EXP");
                        SalesLine.Validate("Work Type Code", EMSMServiceInvoiceLine."Work Type Code EXP");
                    end else begin
                        SalesLine.Validate(Type, SalesLine.Type::Item);
                        SalesLine.Validate("No.", EMSMServiceInvoiceLine."No. EXP");
                    end;
                    SalesLine.Validate("Unit of Measure Code", EMSMServiceInvoiceLine."Unit of Measure Code EXP");
                    SalesLine.Validate(Description, EMSMServiceInvoiceLine."Description EXP");
                    //EMSM18.0.6.203 begin 
                    if (SalesLine.Type = SalesLine.Type::Item) and (Item.Get(SalesLine."No.") and (Item.Type = Item.Type::Inventory)) then begin
                        SalesLine.Validate("Location Code", EMSMServiceInvoiceLine."Location Code EXP");
                    end;
                    //EMSM18.0.6.203 end
                    // EMSM18.0.6.210 begin
                    if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin
                        if (SalesLine.Type = SalesLine.Type::Item) and (ExpandITSetup."Smart Item No. EXP" = SalesLine."No.") then begin
                            SalesLine.Validate("Unit Price", EMSMServiceInvoiceLine."Unit Price EXP");
                            SalesLine.Validate("Unit Cost", EMSMServiceInvoiceLine."Cost Price EXP");
                        end;
                    end;
                    // EMSM18.0.6.210 end
                    SalesLine.Validate(Quantity, EMSMServiceInvoiceLine."Quantity EXP");
                    SalesLine.Validate("Qty. to Invoice", EMSMServiceInvoiceLine."Qty. to Invoice EXP");
                    //end;
                    OnBeforeInsertSalesLine(EMSMServiceInvoiceLine, SalesLine); //EMSM18.0.6.209
                    SalesLine.Insert();
                    EMSMServiceInvoiceLine."Processed Date Time EXP" := CURRENTDATETIME;
                    EMSMServiceInvoiceLine."Processed By User ID EXP" := USERID;
                    //Set Convert Status for EMSM Service Invoice Line
                    EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::Converted;
                    EMSMServiceInvoiceLine.MODIFY;
                    // EMSM18.0.6.139 begin
                    if (Item.Get(SalesLine."No.")) then
                        RecVar := SalesLine;
                    InsertItemTrackingLine(Item, EMSMServiceInvoiceLine, RecVar);
                    // EMSM18.0.6.139 end
                end;
                OnAfterProcessEMSMServiceInvoiceLine(EMSMServiceInvoiceLine);  // EMSM18.0.6.183
            until EMSMServiceInvoiceLine.Next = 0;
        end;
    end;

    local procedure UpdateSalesHeader(EMSMServiceItemLine: Record "EMSM Service Item Line EXP"; VAR SalesHeader: Record "Sales Header");
    var
        ExpandITSetup: Record "ExpandIT Setup EXP";
        OutStr: OutStream;
        Cust: Record "Customer";
        EMSMServiceItemLineLocal: Record "EMSM Service Item Line EXP";
        ExpandITUtil: Codeunit "ExpandIT Util";
    begin
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
            //with EMSMServiceItemLine do begin
            if (EMSMServiceItemLine."Starting Date EXP" <> 0D) then begin
                SalesHeader.SetHideValidationDialog(true);
                Cust.GET(EMSMServiceItemLine."Customer No. EXP");
                if (ExpandITSetup."Internet Default Curr Code EXP" <> '') then
                    SalesHeader.VALIDATE("Currency Code", ExpandITSetup."Internet Default Curr Code EXP")
                else
                    SalesHeader.VALIDATE("Currency Code", Cust."Currency Code");
                if (EMSMServiceItemLine."Starting Date EXP" <> 0D) then begin
                    SalesHeader.VALIDATE("Posting Date", EMSMServiceItemLine."Starting Date EXP");
                    SalesHeader.VALIDATE("Order Date", EMSMServiceItemLine."Starting Date EXP");
                    SalesHeader.VALIDATE("Document Date", EMSMServiceItemLine."Starting Date EXP");
                    SalesHeader.VALIDATE("Shipment Date", EMSMServiceItemLine."Starting Date EXP");
                end;
                if EMSMServiceItemLine."Salesperson Code EXP" = '' then begin
                    if SalesHeader."Salesperson Code" = '' then
                        SalesHeader.VALIDATE("Salesperson Code", ExpandITSetup."Sales Person Code EXP");
                end
                else
                    SalesHeader.VALIDATE("Salesperson Code", EMSMServiceItemLine."Salesperson Code EXP");
                SalesHeader.Validate("Your Reference", EMSMServiceItemLine."Customer Reference No. EXP");
                SalesHeader.Validate("External Document No.", EMSMServiceItemLine."Order No. EXP");
                SalesHeader."Work Description".CREATEOUTSTREAM(OutStr);
                OutStr.WRITE(EMSMServiceItemLine."Job Description EXP");
                // EMSM18.0.6.135 begin
                if ExpandITSetup."Override SalesOrder Status EXP" then
                    SetSalesOrderStatus(EMSMServiceItemLine, ExpandITSetup, SalesHeader);
                // EMSM18.0.6.135 end      
            end;
            //end;
        end;
    end;

    local procedure SetSalesOrderStatus(Rec: Record "EMSM Service Item Line EXP"; ExpandITSetup: Record "ExpandIT Setup EXP"; VAR SalesHeader: Record "Sales Header")
    var
        EMSMServiceItemLineLocal: Record "EMSM Service Item Line EXP";
    begin
        //EMSM3.06.02 begin
        if ExpandITSetup."Sales Order Status EXP" <> ExpandITSetup."Sales Order Status EXP"::" " then begin
            SalesHeader.Validate(Status, ExpandITSetup."Sales Order Status EXP");
        end else begin
            EMSMServiceItemLineLocal.SetRange("Order No. EXP", Rec."Order No. EXP");
            EMSMServiceItemLineLocal.SetRange("JobPlanningGuid EXP", Rec."JobPlanningGuid EXP");
            EMSMServiceItemLineLocal.SETFILTER("Repair Status Code EXP", 'FÆRDIG|COMPLETED');
            if EMSMServiceItemLineLocal.find('-') then
                SalesHeader.Validate(Status, SalesHeader.Status::Released)
            else
                SalesHeader.Validate(Status, SalesHeader.Status::Open);
        end;
        //EMSM3.06.02 end
    end;

    local procedure InsertEMSMSalesCommentLines(EMSMServiceItemLine: Record "EMSM Service Item Line EXP");
    var
        EMSMServiceCommentLine: Record "EMSM Service Comment Line EXP";
        ProcEMSMServCommentLine: Codeunit "Proc. EMSM Serv Com Line EXP";
    begin
        //Loop through Comment Lines and process them
        //with EMSMServiceItemLine do begin
        EMSMServiceCommentLine.SETCURRENTKEY(EMSMServiceCommentLine."No. EXP", EMSMServiceCommentLine."Table Line No. EXP", EMSMServiceCommentLine."JobPlanningGuid EXP", EMSMServiceCommentLine."Type EXP", EMSMServiceCommentLine."Line No. EXP");  //EMSM3.05.09
        d.UPDATE(1, EMSMServiceCommentLine.TABLECAPTION);
        EMSMServiceCommentLine.RESET;
        EMSMServiceCommentLine.SETRANGE("No. EXP", EMSMServiceItemLine."Order No. EXP");
        EMSMServiceCommentLine.SETRANGE("Table Line No. EXP", EMSMServiceItemLine."Line No. EXP");
        EMSMServiceCommentLine.SETRANGE("JobPlanningGuid EXP", EMSMServiceItemLine."JobPlanningGuid EXP");
        if EMSMServiceCommentLine.FIND('-') then
            repeat
                d.UPDATE(2, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("BAS Guid EXP"), EMSMServiceCommentLine."BAS Guid EXP"));
                d.UPDATE(3, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("No. EXP"), EMSMServiceCommentLine."No. EXP"));
                d.UPDATE(4, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("Table Line No. EXP"), EMSMServiceCommentLine."Table Line No. EXP"));
                d.UPDATE(5, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("Line No. EXP"), EMSMServiceCommentLine."Line No. EXP"));
                if EMSMServiceCommentLine."Convert Status EXP" in [EMSMServiceCommentLine."Convert Status EXP"::New, EMSMServiceCommentLine."Convert Status EXP"::Error] then begin
                    ProcEMSMServCommentLine.ProcessToSalesCommentLine(EMSMServiceCommentLine, EMSMServiceItemLine);
                    EMSMServiceCommentLine."Processed Date Time EXP" := CURRENTDATETIME;
                    EMSMServiceCommentLine."Processed By User ID EXP" := USERID;
                    EMSMServiceCommentLine.MODIFY;
                end;
            until EMSMServiceCommentLine.NEXT = 0;
        //end;
    end;

    local procedure InsertJobCommentLines(EMSMServiceItemLine: Record "EMSM Service Item Line EXP");
    var
        EMSMServiceCommentLine: Record "EMSM Service Comment Line EXP";
        ProcEMSMServCommentLine: Codeunit "Proc. EMSM Serv Com Line EXP";
    begin
        //Loop through Comment Lines and process them
        //with EMSMServiceItemLine do begin
        EMSMServiceCommentLine.SETCURRENTKEY(EMSMServiceCommentLine."No. EXP", EMSMServiceCommentLine."Table Line No. EXP", EMSMServiceCommentLine."JobPlanningGuid EXP", EMSMServiceCommentLine."Type EXP", EMSMServiceCommentLine."Line No. EXP");  //EMSM3.05.09
        d.UPDATE(1, EMSMServiceCommentLine.TABLECAPTION);
        EMSMServiceCommentLine.RESET;
        EMSMServiceCommentLine.SETRANGE("No. EXP", EMSMServiceItemLine."Order No. EXP");
        EMSMServiceCommentLine.SETRANGE("Table Line No. EXP", EMSMServiceItemLine."Line No. EXP");
        EMSMServiceCommentLine.SETRANGE("JobPlanningGuid EXP", EMSMServiceItemLine."JobPlanningGuid EXP");
        if EMSMServiceCommentLine.FIND('-') then
            repeat
                d.UPDATE(2, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("BAS Guid EXP"), EMSMServiceCommentLine."BAS Guid EXP"));
                d.UPDATE(3, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("No. EXP"), EMSMServiceCommentLine."No. EXP"));
                d.UPDATE(4, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("Table Line No. EXP"), EMSMServiceCommentLine."Table Line No. EXP"));
                d.UPDATE(5, STRSUBSTNO('%1: %2', EMSMServiceCommentLine.FIELDCAPTION("Line No. EXP"), EMSMServiceCommentLine."Line No. EXP"));
                if EMSMServiceCommentLine."Convert Status EXP" in [EMSMServiceCommentLine."Convert Status EXP"::New, EMSMServiceCommentLine."Convert Status EXP"::Error] then begin
                    ProcEMSMServCommentLine.ProcessToJobCommentLine(EMSMServiceCommentLine, EMSMServiceItemLine);
                    EMSMServiceCommentLine."Processed Date Time EXP" := CURRENTDATETIME;
                    EMSMServiceCommentLine."Processed By User ID EXP" := USERID;
                    EMSMServiceCommentLine.MODIFY;
                end;
            until EMSMServiceCommentLine.NEXT = 0;
        //end;
    end;

    local procedure UpdateServiceHeader(EMSMServiceItemLine: Record "EMSM Service Item Line EXP"; VAR ServiceHdr: Record "Service Header")
    begin
        //with EMSMServiceItemLine do begin
        //EMSM18.0.6.49 begin
        if EMSMServiceItemLine."Customer No. EXP" = 'NEW' then begin
            CreateNewCust(EMSMServiceItemLine, EMSMServiceItemLine."Customer No. EXP");
            ServiceHdr.VALIDATE("Customer No.", EMSMServiceItemLine."Customer No. EXP")
        end else
            ServiceHdr.VALIDATE("Customer No.", EMSMServiceItemLine."Customer No. EXP");
        //EMSM18.0.6.49 end
        //EMSM3.02.05 begin
        ServiceHdr.VALIDATE("Your Reference", EMSMServiceItemLine."Customer Reference No. EXP");
        ServiceHdr.VALIDATE(Description, EMSMServiceItemLine."Job Description EXP");  //EMSM3.02.06
        //ServiceHdr.VALIDATE("Ordered By Contact Name","Order By Contact Name");//EMSM3.02.09
        ServiceHdr.VALIDATE("Service Order Type", EMSMServiceItemLine."Service Order Type EXP");
        //EMSM3.02.05 end
        // EMSM3.06.14 begin
        if EMSMServiceItemLine."Ship-to Code EXP" = 'NEW' then
            CreateNewShipToAddress(EMSMServiceItemLine, EMSMServiceItemLine."Customer No. EXP", EMSMServiceItemLine."Ship-to Code EXP");
        if ServiceHdr."Ship-to Code" <> EMSMServiceItemLine."Ship-to Code EXP" then
            ServiceHdr.VALIDATE("Ship-to Code", EMSMServiceItemLine."Ship-to Code EXP");
        if ServiceHdr."Ship-to Code" <> EMSMServiceItemLine."Ship-to Code EXP" then
            ServiceHdr.VALIDATE("Ship-to Code", '');
        ServiceHdr.VALIDATE("Ship-to Name", EMSMServiceItemLine."Ship-to Name EXP");
        ServiceHdr.VALIDATE("Ship-to Address", EMSMServiceItemLine."Ship-to Address EXP");
        ServiceHdr.VALIDATE("Ship-to Address 2", EMSMServiceItemLine."Ship-to Address 2");
        ServiceHdr.VALIDATE("Ship-to City", EMSMServiceItemLine."Ship-to City EXP");
        ServiceHdr.VALIDATE("Ship-to Post Code", EMSMServiceItemLine."Ship-to Post Code EXP");
        if ServiceHdr."Service Order Type" <> EMSMServiceItemLine."Service Order Type EXP" then
            ServiceHdr.VALIDATE("Service Order Type", EMSMServiceItemLine."Service Order Type EXP");
        // EMSM3.06.14 end
        if ServiceHdr."Starting Date" <> EMSMServiceItemLine."Starting Date EXP" then begin
            if (EMSMServiceItemLine."Starting Date EXP" <> 0D) and (EMSMServiceItemLine."Starting Date EXP" < ServiceHdr."Order Date") then
                ServiceHdr.VALIDATE("Order Date", EMSMServiceItemLine."Starting Date EXP");
            ServiceHdr.VALIDATE("Starting Date", EMSMServiceItemLine."Starting Date EXP");
        end;
        if ServiceHdr."Starting Time" <> EMSMServiceItemLine."Starting Time EXP" then begin
            if (EMSMServiceItemLine."Starting Date EXP" = ServiceHdr."Order Date") and
               (EMSMServiceItemLine."Starting Time EXP" < ServiceHdr."Order Time")
            then
                ServiceHdr.VALIDATE("Order Time", EMSMServiceItemLine."Starting Time EXP");
            //EMSM3.04.15 begin 
            if (EMSMServiceItemLine."Starting Date EXP" <> 0D) then begin
                ;
                ServiceHdr.VALIDATE("Starting Time", EMSMServiceItemLine."Starting Time EXP");
            end;
            //EMSM3.04.15 end
        end;
        if ServiceHdr."Salesperson Code" <> EMSMServiceItemLine."Salesperson Code EXP" then
            ServiceHdr.VALIDATE("Salesperson Code", EMSMServiceItemLine."Salesperson Code EXP");
        //EMSM3.02.08 begin
        if EMSMServiceItemLine."ShiptoDoCallBeforeVisit EXP" then begin
            if (ServiceHdr."Ship-to Phone" <> '') or (ServiceHdr."Phone No." <> '') then begin
                ServiceHdr.VALIDATE("Notify Customer", ServiceHdr."Notify Customer"::"By Phone 1");
            end else
                if (ServiceHdr."Ship-to Phone 2" <> '') or (ServiceHdr."Phone No. 2" <> '') then begin
                    ServiceHdr.VALIDATE("Notify Customer", ServiceHdr."Notify Customer"::"By Phone 2");
                end else
                    ServiceHdr.VALIDATE("Notify Customer", ServiceHdr."Notify Customer"::No);
        end;
        //end;                       //EMSM3.02.08 end
    end;

    //EMSM18.0.6.19 begin
    /// <summary>
    /// OnBeforeProcessEMSMServiceItemLineToSalesOrder.
    /// </summary>
    /// <param name="VAR EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    [BusinessEvent(true)]
    procedure OnBeforeProcessEMSMServiceItemLineToSalesOrder(VAR EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
    begin
    end;

    /// <summary>
    /// OnAfterProcessEMSMServiceItemLineToSalesOrder.
    /// </summary>
    /// <param name="VAR EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    [BusinessEvent(true)]
    procedure OnAfterProcessEMSMServiceItemLineToSalesOrder(VAR EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
    begin
    end;

    /// <summary>
    /// OnBeforeProcessEMSMServiceItemLineToServiceOrder.
    /// </summary>
    /// <param name="VAR EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    [BusinessEvent(true)]
    procedure OnBeforeProcessEMSMServiceItemLineToServiceOrder(VAR EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
    begin
    end;

    /// <summary>
    /// OnAfterProcessEMSMServiceItemLineToServiceOrder.
    /// </summary>
    /// <param name="VAR EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    [BusinessEvent(true)]
    procedure OnAfterProcessEMSMServiceItemLineToServiceOrder(VAR EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
    begin
    end;

    /// <summary>
    /// OnBeforeProcessEMSMServiceItemLineToJobs.
    /// </summary>
    /// <param name="VAR EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    [BusinessEvent(true)]
    procedure OnBeforeProcessEMSMServiceItemLineToJobs(VAR EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
    begin
    end;

    /// <summary>
    /// OnAfterProcessEMSMServiceItemLineToJobs.
    /// </summary>
    /// <param name="VAR EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    [BusinessEvent(true)]
    procedure OnAfterProcessEMSMServiceItemLineToJobs(VAR EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
    begin
    end;

    /// <summary>
    /// OnProcessEMSMServiceItemLine.
    /// </summary>
    /// <param name="VAR EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    [BusinessEvent(true)]
    procedure OnProcessEMSMServiceItemLine(VAR EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
    begin
    end;
    //EMSM18.0.6.19 end

    //EMSM18.0.6.183 begin
    /// <summary>
    /// OnBeforeProcessEMSMServiceInvoiceLine.
    /// </summary>
    /// <param name="VAR EMSMServiceInvLine">Record "EMSM Service Invoice Line EXP".</param>
    [BusinessEvent(true)]
    procedure OnBeforeProcessEMSMServiceInvoiceLine(VAR EMSMServiceInvLine: Record "EMSM Service Invoice Line EXP")
    var
    begin
    end;

    /// <summary>
    /// OnAfterProcessEMSMServiceInvoiceLine.
    /// </summary>
    /// <param name="VAR EMSMServiceInvLine">Record "EMSM Service Invoice Line EXP".</param>
    [BusinessEvent(true)]
    procedure OnAfterProcessEMSMServiceInvoiceLine(VAR EMSMServiceInvLine: Record "EMSM Service Invoice Line EXP")
    var
    begin
    end;
    //EMSM18.0.6.183 end

    // EMSM18.0.6.209 begin 
    /// <summary>
    /// OnBeforeInsertSalesLine.
    /// </summary>
    /// <param name="VAR EMSMServiceInvLine">Record "EMSM Service Invoice Line EXP".</param>
    /// <param name="VAR SalesLine">Record "Sales Line".</param>
    [BusinessEvent(true)]
    procedure OnBeforeInsertSalesLine(VAR EMSMServiceInvLine: Record "EMSM Service Invoice Line EXP"; VAR SalesLine: Record "Sales Line")
    var
    begin
    end;
    // EMSM18.0.6.209 end

    // EMSM18.0.6.25 begin 
    /// <summary>
    /// CopyServiceItemNOFromEMSMServiceItemLine.
    /// </summary>
    /// <param name="EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    /// <param name="VAR EMSMServiceInvoiceLine">Record "EMSM Service Invoice Line EXP".</param>
    procedure CopyServiceItemNOFromEMSMServiceItemLine(EMSMServiceItemLine: Record "EMSM Service Item Line EXP"; VAR EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP")
    begin
        if (EMSMServiceInvoiceLine."Service Item No. EXP" <> EMSMServiceItemLine."Service Item No. EXP") then begin
            EMSMServiceInvoiceLine.Validate("Service Item No. EXP", EMSMServiceItemLine."Service Item No. EXP");
            EMSMServiceInvoiceLine.Validate("Description EXP", EMSMServiceItemLine."Description EXP");
        end;
    end;
    // EMSM18.0.6.25 end

    //EMSM18.0.6.28 begin
    local procedure IsNoSeriesSet(): boolean;
    var
        ServMgtSetup: record "Service Mgt. Setup";
        InvoiceNONotEqualPostedServiceInvoiceNo: Label 'Posted Service Invoice No. and Service Invoice No. must be equal in Service Management Setup page', comment = 'DAN="Bogførings Servicefakturanr. og Servicefakturanr. er ikke ens på Service Konfigurationssiden.",DEU="",ESP="",FRA="N° de la facture de service après-vente et le numéro de la facture de service doivent être égal dans la page de configuration de la gestion des services",SVE=""';
        InvoiceNoAndPostingInvoiceAreBlank: Label 'Posted Service Invoice No. and Service Invoice No. are blank in Service Management Setup page', comment = 'DAN="Bogførings Servicefakturanr. og Servicefakturanr. er tomme på Service Konfigurationssiden.",DEU="",ESP="",FRA="N° de la facture de service après-vente et le numéro de la facture de service sont vides dans la page de configuration de la gestion des services",SVE=""';
    begin
        ServMgtSetup.FindFirst();
        if (ServMgtSetup."Service Invoice Nos." <> ServMgtSetup."Posted Service Invoice Nos.") then
            error(InvoiceNONotEqualPostedServiceInvoiceNo);
        if (ServMgtSetup."Service Invoice Nos." = '') and (ServMgtSetup."Posted Service Invoice Nos." = '') then
            error(InvoiceNoAndPostingInvoiceAreBlank);
        exit(true);
    end;
    //EMSM18.0.6.28 end

    // EMSM18.0.6.139 begin
    /// <summary>
    /// InsertItemTrackingLine.
    /// </summary>
    /// <param name="Item">Record Item.</param>
    /// <param name="EMSMServiceInvoiceLine">Record "EMSM Service Invoice Line EXP".</param>
    /// <param name="RecVar">Variant.</param>
    procedure InsertItemTrackingLine(Item: Record Item; EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP"; RecVar: Variant)
    var
        ReservationEntry: Record "Reservation Entry";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        SalesLine: Record "Sales Line";
        ServiceLine: Record "Service Line";
        JobJnlLine: Record "Job Journal Line";
        RecRef: RecordRef;
        RecordIdVar: RecordId;
        FieldRefDocType: FieldRef;
        FieldRefDocNo: FieldRef;
        FieldRefLineNo: FieldRef;
        FieldRefJobJnlTempName: FieldRef;
        FieldRefJobJnlBatchName: FieldRef;
        TableNo: Integer;
        ItemTrackingCode: Record "Item Tracking Code";
        ErrorDesc: label 'Only record variable of type Service Line, Sales Line and Job Journal Line is expected', Comment = 'DAN="Kun variabel af typen Servicelinje, Salgslinje og Sagskladdelinje er forventet", DEU="", ESP="", SVE="", FRA=""';
    begin
        if ((Item."Item Tracking Code" <> '') and ((EMSMServiceInvoiceLine."Serial No. EXP" <> '') or (EMSMServiceInvoiceLine."Lot No. EXP" <> ''))) then begin // EMSM18.0.6.144
            CLEAR(ReservationEntry);
            //with ReservationEntry do begin
            ReservationEntry.SetRange("Serial No.", EMSMServiceInvoiceLine."Serial No. EXP");
            ReservationEntry.SetRange("Lot No.", EMSMServiceInvoiceLine."Lot No. EXP");
            if not ReservationEntry.FindFirst() then begin
                RecRef.GetTable(RecVar);
                RecordIdVar := RecRef.RecordId();
                TableNo := RecordIdVar.TableNo();
                if ((TableNo = Database::"Sales Line") or (TableNo = Database::"Service Line")) then begin
                    FieldRefDocType := RecRef.Field(1);
                    FieldRefDocNo := RecRef.Field(3);
                    FieldRefLineNo := RecRef.Field(4);
                    if (TableNo = Database::"Sales Line") then begin
#pragma warning disable AL0719
                        if SalesLine.get(FieldRefDocType.Value, FieldRefDocNo.Value, FieldRefLineNo.Value) then
#pragma warning restore AL0719
                            SalesLine.SetReservationEntry(ReservationEntry);
                    end else begin
#pragma warning disable AL0719
                        if ServiceLine.get(FieldRefDocType.Value, FieldRefDocNo.Value, FieldRefLineNo.Value) then
#pragma warning restore AL0719
                            ServiceLine.SetReservationEntry(ReservationEntry);
                    end;
                end else
                    if (TableNo = Database::"Job Journal Line") then begin
                        FieldRefJobJnlTempName := RecRef.Field(1);
                        FieldRefJobJnlBatchName := RecRef.Field(73);
                        FieldRefLineNo := RecRef.Field(2);
#pragma warning disable AL0719
                        if JobJnlLine.get(FieldRefJobJnlTempName.Value, FieldRefJobJnlBatchName.Value, FieldRefLineNo.Value) then
#pragma warning restore AL0719
                            JobJnlLine.SetReservationEntry(ReservationEntry);
                    end else
                        Error(ErrorDesc);
                if ItemTrackingCode.get(Item."Item Tracking Code") then begin
                    ReservationEntry.Validate(Quantity, EMSMServiceInvoiceLine."Quantity EXP");
                    ReservationEntry.Validate("Quantity (Base)", EMSMServiceInvoiceLine."Quantity EXP");
                    ReservationEntry.Validate("Quantity Invoiced (Base)", EMSMServiceInvoiceLine."Qty. to Invoice EXP");
                    if ItemTrackingCode."SN Specific Tracking" then
                        ReservationEntry.Validate("Serial No.", EMSMServiceInvoiceLine."Serial No. EXP");
                    if ItemTrackingCode."Lot Specific Tracking" then
                        ReservationEntry.Validate("Lot No.", EMSMServiceInvoiceLine."Lot No. EXP");
                    ReservationEntry.Validate("Reservation Status", "Reservation Status"::Tracking);
                    ReservationEntry.Insert(true);
                end;
            end;
            //end;
        end;
    end;
    // EMSM18.0.6.139 end

    // EMSM18.0.6.174 begin
    /// <summary>
    /// SetServiceItemLocation.
    /// </summary>
    /// <param name="EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    procedure SetServiceItemLocation(EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
        ServiceItem: Record "Service Item";
    begin
        if ServiceItem.Get(EMSMServiceItemLine."Service Item No. EXP") then begin
            if (EMSMServiceItemLine."Location of Service Item" <> '') and
               (ServiceItem."Location of Service Item" <> EMSMServiceItemLine."Location of Service Item") then begin
                ServiceItem.Validate(ServiceItem."Location of Service Item", EMSMServiceItemLine."Location of Service Item");
                ServiceItem.Modify(true);
            end;
        end;
    end;
    // EMSM18.0.6.174 end
}

