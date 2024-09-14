/// <summary>
/// Page Int. Manager Role Center EXP (ID 68717).
/// </summary>
page 68717 "Int. Manager Role Center EXP"
{
    // version EIS4.01.01

    // EIS4.01.01 2011-02-25 PB * Object created

    Caption = 'Role Center', Comment = 'DAN="Rollecenter",ESP="Área de Roles",FRA="Centre de rôle"';
    PageType = RoleCenter;


    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part(Control1904818808; "Internet Processor Act. EXP")
                {
                    ApplicationArea = All;
                }
                // systempart(Control1901420308;Outlook)
                // {
                // }
                //TODO: Fix Outlook 
            }
            // group(Control1900724708)
            // {
            //     part(Control1903012608; "Connect Online")
            //     {
            //         Visible = false;
            //         ApplicationArea = All;
            //     }
            //     systempart(Control1901377608; MyNotes)
            //     {
            //     }
            // }
        }
    }

    actions
    {
        area(reporting)
        {
        }
        area(embedding)
        {
            action("Sales Orders")
            {
                Caption = 'Sales Orders', Comment = 'DAN="Salgsordrer",ESP="Pedidos de venta",FRA="Commandes de Ventes"';
                RunObject = Page "Sales Order List";
                ApplicationArea = All;
            }
            action("Sales Quotes")
            {
                Caption = 'Sales Quotes', Comment = 'DAN="Salgstilbud",ESP="Ofertas venta",FRA="Devis de vente"';
                Image = Quote;
                RunObject = Page "Sales Quotes";
                ApplicationArea = All;
            }
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices', Comment = 'DAN="Salgsfakturaer",ESP="Facturas venta",FRA="Factures de vente"';
                RunObject = Page "Sales Invoice List";
                ApplicationArea = All;
            }
            action(Items)
            {
                Caption = 'Items', Comment = 'DAN="Varer",ESP="Productos",FRA="Articles"';
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers', Comment = 'DAN="Kunder",ESP="Clientes",FRA="Clients"';
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("Internet Customers")
            {
                Caption = 'Internet Customers', Comment = 'DAN="Internet-kunder",ESP="Clientes Internet",FRA="Clients d''internet"';
                RunObject = Page "Internet Customer List EXP";
                ApplicationArea = All;
            }
            action("Internet Orders")
            {
                Caption = 'Internet Orders', Comment = 'DAN="Internet ordrer",ESP="Pedidos Internet",FRA="Commandes d''internet"';
                RunObject = Page "ExpandIT Sales List EXP";
                ApplicationArea = All;
            }
            action("Internet Orders - Converted")
            {
                Caption = 'Internet Orders - Converted', Comment = 'DAN="Internetordrer - Konverteret",ESP="Pedidos de Internet - Convertidos",FRA="Commandes d''internet - Converti"';
                RunObject = Page "ExpandIT Sales List EXP";
                RunPageView = SORTING("Order Date EXP")
                              WHERE("Status EXP" = FILTER(Converted));
                ApplicationArea = All;
            }
            action("Internet Orders - Rejected")
            {
                Caption = 'Internet Orders - Rejected', Comment = 'DAN="Internetordrer - Afvist",ESP="Pedidos de Internet - Rechazados",FRA="Commandes d''internet - Rejeté"';
                RunObject = Page "ExpandIT Sales List EXP";
                RunPageView = SORTING("Order Date EXP")
                              WHERE("Status EXP" = FILTER(Rejected));
                ApplicationArea = All;
            }
        }
        area(sections)
        {
        }
        area(processing)
        {
            separator(New)
            {
                Caption = 'New', Comment = 'DAN="Ny",ESP="Nuevo",FRA="Nouveau"';
                IsHeader = true;
            }
            action("Customer Login")
            {
                Caption = 'Customer Login', Comment = 'DAN="Kundelogin",ESP="Inicio de sesión de cliente",FRA="Identifiant client"';
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            separator(Tasks)
            {
                Caption = 'Tasks', Comment = 'DAN="Opgaver",ESP="Tareas",FRA="Tâches"';
                IsHeader = true;
            }
            action("Approve Orders")
            {
                Caption = 'Approve Orders', Comment = 'DAN="Godkend ordrer",ESP="Aprobar Pedidos",FRA="Approuvé les commandes"';
                RunObject = Page "ExpandIT Sales List EXP";
                ApplicationArea = All;
            }
        }
    }
}

