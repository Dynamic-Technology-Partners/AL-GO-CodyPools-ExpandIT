/// <summary>
/// PageExtension pageextension777 EXP (ID 68777) extends Record Order Processor Role Center.
/// </summary>
pageextension 68777 "pageextension777 EXP" extends "Order Processor Role Center"
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
                    RunPageMode = View;
                    RunPageOnRec = false;
                    ApplicationArea = All;
                }

            }
        }
    }
}

