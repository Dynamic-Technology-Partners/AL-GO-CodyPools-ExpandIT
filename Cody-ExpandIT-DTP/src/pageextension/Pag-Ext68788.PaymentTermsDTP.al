/// <summary>
/// PageExtension Payment Terms DTP (ID 68788) extends Record Payment Terms.
/// </summary>
pageextension 68788 "Payment Terms DTP" extends "Payment Terms"
{
    layout
    {
        addlast(content)
        {
            field("Credit Card DTP"; rec."Credit Card DTP")
            {
                ApplicationArea = All;
            }
        }
    }
}
