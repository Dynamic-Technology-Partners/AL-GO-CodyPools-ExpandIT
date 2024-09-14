/// <summary>
/// Codeunit EMSM Web Service Mgt EXP (ID 68763).
/// </summary>
codeunit 68763 "EMSM Web Service Mgt EXP"
{
    //EMSM3.04.05  2018-11-22  FAM * Added errorhandling for each line. 
    trigger OnRun()
    begin
    end;

    var

        "Proc. EMSM Service Inv. Line": Codeunit "Proc. EMSM Srv. Inv.(Time) EXP";
        Rec: Record "EMSM Service Invoice Line EXP";

    /// <summary>
    /// ProcessTimeLines.
    /// </summary>
    procedure ProcessTimeLines()
    begin
        Rec.SETRANGE("Convert Status EXP", Rec."Convert Status EXP"::New);
        Rec.SETRANGE("Job No. EXP", '<>%1', '');
        Rec.SETRANGE("Order No. EXP", '%1', '');

        if Rec.FIND('-') then begin
            repeat
                if "Proc. EMSM Service Inv. Line".RUN(Rec) then begin
                    Rec."Convert Status EXP" := Rec."Convert Status EXP"::Converted;
                end else begin
                    Rec."Convert Status EXP" := Rec."Convert Status EXP"::Error;
                    Rec."Error Message EXP" := COPYSTR(GETLASTERRORTEXT, 1, MAXSTRLEN(Rec."Error Message EXP"));
                end;
            //"Proc. EMSM Service Inv. Line".RUN(Rec);      
            until Rec.NEXT = 0;
        end;
    end;


}