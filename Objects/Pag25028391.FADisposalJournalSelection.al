page 25028391 "FA Disposal Journal Selection"
{
    Caption = 'FA Disposal Journal Selection';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = StandardDialog;
    SaveValues = true;
    ShowFilter = false;
    SourceTable = "Integer";
    SourceTableView = SORTING(Number)
                      ORDER(Ascending)
                      WHERE(Number = CONST(1));

    layout
    {
        area(content)
        {
            group(Control2)
            {
                field("FA Jnl Template"; JnlTemplate)
                {
                    Caption = 'FA Jnl. Template';
                    TableRelation = "FA Journal Template";
                }
                field("FA Jnl. Batch"; JnlBatch)
                {
                    Caption = 'FA Jnl. Batch';
                    TableRelation = "FA Journal Batch".Name;
                }
                field("Posting Date"; PostingDate)
                {
                    Caption = 'Posting Date';
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

