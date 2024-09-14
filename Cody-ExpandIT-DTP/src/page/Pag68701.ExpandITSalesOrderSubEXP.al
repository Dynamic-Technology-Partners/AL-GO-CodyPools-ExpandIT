/// <summary>
/// Page ExpandIT Sales Order Sub EXP (ID 68701).
/// </summary>
page 68701 "ExpandIT Sales Order Sub EXP"
{
    // version EIS5.04.01

    // EIS3.02   2009-04-08  JR  * Field "Unit Price Including Tax" was added to the form.
    //                           * Field "Amount Including Tax" was added to the form.
    // EIS5.04.01  2018-02-01  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels.

    AutoSplitKey = true;
    Caption = 'Lines', Comment = 'DAN="Linjer",DEU="Zeilen",ESP="Líneas",FRA="Lignes",SVE="Rader"';
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "ExpandIT Order Line EXP";
    SourceTableView = SORTING("Order Guid EXP", "Line No. EXP");

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Item No."; Rec."Item No. EXP")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec."Description EXP")
                {
                    ApplicationArea = All;
                }
                field("Variant Code EXP"; rec."Variant Code EXP")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec."Quantity EXP")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code EXP"; rec."Unit of Measure Code EXP")
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price EXP")
                {
                    ApplicationArea = All;
                }
                field("Unit Price Including Tax"; Rec."Unit Price Including Tax EXP")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec."Amount EXP")
                {
                    ApplicationArea = All;
                }
                field("Amount Including Tax"; Rec."Amount Including Tax EXP")
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

