/// <summary>
/// PageExtension Sales_Order EXP (ID 68794) extends Record Posted Sales Invoice.
/// </summary>
pageextension 68794 "Posted_Sales_Invoice EXP" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(Content)
        {
            group(ExpandIT)
            {
                Caption = 'ExpandIT';
                field("e-payment Provider Code EXP"; Rec."e-payment Provider Code EXP")
                {
                    ApplicationArea = All;
                    visible = true;
                }
                field("e-payment Clearing OK EXP"; Rec."e-payment Clearing OK EXP")
                {
                    ApplicationArea = All;
                    visible = true;
                }
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            group("&ExpandIT E-payment EXP")
            {
                Caption = '&ExpandIT E-payment', Comment = 'DAN="E-payment",DEU="E-payment",ESP="E-payment",FRA="Paiement en ligne",SVE="E-payment"';

                action("E-Payment Entries")
                {
                    Caption = 'E-Payment Entries';
                    Image = EntriesList;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        EPaymentEntriesPage: Page "e-payment Entries EXP";
                        EPaymentEntry: Record "e-payment Entry EXP";
                    begin
                        EPaymentEntry.SetRange("Invoice No. EXP", Rec."No.");
                        EPaymentEntriesPage.SetTableView(EPaymentEntry);
                        EPaymentEntriesPage.RunModal();
                    end;
                }
            }
        }
    }
}
