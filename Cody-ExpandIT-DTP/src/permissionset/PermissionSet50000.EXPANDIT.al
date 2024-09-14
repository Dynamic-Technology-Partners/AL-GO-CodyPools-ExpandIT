/// <summary>
/// Unknown EXPANDIT (ID 50000).
/// </summary>
permissionset 50000 EXPANDIT
{
    Assignable = true;
    Permissions = tabledata "e-payment Entry EXP" = RIMD,
        tabledata "e-payment Provider EXP" = RIMD,
        tabledata "EMSM JobPlanning EXP" = RIMD,
        tabledata "EMSM JobPln Delete Notice EXP" = RIMD,
        tabledata "EMSM Service Attachments EXP" = RIMD,
        tabledata "EMSM Service Comment Line EXP" = RIMD,
        tabledata "EMSM Service Invoice Line EXP" = RIMD,
        tabledata "EMSM Service Item Line EXP" = RIMD,
        tabledata "EMSM Service Signature EXP" = RIMD,
        tabledata "ExpandIT Order Header EXP" = RIMD,
        tabledata "ExpandIT Order Line EXP" = RIMD,
        tabledata "ExpandIT Setup EXP" = RIMD,
        tabledata "ExpandITServiceOrderCue EXP" = RIMD,
        tabledata "Internet Cue EXP" = RIMD,
        tabledata "Internet Customer B2B EXP" = RIMD,
        tabledata "Internet Customer EXP" = RIMD,
        tabledata "Internet Exchange Rate EXP" = RIMD,
        tabledata "Related Items EXP" = RIMD,
        tabledata "Web Invoice Payment" = RIMD,
        tabledata "Web Invoice Payment Entry" = RIMD,
        table "e-payment Entry EXP" = X,
        table "e-payment Provider EXP" = X,
        table "EMSM JobPlanning EXP" = X,
        table "EMSM JobPln Delete Notice EXP" = X,
        table "EMSM Service Attachments EXP" = X,
        table "EMSM Service Comment Line EXP" = X,
        table "EMSM Service Invoice Line EXP" = X,
        table "EMSM Service Item Line EXP" = X,
        table "EMSM Service Signature EXP" = X,
        table "ExpandIT Order Header EXP" = X,
        table "ExpandIT Order Line EXP" = X,
        table "ExpandIT Setup EXP" = X,
        table "ExpandITServiceOrderCue EXP" = X,
        table "Internet Cue EXP" = X,
        table "Internet Customer B2B EXP" = X,
        table "Internet Customer EXP" = X,
        table "Internet Exchange Rate EXP" = X,
        table "Related Items EXP" = X,
        table "Web Invoice Payment" = X,
        table "Web Invoice Payment Entry" = X,
        report "Bat. Conv. ExpandIT Orders EXP" = X,
        report "Batch Capture e-payments EXP" = X,
        report "Batch Renew e-payments EXP" = X,
        report "EMSM Proc SrvLinesWOHeader EXP" = X,
        report "EMSM Process Orders EXP" = X,
        report "ExpandIT Orders" = X,
        report "Internet Customers EXP" = X,
        codeunit "Create Web Payment" = X,
        codeunit "e-payment Mgt" = X,
        codeunit "E-payment Service EXP" = X,
        codeunit "EMSM Proc JobPlanning Data EXP" = X,
        codeunit "EMSM Process Order EXP" = X,
        codeunit "EMSM Web Service Mgt EXP" = X,
        codeunit "ExpandIT Util" = X,
        codeunit ExpandITAPI = X,
        codeunit "Int Ord to Doc(Yes/No) EXP" = X,
        codeunit "Int Order to Sales-Doc. EXP" = X,
        codeunit "Int Shop Create Demodata EXP" = X,
        codeunit "Internet Shop Management EXP" = X,
        codeunit "NAVUpgradeForExpandIT1 EXP" = X,
        codeunit "Proc. EMSM Serv Attachment EXP" = X,
        codeunit "Proc. EMSM Serv Com Line EXP" = X,
        codeunit "Proc. EMSM Serv Item Line EXP" = X,
        codeunit "Proc. EMSM Srv. Inv.(Srv.) EXP" = X,
        codeunit "Proc. EMSM Srv. Inv.(Time) EXP" = X,
        codeunit "User Management DTP" = X,
        page "Customer Card - Controls EXP" = X,
        page "e-payment Entries EXP" = X,
        page "e-payment Provider EXP" = X,
        page "e-payment Providers EXP" = X,
        page "Edit ExpandIT Order Lines" = X,
        page "Edit ExpandIT Sales Orders" = X,
        page "EMSM Inc. Srv. Inv.(Srv) EXP" = X,
        page "EMSM Inc. Srv. Inv.(Time) EXP" = X,
        page "EMSM Incoming Serv Orders EXP" = X,
        page "EMSM Serv Item Worksht Sb EXP" = X,
        page "EMSM Service Comment Sheet EXP" = X,
        page "EMSM Service Item Worksht EXP" = X,
        page "EMSM Service Sign List EXP" = X,
        page "EMSM Service Signature EXP" = X,
        page "Enter Card ID EXP" = X,
        page "Enter Rejected Description EXP" = X,
        page "ExpandIT EXP" = X,
        page "ExpandIT Sales Line FactBox" = X,
        page "ExpandIT Sales List EXP" = X,
        page "ExpandIT Sales Order EXP" = X,
        page "ExpandIT Sales Order FactBox" = X,
        page "ExpandIT Sales Order Sub EXP" = X,
        page "ExpandIT Sales Order Track EXP" = X,
        page "ExpandIT Setup EXP" = X,
        page "ExpandIT Web Payment" = X,
        page "ExpandIT Web Payment List" = X,
        page "ExpandIT Web Payment Sub" = X,
        page "ExpandItServiceOrderCue EXP" = X,
        page "ExpandITSrvDldHeader FactBox" = X,
        page "ExpandItSrvOrder FactBox EXP" = X,
        page "ExpandITSrvTimeLines FactBox" = X,
        page "Int. Manager Role Center EXP" = X,
        page "Internet Cur. Overview EXP" = X,
        page "Internet Customer B2B List EXP" = X,
        page "Internet Customer Card EXP" = X,
        page "Internet Customer List EXP" = X,
        page "Internet Exchange Rates EXP" = X,
        page "Internet Processor Act. EXP" = X,
        page "Item Card - Controls EXP" = X,
        page "Location Card - Controls EXP" = X,
        page "Related Items EXP" = X,
        page "Sales Header - Controls EXP" = X;
}