/// <summary>
/// Page EMSM Service Comment Sheet EXP (ID 68746).
/// </summary>
page 68746 "EMSM Service Comment Sheet EXP"
{
    // version EMSM3.00.01

    // EMSM3.00.01  2011-10-27  PB  * EMSM Error handling UI implemented.

    AutoSplitKey = true;
    Caption = 'EMSM Service Comment Sheet', Comment = 'DAN="EMSM Servicebemærkninger",DEU="Service Bemerkungen",ESP="Hoja comentario de servicio",FRA="EMSM Feuille de commentaire pour Service"';
    DataCaptionFields = "No. EXP", "Table Line No. EXP";
    LinksAllowed = false;
    PageType = List;
    SourceTable = "EMSM Service Comment Line EXP";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("No."; Rec."No. EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Table Line No."; Rec."Table Line No. EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Saved Date"; Rec."Saved Date EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Saved Time"; Rec."Saved Time EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No. EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Service Comment Line Guid"; Rec."Service Comment Line Guid EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("BAS Guid"; Rec."BAS Guid EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("RecordAction"; Rec."RecordAction EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("JobPlanningGuid"; Rec."JobPlanningGuid EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Processed Date Time"; Rec."Processed Date Time EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Processed By User ID"; Rec."Processed By User ID EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Service Item No."; Rec."Service Item No. EXP")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Convert Status"; Rec."Convert Status EXP")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec."Date EXP")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec."Comment EXP")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

