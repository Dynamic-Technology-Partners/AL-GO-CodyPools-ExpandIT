/// <summary>
/// Codeunit EMSM Proc JobPlanning Data EXP (ID 68755).
/// </summary>
codeunit 68755 "EMSM Proc JobPlanning Data EXP"
{
    // version EMSM3.02

    // EMSM3.02     2015-09-09  PB * The new feature "Job Planning Update" implemented.


    trigger OnRun();
    begin

        ProcessJobPlanningEntries(false, true, true, true, false);
    end;

    var
        StatusDialog: Dialog;

    local procedure "-------  Job Planning  -------"();
    begin
    end;

    /// <summary>
    /// ProcessJobPlanningEntries.
    /// </summary>
    /// <param name="DoReprocessError">Boolean.</param>
    /// <param name="DoNotifyUponCompletion">Boolean.</param>
    /// <param name="DoDisplayStatus">Boolean.</param>
    /// <param name="DoProcessAllocations">Boolean.</param>
    /// <param name="DoProcessStatuses">Boolean.</param>
    procedure ProcessJobPlanningEntries(DoReprocessError: Boolean; DoNotifyUponCompletion: Boolean; DoDisplayStatus: Boolean; DoProcessAllocations: Boolean; DoProcessStatuses: Boolean);
    var
        EMSMJobPlanning: Record "EMSM JobPlanning EXP";
        arrProcessedData: array[10] of Integer;
        LTXT001: Label 'You have processed %1 JobPlanning entries with %2 errors.\You have processed %3 Allocations with %4 errors.\You have processed %5 Job Statuses with %6 errors.', Comment = 'ESP="Se ha procesado %1 entradas de planificación con %2 errores.\Se ha procesado %3 Asignaciones con %4 errores.\Se ha procesado %5 estados de trabajo con %6 errores."';
        ServiceOrderNo: Code[20];
        LineNo: Integer;
        ServiceItemLine: Record "Service Item Line";
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        LTXT002: Label 'EMSM Service Item Line (%1) specified an unknown Resource (%2).', Comment = 'ESP="Especificó un recurso desconocido (%2) para la línea de producto de servicio (%1)."';
        ResourceNo: Code[20];
        DoContinueProcessing: Boolean;
        LTXT003: Label 'Service Order not found for EMSM Service Item Line (%1).', Comment = 'ESP="Pedido de servicio no encontrado para la línea de producto de servicio (%1)."';
        LTXT004: Label 'Allocation', Comment = 'ESP="Asignación"';
        LTXT005: Label 'Order Status', Comment = 'ESP="Estado de pedido"';
        EMSMJobPlanningCounter: Integer;
        LTXT006: Label 'An error occurred when processing allocation records for (%1  |  %2  |   %3)', Comment = 'ESP="Se ha producido un error al procesar asignaciones para (%1 | %2 | %3)"';
        LTXT007: Label 'An error occurred when processing Service Order Status for (%1  |  %2  |   %3)', Comment = 'ESP="Se ha producido un error al procesar Estado Pedido de Servicio para (%1 | %2 | %3)"';
    begin

        // Setup status window, if requested.
        if (DoDisplayStatus) then begin
            CLEAR(StatusDialog);
            StatusDialog.OPEN('#10##############################################\' +
                                   ' \' +
                                   ' Entry: #1################  Of #2################\' +
                                   ' \' +
                                   ' Processing: #3################\' +
                                   ' \' +
                                   ' Current Service Order:  #4############### | Line: #5######## \');
        end;

        // Process Delete Notifications to begin with.
        //   This will ensure that all new data is starting at the same possible point as the existing data.
        if (DoDisplayStatus) then begin
            StatusDialog.UPDATE(10, 'Job Planning Delete Notification Entries');
        end;
        ProcessJobPlanningDelNoticesEx(DoReprocessError,
                                          DoNotifyUponCompletion,
                                          DoDisplayStatus,
                                          DoProcessAllocations,
                                          DoProcessStatuses,
                                          arrProcessedData);

        if (DoDisplayStatus) then begin
            StatusDialog.UPDATE(10, 'Job Planning Entries');
        end;

        arrProcessedData[1] := 0;  // Total JobPlanning Entries
        arrProcessedData[2] := 0;  // Total JobPlanning Entry errors, from any processing.
        arrProcessedData[3] := 0;  // Total Allocations Created\Updated
        arrProcessedData[4] := 0;  // Total Allocation Errors
        arrProcessedData[5] := 0;  // Total Job Statuses Created\Updated
        arrProcessedData[6] := 0;  // Total Job Status Errors
        arrProcessedData[7] := 0;  // Total JobPlanning Delete Notifications
        arrProcessedData[8] := 0;  // Total JobPlanning Delete Notification Errors
        arrProcessedData[9] := 0;  // Total JobPlanning Delete Allocation Errors
        arrProcessedData[10] := 0;  // JobPlanning Delete Status Errors

        // Set filters for the JobPlanning data that will be processed
        EMSMJobPlanning.RESET;
        EMSMJobPlanning.SETFILTER("JobPlanningType EXP", '1|3');  // Only process Service Order Allocations.  Should be inject filter too.
        if (DoReprocessError) then begin
            EMSMJobPlanning.SETFILTER("ConvertStatus EXP", '%1|%2', EMSMJobPlanning."ConvertStatus EXP"::New, EMSMJobPlanning."ConvertStatus EXP"::Error);
            // Process both New and Error JobPlanning enries
        end
        else begin
            EMSMJobPlanning.SETRANGE("ConvertStatus EXP", EMSMJobPlanning."ConvertStatus EXP"::New);  // Process only New JobPlanning enries
        end;

        EMSMJobPlanningCounter := 0;

        // Determine if any records will be processed
        if (EMSMJobPlanning.FIND('-')) then begin
            // Get count of records to be processed.
            arrProcessedData[1] := EMSMJobPlanning.COUNT;
            if (DoDisplayStatus) then begin
                StatusDialog.UPDATE(2, arrProcessedData[1]);
            end;

            repeat

                EMSMJobPlanningCounter += 1;
                DoContinueProcessing := true;
                if (DoDisplayStatus) then begin
                    StatusDialog.UPDATE(1, EMSMJobPlanningCounter);
                end;

                // First, change the status, and conversion information, of the record if needed.
                //   If the user is retrying previous error records, then set it to new here.
                if ((DoReprocessError) and (EMSMJobPlanning."ConvertStatus EXP" = EMSMJobPlanning."ConvertStatus EXP"::Error)) then begin
                    EMSMJobPlanning."ConvertStatus EXP" := EMSMJobPlanning."ConvertStatus EXP"::New;
                    EMSMJobPlanning."ConvertMessage EXP" := '';
                    EMSMJobPlanning."AllocationMessage EXP" := '';
                    EMSMJobPlanning."StatusMessage EXP" := '';
                    EMSMJobPlanning."ConvertedOn EXP" := 0DT;
                    EMSMJobPlanning."ConvertedBy EXP" := '';
                    EMSMJobPlanning.MODIFY(true);
                end;

                // Get the Service Item No, and Line No this JobPlanning entry works against.
                if (DoContinueProcessing) then begin
                    if not (GetServiceOrderNo(EMSMJobPlanning, ServiceOrderNo, LineNo, ServiceItemLine)) then begin
                        DoContinueProcessing := false;
                        EMSMJobPlanning."ConvertStatus EXP" := EMSMJobPlanning."ConvertStatus EXP"::Error;
                        EMSMJobPlanning."ConvertMessage EXP" := STRSUBSTNO(LTXT003, EMSMJobPlanning."JobPlanningGuid EXP");
                        arrProcessedData[2] += 1;
                    end;
                end;

                // Next determine the correct Resource No used on the JobPlanning entry.
                if (DoContinueProcessing) then begin
                    if not (GetResourceNo(EMSMJobPlanning, ResourceNo)) then begin
                        DoContinueProcessing := false;
                        EMSMJobPlanning."ConvertStatus EXP" := EMSMJobPlanning."ConvertStatus EXP"::Error;
                        EMSMJobPlanning."ConvertMessage EXP" := STRSUBSTNO(LTXT002, EMSMJobPlanning."JobPlanningGuid EXP", EMSMJobPlanning."UserGuid EXP");
                        arrProcessedData[2] += 1;
                    end;
                end;

                // Next, Process the requested services.
                // Currently no need to separate their processing, as an error in one shouldn't
                //   preclude the other from happening.
                if (DoContinueProcessing) then begin
                    if (DoDisplayStatus) then begin
                        StatusDialog.UPDATE(4, ServiceOrderNo);
                        StatusDialog.UPDATE(5, LineNo);
                    end;

                    // Determine if Allocations should be processed, and if so, complete this task.
                    if (DoProcessAllocations) then begin
                        if (DoDisplayStatus) then begin
                            StatusDialog.UPDATE(3, LTXT004);
                        end;

                        arrProcessedData[3] += 1;
                        // Call processing for specific Allocation.
                        if not (ProcessAllocation(EMSMJobPlanning, ServiceItemLine, ResourceNo, DoDisplayStatus, arrProcessedData)) then begin
                            // An error was met.  Increase error counter.
                            arrProcessedData[4] += 1;
                            EMSMJobPlanning."ConvertStatus EXP" := EMSMJobPlanning."ConvertStatus EXP"::Error;
                            EMSMJobPlanning."AllocationMessage EXP" := STRSUBSTNO(LTXT006,
                                                                           EMSMJobPlanning."JobPlanningGuid EXP",
                                                                           ServiceOrderNo,
                                                                           LineNo);
                        end;
                    end;

                    // Determine if Statuses should be processed, and if so, complete this task.
                    if (DoProcessStatuses) then begin
                        if (DoDisplayStatus) then begin
                            StatusDialog.UPDATE(3, LTXT004);
                        end;

                        arrProcessedData[5] += 1;
                        // Call processing for specific Status.
                        if not (ProcessJobStatus(EMSMJobPlanning, ServiceItemLine, ResourceNo, DoDisplayStatus, arrProcessedData)) then begin
                            // An error was met.  Increase error counter.
                            arrProcessedData[6] += 1;
                            EMSMJobPlanning."ConvertStatus EXP" := EMSMJobPlanning."ConvertStatus EXP"::Error;
                            EMSMJobPlanning."StatusMessage EXP" := STRSUBSTNO(LTXT007,
                                                                       EMSMJobPlanning."JobPlanningGuid EXP",
                                                                       ServiceOrderNo,
                                                                       LineNo);
                        end;

                    end;
                end;

                // If JobPlanning line hasn't been marked as error, then mark as error.
                if (EMSMJobPlanning."ConvertStatus EXP" <> EMSMJobPlanning."ConvertStatus EXP"::Error) then begin
                    EMSMJobPlanning."ConvertStatus EXP" := EMSMJobPlanning."ConvertStatus EXP"::Converted;
                end;
                MarkJobPlanningRecord(EMSMJobPlanning);

            until EMSMJobPlanning.NEXT = 0;

        end;

        // Processing complete.  Close status, if requested.
        if (DoDisplayStatus) then begin
            StatusDialog.CLOSE();
        end;

        // Notify user of completion if notification has been requested
        if (DoNotifyUponCompletion) then begin
            MESSAGE(LTXT001,
                    arrProcessedData[1],
                    arrProcessedData[2],
                    arrProcessedData[3],
                    arrProcessedData[4],
                    arrProcessedData[5],
                    arrProcessedData[6]);
        end;


        // Delete all "EMSM JobPlanning" and "EMSM JobPlanning Delete Notice" records.
        //   When the "EMSM JobPlanning" records is deleted, a new version of the record will appear again if the
        //   JobPlanning entry is changed. If the entry is changed, the ConvertStatus is new (again).
        DeleteAllIncomming;
    end;

    local procedure ProcessAllocation(var EMSMJobPlanning: Record "EMSM JobPlanning EXP"; var ServiceItemLine: Record "Service Item Line"; ResourceNo: Code[20]; DoDisplayStatus: Boolean; var arrProcessed: array[10] of Integer): Boolean;
    var
        ServiceOrderAllocation: Record "Service Order Allocation";
    begin

        // If the type of JobPlanning is other than 1 or 3 then mark as ignored.
        if ((EMSMJobPlanning."JobPlanningType EXP" <> 1) and (EMSMJobPlanning."JobPlanningType EXP" <> 3)) then begin
            EMSMJobPlanning."AllocationMessage EXP" := 'JobPlanning entry ignored due to JobPlanning Type.';
            EMSMJobPlanning.MODIFY(true);
            exit;
        end;

        // If the Allocation is for a Department, and not user then mark as ignored.
        if (EMSMJobPlanning."UserType EXP" = 'DEPARTMENT') then begin
            EMSMJobPlanning."AllocationMessage EXP" := 'JobPlanning entry ignored due to User Type of DEPARTMENT.';
            EMSMJobPlanning.MODIFY(true);
            exit;
        end;

        // Delete any existing allocation for this user.
        //   Doesn't matter if the allocation is 'active' or 'non-active', we will add an 'active' one later.
        CLEAR(ServiceOrderAllocation);
        ServiceOrderAllocation.SetHideDialog(true);
        ServiceOrderAllocation.INIT;
        ServiceOrderAllocation.SETCURRENTKEY(Status, "Document Type", "Document No.", "Service Item Line No.");
        ServiceOrderAllocation.SETRANGE("Document Type", ServiceItemLine."Document Type");
        ServiceOrderAllocation.SETRANGE("Document No.", ServiceItemLine."Document No.");
        ServiceOrderAllocation.SETRANGE("Service Item Line No.", ServiceItemLine."Line No.");
        ServiceOrderAllocation.SETRANGE("Resource No.", ResourceNo);
        ServiceOrderAllocation.DELETEALL(true);
        // Set any 'active' allocation to 'non-active'.
        //   Only one allocation can be active, and that will be this allocation.
        CLEAR(ServiceOrderAllocation);
        ServiceOrderAllocation.SetHideDialog(true);
        ServiceOrderAllocation.INIT;
        ServiceOrderAllocation.SETCURRENTKEY(Status, "Document Type", "Document No.", "Service Item Line No.");
        ServiceOrderAllocation.SETRANGE(Status, ServiceOrderAllocation.Status::Active);
        ServiceOrderAllocation.SETRANGE("Document Type", ServiceItemLine."Document Type");
        ServiceOrderAllocation.SETRANGE("Document No.", ServiceItemLine."Document No.");
        ServiceOrderAllocation.SETRANGE("Service Item Line No.", ServiceItemLine."Line No.");
        ServiceOrderAllocation.MODIFYALL("Allocation Date", 0D, true);
        ServiceOrderAllocation.MODIFYALL(Status, ServiceOrderAllocation.Status::Nonactive, true);

        // Insert new Allocation and set to 'active'
        CLEAR(ServiceOrderAllocation);
        ServiceOrderAllocation.SetHideDialog(true);
        ServiceOrderAllocation.INIT;
        ServiceOrderAllocation.Status := ServiceOrderAllocation.Status::Nonactive;
        ServiceOrderAllocation.VALIDATE("Document Type", ServiceItemLine."Document Type");
        ServiceOrderAllocation.VALIDATE("Document No.", ServiceItemLine."Document No.");
        ServiceOrderAllocation.VALIDATE("Service Item Line No.", ServiceItemLine."Line No.");
        ServiceOrderAllocation.VALIDATE("Resource No.", ResourceNo);
        ServiceOrderAllocation.INSERT(true);
        ServiceOrderAllocation.VALIDATE("Allocation Date", EMSMJobPlanning."StartDate EXP");
        ServiceOrderAllocation.MODIFY(true);
        // This code will fail if the time is spread across multiple days.
        ServiceOrderAllocation.VALIDATE("Allocated Hours",
                                (EMSMJobPlanning."FinishTime EXP" - EMSMJobPlanning."StartTime EXP") / (60 * 60 * 1000));
        ServiceOrderAllocation.VALIDATE("Starting Time", EMSMJobPlanning."StartTime EXP");
        ServiceOrderAllocation.VALIDATE("Finishing Time", EMSMJobPlanning."FinishTime EXP");
        ServiceOrderAllocation.VALIDATE(Status, ServiceOrderAllocation.Status::Active);
        ServiceOrderAllocation.MODIFY(true);

        exit(true);
    end;

    local procedure ProcessJobStatus(var EMSMJobPlanning: Record "EMSM JobPlanning EXP"; var ServiceItemLine: Record "Service Item Line"; ResourceNo: Code[20]; DoDisplayStatus: Boolean; var arrProcessed: array[2] of Integer): Boolean;
    begin

        ERROR('Processing Job Status is not available');
    end;

    local procedure "-------  Job Planning Delete N"();
    begin
    end;

    /// <summary>
    /// ProcessJobPlanningDeleteNotice.
    /// </summary>
    /// <param name="DoReprocessError">Boolean.</param>
    /// <param name="DoNotifyUponCompletion">Boolean.</param>
    /// <param name="DoDisplayStatus">Boolean.</param>
    /// <param name="DoProcessAllocationNotices">Boolean.</param>
    /// <param name="DoProcessStatusNotices">Boolean.</param>
    procedure ProcessJobPlanningDeleteNotice(DoReprocessError: Boolean; DoNotifyUponCompletion: Boolean; DoDisplayStatus: Boolean; DoProcessAllocationNotices: Boolean; DoProcessStatusNotices: Boolean);
    var
        arrProcessedData: array[10] of Integer;
        LTXT001: Label 'You have processed %1 JobPlanning Delete Notifications entries with %2 errors.\You received %3 Allocations errors.\You have received %4 Job Status errors.', Comment = 'ESP="Se ha procesado %1 entradas de Notificaciones de borrado de planificaciones con %2 errores.\Recibiste %3 errores de asignación.\Recibiste %4 errores de estado del trabajo."';
    begin

        // This function is called when processing Delete Notifications is wanted from an outside request.
        //   One that is not in conjunction with a call from ProcessJobPlanningEntries()
        //   All this function does differently from ProcessJobPlanningDelNoticesEx() is provide
        //   user notifications if they have been requested.

        arrProcessedData[1] := 0;  // Left Unused
        arrProcessedData[2] := 0;  // Left Unused
        arrProcessedData[3] := 0;  // Left Unused
        arrProcessedData[4] := 0;  // Left Unused
        arrProcessedData[5] := 0;  // Left Unused
        arrProcessedData[6] := 0;  // Left Unused
        arrProcessedData[7] := 0;  // Total JobPlanning Delete Notifications
        arrProcessedData[8] := 0;  // Total JobPlanning Delete Notification Errors
        arrProcessedData[9] := 0;  // Total JobPlanning Delete Allocation Errors
        arrProcessedData[10] := 0;  // JobPlanning Delete Status Errors


        // Setup status window, if requested.
        if (DoDisplayStatus) then begin
            CLEAR(StatusDialog);
            StatusDialog.OPEN('Job Planning Delete Notices \' +
                                   ' \' +
                                   ' Entry: #1################  Of #2################\' +
                                   ' \' +
                                   ' Processing: #3################\' +
                                   ' \' +
                                   ' Current Service Order:  #4############### | Line: #5######## \');
        end;

        ProcessJobPlanningDelNoticesEx(DoReprocessError,
                                          DoNotifyUponCompletion,
                                          DoDisplayStatus,
                                          DoProcessAllocationNotices,
                                          DoProcessStatusNotices,
                                          arrProcessedData);

        // Processing complete.  Close status, if requested.
        if (DoDisplayStatus) then begin
            StatusDialog.CLOSE();
        end;

        // Notify user of completion if notification has been requested
        if (DoNotifyUponCompletion) then begin
            MESSAGE(LTXT001,
                    arrProcessedData[7],
                    arrProcessedData[8],
                    arrProcessedData[9],
                    arrProcessedData[10]);
        end;
    end;

    local procedure ProcessJobPlanningDelNoticesEx(DoReprocessError: Boolean; DoNotifyUponCompletion: Boolean; DoDisplayStatus: Boolean; DoProcessAllocationNotices: Boolean; DoProcessStatusNotices: Boolean; var arrProcessedData: array[10] of Integer);
    var
        EMSMJobPlanning: Record "EMSM JobPlanning EXP";
        EMSMJobPlanningDeleteNotice: Record "EMSM JobPln Delete Notice EXP";
        ServiceOrderNo: Code[20];
        LineNo: Integer;
        ServiceItemLine: Record "Service Item Line";
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
        ResourceNo: Code[20];
        DoContinueProcessing: Boolean;
        EMSMJobPlanningCounter: Integer;
        LTXT001: Label 'You have processed %1 JobPlanning entries with %2 errors.\You have processed %3 Allocations with %4 errors.\You have processed %5 Job Statuses with %6 errors.', Comment = 'ESP="Se ha procesado %1 entradas de planificación con %2 errores.\Se ha procesado %3 Asignaciones con %4 errores.\Se ha procesado %5 estados de trabajo con %6 errores."';
        LTXT002: Label 'EMSM Service Item Line (%1) specified an unknown Resource (%2).', Comment = 'ESP="Especificó un recurso desconocido (%2) para la línea de producto de servicio (%1)."';
        LTXT003: Label 'Service Order not found for Job Planning Guid (%1).', Comment = 'ESP="Pedido de servicio no encontrado para la clave de planificación de trabajo (%1)."';
        LTXT004: Label 'Allocation Notices', Comment = 'ESP="Avisos de asignaciones"';
        LTXT005: Label 'Order Status Notices', Comment = 'ESP="Avisos de estado de pedido"';
        LTXT006: Label 'An error occurred when processing allocation delete notification records for (%1  |  %2  |   %3)', Comment = 'ESP="Se ha producido un error al procesar el borrado de  asignaciones para (%1 | %2 | %3)."';
        LTXT007: Label 'An error occurred when processing Service Order Status delete notification for (%1  |  %2  |   %3)', Comment = 'ESP="Se ha producido un error al procesar el borrado del Estado de Pedido de Servicio para (%1 | %2 | %3)."';
    begin

        if (DoReprocessError) then begin
            EMSMJobPlanningDeleteNotice.SETFILTER("ConvertStatus EXP", '%1|%2', EMSMJobPlanningDeleteNotice."ConvertStatus EXP"::New,
        EMSMJobPlanningDeleteNotice."ConvertStatus EXP"::Error);  // Process both New and Error JobPlanning enries
        end
        else begin
            EMSMJobPlanningDeleteNotice.SETRANGE("ConvertStatus EXP", EMSMJobPlanningDeleteNotice."ConvertStatus EXP"::New);
            // Process only New JobPlanning enries
        end;

        if (EMSMJobPlanningDeleteNotice.FIND('-')) then begin

            if (DoDisplayStatus) then begin
                StatusDialog.UPDATE(2, EMSMJobPlanningDeleteNotice.COUNT);
            end;

            repeat

                EMSMJobPlanningCounter += 1;
                DoContinueProcessing := true;
                if (DoDisplayStatus) then begin
                    StatusDialog.UPDATE(1, EMSMJobPlanningCounter);
                end;


                if (EMSMJobPlanning.GET(EMSMJobPlanningDeleteNotice."JobPlanningGuid EXP")) then begin
                    // You now have the original JobPlanning entry.

                    // Get the Service Item No, and Line No this JobPlanning entry works against.
                    if (DoContinueProcessing) then begin
                        if not (GetServiceOrderNo(EMSMJobPlanning, ServiceOrderNo, LineNo, ServiceItemLine)) then begin
                            DoContinueProcessing := false;
                            EMSMJobPlanningDeleteNotice."ConvertStatus EXP" := EMSMJobPlanningDeleteNotice."ConvertStatus EXP"::Error;
                            EMSMJobPlanningDeleteNotice."ConvertMessage EXP" := STRSUBSTNO(LTXT003, EMSMJobPlanning."JobPlanningGuid EXP");
                            arrProcessedData[8] += 1;
                        end;
                    end;

                    // Next determine the correct Resource No used on the JobPlanning entry.
                    if (DoContinueProcessing) then begin
                        if not (GetResourceNo(EMSMJobPlanning, ResourceNo)) then begin
                            DoContinueProcessing := false;
                            EMSMJobPlanningDeleteNotice."ConvertStatus EXP" := EMSMJobPlanningDeleteNotice."ConvertStatus EXP"::Error;
                            EMSMJobPlanningDeleteNotice."ConvertMessage EXP" :=
                              STRSUBSTNO(LTXT002, EMSMJobPlanning."JobPlanningGuid EXP",
                              EMSMJobPlanning."UserGuid EXP");
                            arrProcessedData[8] += 1;
                        end;
                    end;

                    if (DoContinueProcessing) then begin
                        if (DoDisplayStatus) then begin
                            StatusDialog.UPDATE(4, ServiceOrderNo);
                            StatusDialog.UPDATE(5, LineNo);
                        end;

                        // Determine if Allocation Notices should be processed, and if so, complete this task.
                        if (DoProcessAllocationNotices) then begin
                            if (DoDisplayStatus) then begin
                                StatusDialog.UPDATE(3, LTXT004);
                            end;

                            // Call processing for specific Allocation.
                            if not (ProcessAllocationDeleteNotice(EMSMJobPlanning, ServiceItemLine, ResourceNo)) then begin
                                // An error was met.  Increase error counter.
                                arrProcessedData[9] += 1;
                                EMSMJobPlanning."ConvertStatus EXP" := EMSMJobPlanning."ConvertStatus EXP"::Error;
                                EMSMJobPlanning."AllocationMessage EXP" := STRSUBSTNO(LTXT006,
                                                                               EMSMJobPlanning."JobPlanningGuid EXP",
                                                                               ServiceOrderNo,
                                                                               LineNo);
                            end;
                        end;

                        // Determine if Status Notices should be processed, and if so, complete this task.
                        if (DoProcessStatusNotices) then begin
                            if (DoDisplayStatus) then begin
                                StatusDialog.UPDATE(3, LTXT004);
                            end;

                            // Call processing for specific Status.
                            if not (ProcessJobStatusDeleteNotice(EMSMJobPlanning, ServiceItemLine, ResourceNo)) then begin
                                // An error was met.  Increase error counter.
                                arrProcessedData[10] += 1;
                                EMSMJobPlanning."ConvertStatus EXP" := EMSMJobPlanning."ConvertStatus EXP"::Error;
                                EMSMJobPlanning."StatusMessage EXP" := STRSUBSTNO(LTXT007,
                                                                           EMSMJobPlanning."JobPlanningGuid EXP",
                                                                           ServiceOrderNo,
                                                                           LineNo);
                            end;
                        end;

                    end;

                end
                else begin
                    // Not an issue if JobPlanning entry not found.
                    //   Entry could have been deleted before it ever got injected.
                    //   Just mark to ignore, and move on.
                    EMSMJobPlanningDeleteNotice."ConvertStatus EXP" := EMSMJobPlanningDeleteNotice."ConvertStatus EXP"::Ignored;
                end;

                // If JobPlanning Delete Notification hasn't been marked as error, or ignored, then mark as converted.
                if (EMSMJobPlanningDeleteNotice."ConvertStatus EXP" <> EMSMJobPlanningDeleteNotice."ConvertStatus EXP"::Error) then begin
                    EMSMJobPlanningDeleteNotice."ConvertStatus EXP" := EMSMJobPlanningDeleteNotice."ConvertStatus EXP"::Converted;
                end;
                MarkJobPlanningDeleteNoticeRec(EMSMJobPlanningDeleteNotice);

            until EMSMJobPlanningDeleteNotice.NEXT = 0;
        end;
    end;

    local procedure ProcessAllocationDeleteNotice(var EMSMJobPlanning: Record "EMSM JobPlanning EXP"; var ServiceItemLine: Record "Service Item Line"; ResourceNo: Code[20]): Boolean;
    var
        ServiceOrderAllocation: Record "Service Order Allocation";
        DoSetAnotherActive: Boolean;
    begin

        // Simply delete entry for user, and Service Order, if it exists.
        //   In this case, even if it doesn't exist, that isn't an error, as we come to the same end state.
        //   In the future it may be wanted to mark the Allocation as cancelled, and not just delete it.
        //   If so, here is where that change is made.
        ServiceOrderAllocation.SetHideDialog(true);
        ServiceOrderAllocation.SETCURRENTKEY(Status, "Document Type", "Document No.", "Service Item Line No.");
        ServiceOrderAllocation.SETRANGE("Document Type", ServiceItemLine."Document Type");
        ServiceOrderAllocation.SETRANGE("Document No.", ServiceItemLine."Document No.");
        ServiceOrderAllocation.SETRANGE("Service Item Line No.", ServiceItemLine."Line No.");
        ServiceOrderAllocation.SETRANGE("Resource No.", ResourceNo);
        // We need to know if any records exist under this filter so that we can determine if they are an active allocation.
        //   We only need to find first, as there should only ever be one allocation.
        if (ServiceOrderAllocation.FIND('-')) then begin
            DoSetAnotherActive := (ServiceOrderAllocation.Status = ServiceOrderAllocation.Status::Active);
        end;
        ServiceOrderAllocation.DELETEALL(true);

        ServiceOrderAllocation.RESET;
        ServiceOrderAllocation.SetHideDialog(true);
        if (DoSetAnotherActive) then begin
            ServiceOrderAllocation.SETCURRENTKEY(Status, "Document Type", "Document No.", "Service Item Line No.");
            ServiceOrderAllocation.SETRANGE("Document Type", ServiceItemLine."Document Type");
            ServiceOrderAllocation.SETRANGE("Document No.", ServiceItemLine."Document No.");
            ServiceOrderAllocation.SETRANGE("Service Item Line No.", ServiceItemLine."Line No.");
            ServiceOrderAllocation.SETFILTER("Resource No.", '<>%1', '');
            if (ServiceOrderAllocation.FIND('-')) then begin
                ServiceOrderAllocation.Status := ServiceOrderAllocation.Status::Active;
                ServiceOrderAllocation.MODIFY(true);
            end;
        end;
    end;

    local procedure ProcessJobStatusDeleteNotice(var EMSMJobPlanning: Record "EMSM JobPlanning EXP"; var ServiceItemLine: Record "Service Item Line"; ResourceNo: Code[20]): Boolean;
    begin

        ERROR('Processing Job Status Delete Notice is not available');
    end;

    local procedure "-------  Common Functions  ---"();
    begin
    end;

    local procedure GetServiceOrderNo(var EMSMJobPlanning: Record "EMSM JobPlanning EXP"; var ServiceOrderNo: Code[20]; var intServiceOrderLineNo: Integer; var ServiceItemLine: Record "Service Item Line"): Boolean;
    var
        EMSMServiceItemLine: Record "EMSM Service Item Line EXP";
    begin

        ServiceOrderNo := '';
        intServiceOrderLineNo := -1;

        if (EMSMJobPlanning."JobPlanningType EXP" = 1) then begin
            ServiceOrderNo := SELECTSTR(1, CONVERTSTR(EMSMJobPlanning."Guid_X EXP", '_', ','));
            EVALUATE(intServiceOrderLineNo, SELECTSTR(2, CONVERTSTR(EMSMJobPlanning."Guid_X EXP", '_', ',')));
        end
        else begin
            EMSMServiceItemLine.RESET;
            EMSMServiceItemLine.SETFILTER("Order No. EXP", EMSMJobPlanning."Guid_X EXP");
            EMSMServiceItemLine.SETFILTER("Service Header Guid EXP", '<>%1', '');
            if EMSMServiceItemLine.FIND('+') then begin
                ServiceOrderNo := EMSMServiceItemLine."Service Header Guid EXP";
                intServiceOrderLineNo := 10000;
            end;
        end;

        exit(ServiceItemLine.GET(ServiceItemLine."Document Type"::Order, ServiceOrderNo, intServiceOrderLineNo));
    end;

    local procedure GetResourceNo(var EMSMJobPlanning: Record "EMSM JobPlanning EXP"; var ResourceNo: Code[20]): Boolean;
    var
        Resource: Record Resource;
        Employee: Record Employee;
    begin

        ResourceNo := '';

        if (Resource.GET(EMSMJobPlanning."UserGuid EXP")) then begin
            ResourceNo := EMSMJobPlanning."UserGuid EXP";
        end
        else begin
            if (Employee.GET(EMSMJobPlanning."UserGuid EXP")) then begin
                if (Employee."Resource No." <> '') then begin
                    ResourceNo := Employee."Resource No.";
                end;
            end;
        end;

        if (ResourceNo = '') then begin
            exit(false);
        end
        else begin
            exit(true);
        end;
    end;

    local procedure MarkJobPlanningRecord(var EMSMJobPlanning: Record "EMSM JobPlanning EXP");
    begin

        EMSMJobPlanning."ConvertedOn EXP" := CURRENTDATETIME;
        EMSMJobPlanning."ConvertedBy EXP" := USERID;
        EMSMJobPlanning.MODIFY(true);
    end;

    local procedure MarkJobPlanningDeleteNoticeRec(var EMSMJobPlanningDeleteNotice: Record "EMSM JobPln Delete Notice EXP");
    begin

        EMSMJobPlanningDeleteNotice."ConvertedOn EXP" := CURRENTDATETIME;
        EMSMJobPlanningDeleteNotice."ConvertedBy EXP" := USERID;
        EMSMJobPlanningDeleteNotice.MODIFY(true);
    end;

    /// <summary>
    /// DeleteAllIncomming.
    /// </summary>
    procedure DeleteAllIncomming();
    var
        EMSMJobPlanning: Record "EMSM JobPlanning EXP";
        EMSMJobPlanningDeleteNotice: Record "EMSM JobPln Delete Notice EXP";
    begin
        // Delete all "EMSM JobPlanning" and "EMSM JobPlanning Delete Notice" records.
        //   When the "EMSM JobPlanning" records is deleted, a new version of the record will appear again if the
        //   JobPlanning entry is changed. If the entry is changed, the ConvertStatus is new (again).
        CLEAR(EMSMJobPlanning);
        EMSMJobPlanning.DELETEALL;
        CLEAR(EMSMJobPlanningDeleteNotice);
        EMSMJobPlanningDeleteNotice.DELETEALL;
    end;
}

