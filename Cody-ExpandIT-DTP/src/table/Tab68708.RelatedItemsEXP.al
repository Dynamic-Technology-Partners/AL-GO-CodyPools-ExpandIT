/// <summary>
/// Table Related Items EXP (ID 68708).
/// </summary>
table 68708 "Related Items EXP"
{
    // version EIS5.04.06

    // EIS5.04.01  2018-02-08  FAM * DAN/DEU/FRA/ESP/SVE in now added to labels and textConstants.
    // EIS5.04.06  2018-05-17  FAM * Service Items is added to RelationType option.

    Caption = 'Related Items', Comment = 'DAN="Relaterede varer",DEU="Verbundene Artikel",ESP="Productos Relacionados",FRA="Articles associés",SVE="Relaterade artiklar"';

    fields
    {
        field(1; "Item No. EXP"; Code[20])
        {
            Caption = 'Item No.', Comment = 'DAN="Varenr.",DEU="Artikelnummer",ESP="Num. de producto",FRA="N° article",SVE="Artikelnr"';
            Description = 'EIS5.04.01';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(2; "Relation Type EXP"; Option)
        {
            Caption = 'Relation Type', Comment = 'DAN="Relationstype",DEU="Verbindungstyp",ESP="Tipo de Relación",FRA="Type d''association",SVE="Relationstyp"';
            Description = 'EIS5.04.06';
            OptionCaption = 'Other Customers Bought,Similar products,See also,Service Items', Comment = 'DAN="Andre kunder købte,Tilsvarnde produkt,Se også, Serviceartikler",DEU="andere Kunden kauften,gleiche Produkte,sehen Sie bitte auch",ESP="Otros Clientes compraron,Productos Similares,Ver También,Productos de servicio",FRA="Les clients ayant acheté cet article ont également acheté,Produits fréquemment achetés ensemble,Les clients ayant consulté cet article ont également regardé",SVE="Andra Kunder Köpte, Likvärdiga produkter, Se också"';
            OptionMembers = "Other Customers Bought","Similar products","See also","Service Items";
            DataClassification = CustomerContent;
        }
        field(3; "Related to Item No. EXP"; Code[20])
        {
            Caption = 'Related to Item No.', Comment = 'DAN="Rel. til varenr.",DEU="Verbunden mit Artikelnummer",ESP="Relacionado con el producto num.",FRA="Article associé",SVE="Relaterad till artikelnr"';
            Description = 'EIS5.04.01';
            TableRelation = Item;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CALCFIELDS("Related to Item Description");
            end;
        }
        field(4; "Line No. EXP"; Integer)
        {
            Caption = 'Line No.', Comment = 'DAN="Linienr.",DEU="Zeilennummer",ESP="Línea Num.",FRA="N° ligne",SVE="Radnr"';
            Description = 'EIS5.04.01';
            DataClassification = CustomerContent;
        }
        field(5; "Related to Item Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Related to Item No. EXP")));
            Caption = 'Related to Item Description', Comment = 'DAN="Varebeskrivelse",DEU="Verbunden mit Artikelbeschreibung",ESP="Relativo a la descripción del producto",FRA="Désignation article associé",SVE="Relaterad till artikelbeskrivning"';
            Description = 'EIS5.04.01';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Item No. EXP", "Relation Type EXP", "Related to Item No. EXP", "Line No. EXP")
        {
        }
    }

    fieldgroups
    {
    }
}

