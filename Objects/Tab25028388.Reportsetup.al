table 25028388 "Report setup"
{
    Caption = 'Report setup';

    fields
    {
        field(10000; Primary; Code[10])
        {
            Caption = 'Primary';
        }
        field(20000; "FA Receipt Act No. Series"; Code[20])
        {
            Caption = 'FA Receipt Act No. Series';
            TableRelation = "No. Series".Code;
        }
        field(30000; "FA Transfer Act No. Series"; Code[20])
        {
            Caption = 'FA Transfer Act No. Series';
            TableRelation = "No. Series".Code;
        }
        field(40000; "FA Disposal Act No. Series"; Code[20])
        {
            Caption = 'FA Disposal Act No. Series';
            TableRelation = "No. Series".Code;
        }
        field(50000; "FA Inventory Act No. Series"; Code[20])
        {
            Caption = 'FA Inventory Act No. Series';
            TableRelation = "No. Series".Code;
        }
        field(60000; "FA Dep. Book code for Assets"; Code[30])
        {
            Caption = 'FA Dep. Book code for Assets';
            TableRelation = "Depreciation Book".Code;
        }
        field(70000; "FA Dep. Book code for Low Val."; Code[30])
        {
            Caption = 'FA Dep. Book code for Low Valuable Inventory';
            TableRelation = "Depreciation Book".Code;
        }
    }

    keys
    {
        key(Key1; Primary)
        {

        }
    }
}