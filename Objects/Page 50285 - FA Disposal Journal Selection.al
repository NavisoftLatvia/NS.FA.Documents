page 50285 "FA Disposal Journal Selection"
{
    // version NS.MK.Acts.2018

    CaptionML = ENU = 'FA Disposal Journal Selection',
                LVI = 'PL likvidācijas žurnālu uzstādījumi';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = StandardDialog;
    SaveValues = true;
    ShowFilter = false;
    SourceTable = "Integer";
    SourceTableView = SORTING (Number)
                      ORDER(Ascending)
                      WHERE (Number = CONST (1));

    layout
    {
        area(content)
        {
            group(Control2)
            {
                field("FA Jnl Template"; JnlTemplate)
                {
                    CaptionML = ENU = 'FA Jnl. Template',
                                LVI = 'PL žurnāla veidne';
                    TableRelation = "FA Journal Template";
                }
                field("FA Jnl. Batch"; JnlBatch)
                {
                    CaptionML = ENU = 'FA Jnl. Batch',
                                LVI = 'PL žurnāla iedaļa';
                    TableRelation = "FA Journal Batch".Name;
                }
                field("Posting Date"; PostingDate)
                {
                    CaptionML = ENU = 'Posting Date',
                                LVI = 'Grāmatošanas datums';
                }
            }
        }
    }

    actions
    {
    }

    var
        JnlTemplate: Code[20];
        JnlBatch: Code[20];
        PostingDate: Date;

    procedure GetValues(var _JnlTemplate: Code[20]; var _JnlBatch: Code[20]; var _PostingDate: Date);
    begin
        _JnlTemplate := _JnlTemplate;
        _JnlBatch := _JnlBatch;
        _PostingDate := _PostingDate;
    end;
}

