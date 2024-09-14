/// <summary>
/// PageExtension Customer List EXP (ID 68780) extends Record Customer List.
/// </summary>
pageextension 68780 "Customer List EXP" extends "Customer List"
{
    layout
    {
        addlast(content)
        {
            field("DTP Pool Cleaning Customer"; Rec."DTP Pool Cleaning Customer")
            {
                ApplicationArea = All;
                Importance = Promoted;
            }
        }
    }
}
