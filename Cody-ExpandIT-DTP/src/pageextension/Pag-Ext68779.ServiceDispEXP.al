/// <summary>
/// PageExtension ServiceDisp EXP (ID 68779) extends Record Service Dispatcher Role Center.
/// </summary>
pageextension 68779 "ServiceDisp EXP" extends "Service Dispatcher Role Center"
{

    actions
    {

        addlast(Sections)
        {
            group("ExpandIT")
            {
                action("ExpandIT Department")
                {
                    RunObject = page 68778;
                    ApplicationArea = All;
                }

            }
        }
    }
}