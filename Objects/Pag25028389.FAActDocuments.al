page 25028389 "FA Act Documents"
{
    Caption = 'FA Act Documents';
    CardPageID = "FA Act Document";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "FA Act Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("ResponsAct Number"; "ResponsAct Number")
                {
                }
                field(Date; Date)
                {
                }
                field(Released; Released)
                {
                }
                field("Act Statuss"; "Act Statuss")
                {
                }
                field("Old Location Code"; "Old Location Code")
                {
                }
                field("Old Location Name"; "Old Location Name")
                {
                }
                field("Old Responsible SP Code"; "Old Responsible SP Code")
                {
                }
                field("Old Responsible SP Name"; "Old Responsible SP Name")
                {
                }
                field("New Location Code"; "New Location Code")
                {
                }
                field("New Location Name"; "New Location Name")
                {
                }
                field("New Responsible SP Code"; "New Responsible SP Code")
                {
                }
                field("New Responsible SP Name"; "New Responsible SP Name")
                {
                }
                field("Insert User"; "Insert User")
                {
                    Visible = false;
                }
                field("Insert DateTime"; "Insert DateTime")
                {
                    Visible = false;
                }
                field("Modify User"; "Modify User")
                {
                    Visible = false;
                }
                field("Modify DateTime"; "Modify DateTime")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("FA Documents Setup")
            {
                ApplicationArea = All;
                Caption = 'FA Documents Setup';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LogSetup;
                RunObject = page "FA Act Setup";
            }
        }
    }
}

