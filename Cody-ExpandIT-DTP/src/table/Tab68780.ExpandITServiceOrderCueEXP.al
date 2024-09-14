/// <summary>
/// Table ExpandITServiceOrderCue EXP (ID 68780).
/// </summary>
table 68780 "ExpandITServiceOrderCue EXP"
{

    fields
    {
        field(1; "Primary Key EXP"; Code[250])
        {
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(2; "ServiceOrders EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Open Service Orders', Comment = 'DAN="Åbne Serviceordrer",DEU="Offene Serviceaufträge",ESP="",SVE="",FRA="Ordres de service ouverts"';
            CalcFormula = count("EMSM Service Item Line EXP" where("Order No. EXP" = Filter(<> ''), "Convert Status EXP" = FILTER(0)));
        }
        field(3; "ServiceLinesDlyHdr EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Service Lines with delayed header', Comment = 'DAN="Servicelinjer Med Forsinket Ordrehoved",DEU="ExpandIT Service Zeilen mit verzögerten Kopf. Der Kopf ist noch nicht genehmigt.",ESP="",SVE="",FRA="Lignes de service avec en-tête retardé"';
            CalcFormula = count("EMSM Service Invoice Line EXP" where("Order No. EXP" = FILTER(<> ''), "Convert Status EXP" = FILTER(0), "ServiceHeaderExist EXP" = filter(false), "JobPlanningGuid EXP" = Filter(<> '')));

        }

        field(4; "ServiceTimeLines EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Time Lines', Comment = 'DAN="Timelinjer",DEU="ExpandIT Service Zeit Zeilen",ESP="",SVE="",FRA="Lignes de temps"';
            CalcFormula = count("EMSM Service Invoice Line EXP" where("Order No. EXP" = FILTER(''), "Job No. EXP" = FILTER(<> ''), "Convert Status EXP" = FILTER(0)));
        }

        field(5; "SalesOrders EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Sales Orders', Comment = 'DAN="Salgsordrer",DEU="Verkaufsaufträge",ESP="",SVE="",FRA="Commandes de vente"';
            CalcFormula = count("ExpandIT Order Header EXP" where("Status EXP" = FILTER(0)));
        }

        field(6; "ExpandITSetup EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'ExpandIT Setup', Comment = 'DAN="ExpandIT Opsætning",DEU="ExpandIT Einrichtung",ESP="",SVE="",FRA=""';
            CalcFormula = count("Sales & Receivables Setup");

        }

        //Fields which shows the number of failed records
        field(7; "ServiceOrdersWError EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Open Service Orders - With Error', Comment = 'DAN="Åbne Serviceordrer - Med Fejl",DEU="Service Aufträge - Mit Fehler",ESP="",SVE="",FRA="Ordres de service ouverts - avec erreur"';
            CalcFormula = count("EMSM Service Item Line EXP" where("Order No. EXP" = Filter(<> ''), "Convert Status EXP" = FILTER(3)));
        }
        field(8; "ServiceLinesDlyHdrWError EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Service Lines with delayed header - With Error', Comment = 'DAN="Servicelinjer Med Forsinket Ordrehoved - Med Fejl",DEU="Servicezeilen mit verzögerten Kopfdaten - Mit Fehler",ESP="",SVE="",FRA="Lignes de service avec en-tête retardé - avec erreur"';
            CalcFormula = count("EMSM Service Invoice Line EXP" where("Order No. EXP" = FILTER(<> ''), "Convert Status EXP" = FILTER(3), "ServiceHeaderExist EXP" = FILTER(false), "JobPlanningGuid EXP" = Filter(<> '')));
        }
        field(9; "ServiceTimeLinesWError EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Time Lines - With Error', Comment = 'DAN="Timelinjer - Med Fejl",DEU="Service Zeitzeile - Mit Fehler",ESP="",SVE="",FRA="Les lignes du temps - avec erreurs"';
            CalcFormula = count("EMSM Service Invoice Line EXP" where("Order No. EXP" = FILTER(''), "Job No. EXP" = FILTER(<> ''), "Convert Status EXP" = FILTER(3)));
        }


        //Fields which shows the number of converted records
        field(10; "ServiceOrdersConverted EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Converted Service Orders', Comment = 'DAN="Konverterede Serviceordrer",DEU="Service Aufträge Konvertiert",ESP="",SVE="",FRA="Ordres de service convertis"';
            CalcFormula = count("EMSM Service Item Line EXP" where("Order No. EXP" = Filter(<> ''), "Convert Status EXP" = FILTER(1)));
        }
        field(11; "ServiceLinesDlyHdrConv EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Converted Service Lines With Delayed Header', Comment = 'DAN="Konverterede Servicelinjer Med Forsinket Ordrehoved",DEU="Konvertierte Service Zeilen mit verzögerten Kopf",ESP="",SVE="",FRA="Lignes de service converties avec en-tête retardé"';
            CalcFormula = count("EMSM Service Invoice Line EXP" where("Order No. EXP" = FILTER(<> ''), "Convert Status EXP" = FILTER(1), "ServiceHeaderExist EXP" = filter(false)));

        }
        field(12; "ServiceTimeLinesConverted EXP"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Converted Service Time Lines', Comment = 'DAN="Konverterede Service Timelinjer",DEU="Service Zeitzeile Konvertiert",ESP="",SVE="",FRA="Lignes de temps de service converties"';
            CalcFormula = count("EMSM Service Invoice Line EXP" where("Order No. EXP" = FILTER(''), "Job No. EXP" = FILTER(<> ''), "Convert Status EXP" = FILTER(1), "JobPlanningGuid EXP" = Filter(<> '' | '')));
        }

        field(13; "ServiceTimeLinesErrorDesc EXP"; Text[250])
        {
            //FieldClass = FlowField;
            Editable = false;
            Caption = 'Time Lines - With Error', comment = 'DAN="Nye ExpandIT Timelinjer - Med Fejl",DEU="Neue ExpandIT Zeitenzeilen - Mit Fehler",ESP="",SVE="",FRA="Les lignes du temps - avec erreurs"';
            //CalcFormula = count ("EMSM Service Invoice Line" where ("Order No." = FILTER (''), "Job No." = FILTER (<> ''), "Convert Status" = FILTER ('Converted')));
        }
    }

    keys
    {
        key(PK; "Primary Key EXP")
        {
            Clustered = true;
        }
    }



}