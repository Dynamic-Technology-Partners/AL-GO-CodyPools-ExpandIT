/// <summary>
/// Enum Document Type EXP (ID 68780).
/// </summary>
enum 68780 "Document Type EXP"
{
    Extensible = true;
    AssignmentCompatibility = true;
    value(0; "Quote") { Caption = 'Quote', Comment = 'DAN="Tilbud",DEU="Anfrage",ESP="Oferta",FRA="Devis",SVE="Offert"'; }
    value(1; "Order") { Caption = 'Order', Comment = 'DAN="Ordre",DEU="Bestellung",ESP="Pedido",FRA="Commande",SVE="Order"'; }
    value(2; "Invoice") { Caption = 'Invoice', Comment = 'DAN="Faktura",DEU="Rechnung",ESP="Factura",FRA="Facture",SVE="Faktura"'; }
    value(3; "Credit Memo") { Caption = 'Invoice', Comment = 'DAN="Kreditnota",DEU="Gutschrift",ESP="Abono",FRA="Avoir",SVE="Kreditnota"'; }
    value(4; "Blanket Order") { Caption = 'Invoice', Comment = 'DAN="Rammeordre",DEU="allgemeine Bestellung",ESP="Pedido en Blanco",FRA="Commande ouverte",SVE="Avropsorder"'; }
}

