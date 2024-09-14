/// <summary>
/// Codeunit Create Web Payment (ID 68720).
/// </summary>
codeunit 68720 "Create Web Payment"
{
    TableNo = "Web Invoice Payment";
    trigger OnRun()
    var
        TXT001: Label 'Payment for Inv. %1 on Job %2';
        TXT002: Label 'Portal Transaction: %1 for Customer: %2';
        TXT003: Label 'Merchant Fee for Portal Transaction: %1';
        PaymentTotal: Decimal;
    begin
        SalesSetup.Get();
        GenJnlLine.SetRange("Journal Template Name", SalesSetup."Web Payment Jnl. Template");
        GenJnlLine.SetRange("Journal Batch Name", SalesSetup."Web Payment Jnl. Batch");

        if not GenJnlLine.FindLast() then
            LastLineNo := 0
        else
            LastLineNo := GenJnlLine."Line No.";

        GenJnlLine."Journal Template Name" := SalesSetup."Web Payment Jnl. Template";


        GenJnlLine."Journal Template Name" := SalesSetup."Web Payment Jnl. Template";
        GenJnlLine."Journal Batch Name" := SalesSetup."Web Payment Jnl. Batch";
        LastLineNo += 10000;
        GenJnlLine."Line No." := LastLineNo;
        Rec.CALCFIELDS("Payment Date");
        GenJnlLine."Posting Date" := Rec."Payment Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := copystr(Rec."Transaction ID", 3);
        GenJnlLine."Account Type" := SalesSetup."Web Payment Bal. A/C Type";
        GenJnlLine."Account No." := SalesSetup."Web Payment Bal. A/C No.";
        GenJnlLine.Description := STRSUBSTNO(TXT002, rec."Transaction ID",
                                                        rec."Customer No.");
        GenJnlLine.Amount := Rec."Paid Amount";
        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", 'CORPORATE');
        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", 'CORPORATE');

        PaymentTotal := rec."Paid Amount";

        CreateJnlLine(GenJnlLine);
        Rec."Status Exp" := Rec."Status Exp"::Converted;
        Rec.MODIFY;

        WebPaymentEntry.SETRANGE("Payment Transaction ID", Rec."Transaction ID");
        WebPaymentEntry.FINDSET();

        REPEAT
            CLEAR(GenJnlLine);
            GenJnlLine."Journal Template Name" := SalesSetup."Web Payment Jnl. Template";
            GenJnlLine."Journal Batch Name" := SalesSetup."Web Payment Jnl. Batch";
            LastLineNo += 10000;
            GenJnlLine."Line No." := LastLineNo;
            GenJnlLine."Posting Date" := Rec."Payment Date";
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No." := CopyStr(WebPaymentEntry."Payment Transaction ID", 3);
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
            GenJnlLine."Account No." := WebPaymentEntry."Customer No.";
            GenJnlLine.Amount := -WebPaymentEntry."Invoice Paid Amount";
            PaymentTotal := PaymentTotal - WebPaymentEntry."Invoice Paid Amount";
            GenJnlLine.Description := STRSUBSTNO(TXT001, WebPaymentEntry."Invoice No.",
                                                        WebPaymentEntry."Job No. EXP");
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := WebPaymentEntry."Invoice No.";
            if job.Get(WebPaymentEntry."Job No. EXP") then begin
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", Job."Global Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", Job."Global Dimension 2 Code");
            end;

            CreateJnlLine(GenJnlLine);
            WebPaymentEntry."Status Exp" := WebPaymentEntry."Status Exp"::Converted;
            WebPaymentEntry.MODIFY;
        UNTIL WebPaymentEntry.NEXT = 0;
        if PaymentTotal > 0 then begin
            CLEAr(GenJnlLine);
            GenJnlLine."Journal Template Name" := SalesSetup."Web Payment Jnl. Template";
            GenJnlLine."Journal Batch Name" := SalesSetup."Web Payment Jnl. Batch";
            LastLineNo += 10000;
            GenJnlLine."Line No." := LastLineNo;
            Rec.CALCFIELDS("Payment Date");
            GenJnlLine."Posting Date" := Rec."Payment Date";
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No." := copystr(Rec."Transaction ID", 3);
            GenJnlLine."Account Type" := SalesSetup."Merchant Fee A/C Type";
            GenJnlLine."Account No." := SalesSetup."Merchant Fee A/C No.";
            GenJnlLine.Description := STRSUBSTNO(TXT003, rec."Transaction ID");
            GenJnlLine.Amount := -PaymentTotal;
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", 'CORPORATE');
            GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", 'CORPORATE');

            CreateJnlLine(GenJnlLine);
        end;

        COMMIT;
        GenJnlLine.SETRANGE("Journal Template Name", SalesSetup."Web Payment Jnl. Template");
        GenJnlLine.SETRANGE("Journal Batch Name", SalesSetup."Web Payment Jnl. Batch");

        //GenJnlPost.
        //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

        //StartSession(SessionId, CODEUNIT::"Gen. Jnl.-Post", CompanyName, GenJnlLine);

        IF GUIALLOWED THEN
            MESSAGE('Cash Receipt Journal for this entry has been created.');

    end;

    var
        WebPaymentEntry: Record "Web Invoice Payment Entry";
        SalesSetup: Record "ExpandIT Setup EXP";
        LastLineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        HideDialog: Boolean;
        Job: Record Job;

    /// <summary>
    /// CreateJnlLine.
    /// </summary>
    /// <param name="GenJnlLine">Record "Gen. Journal Line".</param>
    procedure CreateJnlLine(GenJnlLine: Record "Gen. Journal Line")
    var
        GenJnlLine2: Record "Gen. Journal Line";
    begin
        GenJnlLine2."Journal Template Name" := GenJnlLine."Journal Template Name";
        GenJnlLine2."Journal Batch Name" := GenJnlLine."Journal Batch Name";
        GenJnlLine2."Line No." := GenJnlLine."Line No.";
        GenJnlLine2.INSERT(TRUE);
        GenJnlLine2.VALIDATE("Posting Date", GenJnlLine."Posting Date");
        GenJnlLine2.VALIDATE("Document Type", GenJnlLine."Document Type");
        GenJnlLine2.VALIDATE("Document No.", GenJnlLine."Document No.");
        GenJnlLine2.VALIDATE("Account Type", GenJnlLine."Account Type");
        GenJnlLine2.VALIDATE("Account No.", GenJnlLine."Account No.");
        GenJnlLine2.VALIDATE(Amount, GenJnlLine.Amount);
        GenJnlLine2.Validate("Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine2.Validate("Shortcut Dimension 2 Code", GenJnlLine."Shortcut Dimension 2 Code");

        IF GenJnlLine."Applies-to Doc. Type" <> GenJnlLine."Applies-to Doc. Type"::" " THEN
            GenJnlLine2.VALIDATE("Applies-to Doc. Type", GenJnlLine."Applies-to Doc. Type");
        IF GenJnlLine."Applies-to Doc. No." <> '' THEN
            GenJnlLine2.VALIDATE("Applies-to Doc. No.", GenJnlLine."Applies-to Doc. No.");

        GenJnlLine2.Description := GenJnlLine.Description;

        GenJnlLine2.MODIFY(TRUE);
    end;

    /// <summary>
    /// SetHideDialog.
    /// </summary>
    /// <param name="pHideDialog">Boolean.</param>
    procedure SetHideDialog(pHideDialog: Boolean)
    begin
        HideDialog := pHideDialog;
    end;

}
