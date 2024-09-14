/// <summary>
/// Page Related Items EXP (ID 68715).
/// </summary>
page 68715 "Related Items EXP"
{
    // version EIS5.04.01

    // EIS5.04.01  2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    AutoSplitKey = true;
    Caption = 'Related Items', Comment = 'DAN="Relaterede Varer",DEU="Verbundene Artikel",ESP="productos relacionados",FRA="Articles associés",SVE="Related Items"';
    PageType = List;
    SourceTable = "Related Items EXP";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Item No."; Rec."Item No. EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Relation Type"; Rec."Relation Type EXP")
                {
                    ApplicationArea = All;
                }
                field("Related to Item No."; Rec."Related to Item No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Related to Item Description"; Rec."Related to Item Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

