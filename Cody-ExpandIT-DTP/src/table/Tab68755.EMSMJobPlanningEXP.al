/// <summary>
/// Table EMSM JobPlanning EXP (ID 68755).
/// </summary>
table 68755 "EMSM JobPlanning EXP"
{
    // version EMSM3.02

    // EMSM3.02     2015-09-09  PB * The new feature "Job Planning Update" implemented.


    fields
    {
        field(1; "JobPlanningGuid EXP"; Text[50])
        {
            Caption = 'JobPlanningGuid', Comment = 'ESP="JobPlanningGuid"';
            DataClassification = CustomerContent;
        }
        field(2; "JobPlanningType EXP"; Integer)
        {
            Caption = 'JobPlanningType', Comment = 'ESP="JobPlanningType"';
            DataClassification = CustomerContent;
        }
        field(3; "Guid_X EXP"; Text[50])
        {
            Caption = 'Guid_X', Comment = 'ESP="Guid_X"';
            DataClassification = CustomerContent;
        }
        field(4; "JobPlanningGroupGuid EXP"; Text[50])
        {
            Caption = 'JobPlanningGroupGuid', Comment = 'ESP="JobPlanningGroupGuid"';
            DataClassification = CustomerContent;
        }
        field(5; "JobPlanningLinkGuid EXP"; Text[50])
        {
            Caption = 'JobPlanningLinkGuid', Comment = 'ESP="JobPlanningLinkGuid"';
            DataClassification = CustomerContent;
        }
        field(6; "UserGuid EXP"; Text[50])
        {
            Caption = 'UserGuid', Comment = 'ESP="UserGuid", FRA="Guide de l''utilisateur", DEU="", SVE="", DAN=""';
            DataClassification = CustomerContent;
        }
        field(7; "UserType EXP"; Text[20])
        {
            Caption = 'UserType', Comment = 'ESP="UserType"';
            DataClassification = CustomerContent;
        }
        field(8; "DepartmentGuidOrg EXP"; Text[50])
        {
            Caption = 'DepartmentGuidOrg', Comment = 'ESP="DepartmentGuidOrg"';
            DataClassification = CustomerContent;
        }
        field(9; "StatusGuid EXP"; Text[20])
        {
            Caption = 'StatusGuid', Comment = 'ESP="StatusGuid"';
            DataClassification = CustomerContent;
        }
        field(10; "StartDate EXP"; Date)
        {
            Caption = 'StartDate', Comment = 'ESP="StartDate"';
            DataClassification = CustomerContent;
        }
        field(11; "StartTime EXP"; Time)
        {
            Caption = 'StartTime', Comment = 'ESP="StartTime"';
            DataClassification = CustomerContent;
        }
        field(12; "FinishDate EXP"; Date)
        {
            Caption = 'FinishDate', Comment = 'ESP="FinishDate"';
            DataClassification = CustomerContent;
        }
        field(13; "FinishTime EXP"; Time)
        {
            Caption = 'FinishTime', Comment = 'ESP="FinishTime"';
            DataClassification = CustomerContent;
        }
        field(14; "JobSavedDateTime EXP"; DateTime)
        {
            Caption = 'JobSavedDateTime', Comment = 'ESP="JobSavedDateTime"';
            DataClassification = CustomerContent;
        }
        field(15; "BackEndUpdate EXP"; Code[50])
        {
            Caption = 'BackEndUpdate', Comment = 'ESP="BackEndUpdate"';
            DataClassification = CustomerContent;
        }
        field(100; "ConvertStatus EXP"; Option)
        {
            Caption = 'ConvertStatus', Comment = 'ESP="ConvertStatus"';
            OptionCaption = 'New,Converted,Error,Deleted', Comment = 'ESP="Nuevo,Convertido,Error,Borrado"';
            OptionMembers = New,Converted,Error,Deleted;
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
        key(Key2; "JobPlanningType EXP", "UserGuid EXP", "StatusGuid EXP")
        {
        }
        key(Key3; "ConvertStatus EXP")
        {
        }
        key(Key4; "UserGuid EXP")
        {
        }
    }

    fieldgroups
    {
    }
}

