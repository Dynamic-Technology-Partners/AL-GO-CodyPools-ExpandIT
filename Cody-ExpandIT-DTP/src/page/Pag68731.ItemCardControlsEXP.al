/// <summary>
/// Page Item Card - Controls EXP (ID 68731).
/// </summary>
page 68731 "Item Card - Controls EXP"
{
    // version EIS4.02.02,COPYPASTE

    // EIS4.01    2010-09-08 JR  * The purpose of this form is to hold controls that you
    //                             can copy and paste to forms using the same source table.
    // EIS4.02.02 2012-11-01  PB  * Moved to NAV 2013 (NAVW17.00)
    // EIS4.02.02 2018-02-02  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.

    PageType = Card;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&ExpandIT")
            {
                Caption = '&ExpandIT', Comment = 'DAN="&ExpandIT",DEU="&ExpandIT",ESP="&ExpandIT",FRA="&ExpandIT",SVE="&ExpandIT"';
                action("Related Items")
                {
                    Caption = 'Related Items', Comment = 'DAN="Relaterede Varer",DEU="Verbundene Artikel",ESP="Productos Relacionados",FRA="Articles Liés",SVE="Relaterade artiklar"';
                    Image = ItemTracking;
                    RunObject = Page "Related Items EXP";
                    RunPageLink = "Item No. EXP" = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }
}

