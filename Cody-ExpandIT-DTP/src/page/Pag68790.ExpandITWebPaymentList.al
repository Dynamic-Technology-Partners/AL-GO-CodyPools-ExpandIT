/// <summary>
/// Page ExpandIT Web Payment List (ID 68790).
/// </summary>
page 68790 "ExpandIT Web Payment List"
{
    ApplicationArea = All;
    Caption = 'ExpandIT Web Payment List';
    PageType = List;
    SourceTable = "Web Invoice Payment";
    UsageCategory = Lists;
    CardPageId = "ExpandIT Web Payment";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ToolTip = 'Specifies the value of the Transaction ID field.';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the Payment Date field.';
                }
                field("Paid Amount"; Rec."Paid Amount")
                {
                    ToolTip = 'Specifies the value of the Paid Amount field.';
                }
                field("Transaction Reference"; Rec."Transaction Reference")
                {
                    ToolTip = 'Specifies the value of the Transaction Reference field.';
                }
                field("Status EXP"; Rec."Status EXP")
                {
                    ToolTip = 'Specifies the value of the Status EXP field.';
                }
            }
        }
    }
}
