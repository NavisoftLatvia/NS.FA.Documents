pageextension 50280 "FA Acts" extends "Accountant Role Center"
{
    actions
    {
        addafter("Recurring Fixed Asset Journals")
        {
            group("FA Acts")
            {
                CaptionML = ENU = 'FA Acts',
                            LVI = 'PL Akti';
                action("FA Documents")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'FA Documents',
                                LVI = 'PL Dokumenti';
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