// EIS6.0.01 2020-04-06 FAM * Maintain B2B logic 
// EIS6.0.13 2020-09-28 FAM * Show/Hide Enable Shop Logins and ExpandIT Customers Menu
/// <summary>
/// PageExtension Customer_card EXP (ID 68781) extends Record Customer Card.
/// </summary>
pageextension 68781 "Customer_card EXP" extends "Customer Card"
{
    // version NAVW111.00,EIS6.0.13

    layout
    {
        addlast(General)
        {
            field("Enable Shop Logins EXP"; Rec."Enable Shop Logins EXP")
            {
                ApplicationArea = All;
                Visible = MaintainB2BLoginsInBC;
            }
            field("DTP Pool Cleaning Customer"; Rec."DTP Pool Cleaning Customer")
            {
                ApplicationArea = All;
                Visible = True;
                Importance = Promoted;
            }
        }
    }
    actions
    {
        addfirst(navigation)
        {

            group("&ExpandIT Internet EXP")
            {
                Visible = ShowExpandITCustomer;
                Caption = '&ExpandIT Internet';

                action("&Logins EXP")
                {
                    Caption = '&Logins', Comment = 'DAN="&Logins",DEU="&Anmeldung",ESP="&Logins",FRA="&Idenfiants",SVE="&Inloggningar"';
                    Image = CustomerCode;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        InternetCustB2bList: Page "Internet Customer B2B List EXP";
                        IntrnetCustB2B: record "Internet Customer B2B EXP";

                    begin
                        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin // EIS6.0.12
                            // EIS6.0.01 begin                                    
                            if MaintainB2BLoginsInBC then begin
                                IntrnetCustB2B.SetRange("Customer No. EXP", Rec."No.");
                                if IntrnetCustB2B.FindFirst() then begin
                                    InternetCustB2bList.SetTableView(IntrnetCustB2B);
                                    InternetCustB2bList.SetCustomerNo(Rec."No.");
                                    InternetCustB2bList.Run();
                                end else begin
                                    IntrnetCustB2B.SetRange("Customer No. EXP", '');
                                    if not IntrnetCustB2B.FindFirst() then begin
                                        InternetCustB2bList.SetTableView(IntrnetCustB2B);
                                        InternetCustB2bList.SetCustomerNo(Rec."No.");
                                        InternetCustB2bList.Run();
                                    end;
                                end;
                            end else begin
                                Hyperlink(ExpandITSetup."Local Shop URL EXP" + '/cms/UserManagement/Users');
                                // EIS6.0.01 end
                            end;
                        end;
                    end;

                }
                action("&Internet customer list EXP")
                {
                    Caption = '&Internet customer list', Comment = 'DAN="&Internet Kundeoversigt",DEU="&Internet Kundenliste",ESP="&Lista Clientes Internet ",FRA="Liste des clients &Internet",SVE="&Internet kundlista"';
                    Image = ContactPerson;
                    RunObject = Page "Internet Customer List EXP";
                    RunPageLink = "Customer No. EXP" = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        MaintainB2BLoginsInBC: Boolean;
        ExpandITSetup: Record "ExpandIT Setup EXP";
        ExpandITUtil: Codeunit "ExpandIT Util";
        ShowExpandITCustomer: Boolean;

    trigger OnOpenPage()
    // EIS6.0.01 begin    
    begin
        // EIS6.0.12 begin 
        if ExpandITUtil.GetExpandITSetupRecord(ExpandITSetup) then begin  // EIS6.0.12
            // EIS6.0.13 begin 
            if ExpandITSetup."Maintain B2B Logins in BC EXP" then begin
                MaintainB2BLoginsInBC := ExpandITSetup."Maintain B2B Logins in BC EXP";
                ShowExpandITCustomer := true;
            end else begin
                MaintainB2BLoginsInBC := ExpandITSetup."Maintain B2B Logins in BC EXP";
                ShowExpandITCustomer := false;
            end;
        end;
        // EIS6.0.12 end
    end;
    // EIS6.0.01 end





    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

