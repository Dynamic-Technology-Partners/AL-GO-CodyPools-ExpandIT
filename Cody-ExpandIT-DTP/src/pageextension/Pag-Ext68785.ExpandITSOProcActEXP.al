/// <summary>
/// PageExtension ExpandIT SO_Proc_Act EXP (ID 68785) extends Record SO Processor Activities.
/// </summary>
pageextension 68785 "ExpandIT SO_Proc_Act EXP" extends "SO Processor Activities"
{
    layout
    {
        /*         addlast("My User Tasks")
                {
                    cuegroup("SalesContainer EXP")
                    {
                        Caption = 'ExpandIT';
                        field("SalesOrders EXP"; Rec."SalesOrders EXP")
                        {
                            DrillDownPageId = "ExpandIT Sales List EXP";
                            ToolTip = 'New ExpandIT Sales Orders', Comment = 'DAN="Nye ExpandIT Salgsordrer",DEU="Neue ExpandIT Verkaufsaufträge",ESP="",SVE="",FRA="Nouvelles commandes de vente ExpandIT"';
                            Caption = 'Sales Orders', Comment = 'DAN="Salgsordrer",DEU="Verkaufsaufträge",ESP="",SVE="",FRA=""';
                            Image = Document;
                            StyleExpr = ColorSales;
                            Style = Unfavorable;
                            ApplicationArea = All;
                        }
                    }


                    cuegroup("ExpandITDepartment EXP")
                    {
                        Caption = '';
                        actions
                        {
                            action("ExpDepartment")
                            {
                                RunObject = page 50089;
                                Image = TileSettings;
                                ToolTip = 'ExpandIT Department Page for Sales, Service and Setup', Comment = 'DAN="ExpandIT Department Side for Salgs, Service og Opsætning",DEU="",ESP="",SVE="",FRA="Département ExpandIT"';
                                Caption = 'ExpandIT Department', Comment = 'DAN="ExpandIT Department",DEU="",ESP="",SVE="",FRA=""';
                                ApplicationArea = All;


                                trigger OnAction()
                                begin

                                end;
                            }
                        }
                    }
                } */
    }
    var
        ColorSales: Boolean;

    trigger OnAfterGetRecord();
    begin
        if (Rec."SalesOrders EXP" > 20) then begin
            ColorSales := true;
        end;
        CurrPage.Update();
    end;
}

