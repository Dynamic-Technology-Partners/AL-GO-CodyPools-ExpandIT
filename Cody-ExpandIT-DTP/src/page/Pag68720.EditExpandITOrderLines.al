/// <summary>
/// Page Edit ExpandIT Order Lines (ID 68720).
/// </summary>
page 68720 "Edit ExpandIT Order Lines"
{
    ApplicationArea = All;
    Caption = 'Edit ExpandIT Order Lines';
    PageType = List;
    SourceTable = "ExpandIT Order Line EXP";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer Reference No."; rec."Customer Reference No.")
                {
                    ApplicationArea = all;
                }
                field("Converted to Doc. No."; rec."Converted to Doc. No.")
                {
                    ApplicationArea = all;
                }
                field("Order Guid EXP"; Rec."Order Guid EXP")
                {
                    ToolTip = 'Specifies the value of the Order Guid field.', Comment = 'DAN="Ordre GUID",DEU="Bestellhinweis",ESP="Ref. pedido",FRA="GUID commande",SVE="Orderstyrning"';
                    ApplicationArea = All;
                }
                field("Line No. EXP"; Rec."Line No. EXP")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = 'DAN="Linienr.",DEU="Zeilen Nr.",ESP="Nº línea",FRA="N° ligne",SVE="Radnr"';
                    ApplicationArea = All;
                }
                field("Item No. EXP"; Rec."Item No. EXP")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = 'DAN="Nummer",DEU="Artikel Nr.",ESP="Nº",FRA="N° article",SVE="Artikelnr"';
                    ApplicationArea = All;
                }
                field("Description EXP"; Rec."Description EXP")
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = 'DAN="Beskrivelse",DEU="Beschreibung",ESP="Descripción",FRA="Désignation",SVE="Beskrivning"';
                    ApplicationArea = All;
                }
                field("Quantity EXP"; Rec."Quantity EXP")
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = 'DAN="Antal",DEU="Menge",ESP="Cantidad",FRA="Quantité",SVE="Antal"';
                    ApplicationArea = All;
                }
                field("Location Code DTP"; Rec."Location Code DTP")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    ApplicationArea = All;
                }
                field("Variant Code EXP"; rec."Variant Code EXP")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code EXP"; rec."Unit of Measure Code EXP")
                {
                    ApplicationArea = all;
                }
                field("Unit Price EXP"; rec."Unit Price EXP")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
