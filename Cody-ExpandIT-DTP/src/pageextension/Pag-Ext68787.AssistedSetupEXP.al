// EMSM18.0.6.168,EIS6.0.15 2020-10-14 FAM * Assisted Setup wizard is created
/// <summary>
/// PageExtension Assisted_Setup EXP (ID 68787) extends Record Assisted Setup.
/// </summary>
pageextension 68787 "Assisted_Setup EXP" extends "Assisted Setup"
{
    var
        TxtWizardTitle: Label 'Set up ExpandIT Connector', comment = 'ESP="",DEU="",DAN="Konfigurer ExpandIT Connector", FRA="",SVE=""';
        TxtWizardShortTitle: Label 'Set up ExpandIT Connector', comment = 'ESP="",DEU="",DAN="Konfigurer ExpandIT Connector", FRA="",SVE=""';
        TxtWizardDesc: Label 'Insert default values in ExpandIT Setup', comment = 'ESP="",DEU="",DAN="Indsæt standardværdier i ExpandIT Setup", FRA="",SVE=""';
        //AssistedSetup: Codeunit "Assisted Setup";
        GuideExperience: Codeunit "Guided Experience";

    trigger OnOpenPage()
    begin
        if not GuideExperience.Exists(Rec."Guided Experience Type"::"Assisted Setup", ObjectType::Page, 78787) then begin
            //GuideExperience.InsertAssistedSetup('fdafac4a-a281-438f-b6d2-19ae153b75dd', PAGE::"ExpandIT Setup Wiz EXP", TxtWizardName, Enum::"Assisted Setup Group"::Extensions, '', Enum::"Video Category"::Extensions, '', TxtWizardDesc);
            GuideExperience.InsertAssistedSetup(TxtWizardTitle, TxtWizardShortTitle, TxtWizardDesc, 10, ObjectType::Page, 78787, Enum::"Assisted Setup Group"::Extensions, '', Enum::"Video Category"::Extensions, '');

            CurrPage.Update();
        end;
    end;
}