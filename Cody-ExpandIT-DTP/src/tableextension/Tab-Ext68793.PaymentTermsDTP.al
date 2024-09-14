/// <summary>
/// TableExtension Payment Terms DTP (ID 68793) extends Record Payment Terms.
/// </summary>
tableextension 68793 "Payment Terms DTP" extends "Payment Terms"
{
    fields
    {
        field(68700; "Credit Card DTP"; Boolean)
        {
            Caption = 'Credit Card';
            DataClassification = ToBeClassified;
        }
    }
}
