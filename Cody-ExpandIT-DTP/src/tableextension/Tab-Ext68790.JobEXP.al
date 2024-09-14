// EMSM18.0.6.57    2020-05-12 FAM * EXP Dimensions added 
/// <summary>
/// TableExtension Job EXP (ID 68790) extends Record Job.
/// </summary>
tableextension 68790 "Job EXP" extends Job
{
    fields
    {
        field(68781; "EXP Dimension 1"; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'EXP Dimension 1', Comment = 'DAN="EXP Dimension 1",DEU="",ESP="",FRA="",SVE=""';
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Dimension Code" = Field("EXP Dimension 1 Filter"), "No." = Field("No."), "Table ID" = Filter(= '5200')));

            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68782; "EXP Dimension 1 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'EXP Dimension 1 Filter', Comment = 'DAN="EXP Dimension 1",DEU="",ESP="",FRA="",SVE=""';
            TableRelation = "Dimension".Code;
            Editable = true;
            Description = 'EMSM18.0.6.57';
        }

        field(68783; "EXP Dimension 2"; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'EXP Dimension 2', Comment = 'DAN="EXP Dimension 2",DEU="",ESP="",FRA="",SVE=""';
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Dimension Code" = Field("EXP Dimension 1 Filter"), "No." = Field("No."), "Table ID" = Filter(= '5200')));

            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68784; "EXP Dimension 2 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'EXP Dimension 2 Filter', Comment = 'DAN="EXP Dimension 2 Filter",DEU="",ESP="",FRA="",SVE=""';
            TableRelation = "Dimension".Code;
            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68785; "EXP Dimension 3"; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'EXP Dimension 3', Comment = 'DAN="EXP Dimension 3",DEU="",ESP="",FRA="",SVE=""';
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Dimension Code" = Field("EXP Dimension 1 Filter"), "No." = Field("No."), "Table ID" = Filter(= '5200')));

            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
        field(68786; "EXP Dimension 3 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'EXP Dimension 3 Filter', Comment = 'DAN="EXP Dimension 3 Filter",DEU="",ESP="",FRA="",SVE=""';
            TableRelation = "Dimension".Code;
            Editable = true;
            Description = 'EMSM18.0.6.57';
        }
    }
}