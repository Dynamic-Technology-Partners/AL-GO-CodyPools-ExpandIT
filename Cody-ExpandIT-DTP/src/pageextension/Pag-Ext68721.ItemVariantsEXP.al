/// <summary>
/// PageExtension ItemVariants EXP (ID 68721) extends Record Item Variants.
/// </summary>
pageextension 68721 "ItemVariants EXP" extends "Item Variants"
{
    layout
    {
        addlast(content)
        {
            field("QtyAvailable EXP"; Rec."QtyAvailable EXP")
            {
                ApplicationArea = All;
            }
        }
    }
}