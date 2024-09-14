/// <summary>
/// Codeunit NAVUpgradeForExpandIT1 EXP (ID 68761).
/// </summary>
codeunit 68761 "NAVUpgradeForExpandIT1 EXP"
{
    // version EXP365W11.0
    Subtype = Upgrade;


    trigger OnRun();
    begin
    end;

    trigger OnUpgradePerDatabase();
    begin
    end;

    trigger OnUpgradePerCompany();
    begin
        // NAVAPP.RestoreArchiveData(Database::"Gen. Journal Line");
        // NAVAPP.RestoreArchiveData(Database::"Sales Header");
        // NAVAPP.RestoreArchiveData(Database::"Sales Invoice Header");
        // NAVAPP.RestoreArchiveData(Database::"Customer");
        // NAVAPP.RestoreArchiveData(Database::"Currency");
        // NAVAPP.RestoreArchiveData(Database::"Payment Method");
        // NAVAPP.RestoreArchiveData(Database::"Sales Cue");
        // NAVAPP.RestoreArchiveData(Database::"Service Cue");
        // NAVAPP.RestoreArchiveData(Database::"Employee");
        // NAVAPP.RestoreArchiveData(Database::"Item Variant");
        // NAVAPP.RestoreArchiveData(Database::"Job");
        // NAVAPP.RestoreArchiveData(Database::Resource);
        // NAVAPP.RestoreArchiveData(Database::"Service Header");
        // NAVAPP.RestoreArchiveData(Database::"ExpandIT Order Header EXP");
        // NAVAPP.RestoreArchiveData(Database::"ExpandIT Order Line EXP");
        // NAVAPP.RestoreArchiveData(Database::"ExpandIT Setup EXP");
        // NAVAPP.RestoreArchiveData(Database::"Internet Customer EXP");
        // NAVAPP.RestoreArchiveData(Database::"Internet Customer B2B EXP");
        // NAVAPP.RestoreArchiveData(Database::"Internet Exchange Rate EXP");
        // NAVAPP.RestoreArchiveData(Database::"e-payment Provider EXP");
        // NAVAPP.RestoreArchiveData(Database::"e-payment Entry EXP");
        // NAVAPP.RestoreArchiveData(Database::"Related Items EXP");
        // NAVAPP.RestoreArchiveData(Database::"Internet Cue EXP");
        // // NAVAPP.RestoreArchiveData(Database::"EMSM Service Header");
        // NAVAPP.RestoreArchiveData(Database::"EMSM Service Item Line EXP");
        // NAVAPP.RestoreArchiveData(Database::"EMSM Service Invoice Line EXP");
        // NAVAPP.RestoreArchiveData(Database::"EMSM Service Comment Line EXP");
        // NAVAPP.RestoreArchiveData(Database::"EMSM Service Signature EXP");
        // NAVAPP.RestoreArchiveData(Database::"EMSM Service Attachments EXP");
        // NAVAPP.RestoreArchiveData(Database::"ExpandITServiceOrderCue EXP");
        // NAVAPP.RestoreArchiveData(Database::"EMI Setup");
        // NAVAPP.RestoreArchiveData(Database::"EMI Location Product Defaults");
        //NAVAPP.RestoreArchiveData(Database::"EMSM JobPlanning");
        //NAVAPP.RestoreArchiveData(Database::"EMSM JobPlanning Delete Notice");
        // NAVAPP.RestoreArchiveData(Database::"EMT Registration");
        // NAVAPP.RestoreArchiveData(Database::"EMT Employees per Job");
        // NAVAPP.RestoreArchiveData(Database::"ECRM Company");
        // NAVAPP.RestoreArchiveData(Database::"ECRM Contact");
        // NAVAPP.RestoreArchiveData(Database::"ECRM Activity");
        // NAVAPP.RestoreArchiveData(Database::"ECRM Opportunity Header");
        // NAVAPP.RestoreArchiveData(Database::"ECRM Opportunity Line");
        // NAVAPP.RestoreArchiveData(Database::"ECRM Contact Mailing Group");
        // NAVAPP.RestoreArchiveData(Database::"ECRM Setup");
        // NAVAPP.RestoreArchiveData(Database::"ECRM TempTimeSequence");
        // NAVAPP.RestoreArchiveData(Database::"ECRM Signature");
    end;
}

