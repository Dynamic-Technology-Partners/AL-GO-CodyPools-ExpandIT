/// <summary>
/// Page ExpandIT Web Payment Sub (ID 68792).
/// </summary>
page 68792 "ExpandIT Web Payment Sub"
{
    ApplicationArea = All;
    Caption = 'ExpandIT Web Payment Sub';
    PageType = ListPart;
    SourceTable = "Web Invoice Payment Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry Guid"; Rec."Entry Guid")
                {
                    ToolTip = 'Specifies the value of the Entry Guid field.';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                }
                field("Invoice Paid Amount"; Rec."Invoice Paid Amount")
                {
                    ToolTip = 'Specifies the value of the Invoice Paid Amount field.';
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the Payment Date field.';
                }
                field("Payment Transaction ID"; Rec."Payment Transaction ID")
                {
                    ToolTip = 'Specifies the value of the Payment Transaction ID field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Status Exp"; Rec."Status Exp")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Job No. EXP"; Rec."Job No. EXP")
                {
                    ToolTip = 'Specifies the value of the Job No. field.';
                }
            }
        }
    }
}
