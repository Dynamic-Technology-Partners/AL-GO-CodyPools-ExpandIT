// EMSM13.0.6.45 2020-04-02 FAM * ExpandIT attachment functionality is implemented
// EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record 
/// <summary>
/// PageExtension Service_Order EXP (ID 68792) extends Record Service Order.
/// </summary>
pageextension 68792 "Service_Order EXP" extends "Service Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(processing)
        {
            action("Open In ExpandIT EXP")
            {
                Caption = 'Open in ExpandIT', comment = 'ESP="", DAN="Åbn i ExpandIT", DEU="", SVE="", FRA=""';
                ToolTip = 'Opens BAS Edit Order with the list of all attachments, comments and etc. for this order', comment = 'DAN="Åbner BAS Edit Order med en liste over alle de vedhæftninger, kommentarer osv. der er til denne ordre.", ESP="", DEU="", SVE="", FRA=""';
                Visible = ShowExpandITAttachmentMenu;
                ApplicationArea = All;
                Image = Attachments;

                trigger OnAction()
                var
                    ExpandITSetup: Record "ExpandIT Setup EXP";
                    EMSMServiceITemLine: Record "EMSM Service Item Line EXP";
                begin
                    if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
                        EMSMServiceITemLine.SetRange("Service Header Guid EXP", Rec."No.");
                        if EMSMServiceITemLine.FindFirst() then begin
                            Hyperlink(ExpandITUtil.TrimExpandITURL(ExpandITSetup."ExpandIT URL EXP") + 'Modules/emsm_NewServiceOrder/NewServiceOrder.asp?ServiceOrderGuid=' + EMSMServiceITemLine."Order No. EXP");
                        end else begin
                            EMSMServiceITemLine.SetRange("Order No. EXP", Rec."No.");
                            if EMSMServiceITemLine.FindFirst() then
                                Hyperlink(ExpandITUtil.TrimExpandITURL(ExpandITSetup."ExpandIT URL EXP") + 'Modules/emsm_NewServiceOrder/NewServiceOrder.asp?ServiceOrderGuid=' + EMSMServiceITemLine."Order No. EXP");
                        end;
                    end;
                end;
            }

        }
    }

    var
        ExpandITSetup: Record "ExpandIT Setup EXP";
        ShowExpandITAttachmentMenu: Boolean;
        ExpandITUtil: Codeunit "ExpandIT Util";

    trigger OnAfterGetRecord()
    begin
        // EMSM18.0.6.134 begin
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
            if ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Service Order" then begin
                ShowExpandITAttachmentMenu := true;
            end else
                ShowExpandITAttachmentMenu := false;
            // EMSM18.0.6.134 end
        end;

    end;
}