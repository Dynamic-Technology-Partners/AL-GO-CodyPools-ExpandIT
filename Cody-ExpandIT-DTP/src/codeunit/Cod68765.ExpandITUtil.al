// EMSM18.0.6.155,EIS6.0.12 2020-09-10 FAM * Add FindFirst check for ExpandIT Setup
// EIS6.0.17 2020-12-22 FAM * Trim whitespaces and add / to ExpandIT Shop Local URL.
// EMSM18.0.6.211 2021-04-13 FAM * Check for EXP permissionSet
// EMSM18.0.6.212 2020-09-10 FAM * Refactoring of the GetExpandITSetupRecord

/// <summary>
/// Codeunit ExpandIT Util (ID 68765).
/// </summary>
codeunit 68765 "ExpandIT Util"
{
    trigger OnRun()
    begin

    end;



    // EMSM18.0.6.212 begin
    /// <summary>
    /// GetExpandITSetupRecord.
    /// </summary>
    /// <param name="VAR ExpandITSetup">Record "Sales and Receivables Setup".</param>
    [TryFunction]
    procedure GetExpandITSetupRecord(VAR ExpandITSetup: Record "ExpandIT Setup EXP")
    var
    // User: Record "User";
    // AccessControl: Record "Access Control";
    begin
        // User.SetRange("User Name", UserId());
        // if User.FindFirst() then begin
        //     AccessControl.SetRange("User Security ID", User."User Security ID");
        //     AccessControl.SetFilter("Role ID", '%1|%2', 'EXP', 'SUPER');

        //     if AccessControl.FindFirst() then begin
        //         if not ExpandITSetup.get() then
        //             error(ExpandItSetupError);
        //     end
        // end;

        if not ExpandITSetup.get() then
            error(ExpandItSetupError);
    end;
    // EMSM18.0.6.212 end

    /// <summary>
    /// CheckEXPPermissionSet.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure CheckEXPPermissionSet(): Boolean
    var
        User: Record "User";
        AccessControl: Record "Access Control";
    begin
        User.SetRange("User Name", UserId());
        if User.FindFirst() then begin
            AccessControl.SetRange("User Security ID", User."User Security ID");
            AccessControl.SetFilter("Role ID", '%1|%2', 'EXP', 'SUPER');

            if AccessControl.FindFirst() then begin
                exit(true)
            end else begin
                exit(false);
            end;
        end else
            exit(false);
    end;

    // EIS6.0.17 begin 
    /// <summary>
    /// TrimExpandITURL.
    /// </summary>
    /// <param name="URL">Text[80].</param>
    /// <returns>Return value of type Text[80].</returns>
    procedure "TrimExpandITURL"(URL: Text[80]): Text[80]
    var
        TrimedURL: Text[80];
    begin
        TrimedURL := DELCHR(URL, '=', ' ');
        if not TrimedURL.EndsWith('/') then begin
            TrimedURL := TrimedURL + '/';
        end;
        exit(TrimedURL);
    end;
    // EIS6.0.17 end

    var
        ExpandItSetupError: Label 'EU Setup is empty', comment = 'ESP="", DAN="ExpandIT Opsætning er tom", DEU="", FRA="", SVE=""';

}