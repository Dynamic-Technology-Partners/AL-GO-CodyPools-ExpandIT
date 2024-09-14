/// <summary>
/// Codeunit Proc. EMSM Srv. Inv.(Time) EXP (ID 68744).
/// </summary>
codeunit 68744 "Proc. EMSM Srv. Inv.(Time) EXP"
{
    // version EMSM3.04.05

    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    // EMSM3.00.02  2018-02-21  FAM * Saved Date instead of Posting Date. (Tag EMSM3.00.02)
    // EMSM3.04.04  2018-04-23  FAM * "OR" instead of "AND" to remove the risk of sending an empty field. (Tag EMSM3.04.04)
    // EMSM3.04.05  2018-06-22  FAM * Check the Type of the receivertable with ours.
    // EMSM3.05.01  2018-12-13  FAM * If a record is DELETE it will not be processed.
    // EMSM3.05.02  2019-04-04  FAM * Add job task to Job journals.
    // EMSM3.05.09 2019-08-02 FAM * Select and add Gen.Bus.Posting Group from customer  
    // EMSM3.05.09.01 2019-08-21 FAM * Check if the Job Journal exists. 
    // EMSM3.05.09.02 2019-08-21 FAM * Set service Item Line No as LineNo. for Job Journal
    // EMSM18.0.6.42  2020-03-20 FAM * Use Resource Name As Description
    // EMSM18.0.6.46  2020-04-02 FAM * Create new jobs when job No. is NEW
    // EMSM18.0.6.52 2020-04-20  FAM * Cost price added (Smart item) 
    // EMSM18.0.6.62 2020-05-15  FAM * Service Line Type enum is used
    // EMSM18.0.6.139  2020-07-27  FAM * Create an Item Tracking Line if SerialNo and Item Tracking Code is set for an Item.
    // EMSM18.0.6.148 2020-09-10 FAM * Add FindFirst check for ExpandIT Setup
    // EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record 
    // EMSM18.06.176  2018-10-16  FAM * Description 2 field size increased to 100 and is now converted
    // EMSM18.0.6.183 2020-11-05 FAM * OnAfter and OnBefore events created and raised on service invoice line level
    // EMSM18.0.6.193 2020-12-07 FAM * ExpandIT Setup is empty
    // EMSM18.0.6.204 2021-02-19 FAM * (Job Journals) Set Location Code only for items with type = Inventory
    // EMSM18.0.6.209 2021-03-23 FAM * Event added for Service Line

    TableNo = "EMSM Service Invoice Line EXP";

    trigger OnRun();
    var
        ExpandITSetup: Record "ExpandIT Setup EXP";
        LineNo: Integer;
        // EMSM18.0.6.139 begin
        ProcessEMSMServiceItemLine: Codeunit "Proc. EMSM Serv Item Line EXP";
        RecVar: Variant;
        Item: Record Item;
        ExpandITUtil: Codeunit "ExpandIT Util";
    // EMSM18.0.6.139 end
    begin
        //Processes one line and encapsulates possible errors from processing the line
        //EMSM3.05.01 begin
        if not (Rec."Convert Status EXP" in [Rec."Convert Status EXP"::New, Rec."Convert Status EXP"::Error]) or (Rec."RecordAction EXP" = 'DELETE') then //EMSM3.05.01
            exit;
        //EMSM3.05.01 end

        //EMSM3.05.07 begin
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
            IF (ExpandITSetup."Conversion Rule EXP" <> ExpandITSetup."Conversion Rule EXP"::"Prefer Jobs") THEN
                Rec.TESTFIELD("Order No. EXP", '');
            //EMSM3.05.07 begin
            Rec.TESTFIELD("Job No. EXP");
            //TESTFIELD(RecordAction,'NEW');

            //IF (ExpandITSetup."Job Jnl. Template Name" = '') AND (ExpandITSetup."Job Jnl. Batch Name" = '') THEN BEGIN
            if (ExpandITSetup."Job Jnl. Template Name EXP" = '') or (ExpandITSetup."Job Jnl. Batch Name EXP" = '') then begin //EMSM3.04.04
                ExpandITSetup.GET;
                ExpandITSetup.TESTFIELD("Job Jnl. Template Name EXP");
                ExpandITSetup.TESTFIELD("Job Jnl. Batch Name EXP");
            end;

            JobJnlLine.SETRANGE("Journal Template Name", ExpandITSetup."Job Jnl. Template Name EXP");
            JobJnlLine.SETRANGE("Journal Batch Name", ExpandITSetup."Job Jnl. Batch Name EXP");
            if JobJnlLine.FIND('+') then begin
                // EMSM3.05.09.02 begin
                if ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Jobs" then begin
                    JobJnlLine."Line No." := Rec."Line No. EXP";
                end else begin
                    JobJnlLine."Line No." := JobJnlLine."Line No." + 10000;
                end;
                // EMSM3.05.09.02 end
                LastJobJnlLine := JobJnlLine;
            end else begin
                JobJnlLine."Journal Template Name" := ExpandITSetup."Job Jnl. Template Name EXP";
                JobJnlLine."Journal Batch Name" := ExpandITSetup."Job Jnl. Batch Name EXP";
                JobJnlLine."Line No." := Rec."Line No. EXP";
                LastJobJnlLine := JobJnlLine;
            end;
            //EMSM3.05.09.01 begin
            JobJnlLine.SETRANGE("Journal Template Name", ExpandITSetup."Job Jnl. Template Name EXP");
            JobJnlLine.SETRANGE("Journal Batch Name", ExpandITSetup."Job Jnl. Batch Name EXP");
            JobJnlLine.SETRANGE("Line No.", Rec."Line No. EXP");
            if JobJnlLine.FIND('-') then begin
                UpdateJobJnlLine(JobJnlLine, Rec, ExpandITSetup);
                JobJnlLine.Modify(true);
            end else begin
                JobJnlLine.SetUpNewLine(LastJobJnlLine);
                UpdateJobJnlLine(JobJnlLine, Rec, ExpandITSetup);
                OnBeforeInsertJobJournalLine(rec, JobJnlLine); // EMSM18.0.6.209
                JobJnlLine.INSERT(true);
            end;
            //EMSM3.05.09.01 end


            Rec."Convert Status EXP" := Rec."Convert Status EXP"::Converted;
            Rec."Error Message EXP" := '';
            // EMSM18.0.6.139 begin
            if (Item.get(Rec."No. EXP")) then
                RecVar := JobJnlLine;
            ProcessEMSMServiceItemLine.InsertItemTrackingLine(Item, Rec, RecVar);
            // EMSM18.0.6.139 end
            Rec.MODIFY;
        end else
            error(ExpandItSetupError); // EMSM18.0.6.193
    end;

    var
        ExpanditSetup: Record "ExpandIT Setup EXP";
        JobJnlLine: Record "Job Journal Line";
        LastJobJnlLine: Record "Job Journal Line";
        LineNo: Integer;
        EMSMServiceITemLine: Record "EMSM Service Item Line EXP";
        ExpandItSetupError: Label 'ExpandIT Setup is empty', comment = 'ESP="", DAN="ExpandIT Opsætning er tom", DEU="", FRA="", SVE=""';

    /// <summary>
    /// UpdateJobJnlLine.
    /// </summary>
    /// <param name="JobJnlLine">VAR Record "Job Journal Line".</param>
    /// <param name="EMSMServiceInvoiceLine">Record "EMSM Service Invoice Line EXP".</param>
    /// <param name="ExpandITSetup">Record "Sales and Receivables Setup".</param>
    procedure UpdateJobJnlLine(var JobJnlLine: Record "Job Journal Line"; EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP"; ExpandITSetup: Record "ExpandIT Setup EXP");
    var
        JobTask: Record "Job Task";
        txtError: Label 'Job task: %1, with Job Task Type: %2,  does not exist for job: %3.', Comment = 'DAN="Sagsopgave: %1, med sahgsopgave type: %2, eksisterer ikke for sag: %3.",DEU="Projektaufgabe: %1, mit Projektaufgabentyp: %2, existiert nit für Aufgabe %3",ESP="",FRA="Tâche : %1, avec le type de tâche : %2, n''existe pas pour l''emploi : %3.",SVE=""';
        Job: Record Job;
        Customer: Record "Customer";
        Resource: Record Resource;
        LineType: Enum "Line Type EXP";
        Item: Record Item;
    begin
        //with JobJnlLine do begin
        //EMSM3.00.02 begin
        JobJnlLine.Validate("Posting Date", EMSMServiceInvoiceLine."Saved Date EXP");
        JobJnlLine.Validate("Document Date", EMSMServiceInvoiceLine."Saved Date EXP");
        //EMSM3.00.02 end 
        // EMSM18.0.6.46 begin
        if EMSMServiceInvoiceLine."Job No. EXP" = 'NEW' then begin
            EMSMServiceITemLine.SetRange("Order No. EXP", EMSMServiceInvoiceLine."Order No. EXP");
            EMSMServiceITemLine.SetRange("Line No. EXP", 0);
            EMSMServiceITemLine.SetRange("RecordAction EXP", 'NEW');
            EMSMServiceITemLine.SetRange("Convert Status EXP", EMSMServiceITemLine."Convert Status EXP"::Converted);
            if EMSMServiceITemLine.FindFirst() then
                JobJnlLine.Validate("Job No.", EMSMServiceITemLine."Job No. EXP")
            else
                JobJnlLine.Validate("Job No.", EMSMServiceInvoiceLine."Job No. EXP");
        end else begin
            JobJnlLine.Validate("Job No.", EMSMServiceInvoiceLine."Job No. EXP");
        end;
        // EMSM18.0.6.46 end
        //Add Job task if the field is not empty. Else insert a dummy task. 
        if EMSMServiceInvoiceLine."Job Task No. EXP" = '' then begin
            if JobTask.GET(JobJnlLine."Job No.", '0') then begin
                JobJnlLine.Validate(JobJnlLine."Job Task No.", JobTask."Job Task No.");
            end else begin
                JobTask.Reset();
                JobTask."Job Task No." := '0';
                JobTask."Job No." := JobJnlLine."Job No.";
                JobTask.Insert();
                JobJnlLine.Validate(JobJnlLine."Job Task No.", JobTask."Job Task No.");
            end;
        end else begin
            JobTask.SetFilter("Job No.", JobJnlLine."Job No.");
            JobTask.setfilter("Job Task No.", EMSMServiceInvoiceLine."Job Task No. EXP");
            JobTask.SetFilter("Job Task Type", '%1', JobTask."Job Task Type"::Posting);

            if JobTask.FindFirst() then begin
                JobJnlLine.Validate(JobJnlLine."Job Task No.", JobTask."Job Task No.");
            end else begin
                Error(txtError, EMSMServiceInvoiceLine."Job Task No. EXP", JobTask."Job Task Type"::Posting, JobJnlLine."Job No.");
            end;
        end;
        ConvertServiceTypeToJobType(EMSMServiceInvoiceLine."Type EXP", LineType);
        JobJnlLine.Validate(Type, LineType); // EMSM18.0.6.62
        JobJnlLine.Validate("No.", EMSMServiceInvoiceLine."No. EXP");
        // EMSM18.0.6.42 begin
        if (EMSMServiceInvoiceLine."Type EXP" = EMSMServiceInvoiceLine."Type EXP"::Resource) and (ExpandITSetup."UseResNameAsDescription EXP") then begin
            if Resource.get(JobJnlLine."No.") then
                JobJnlLine.Validate(Description, Resource.Name)
            else
                JobJnlLine.Validate(Description, EMSMServiceInvoiceLine."Description EXP");
        end else
            JobJnlLine.Validate(Description, EMSMServiceInvoiceLine."Description EXP");

        // EMSM18.0.6.204 begin 
        if (JobJnlLine.Type = JobJnlLine.Type::Item) and (Item.Get(JobJnlLine."No.") and (Item.Type = Item.Type::Inventory)) then begin
            JobJnlLine.Validate("Location Code", EMSMServiceInvoiceLine."Location Code EXP");
        end else begin
            if JobJnlLine."Location Code" <> '' then begin
                JobJnlLine.Validate("Location Code", '');
            end;
        end;

        // EMSM18.0.6.204 end
        // EMSM18.0.6.42 end
        //EMSM3.04.05 - begin
        if (EMSMServiceInvoiceLine."Type EXP" = EMSMServiceInvoiceLine."Type EXP"::Resource) then
            JobJnlLine.Validate("Work Type Code", EMSMServiceInvoiceLine."Work Type Code EXP");
        //EMSM3.04.05 - end
        // If UOM functionality has been added, you can uncomment the next line to transfer the data
        JobJnlLine.validate("Unit of Measure Code", EMSMServiceInvoiceLine."Unit of Measure Code EXP");
        JobJnlLine.Validate(Quantity, EMSMServiceInvoiceLine."Quantity EXP");
        //Select the Line type from ExpandIT 365 Setup            
        //Validate("Line Type", ExpandITSetup."Line Type");
#pragma warning disable AL07
        //JobJnlLine."Line Type" := ExpandITSetup."Line Type EXP";
#pragma warning restore AL07
        JobJnlLine.VALIDATE("Description 2", EMSMServiceInvoiceLine."Description 2 EXP"); //EMSM18.06.176

        //EMSM3.05.09 begin
        //Select Gen.Bus.Posting Group from customer
        if Job.Get(JobJnlLine."Job No.") then begin
            Customer.Get(Job."Bill-to Customer No.");
            JobJnlLine.Validate("Gen. Bus. Posting Group", Customer."Gen. Bus. Posting Group");
        end;
        //EMSM3.05.09 end

        //VALIDATE("Location Code", Service365Line2."Location Code");
        //EMSM18.0.6.52 begin
        if (JobJnlLine.Type = JobJnlLine.Type::Item) and (ExpandITSetup."Smart Item No. EXP" = JobJnlLine."No.") then begin
            JobJnlLine.Validate("Unit Price", EMSMServiceInvoiceLine."Unit Price EXP");
            JobJnlLine.Validate("Unit Cost", EMSMServiceInvoiceLine."Cost Price EXP");
        end;
        //EMSM18.0.6.52 end
        //end;
    end;

    /// <summary>
    /// PrcsEMSMSrvInvLinsWtTimeReg.
    /// </summary>
    /// <param name="EMSMServiceInvoiceLine">VAR Record "EMSM Service Invoice Line EXP".</param>
    /// <param name="DoRunWithErrorMessage">Boolean.</param>
    procedure PrcsEMSMSrvInvLinsWtTimeReg(var EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP"; DoRunWithErrorMessage: Boolean);
    var
        ProcEMSMServiceInvLineTime: Codeunit "Proc. EMSM Srv. Inv.(Time) EXP";
        ProcServiceItemLine: Codeunit "Proc. EMSM Serv Item Line EXP";
    begin
        // Process EMSMServiceInvoiceLines With Time Registrations
        ProcServiceItemLine.OnBeforeProcessEMSMServiceInvoiceLine(EMSMServiceInvoiceLine);// EMSM18.0.6.183
                                                                                          // with EMSMServiceInvoiceLine do begin
        if EMSMServiceInvoiceLine."Convert Status EXP" in [EMSMServiceInvoiceLine."Convert Status EXP"::New, EMSMServiceInvoiceLine."Convert Status EXP"::Error] then begin
            if DoRunWithErrorMessage then begin
                ProcEMSMServiceInvLineTime.RUN(EMSMServiceInvoiceLine);
                EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::Converted;
                EMSMServiceInvoiceLine."Error Message EXP" := '';
            end else begin
                if ProcEMSMServiceInvLineTime.RUN(EMSMServiceInvoiceLine) then begin
                    EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::Converted;
                    EMSMServiceInvoiceLine."Error Message EXP" := '';
                end else begin
                    EMSMServiceInvoiceLine."Convert Status EXP" := EMSMServiceInvoiceLine."Convert Status EXP"::Error;
                    EMSMServiceInvoiceLine."Error Message EXP" := COPYSTR(GETLASTERRORTEXT, 1, MAXSTRLEN(EMSMServiceInvoiceLine."Error Message EXP"));
                end;
            end;
            EMSMServiceInvoiceLine."Processed Date Time EXP" := CURRENTDATETIME;
            EMSMServiceInvoiceLine."Processed By User ID EXP" := USERID;
            EMSMServiceInvoiceLine."Proc With Delayed Item Li EXP" := true;
            EMSMServiceInvoiceLine.MODIFY;
            COMMIT;
        end;
        // end;
        ProcServiceItemLine.OnAfterProcessEMSMServiceInvoiceLine(EMSMServiceInvoiceLine);// EMSM18.0.6.183
    end;
    // EMSM18.0.6.62 begin
    /// <summary>
    /// ConvertServiceTypeToJobType.
    /// </summary>
    /// <param name="SrvLineType">Enum "Type EXP".</param>
    /// <param name="VAR LineType">Enum "Line Type EXP".</param>
    procedure ConvertServiceTypeToJobType(SrvLineType: Enum "Type EXP"; VAR LineType: Enum "Line Type EXP")
    var
        ServiceLine: Record "Service Line";
        JobJnlLine: Record "Job Journal Line";

    begin
        //Service Line Types: ,Item,Resource,Cost,G/L Account
        //Job Journal Line Type: Resource,Item,G/L Account
        ServiceLine.Type := SrvLineType;
        case ServiceLine.Type of
            ServiceLine.Type::Item:
                LineType := JobJnlLine.Type::Item;
            ServiceLine.Type::Resource:
                LineType := JobJnlLine.Type::Resource;
            ServiceLine.Type::"G/L Account":
                LineType := JobJnlLine.Type::"G/L Account";
        end;
    end;
    // EMSM18.0.6.62 end

    // EMSM18.0.6.209 begin 
    /// <summary>
    /// OnBeforeInsertJobJournalLine.
    /// </summary>
    /// <param name="VAR EMSMServiceInvLine">Record "EMSM Service Invoice Line EXP".</param>
    /// <param name="VAR JobJournalLine">Record "Job Journal Line".</param>
    [BusinessEvent(true)]
    procedure OnBeforeInsertJobJournalLine(VAR EMSMServiceInvLine: Record "EMSM Service Invoice Line EXP"; VAR JobJournalLine: Record "Job Journal Line")
    var
    begin
    end;
    // EMSM18.0.6.209 end
}

