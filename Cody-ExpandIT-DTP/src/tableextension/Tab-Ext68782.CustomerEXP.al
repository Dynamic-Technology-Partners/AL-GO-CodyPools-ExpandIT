// EMSM18.0.6.57    2020-05-12 FAM * EXP Dimensions added 
/// <summary>
/// TableExtension Customer EXP (ID 68782) extends Record Customer.
/// </summary>
tableextension 68782 "Customer EXP" extends Customer
{
    // version NAVW111.00.00.19846,EIS5.04.05

    fields
    {

        //Unsupported feature: Change Description on ""Country/Region Code"(Field 35)". Please convert manually.

        field(68705; "Enable Shop Logins EXP"; Boolean)
        {
            Caption = 'Enable Shop Login', Comment = 'DAN="Internet Logins Aktive",DEU="Mögliche Internetshop Anmeldung",ESP="Activar Acceso Internet",FRA="Activer Login Internet Shop",SVE="Aktivera shop inloggning"';
            Description = 'EIS5.04.02';
            DataClassification = CustomerContent;

        }
        field(68706; "EXP Dimension 1"; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'EXP Dimension 1', Comment = 'DAN="EXP Dimension 1",DEU="",ESP="",FRA="",SVE=""';
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Dimension Code" = Field("EXP Dimension 1 Filter"), "No." = Field("No."), "Table ID" = Filter(= '5200')));

            Editable = true;
            Description = 'EMSM18.0.6.57';

        }
        field(68707; "EXP Dimension 1 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'EXP Dimension 1 Filter', Comment = 'DAN="EXP Dimension 1",DEU="",ESP="",FRA="",SVE=""';
            TableRelation = "Dimension".Code;
            Editable = true;
            Description = 'EMSM18.0.6.57';
        }

        field(68708; "EXP Dimension 2"; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'EXP Dimension 2', Comment = 'DAN="EXP Dimension 2",DEU="",ESP="",FRA="",SVE=""';
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Dimension Code" = Field("EXP Dimension 1 Filter"), "No." = Field("No."), "Table ID" = Filter(= '5200')));

            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68709; "EXP Dimension 2 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'EXP Dimension 2 Filter', Comment = 'DAN="EXP Dimension 2 Filter",DEU="",ESP="",FRA="",SVE=""';
            TableRelation = "Dimension".Code;
            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68710; "EXP Dimension 3"; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'EXP Dimension 3', Comment = 'DAN="EXP Dimension 3",DEU="",ESP="",FRA="",SVE=""';
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Dimension Code" = Field("EXP Dimension 1 Filter"), "No." = Field("No."), "Table ID" = Filter(= '5200')));

            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68711; "EXP Dimension 3 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'EXP Dimension 3 Filter', Comment = 'DAN="EXP Dimension 3 Filter",DEU="",ESP="",FRA="",SVE=""';
            TableRelation = "Dimension".Code;
            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68800; "DTP SKU Location Code"; Code[20])
        {
            Caption = 'SKU Location Code';
            TableRelation = Location.Code;
            Editable = True;
        }
        field(68801; "DTP Pool Cleaning Customer"; Boolean)
        {
            Caption = 'Pool Cleaning Customer';
            DataClassification = CustomerContent;
            Editable = true;
        }
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: InternetCustomerB2B)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);

    ServiceItem.SETRANGE("Customer No.","No.");
    #4..55
    end;

    SalesOrderLine.SETCURRENTKEY("Document Type","Bill-to Customer No.");
    SalesOrderLine.SETFILTER(
      "Document Type",'%1|%2',
      SalesOrderLine."Document Type"::Order,
      SalesOrderLine."Document Type"::"Return Order");
    SalesOrderLine.SETRANGE("Bill-to Customer No.","No.");
    if SalesOrderLine.FINDFIRST then
      ERROR(
    #66..127
    VATRegistrationLogMgt.DeleteCustomerLog(Rec);

    DimMgt.DeleteDefaultDim(DATABASE::Customer,"No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..58
    #63..130
    // >> EIS5.04.05
    InternetCustomerB2B.SETRANGE("Customer No.", "No.");
    InternetCustomerB2B.DELETEALL;
    // << EIS5.04.05
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        InternetCustomerB2B: Record "Internet Customer B2B EXP";
}

