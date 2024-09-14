// EMSM18.0.6.57    2020-05-12 FAM * EXP Dimensions added 
/// <summary>
/// TableExtension Resource EXP (ID 68791) extends Record Resource.
/// </summary>
tableextension 68791 "Resource EXP" extends Resource
{
    fields
    {
        field(68781; "EXP Dimension 1 EXP"; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'EXP Dimension 1', Comment = 'DAN="EXP Dimension 1",DEU="",ESP="",FRA="",SVE=""';
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Dimension Code" = Field("EXP Dimension 1 Filter EXP"), "No." = Field("No."), "Table ID" = Filter(= '5200')));

            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68782; "EXP Dimension 1 Filter EXP"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'EXP Dimension 1 Filter', Comment = 'DAN="EXP Dimension 1",DEU="",ESP="",FRA="",SVE=""';
            TableRelation = "Dimension".Code;
            Editable = true;
            Description = 'EMSM18.0.6.57';
        }

        field(68783; "EXP Dimension 2 EXP"; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'EXP Dimension 2', Comment = 'DAN="EXP Dimension 2",DEU="",ESP="",FRA="",SVE=""';
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Dimension Code" = Field("EXP Dimension 1 Filter EXP"), "No." = Field("No."), "Table ID" = Filter(= '5200')));

            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68784; "EXP Dimension 2 Filter EXP"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'EXP Dimension 2 Filter', Comment = 'DAN="EXP Dimension 2 Filter",DEU="",ESP="",FRA="",SVE=""';
            TableRelation = "Dimension".Code;
            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68785; "EXP Dimension 3 EXP"; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'EXP Dimension 3', Comment = 'DAN="EXP Dimension 3",DEU="",ESP="",FRA="",SVE=""';
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Dimension Code" = Field("EXP Dimension 1 Filter EXP"), "No." = Field("No."), "Table ID" = Filter(= '5200')));

            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68786; "EXP Dimension 3 Filter EXP"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'EXP Dimension 3 Filter', Comment = 'DAN="EXP Dimension 3 Filter",DEU="",ESP="",FRA="",SVE=""';
            TableRelation = "Dimension".Code;
            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
    }
}