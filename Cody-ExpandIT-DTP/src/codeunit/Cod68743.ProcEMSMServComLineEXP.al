/// <summary>
/// Codeunit Proc. EMSM Serv Com Line EXP (ID 68743).
/// </summary>
codeunit 68743 "Proc. EMSM Serv Com Line EXP"
{
    // version EMSM18.0.6.190
    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    // EMSM3.01.01  2012-10-10  PB  * Fixed bug: Two comments had the same Key.
    //              2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EMSM3.01.02  2018-04-16  FAM * Create invoice message in service line.
    // EMSM3.05.04  2019-04-12  FAM * Check if a commentline exists in service line
    // EMSM3.05.10  2019-10-04  FAM * Add document type quote or order.
    // EMSM3.05.11  2019-10-09  FAM * Add service Item No. to commentline
    // EMSM18.0.6.27 2020-02-20 FAM * Bug fixed for missing Service Header Guid
    // EMSM18.0.6.146 2020-08-24 FAM * Bug fixed in Process comments for jobs. Process Job Comments and Process Sales Comments are moved from Codeunit 78741 
    // EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record
    // EMSM18.0.6.190 2020-12-01 FAM * Comments for Service Items added. Added a generic function for inserting commentlines
    TableNo = "EMSM Service Comment Line EXP";

    trigger OnRun();
    var
        ServiceCommentLine: Record "Service Comment Line";
        ServiceLine_LineNo: Integer;
    begin
        //Processes one line and encapsulates possible errors from processing the line
        if not (Rec."Convert Status EXP" in [Rec."Convert Status EXP"::New, Rec."Convert Status EXP"::Error]) then
            exit;
        //EMSM18.0.6.190 begin 
        if Rec."Service Item No. EXP" = '' then
            InsertServiceCommentLine(ServiceCommentLine."Table Name"::"Service Header", Rec, EMSMServiceItemLine, ServiceCommentLine)
        else
            InsertServiceCommentLine(ServiceCommentLine."Table Name"::"Service Item", Rec, EMSMServiceItemLine, ServiceCommentLine);
        //EMSM18.0.6.190 begin 
        Rec."Convert Status EXP" := Rec."Convert Status EXP"::Converted;
        Rec.MODIFY;
        //EMSM3.01.02 begin
        IF (Rec."Type EXP" = Rec."Type EXP"::Invoice) THEN BEGIN
            ServiceLine_LineNo := ServiceCommentLine."Line No." + 10000000;  //EMSM3.05.04
            ServiceLine.RESET;
            ServiceLine.SETRANGE("Customer No.", EMSMServiceItemLine."Customer No. EXP");
            ServiceLine.SETRANGE("Line No.", ServiceLine_LineNo);  //EMSM3.05.04
            ServiceLine.SETRANGE("Document No.", ServiceCommentLine."No.");
            IF NOT ServiceLine.FIND('-') THEN BEGIN
                ServiceLine.INIT;
                ServiceLine."Line No." := ServiceLine_LineNo;
                ServiceLine."Document No." := ServiceCommentLine."No.";
                ServiceLine.Description := ServiceCommentLine.Comment;
                ServiceLine."Service Item Line No." := Rec."Line No. EXP";
                //EMSM3.05.11 begin
                ServiceLine."Service Item No." := Rec."Service Item No. EXP";
                //EMSM3.05.11 end
                // EMSM3.05.10 begin
                if (EMSMServiceItemLine."Document Type EXP" = EMSMServiceItemLine."Document Type EXP"::Order) then
                    ServiceLine."Document Type" := ServiceLine."Document Type"::Order
                else
                    ServiceLine."Document Type" := ServiceLine."Document Type"::Quote;
                // EMSM3.05.10 end
                ServiceLine."Customer No." := EMSMServiceItemLine."Customer No. EXP";
                ServiceLine.INSERT;
            END
        END
        //EMSM3.01.02 end
    end;

    //EMSM18.0.6.190 begin 
    /// <summary>
    /// InsertServiceCommentLine.
    /// </summary>
    /// <param name="EnumServiceCommentTableName">Enum "Service Comment Table Name".</param>
    /// <param name="Var EMSMServiceCommentLine">Record "EMSM Service Comment Line EXP".</param>
    /// <param name="EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    /// <param name="VAR ServiceCommentLine">Record "Service Comment Line".</param>
    procedure InsertServiceCommentLine(EnumServiceCommentTableName: Enum "Service Comment Table Name"; Var EMSMServiceCommentLine: Record "EMSM Service Comment Line EXP"; EMSMServiceItemLine: Record "EMSM Service Item Line EXP"; VAR ServiceCommentLine: Record "Service Comment Line")
    var
        ServiceCommentLineType: Enum "Service Comment Line Type";
    begin
        Case EnumServiceCommentTableName of
            EnumServiceCommentTableName::"Service Header":
                begin
                    ServiceCommentLine.SETRANGE("Table Name", ServiceCommentLine."Table Name"::"Service Header");
                    ServiceCommentLine.SETRANGE("No.", EMSMServiceItemLine."Service Header Guid EXP");
                    ServiceCommentLine.SETRANGE("Table Subtype", 1);
                    ServiceCommentLine.SETRANGE(Type, EMSMServiceCommentLine."Type EXP");
                    ServiceCommentLine.SETRANGE("Table Line No.", EMSMServiceCommentLine."Table Line No. EXP");
                    if ServiceCommentLine.FIND('+') then
                        EMSMServiceCommentLine."Line No. EXP" := ServiceCommentLine."Line No." + 10000;
                    ServiceCommentLine.INIT;
                    ServiceCommentLine."Table Name" := ServiceCommentLine."Table Name"::"Service Header";
#pragma warning disable AL0603
                    ServiceCommentLine."Table Subtype" := ServiceCommentLineType::Fault;
#pragma warning restore AL0603
                    ServiceCommentLine.TRANSFERFIELDS(EMSMServiceCommentLine);
                    if EMSMServiceItemLine."Service Header Guid EXP" <> '' then
                        ServiceCommentLine."No." := EMSMServiceItemLine."Service Header Guid EXP";
                    ServiceCommentLine.INSERT(true);
                end;
            EnumServiceCommentTableName::"Service Item":
                begin
                    ServiceCommentLine.SETRANGE("Table Name", ServiceCommentLine."Table Name"::"Service Item");
                    ServiceCommentLine.SETRANGE("No.", EMSMServiceItemLine."Service Item No. EXP");
                    ServiceCommentLine.SETRANGE("Table Subtype", 0);
                    ServiceCommentLine.SETRANGE(Type, EMSMServiceCommentLine."Type EXP");
                    ServiceCommentLine.SETRANGE("Table Line No.", EMSMServiceCommentLine."Table Line No. EXP");
                    if ServiceCommentLine.FIND('+') then
                        EMSMServiceCommentLine."Line No. EXP" := ServiceCommentLine."Line No." + 10000;

                    ServiceCommentLine.INIT;
                    ServiceCommentLine."Table Name" := ServiceCommentLine."Table Name"::"Service Item";
#pragma warning disable AL0603
                    ServiceCommentLine."Table Subtype" := ServiceCommentLineType::Accessory;
#pragma warning restore AL0603
                    ServiceCommentLine.TRANSFERFIELDS(EMSMServiceCommentLine);
                    if EMSMServiceItemLine."Service Item No. EXP" <> '' then
                        ServiceCommentLine."No." := EMSMServiceItemLine."Service Item No. EXP";
                    ServiceCommentLine.INSERT(true);
                end;
        end;
    end;

    //EMSM18.0.6.190 begin
    var
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        ServiceLine: Record "Service Line";
    /// <summary>
    /// SetEMSMServiceItemLine.
    /// </summary>
    /// <param name="NewEMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    procedure SetEMSMServiceItemLine(NewEMSMServiceItemLine: Record "EMSM Service Item Line EXP");
    begin
        EMSMServiceItemLine := NewEMSMServiceItemLine;
    end;

    // EMSM18.0.6.146 begin
    /// <summary>
    /// ProcessToJobCommentLine.
    /// </summary>
    /// <param name="VAR EMSMSrvCommentLine">Record "EMSM Service Comment Line EXP".</param>
    /// <param name="EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    procedure ProcessToJobCommentLine(VAR EMSMSrvCommentLine: Record "EMSM Service Comment Line EXP"; EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
        CommentLine: Record "Comment Line";
        LineNo: Integer;
        JobPlanningLine: Record "Job Planning Line";
        EMSMServiceInvoiceLine: Record "EMSM Service Invoice Line EXP";
        ExpandITSetup: Record "ExpandIT Setup EXP";
        JobTask: Record "Job Task";
        ExpandITUtil: Codeunit "ExpandIT Util";
    begin
        //Processes one line and encapsulates possible errors from processing the line        
        //with EMSMSrvCommentLine do begin
        CommentLine.SETRANGE("No.", EMSMServiceItemLine."Job No. EXP");
        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Job);
        CommentLine.SETRANGE("Line No.", EMSMSrvCommentLine."Line No. EXP");
        if CommentLine.FIND('+') then
            CommentLine."Line No." := EMSMSrvCommentLine."Line No. EXP" + 10000
        else
            CommentLine."Line No." := EMSMSrvCommentLine."Line No. EXP";
        CommentLine.INIT;
        CommentLine.Validate("Table Name", CommentLine."Table Name"::Job);
        CommentLine.Validate("No.", EMSMServiceItemLine."Job No. EXP");
        CommentLine.Validate(Date, EMSMSrvCommentLine."Date EXP");
        CommentLine.Validate(Comment, EMSMSrvCommentLine."Comment EXP");
        CommentLine.INSERT(true);
        EMSMSrvCommentLine."Convert Status EXP" := EMSMSrvCommentLine."Convert Status EXP"::Converted;
        EMSMSrvCommentLine.MODIFY;
        if (EMSMSrvCommentLine."Type EXP" = EMSMSrvCommentLine."Type EXP"::Invoice) then begin
            LineNo := EMSMSrvCommentLine."Line No. EXP" + 100000;
            JobPlanningLine.RESET;
            JobPlanningLine.SETRANGE("Job No.", EMSMServiceItemLine."Job No. EXP");
            JobPlanningLine.SETRANGE("Line No.", LineNo);
            JobPlanningLine.SETRANGE("Job Task No.", EMSMServiceItemLine."Job Task No. EXP"); ///MSM15.0.6.20
            if NOT JobPlanningLine.FIND('-') then begin
                if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
                    JobPlanningLine.INIT;
                    JobPlanningLine.Validate("Job No.", EMSMServiceItemLine."Job No. EXP");
                    JobPlanningLine.Validate("Line Type", ExpandITSetup."Line Type EXP");
                    if EMSMServiceInvoiceLine."Job Task No. EXP" <> '' then
                        JobPlanningLine.Validate("Job Task No.", EMSMServiceInvoiceLine."Job Task No. EXP")
                    else begin
                        // EMSM18.0.6.21 begin
                        if JobTask.GET(EMSMServiceItemLine."Job No. EXP", '0') then begin
                            JobPlanningLine.Validate("Job Task No.", '0');
                        end else begin
                            JobTask.Reset();
                            JobTask."Job Task No." := '0';
                            JobTask.Validate("Job Task Type", JobTask."Job Task Type"::Posting);
                            JobTask."Job No." := EMSMServiceItemLine."Job No. EXP";
                            JobTask.Insert();
                            if JobTask.GET(EMSMServiceItemLine."Job No. EXP", '0') then begin
                                JobPlanningLine.Validate("Job Task No.", '0');
                            end;
                        end;
                        // EMSM18.0.6.21 end
                    end;
                end;
                JobPlanningLine.Validate("Line No.", LineNo);
                JobPlanningLine.Validate("Planning Date", Today);
                JobPlanningLine.Validate(Description, CommentLine.Comment);
                JobPlanningLine.Validate("Type", JobPlanningLine."Type"::Text);
                JobPlanningLine.INSERT;
            end
        end; //end;
    end;

    /// <summary>
    /// ProcessToSalesCommentLine.
    /// </summary>
    /// <param name="VAR EMSMSrvCommentLine">Record "EMSM Service Comment Line EXP".</param>
    /// <param name="EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    procedure ProcessToSalesCommentLine(VAR EMSMSrvCommentLine: Record "EMSM Service Comment Line EXP"; EMSMServiceItemLine: Record "EMSM Service Item Line EXP")
    var
        SalesCommenLine: Record "Sales Comment Line";
        Sales_LineNo: Integer;
        SalesLine: Record "Sales Line";
    begin
        //Processes one line and encapsulates possible errors from processing the line        
        //with EMSMSrvCommentLine do begin
        SalesCommenLine.SETRANGE("Document Type", EMSMSrvCommentLine."Type EXP");
        SalesCommenLine.SETRANGE("No.", EMSMServiceItemLine."Service Header Guid EXP");
        SalesCommenLine.SETRANGE("Document Line No.", EMSMSrvCommentLine."Table Line No. EXP");
        SalesCommenLine.SETRANGE("Line No.", EMSMSrvCommentLine."Line No. EXP");
        if SalesCommenLine.FIND('+') then
            SalesCommenLine."Line No." := SalesCommenLine."Line No." + 10000
        else
            SalesCommenLine."Line No." := 10000;
        SalesCommenLine.INIT;
        SalesCommenLine.Validate("Document Line No.", EMSMSrvCommentLine."Table Line No. EXP");
        SalesCommenLine.Validate("No.", EMSMServiceItemLine."Service Header Guid EXP");
        case EMSMSrvCommentLine."Type EXP" of
            EMSMSrvCommentLine."Type EXP"::Portal:
                SalesCommenLine.Validate("Document Type", SalesCommenLine."Document Type"::"Blanket Order");
            EMSMSrvCommentLine."Type EXP"::Invoice:
                SalesCommenLine.Validate("Document Type", SalesCommenLine."Document Type"::Invoice);
            EMSMSrvCommentLine."Type EXP"::Internal:
                SalesCommenLine.Validate("Document Type", SalesCommenLine."Document Type"::Order);
        end;
        SalesCommenLine.Validate(Date, EMSMSrvCommentLine."Date EXP");
        SalesCommenLine.Validate(Comment, EMSMSrvCommentLine."Comment EXP");
        SalesCommenLine.INSERT(true);
        EMSMSrvCommentLine."Convert Status EXP" := EMSMSrvCommentLine."Convert Status EXP"::Converted;
        EMSMSrvCommentLine.MODIFY;
        if (EMSMSrvCommentLine."Type EXP" = EMSMSrvCommentLine."Type EXP"::Invoice) then begin
            Sales_LineNo := EMSMSrvCommentLine."Line No. EXP" + 1000000;
            SalesLine.RESET;
            //SalesLine.SETRANGE("No.", EMSMServiceItemLine."Service Header Guid");
            SalesLine.SETRANGE("No.", SalesCommenLine."No.");
            SalesLine.SETRANGE("Bill-to Customer No.", EMSMServiceItemLine."Customer No. EXP");
            SalesLine.SETRANGE("Line No.", Sales_LineNo);
            SalesLine.SETRANGE("Document No.", EMSMServiceItemLine."Service Header Guid EXP");
            if not SalesLine.FIND('-') then begin
                SalesLine.INIT;
                SalesLine.Validate(SalesLine."Line No.", EMSMSrvCommentLine."Line No. EXP" + 1000000);
                SalesLine."Document No." := SalesCommenLine."No.";
                SalesLine.Validate(SalesLine.Description, SalesCommenLine.Comment);
                //EMSM3.06.11 begin
                if (EMSMServiceItemLine."Document Type EXP" = EMSMServiceItemLine."Document Type EXP"::Order) then
                    SalesLine.Validate(SalesLine."Document Type", SalesLine."Document Type"::Order)
                else
                    SalesLine.Validate(SalesLine."Document Type", SalesLine."Document Type"::Quote);
                //EMSM3.06.11 end
                SalesLine.Validate(SalesLine."Bill-to Customer No.", EMSMServiceItemLine."Customer No. EXP");
                SalesLine.INSERT;
            end
        end; //end;
    end;
    // EMSM18.0.6.146 end
}

