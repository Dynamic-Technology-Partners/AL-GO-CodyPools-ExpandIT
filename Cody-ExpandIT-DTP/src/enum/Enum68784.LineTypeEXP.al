/// <summary>
/// Enum Line Type EXP (ID 68784).
/// </summary>
enum 68784 "Line Type EXP"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "G/L Account") { Caption = 'G/L Account', Comment = 'DAN="",DEU="",ESP="",FRA="",SVE=""'; }
    value(1; "Item") { Caption = 'Item', Comment = 'DAN="Artikel",DEU="",ESP="",FRA="",SVE=""'; }
    value(2; "Resource") { Caption = 'Resource', Comment = 'DAN="Ressource",DEU="",ESP="",FRA="",SVE=""'; }

}