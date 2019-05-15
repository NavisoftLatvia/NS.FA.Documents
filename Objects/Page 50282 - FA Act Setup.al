page 50282 "FA Act Setup"
{
    // version NS.MK.Acts.2018

    CaptionML = ENU = 'FA Act Setup',
                LVI = 'PL Aktu uzstādījumi';
    PageType = Card;
    SourceTable = "Report setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            LVI = 'Vispārējie uzstādījumi';

                field("FA Receipt Act No. Series"; "FA Receipt Act No. Series")
                {
                }
                field("FA Transfer Act No. Series"; "FA Transfer Act No. Series")
                {
                }
                field("FA Disposal Act No. Series"; "FA Disposal Act No. Series")
                {
                }
                field("FA Inventory Act No. Series"; "FA Inventory Act No. Series")
                {
                }
                field("FA Dep. Book code for Assets"; "FA Dep. Book code for Assets")
                {
                }
                field("FA Dep. Book code for Low Val."; "FA Dep. Book code for Low Val.")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        if not FINDFIRST then begin
            INIT;
            INSERT;
            RESET;
        end;
    end;
}

