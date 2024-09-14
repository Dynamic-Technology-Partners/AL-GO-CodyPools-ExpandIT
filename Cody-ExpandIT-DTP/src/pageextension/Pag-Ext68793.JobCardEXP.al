// EMSM18.0.6.45 2020-04-02 FAM * ExpandIT attachment functionality is implemented
// EMSM18.0.6.134 2020-07-07 FAM * Bug fixed - missing ExpandIT Setup
// EMSM18.0.6.155 2020-09-10 FAM * Get ExpandIT Setup record 
/// <summary>
/// PageExtension Job_Card EXP (ID 68793) extends Record Job Card.
/// </summary>
pageextension 68793 "Job_Card EXP" extends "Job Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addfirst(processing)
        {
            action("Open In ExpandIT EXP")
            {
                Caption = 'Open in ExpandIT', comment = 'ESP="", DAN="Åbn i ExpandIT", DEU="", SVE="", FRA=""';
                ToolTip = 'Opens ExpandIT Service Orders, which are bound to this job', comment = 'DAN="Åbner ExpandIT Serviceordrer, der er knyttet til denne sag.", ESP="", DEU="", SVE="", FRA="Ordre de service ExpandIT"';
                Visible = ShowExpandITAttachmentMenu;
                ApplicationArea = All;
                Image = Attachments;


                trigger OnAction()
                var
                    ExpandITSetup: Record "ExpandIT Setup EXP";
                    EMSMServiceITemLine: Record "EMSM Service Item Line EXP";
                    EMSMServiceOrders: Page "EMSM Incoming Serv Orders EXP";
                    ExpandITUtil: Codeunit "ExpandIT Util";
                begin
                    if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
                        EMSMServiceITemLine.Setrange("Job No. EXP", Rec."No.");
                        EMSMServiceITemLine.Setrange("Line No. EXP", 0);
                        if EMSMServiceITemLine.FindFirst() then begin
                            EMSMServiceOrders.SetTableView(EMSMServiceITemLine);
                            EMSMServiceOrders.Editable := false;
                            EMSMServiceOrders.Run();
                            CurrPage.UPDATE;
                        end else begin
                            Message(ExpandITWorkOrdersNotFound);
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
        ExpandITWorkOrdersNotFound: Label 'There are no ExpandIT Work Orders bound to this job.', comment = 'ESP="", DAN="Der er ingen ExpandIT Ordrer, der er tilknyttet denne sag.", DEU="", SVE="", FRA="Il n''y a pas d''ordre de travail ExpandIT liés à cette tâches."';

    trigger OnAfterGetRecord()
    begin
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EMSM18.0.6.155
            if ExpandITSetup."Conversion Rule EXP" = ExpandITSetup."Conversion Rule EXP"::"Prefer Jobs" then
                ShowExpandITAttachmentMenu := true
            else
                ShowExpandITAttachmentMenu := false;
        end;

    end;
}