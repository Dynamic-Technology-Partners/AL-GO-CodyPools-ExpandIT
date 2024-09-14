/// <summary>
/// Table Web Invoice Payment Entry (ID 68721).
/// </summary>
table 68721 "Web Invoice Payment Entry"
{
    Caption = 'Web Invoice Payment Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry Guid"; Integer)
        {
            Caption = 'Entry Guid';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(3; "Invoice No."; Code[50])
        {
            Caption = 'Invoice No.';
        }
        field(4; "Invoice Paid Amount"; Decimal)
        {
            Caption = 'Invoice Paid Amount';
        }
        field(5; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(6; "Payment Transaction ID"; Text[100])
        {
            Caption = 'Payment Transaction ID';
        }
        field(7; "Payment Mode"; Text[50])
        {
            Caption = 'Payment Mode';
        }
        field(8; "Is Dirty"; Boolean)
        {
            Caption = 'Is Dirty';
        }
        field(78702; "Status Exp"; Option)
        {
            Caption = 'Status';
            OptionMembers = New,Converted,Rejected;
            OptionCaption = 'New,Converted,Rejected';
        }
        field(78705; "Job No. EXP"; Code[20])
        {
            Caption = 'Job No.';
        }
    }
    keys
    {
        key(PK; "Entry Guid", "Customer No.", "Payment Transaction ID")
        {
            Clustered = true;
        }
    }
}
