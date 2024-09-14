/// <summary>
/// Page EMSM Service Signature EXP (ID 68740).
/// </summary>
page 68740 "EMSM Service Signature EXP"
{
    // version EMSM2.13

    // EMSM2.13 2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    Caption = 'EMSM Service Signature', Comment = 'DAN="EMSM Service Underskrift",DEU="EMSM Service Unterschrift",ESP="Firma del Servicio",FRA="Signature service EMSM",SVE="EMSM service underskrift"';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "EMSM Service Signature EXP";


    layout
    {
        area(content)
        {
            field("BMP Signature EXP"; Rec."BMP Signature EXP")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

