/// <summary>
/// Page ExpandIT Sales Order FactBox (ID 68719).
/// </summary>
page 68719 "ExpandIT Sales Order FactBox"
{
    // version EIS4.01.01

    // EIS4.01.01 2011-02-25 PB * Object created

    Caption = 'Statistics', Comment = 'DAN="Statistik",ESP="Estadísticas",FRA="Statistiques"';
    PageType = CardPart;
    SourceTable = "ExpandIT Order Header EXP";

    layout
    {
        area(content)
        {
            field("Currency Code"; Rec."Currency Code EXP")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec."Amount EXP")
            {
                ApplicationArea = All;
            }
            field("Amount Including Tax"; Rec."Amount Including Tax EXP")
            {
                ApplicationArea = All;
            }
            field("Invoice Discount"; Rec."Invoice Discount EXP")
            {
                ApplicationArea = All;
            }
            field("Service Charge"; Rec."Service Charge EXP")
            {
                ApplicationArea = All;
            }
            field(Comment; Rec."Comment EXP")
            {
                ApplicationArea = All;
            }
            field("Shipping Amount"; Rec."Shipping Amount EXP")
            {
                ApplicationArea = All;
            }
            field("Handling Amount"; Rec."Handling Amount EXP")
            {
                ApplicationArea = All;
            }
            field("Payment Fee Amount"; Rec."Payment Fee Amount EXP")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

