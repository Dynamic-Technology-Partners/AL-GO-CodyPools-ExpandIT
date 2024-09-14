/// <summary>
/// Page ExpandIT Sales Line FactBox (ID 68718).
/// </summary>
page 68718 "ExpandIT Sales Line FactBox"
{
    // version EIS4.01.01

    // EIS4.01.01 2011-02-25 PB * Object created

    Caption = 'Details', Comment = 'DAN="Detaljer",ESP="Detalles",FRA="Détails"';
    PageType = ListPart;
    SourceTable = "ExpandIT Order Line EXP";

    layout
    {
        area(content)
        {
            repeater(Control1160840000)
            {
                field("Item No."; Rec."Item No. EXP")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec."Description EXP")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec."Quantity EXP")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec."Amount EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

