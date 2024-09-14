// EMSM18.0.6.33    2020-03-03  FAM * Convert attachments to Service order if job no. is blank and conversion rule is set to Prefer jobs 
// EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record
/// <summary>
/// Codeunit Proc. EMSM Serv Attachment EXP (ID 68745).
/// </summary>
codeunit 68745 "Proc. EMSM Serv Attachment EXP"
{

    TableNo = "EMSM Service Attachments EXP";

    trigger OnRun()


    begin

    end;

    /// <summary>
    /// processAttachments.
    /// </summary>
    /// <param name="EMSMServiceItemLine">Record "EMSM Service Item Line EXP".</param>
    /// <param name="Rec">Record "EMSM Service Attachments EXP".</param>
    procedure processAttachments(EMSMServiceItemLine: Record "EMSM Service Item Line EXP"; Rec: Record "EMSM Service Attachments EXP")
    var
        ProcessEMSMServiceItemLine: Codeunit "Proc. EMSM Serv Item Line EXP";
        ServiceHdr: Record "Service Header";
        SalesHdr: Record "Sales Header";
        job: Record Job;
        ServiceHeaderNo: Code[20];
        SalesHeaderNo: Code[20];
        ExpandITSetup: Record "ExpandIT Setup EXP";
        RecLink: Record "Record Link";
        LinkID: Integer;
        OutStr: OutStream;
        // TypeHelper: Codeunit "Type Helper";
        LenChar: Integer;
        ExpandITUtil: Codeunit "ExpandIT Util";
    begin
        //Processes one line and encapsulates possible errors from processing the line
        if not (Rec."Convert Status EXP" in [Rec."Convert Status EXP"::New, Rec."Convert Status EXP"::Error]) then
            exit;
        //Find ExpandIT setup
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
                                                                         //For Sales Orders
            if (ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Sales Order") then begin
                if ProcessEMSMServiceItemLine.FindSalesHeader(EMSMServiceItemLine, SalesHdr, SalesHeaderNo) then
                    SalesHdr.AddLink(Rec."ExternalURL EXP", Rec."Description EXP");
            end;
            //For Service Orders
            if (ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Service Order") then begin
                if ProcessEMSMServiceItemLine.FindServiceHeader(EMSMServiceItemLine, ServiceHdr, ServiceHeaderNo) then
                    ServiceHdr.AddLink(Rec."ExternalURL EXP", Rec."Description EXP");
            end;
            //For Jobs
            if (ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Jobs") then begin
                // EMSM18.0.6.33 begin
                if job.Get(Rec."Job No. EXP") and (Rec."Job No. EXP" <> '') then begin
                    job.AddLink(Rec."ExternalURL EXP", Rec."Description EXP");
                end else
                    //If Job No. is blank and Conversion Rule is set to Prefer Jobs, then the conversion will automatically go to Service Order. 
                    //Therefore the attachments must go to Service Orders too. 
                    if ProcessEMSMServiceItemLine.FindServiceHeader(EMSMServiceItemLine, ServiceHdr, ServiceHeaderNo) then begin
                        ServiceHdr.AddLink(Rec."ExternalURL EXP", Rec."Description EXP");
                    end;
                // EMSM18.0.6.33 end
            end;
        end;
    end;






}