/// <summary>
/// Table ExpandIT Order Line EXP (ID 68701).
/// </summary>
table 68701 "ExpandIT Order Line EXP"
{
    // version EIS5.04.03,EMI2.13

    // EIS3.01   2009-04-08  JR  * Field 726 "Unit Price Including Tax" was added to the table.
    // EIS5.04.01   2018-02-01  FAM * DAN/DEU/ESP/SVE/FRA is now added to fields and TextConstants.
    // EIS5.04.03   2018-02-22  FAM * Unit Of Measure fix is added.

    Caption = 'ExpandIT Order Line', Comment = 'DAN="ExpandIT-ordrelinie",DEU="ExpandIT Bestellzeilen",ESP="ExpandIT Líneas de pedido",FRA="Ligne commande ExpandIT",SVE="ExpandIT orderrad"';

    fields
    {
        field(4; "Line No. EXP"; Integer)
        {
            Caption = 'Line No.', Comment = 'DAN="Linienr.",DEU="Zeilen Nr.",ESP="Nº línea",FRA="N° ligne",SVE="Radnr"';
            DataClassification = CustomerContent;
        }
        field(6; "Item No. EXP"; Code[20])
        {
            Caption = 'Item No.', Comment = 'DAN="Nummer",DEU="Artikel Nr.",ESP="Nº",FRA="N° article",SVE="Artikelnr"';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(7; "Location Code DTP"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
        }
        field(11; "Description EXP"; Text[50])
        {
            Caption = 'Description', Comment = 'DAN="Beskrivelse",DEU="Beschreibung",ESP="Descripción",FRA="Désignation",SVE="Beskrivning"';
            DataClassification = CustomerContent;
        }
        field(15; "Quantity EXP"; Decimal)
        {
            Caption = 'Quantity', Comment = 'DAN="Antal",DEU="Menge",ESP="Cantidad",FRA="Quantité",SVE="Antal"';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(22; "Unit Price EXP"; Decimal)
        {
            Caption = 'Unit Price', Comment = 'DAN="Salgspris",DEU="Artikelpreis",ESP="Precio venta excl. IVA",FRA="Prix unitaire",SVE="A-pris"';
            DataClassification = CustomerContent;
        }
        field(27; "Line Discount % EXP"; Decimal)
        {
            Caption = 'Line Discount %', Comment = 'DAN="Linierabatpct",DEU="Zeilenrabatt %",ESP="% Descuento línea",FRA="% remise ligne",SVE="Radrabatt %"';
            DataClassification = CustomerContent;
        }
        field(29; "Amount EXP"; Decimal)
        {
            Caption = 'Amount', Comment = 'DAN="Beløb",DEU="Betrag",ESP="Importe",FRA="Montant",SVE="Belopp"';
            DataClassification = CustomerContent;
        }
        field(30; "Amount Including Tax EXP"; Decimal)
        {
            Caption = 'Amount Including Tax', Comment = 'DAN="Beløb inkl. moms",DEU="Betrag inkl. MwSt.",ESP="Importe IVA incl.",FRA="Montant TTC",SVE="Belopp inklusive moms"';
            DataClassification = CustomerContent;
        }
        field(5407; "Unit of Measure Code EXP"; Code[10])
        {
            Description = 'EIS5.04.03';
            Caption = 'Unit of Measure Code', Comment = 'DAN="Enhedskode",DEU="Einheitencode",ESP="Cód. unidad medida",FRA="Code unité",SVE="Enhetskod"';
            DataClassification = CustomerContent;
        }
        field(78700; "Customer Reference No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("ExpandIT Order Header EXP"."Customer Reference No. EXP" where("Order Guid EXP" = field("Order Guid EXP")));
        }
        field(78701; "Converted to Doc. No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("ExpandIT Order Header EXP"."Converted-To Document No. EXP" where("Order Guid EXP" = field("Order Guid EXP")));
        }
        field(78702; "Status EXP"; Option)
        {
            Caption = 'Status', Comment = 'DAN="Status",DEU="Status",ESP="Estado",FRA="Statut",SVE="Status"';
            Description = 'EIS5.04.01';
            OptionCaption = 'New,Converted,Rejected', Comment = 'DAN="Ny,Overført,Afvist",DEU="Neu,Übernommen,Abgelehnt",ESP="Nuevo, convertido, rechazado",FRA="Nouveau,Accepté,Rejeté",SVE="Ny,Godkänd,Avbruten"';
            OptionMembers = New,Converted,Rejected;
            DataClassification = CustomerContent;
        }
        field(78713; "Comment EXP"; Text[100])
        {
            Caption = 'Comment', Comment = 'DAN="Kommentar",DEU="Bemerkung",ESP="Comentario",FRA="Commentaires",SVE="Kommentar"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(78715; "Order Guid EXP"; Text[38])
        {
            Caption = 'Order Guid', Comment = 'DAN="Ordre GUID",DEU="Bestellhinweis",ESP="Ref. pedido",FRA="GUID commande",SVE="Orderstyrning"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(78723; "Order Line Guid EXP"; Text[38])
        {
            Caption = 'Order Line Guid', Comment = 'DAN="Ordre Linie GUID",DEU="Bestellzeilenhinweis",ESP="Ref. Línea pedido",FRA="GUID ligne commande",SVE="Orderradstyrning"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(78724; "Variant Code EXP"; Text[20])
        {
            Caption = 'Variant Code', Comment = 'DAN="Variantkode",DEU="Variantencode",ESP="Cod. Variante",FRA="Code variante",SVE="Variantkod"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(78725; "Quantity Shipped EXP"; Decimal)
        {
            Caption = 'Quantity Shipped', Comment = 'DAN="Antal leveret",DEU="Liefermenge",ESP="Cantidad enviada",FRA="Qté expédiée",SVE="Antal Levererade"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(78726; "Unit Price Including Tax EXP"; Decimal)
        {
            Caption = 'Unit Price Including Tax', Comment = 'DAN="Salgspris inkl. moms",DEU="VK-Preis inklusive MwSt.",ESP="Precio Unitario Imp. Inc.",FRA="Prix Unitaire TTC",SVE="Enhetspris inklusive moms"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Order Line Guid EXP")
        {
        }
        key(Key2; "Order Guid EXP", "Line No. EXP")
        {
        }
    }

    fieldgroups
    {
    }

    var
        InternetOrderLine: Record "ExpandIT Order Line EXP";
}

