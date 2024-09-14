/// <summary>
/// PageExtension Navigate EXP (ID 68784) extends Record Navigate.
/// </summary>
pageextension 68784 "Navigate EXP" extends Navigate
{
    // version NAVW111.00.00.19846,EIS5.04.05

    layout
    {

    }
    var
        EPaymentEntry: Record "e-payment Entry EXP";


    //Unsupported feature: CodeModification on "FindRecords(PROCEDURE 2)". Please convert manually.

    //procedure FindRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Window.OPEN(Text002);
    RESET;
    DELETEALL;
    #4..308
      InsertIntoDocEntry(
        DATABASE::"Cost Entry",0,CostEntry.TABLECAPTION,CostEntry.COUNT);
    end;
    OnAfterNavigateFindRecords(Rec,DocNoFilter,PostingDateFilter);
    DocExists := FINDFIRST;

    #315..476
    if UpdateForm then
      UpdateFormAfterFindRecords;
    Window.CLOSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..311
    // >> EIS5.04.05
    if EPaymentEntry.READPERMISSION then begin
      EPaymentEntry.RESET;
      EPaymentEntry.SETCURRENTKEY("Invoice No.","Payment Posting Date");
      EPaymentEntry.SETFILTER("Invoice No.",DocNoFilter);
      EPaymentEntry.SETFILTER("Payment Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"e-payment Entry",0,EPaymentEntry.TABLENAME,EPaymentEntry.COUNT);
    end;
    // << EIS5.04.05

    #312..479
    */
    //end;


    //Unsupported feature: CodeModification on "ShowRecords(PROCEDURE 6)". Please convert manually.

    //procedure ShowRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ItemTrackingSearch then
      ItemTrackingNavigateMgt.Show("Table ID")
    else
    #4..145
          PAGE.RUN(0,WarrantyLedgerEntry);
        DATABASE::"Cost Entry":
          PAGE.RUN(0,CostEntry);
      end;

    OnAfterNavigateShowRecords("Table ID",DocNoFilter,PostingDateFilter,ItemTrackingSearch);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..148
        // << EIS5.04.05
        DATABASE::"e-payment Entry":
          PAGE.RUN(0,EPaymentEntry)
        // >> EIS5.04.05
    #149..151
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

