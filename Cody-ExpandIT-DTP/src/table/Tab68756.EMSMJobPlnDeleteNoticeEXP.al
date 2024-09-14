/// <summary>
/// Table EMSM JobPln Delete Notice EXP (ID 68756).
/// </summary>
table 68756 "EMSM JobPln Delete Notice EXP"
{
    // version EMSM3.02

    // EMSM3.02     2015-09-09  PB * The new feature "Job Planning Update" implemented.


    fields
    {
        field(10; "JobPlanningGuid EXP"; Text[50])
        {
            Caption = 'JobPlanningGuid', Comment = 'ESP="JobPlanningGuid"';
            DataClassification = CustomerContent;
        }
        field(15; "Created On EXP"; DateTime)
        {
            Caption = 'Created On', Comment = 'ESP="Creado a"';
            DataClassification = CustomerContent;
        }
        field(100; "ConvertStatus EXP"; Option)
        {
            Caption = 'ConvertStatus', Comment = 'ESP="ConvertStatus"';
            OptionCaption = 'New,Converted,Error,Deleted,Ignored', Comment = 'ESP="Nuevo,Convertido,Error,Borrado,Ignorado"';
            OptionMembers = New,Converted,Error,Deleted,Ignored;
            DataClassification = CustomerContent;
        }
        field(105; "ConvertMessage EXP"; Text[250])
        {
            Caption = 'ConvertMessage', Comment = 'ESP="ConvertMessage"';
            DataClassification = CustomerContent;
        }
        field(110; "AllocationMessage EXP"; Text[250])
        {
            Caption = 'AllocationMessage', Comment = 'ESP="AllocationMessage"';
            DataClassification = CustomerContent;
        }
        field(115; "StatusMessage EXP"; Text[250])
        {
            Caption = 'StatusMessage', Comment = 'ESP="StatusMessage"';
            DataClassification = CustomerContent;
        }
        field(150; "ConvertedOn EXP"; DateTime)
        {
            Caption = 'ConvertedOn', Comment = 'ESP="ConvertedOn"';
            DataClassification = CustomerContent;
        }
        field(155; "ConvertedBy EXP"; Text[250])
        {
            Caption = 'ConvertedBy', Comment = 'ESP="ConvertedBy"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "JobPlanningGuid EXP")
        {
        }
    }

    fieldgroups
    {
    }
}

