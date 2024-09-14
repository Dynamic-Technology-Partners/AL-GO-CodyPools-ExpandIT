// EIS6.0.02   2020-04-15 FAM * Maintain Related Items in BC 
// EIS6.0.03  2020-07-27  FAM * Create an Item Tracking Line if SerialNo and Item Tracking Code is set for an Item.
// EIS6.0.12 2020-09-10 FAM * Get ExpandIT Setup record

/// <summary>
/// PageExtension Item_Card EXP (ID 68783) extends Record Item Card.
/// </summary>
pageextension 68783 "Item_Card EXP" extends "Item Card"
{
    // version NAVW111.00.00.19846,EIS5.04.02

    layout
    {
        addafter("Expiration Calculation")
        {
            field(EXPRequireLotNo; Rec."EXPRequireLotNo EXP")
            {
                ApplicationArea = All;
                Description = 'EIS6.0.03';
                Visible = true;
            }
            field(EXPRequireSerialNo; Rec."EXPRequireSerialNo EXP")
            {
                ApplicationArea = All;
                Description = 'EIS6.0.03';
                Visible = true;
            }
        }
        addafter("Purchasing Code")
        {
            field("DTP Master Item"; rec."DTP Master Item")
            {
                ApplicationArea = ALL;
                Visible = true;
            }
            field("DTP Variant Sort Order"; rec."DTP Variant Sort Order")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }

        //Unsupported feature: CodeModification on ""Assembly BOM"(Control 8).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        COMMIT;
        BOMComponent.SETRANGE("Parent Item No.","No.");
        PAGE.RUN(PAGE::"Assembly BOM",BOMComponent);
        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        */
        //end;
    }
    actions
    {
        addfirst(navigation)
        {
            group("&ExpandIT EXP")
            {
                Caption = '&ExpandIT', Comment = 'DAN="&ExpandIT",DEU="&ExpandIT",ESP="&ExpandIT",FRA="&ExpandIT",SVE="&ExpandIT"';
                action("Related Items EXP")
                {
                    // EIS6.0.02begin
                    Caption = 'Related Items', Comment = 'DAN="Relaterede Varer",DEU="Verbundene Artikel",ESP="productos relacionados",FRA="Articles associés",SVE="Relaterade artiklar"';
                    Image = ItemTracking;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ExpandITSetup: Record "ExpandIT Setup EXP";
                        RelatedItems: page "Related Items EXP";
                        RelatedItemsRec: Record "Related Items EXP";
                        ExpandITUtil: Codeunit "ExpandIT Util";
                    begin
                        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EIS6.0.12
                            if MaintainRelatedItemsInBC then begin
                                RelatedItemsRec.SetRange("Item No. EXP", Rec."No.");
                                RelatedItems.SetTableView(RelatedItemsRec);
                                RelatedItems.Run();
                            end else
                                Hyperlink(ExpandITSetup."Local Shop URL EXP" + '/cms/Catalog/ProductRelations');
                        end;

                    end;
                    // EIS6.0.02end
                }
            }
        }
    }

    var
        MaintainRelatedItemsInBC: Boolean;

    trigger OnOpenPage()
    // EIS6.0.02begin
    var
        ExpandITSetup: Record "ExpandIT Setup EXP";
        ExpandITUtil: Codeunit "ExpandIT Util";
    begin
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EIS6.0.12
            MaintainRelatedItemsInBC := ExpandITSetup."Maintain Rel. Items In BC EXP";
        end;

    end;
    // EIS6.0.02end

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

