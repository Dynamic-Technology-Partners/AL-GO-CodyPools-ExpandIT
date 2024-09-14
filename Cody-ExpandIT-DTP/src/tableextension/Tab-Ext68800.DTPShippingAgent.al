/// <summary>
/// TableExtension DTP Shipping Agent (ID 68800) extends Record Shipping Agent.
/// </summary>
tableextension 68800 "DTP Shipping Agent" extends "Shipping Agent"
{
    fields
    {
        field(68800; "DTP Shipping Service Code"; Code[10])
        {
            Caption = 'Shipping Service Code';
            DataClassification = ToBeClassified;
        }
    }
}
