/// <summary>
/// Codeunit EMSM Process Order EXP (ID 68740).
/// </summary>
codeunit 68740 "EMSM Process Order EXP"
{
    // version EMSM3.00.01
    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.
    // EMSM3.00.02  2018-09-10  FAM * Remove the check multipl Service Item Lines 
    // EMSM18.0.6.19 2020-01-15  FAM * Only set status to 'Converted' when we come with a status 'New'.   
    TableNo = "EMSM Service Item Line EXP";

    trigger OnRun();
    var
        ProcessEMSMServiceItemLine: Codeunit "Proc. EMSM Serv Item Line EXP";
    begin
        CLEAR(Rec."Error Message EXP");
        if Rec."Convert Status EXP" in [Rec."Convert Status EXP"::New, Rec."Convert Status EXP"::Error] then begin
            //EMSM3.00.01 begin
            //  CALCFIELDS("Has Multiple Serv. Item Lines");
            //  IF "Has Multiple Serv. Item Lines" AND ("Line No." <> 0) THEN
            //    FIELDERROR("Line No.");
            //EMSM3.00.01 end
            if DoRunWithErrorMessage then begin
                ProcessEMSMServiceItemLine.RUN(Rec);
                Rec."Convert Status EXP" := Rec."Convert Status EXP"::Converted;
                Rec."Error Message EXP" := '';
            end else begin
                if ProcessEMSMServiceItemLine.RUN(Rec) then begin
                    // EMSM18.0.6.19 begin                    
                    // Only set the convert status to 'Converted', when the record returns status 'New'.
                    // When the status is 'Error' or 'Rejected', it indicates that the standard code or the code raised by the events has set the status to one of these values.
                    if (Rec."Convert Status EXP" = Rec."Convert Status EXP"::New) then begin
                        Rec."Convert Status EXP" := Rec."Convert Status EXP"::Converted;
                        Rec."Error Message EXP" := '';
                        // EMSM18.0.6.19 end
                    end;
                end else begin
                    Rec."Convert Status EXP" := Rec."Convert Status EXP"::Error;
                    Rec."Error Message EXP" := COPYSTR(GETLASTERRORTEXT, 1, MAXSTRLEN(Rec."Error Message EXP"));
                end;
            end;
            Rec."Processed Date Time EXP" := CURRENTDATETIME;
            Rec."Processed By User ID EXP" := USERID;
            Rec.MODIFY;
            COMMIT;
        end;
    end;

    var
        DoRunWithErrorMessage: Boolean;

    /// <summary>
    /// RunWithErrorMessage.
    /// </summary>
    /// <param name="NewRunWithErrorMessage">Boolean.</param>
    procedure RunWithErrorMessage(NewRunWithErrorMessage: Boolean);
    begin
        DoRunWithErrorMessage := NewRunWithErrorMessage;
    end;

}

