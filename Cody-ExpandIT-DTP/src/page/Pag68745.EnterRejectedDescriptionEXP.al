/// <summary>
/// Page Enter Rejected Description EXP (ID 68745).
/// </summary>
page 68745 "Enter Rejected Description EXP"
{
    // version EMSM3.00.01

    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.

    Caption = 'Enter Rejected Description', Comment = 'DAN="Udfyld afvisningsbeskrivelse",ESP="Introducir descripción de rechazo",FRA="Entrer la Description Rejeté", DEU="Abgelehnte Beschreibung eingeben"';
    PageType = Card;


    layout
    {
        area(content)
        {
            field("EMSMServiceItemLine.""Rejected Description"""; EMSMServiceItemLine."Rejected Description EXP")
            {
                Caption = 'Rejected Description', Comment = 'DAN="Afvisningsbeskrivelse",ESP="Descripción de rechazo",FRA="Description Rejeté", DEU="Beschreibung abgelehnte"';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := true;
    end;

    var
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";

    /// <summary>
    /// GetDescription.
    /// </summary>
    /// <returns>Return value of type Text[250].</returns>
    procedure GetDescription(): Text[250];
    begin
        exit(EMSMServiceItemLine."Rejected Description EXP");
    end;
}

