table 50282 "Report setup"
{
    CaptionML = ENU = 'Report setup',
                LVI = 'Atskaišu uzstādījumi';

    fields
    {
        field(10000; Primary; Code[10])
        {
            CaptionML = ENU = 'Primary',
                        LVI = 'Primārā atslēga';
        }
        field(20000; "FA Receipt Act No. Series"; Code[20])
        {
            CaptionML = ENU = 'FA Receipt Act No. Series',
                        LVI = 'Saņemšanas aktu num. sērija';
            TableRelation = "No. Series".Code;
        }
        field(30000; "FA Transfer Act No. Series"; Code[20])
        {
            CaptionML = ENU = 'FA Transfer Act No. Series',
                        LVI = 'Pārvietošanas aktu num. sērija';
            TableRelation = "No. Series".Code;
        }
        field(40000; "FA Disposal Act No. Series"; Code[20])
        {
            CaptionML = ENU = 'FA Disposal Act No. Series',
                        LVI = 'Likvidācijas aktu num. sērija';
            TableRelation = "No. Series".Code;
        }
        field(50000; "FA Inventory Act No. Series"; Code[20])
        {
            CaptionML = ENU = 'FA Inventory Act No. Series',
                        LVI = 'Inventarizācijas aktu num. sērija';
            TableRelation = "No. Series".Code;
        }
        field(60000; "FA Dep. Book code for Assets"; Code[30])
        {
            CaptionML = ENU = 'FA Dep. Book code for Assets',
                        LVI = 'Nolietojuma grāmata pamatlīdzekļiem';
            TableRelation = "Depreciation Book".Code;
        }
        field(70000; "FA Dep. Book code for Low Val."; Code[30])
        {
            CaptionML = ENU = 'FA Dep. Book code for Low Valuable Inventory',
                        LVI = 'Nolietojuma grāmata mazvērtīgajam inventāram';
            TableRelation = "Depreciation Book".Code;
        }
    }

    keys
    {
        key(Key1; Primary)
        {
        }
    }

    fieldgroups
    {
    }
}

