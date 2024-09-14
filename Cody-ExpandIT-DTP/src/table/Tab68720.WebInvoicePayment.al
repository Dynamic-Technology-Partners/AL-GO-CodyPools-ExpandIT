/// <summary>
/// Table Web Invoice Payment (ID 68720).
/// </summary>
table 68720 "Web Invoice Payment"
{
    Caption = 'Web Invoice Payment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Transaction ID"; Text[100])
        {
            Caption = 'Transaction ID';
        }
        field(2; "Payment Provider"; Code[50])
        {
            Caption = 'Payment Provider';
        }
        field(3; "Payment Type"; Text[50])
        {
            Caption = 'Payment Type';
        }
        field(4; "Paid Amount"; Decimal)
        {
            Caption = 'Paid Amount';
        }
        field(5; Currency; Code[10])
        {
            Caption = 'Currency';
        }
        field(6; "Transaction Reference"; Text[100])
        {
            Caption = 'Transaction Reference';
        }
        field(7; "Is Failed Capture"; Boolean)
        {
            Caption = 'Is Failed Capture';
        }
        field(8; "Failed Capture Comment"; Text[250])
        {
            Caption = 'Failed Capture Comment';
        }
        field(78700; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Web Invoice Payment Entry"."Customer No." where("Payment Transaction ID" = field("Transaction ID")));
        }
        field(78702; "Status EXP"; Option)
        {
            Caption = 'Status';
            OptionMembers = New,Converted,Rejected;
            OptionCaption = 'New,Converted,Rejected';
        }
        field(78710; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Web Invoice Payment Entry"."Payment Date" where("Payment Transaction ID" = field("Transaction ID")));
        }
    }
    keys
    {
        key(PK; "Transaction ID")
        {
            Clustered = true;
        }
    }
    /// <summary>
    /// ChangeToNew.
    /// </summary>
    procedure ChangeToNew()
    var
        Text001: Label 'Do you want to change status on %1 %2 to "New"?';
        WebInvPmtEntry: Record "Web Invoice Payment Entry";
    begin
        If ("Status EXP" <> "Status EXP"::New) then
            If Confirm(Text001, TRUE, rec.TableName, "Transaction ID") then begin
                "Status EXP" := "Status EXP"::New;
                Modify();

                WebInvPmtEntry.SetRange(WebInvPmtEntry."Payment Transaction ID", rec."Transaction ID");
                WebInvPmtEntry.ModifyAll("Status Exp", WebInvPmtEntry."Status Exp"::New);
            end;

    end;
}
