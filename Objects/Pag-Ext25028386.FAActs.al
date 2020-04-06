pageextension 25028386 "FA Acts" extends "Accountant Role Center"
{
    actions
    {
        addafter("Recurring Fixed Asset Journals")
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