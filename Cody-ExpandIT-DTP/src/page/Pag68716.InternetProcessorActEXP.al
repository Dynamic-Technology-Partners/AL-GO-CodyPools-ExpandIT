/// <summary>
/// Page Internet Processor Act. EXP (ID 68716).
/// </summary>
page 68716 "Internet Processor Act. EXP"
{
    // version EIS4.01.01

    // EIS4.01.01 2011-02-25 PB * Object created

    PageType = CardPart;
    SourceTable = "Internet Cue EXP";

    layout
    {
        area(content)
        {
            cuegroup(Incoming)
            {
                Caption = 'Incoming', Comment = 'DAN="Indkommende",ESP="Entrada",FRA="Nouveau"';
                field("Internet Orders - New"; Rec."Internet Orders - New EXP")
                {
                    DrillDownPageID = "ExpandIT Sales List EXP";
                    ApplicationArea = All;
                }

                actions
                {
                    action("Order Tracking")
                    {
                        Caption = 'Order Tracking', Comment = 'DAN="Ordresporing",ESP="Seguimiento de pedido",FRA="Suivi de commande"';
                        RunObject = Page "ExpandIT Sales Order Track EXP";
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
    }
}

