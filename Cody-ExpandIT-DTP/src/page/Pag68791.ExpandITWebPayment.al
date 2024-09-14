/// <summary>
/// Page ExpandIT Web Payment (ID 68791).
/// </summary>
page 68791 "ExpandIT Web Payment"
{
    ApplicationArea = All;
    Caption = 'ExpandIT Web Payment';
    PageType = Document;
    SourceTable = "Web Invoice Payment";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

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
            part(Subform; "ExpandIT Web Payment Sub")
            {
                SubPageLink = "Payment Transaction ID" = field("Transaction ID");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Apply Payment")
                {
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.TestField("Status EXP", Rec."Status EXP"::New);
                        Codeunit.Run(Codeunit::"Create Web Payment", Rec);
                    end;
                }
                action("Reset Status")
                {
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ChangeToNew;
                    end;
                }
            }
        }
    }
}
