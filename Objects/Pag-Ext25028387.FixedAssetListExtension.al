pageextension 25028387 "Fixed Asset List Extension" extends "Fixed Asset List"
{
    actions
    {
        addafter(Statistics)
        {
            group("FA Acts")
            {
                Caption = 'FA Acts';
                action("FA Documents")
                {
                    ApplicationArea = All;
                    Caption = 'FA Documents';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Documents;
                    RunObject = page "FA Act Documents";
                }
            }
        }
    }
}