/// <summary>
/// PageExtension Payment_Methods EXP (ID 68786) extends Record Payment Methods.
/// </summary>
pageextension 68786 "Payment_Methods EXP" extends "Payment Methods"
{
    // version NAVW111.00.00.19846,EIS5.04.02

    layout
    {
        addlast(content)
        {
            field("e-payment Provider Code EXP"; Rec."e-payment Provider Code EXP")
            {
                ApplicationArea = All;
            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

