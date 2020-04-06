page 25028387 "FA Act Doc. Subp. Lines"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "FA Act Line";

    layout
    {
        area(content)
        {
            repeater(Rows)
            {
                Caption = 'Lines';
                field("Document No."; "Document No.")
                {
                    Visible = false;
                }
                field("Line No."; "Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("FA No."; "FA No.")
                {
                }
                field("FA Description"; "FA Description")
                {
                }
                field("FA Description 2"; "FA Description 2")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Unit Cost"; "Unit Cost")
                {
                }
                field(Amount; Amount)
                {
                }
                field("FA History Entry No."; "FA History Entry No.")
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
                field("Disposal reason"; "Disposal reason")
                {
                }
                field("Responsible SP Code"; "Responsible SP Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("FA Ledger Entry No."; "FA Ledger Entry No.")
                {
                }
                field("FA Ledger Entry Date"; "FA Ledger Entry Date")
                {
                }
                field("FA Ledger Entry Document No."; "FA Ledger Entry Document No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(AddMultipleAssets)
            {
                Caption = 'Add Multiple Assets';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    AddMultipleFAActLines(Rec);
                end;
            }
        }
    }

    var
        IsReleased: Boolean;
        Responsible: Code[50];
        Location: Code[50];
        _FAActHeader: Record "FA Act Header";

    local procedure AddMultipleFAActLines(var _rec: Record "FA Act Line");
    var
        FAActLine: Record "FA Act Line";
        FixedAsset: Record "Fixed Asset";
        FixedAssetSelection: Page "Fixed Asset Selection";
        FixedAssetSelectionFilter: Text;
        FADepreciationBook: Record "FA Depreciation Book";
        Reportsetup: Record "Report setup";
        gui: Dialog;
        guiText: Label 'Collecting Assets @@@@@@1@@@@@@';
        totalFA: Integer;
        currentFA: Integer;
    begin
        _FAActHeader.TESTFIELD(Released, false);
        if (_FAActHeader.Type = _FAActHeader.Type::Reception) then
            _FAActHeader.TESTFIELD("New Responsible SP Code")
        else
            _FAActHeader.TESTFIELD("Old Responsible SP Code");

        FixedAsset.RESET;

        Reportsetup.GET;

        gui.OPEN(guiText);
        totalFA := FixedAsset.COUNT;

        //FixedAsset.CALCFIELDS("FA Depr. Book Code");
        FixedAsset.CLEARMARKS;
        if FixedAsset.FINDFIRST then
            repeat
                currentFA += 1;
                gui.UPDATE(1, ROUND(currentFA / totalFA * 10000, 1));
                if _FAActHeader."Low Value" then begin
                    if FADepreciationBook.GET(FixedAsset."No.", Reportsetup."FA Dep. Book code for Low Val.") then
                        FixedAsset.MARK(true);
                end else begin
                    if FADepreciationBook.GET(FixedAsset."No.", Reportsetup."FA Dep. Book code for Assets") then
                        FixedAsset.MARK(true);
                end;
            until FixedAsset.NEXT = 0;
        gui.CLOSE;
        FixedAsset.MARKEDONLY(true);

        FixedAsset.FILTERGROUP(5);
        FixedAsset.SETRANGE(Blocked, false);
        FixedAsset.SETRANGE(Inactive, false);
        FixedAsset.FILTERGROUP(0);
        if not (_FAActHeader.Type = _FAActHeader.Type::Reception) then
            FixedAsset.SETRANGE("Responsible Employee", _FAActHeader."Old Responsible SP Code");
        if not (_FAActHeader.Type = _FAActHeader.Type::Reception) then begin
            if _FAActHeader."Old Location Code" <> '' then
                FixedAsset.SETRANGE("FA Location Code", _FAActHeader."Old Location Code");
        end;

        CLEAR(FixedAssetSelection);
        FixedAssetSelection.SETTABLEVIEW(FixedAsset);
        FixedAssetSelection.EDITABLE(false);
        FixedAssetSelection.LOOKUPMODE(true);

        if not (FixedAssetSelection.RUNMODAL = ACTION::LookupOK) then
            ERROR('');

        FixedAssetSelection.GETRECORD(FixedAsset);

        FixedAssetSelectionFilter := FixedAssetSelection.GetSelectionFilterForAssets(FixedAsset);
        if (FixedAssetSelectionFilter = '') then
            ERROR('');

        FixedAsset.RESET;

        FixedAsset.SETRANGE(Blocked, false);
        FixedAsset.SETRANGE(Inactive, false);

        FixedAsset.SETFILTER("No.", FixedAssetSelectionFilter);

        FixedAsset.FINDFIRST;
        repeat
            FAActLine.INIT;
            FAActLine."Document No." := _FAActHeader."No.";
            FAActLine."Document Type" := _FAActHeader.Type;
            FAActLine."Line No." := 0;
            FAActLine.INSERT(true);
            FAActLine.VALIDATE("FA No.", FixedAsset."No.");
            FAActLine.MODIFY(true);
        until FixedAsset.NEXT = 0;
    end;

    procedure SetGlobalVariables(var _rec: Record "FA Act Header");
    begin
        _FAActHeader := _rec
    end;
}

