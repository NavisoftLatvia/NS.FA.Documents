page 25028386 "FA Act Document"
{
    Caption = 'FA Act Document';
    SourceTable = "FA Act Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(GeneralInfo)
                {
                    Caption = '';
                    field(Type; Type)
                    {
                        Editable = false;

                        trigger OnValidate();
                        begin
                            //Rec.ChangeDocType();
                        end;
                    }
                    field("No."; "No.")
                    {
                        Editable = false;
                    }
                    field("ResponsAct Number"; "ResponsAct Number")
                    {
                    }
                    field(Date; Date)
                    {
                    }
                    field("Low Value"; "Low Value")
                    {
                    }
                    group(Varrant)
                    {
                        Caption = '';
                        Visible = IsInventory;
                        field("Warrant Number"; "Warrant Number")
                        {
                        }
                        field("Warrant date"; "Warrant date")
                        {
                        }
                    }
                    field(Released1; Released)
                    {
                    }
                    field("Act Statuss"; "Act Statuss")
                    {
                    }
                }
                group("Current Location")
                {
                    field("Old Location Code"; "Old Location Code")
                    {
                        Caption = 'Location Code';
                        Enabled = IsFromControlsVisibled;

                        trigger OnValidate();
                        begin
                            CALCFIELDS("Old Location Name");
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Old Location Name"; "Old Location Name")
                    {
                        Caption = 'Location';
                        Enabled = IsFromControlsVisibled;
                    }
                    field("Old Responsible SP Code"; "Old Responsible SP Code")
                    {
                        Caption = 'Responsible Employee';
                        Enabled = IsFromControlsVisibled;

                        trigger OnValidate();
                        begin
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Old Responsible SP Name"; "Old Responsible SP Name")
                    {
                        Caption = 'Responsible Employee';
                        Enabled = IsFromControlsVisibled;
                    }
                }
                group("New Location")
                {
                    Editable = IsToControlsVisibled;
                    Visible = IsToControlsVisibled;
                    field("New Location Code"; "New Location Code")
                    {

                        trigger OnValidate();
                        begin
                            CALCFIELDS("New Location Name");
                            CurrPage.UPDATE;
                        end;
                    }
                    field("New Location Name"; "New Location Name")
                    {
                    }
                    field("New Responsible SP Code"; "New Responsible SP Code")
                    {

                        trigger OnValidate();
                        begin
                            CurrPage.UPDATE;
                        end;
                    }
                    field("New Responsible SP Name"; "New Responsible SP Name")
                    {
                    }
                }
            }
            part(FAActDocSubpLines; "FA Act Doc. Subp. Lines")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Document Type" = FIELD(Type);
                SubPageView = SORTING("Document No.", "Document Type", "Line No.")
                              ORDER(Ascending);
            }
            group("Comision Decision")
            {
                Caption = 'Comision Decision';
                Visible = IsDisposal;
                field("Reason Of Disposal"; "Reason Of Disposal")
                {
                    MultiLine = true;
                }
                field("Comission Closure"; "Comission Closure")
                {
                    MultiLine = true;
                }
            }
            group(Commision)
            {
                Caption = 'Commision';
                group("Commision Approval")
                {
                    Caption = '';
                    field("President Of Commission Code"; "President Of Commission Code")
                    {
                    }
                    field("President Of Commission Name"; "President Of Commission Name")
                    {
                    }
                    field("Aproved by person code"; "Aproved by person code")
                    {
                    }
                    field("Aproved by person name"; "Aproved by person name")
                    {
                    }
                }
                group("Members")
                {
                    Caption = '';
                    field("Members Of Commission 1 Code"; "Members Of Commission 1 Code")
                    {
                    }
                    field("Members Of Commission 1 Name"; "Members Of Commission 1 Name")
                    {
                    }
                    field("Members Of Commission 2 Code"; "Members Of Commission 2 Code")
                    {
                    }
                    field("Members Of Commission 2 Name"; "Members Of Commission 2 Name")
                    {
                    }
                    field("Members Of Commission 3 Code"; "Members Of Commission 3 Code")
                    {
                    }
                    field("Members Of Commission 3 Name"; "Members Of Commission 3 Name")
                    {
                    }
                }
            }
            group(System)
            {
                Caption = 'System';
                field(Lines; Lines)
                {
                }
                group("Document Statuss")
                {
                    Caption = '';
                    field(Released; Released)
                    {
                    }
                    field("Released Date"; "Released Date")
                    {
                    }
                }
                group("User Control")
                {
                    Caption = '';
                    field("Insert User"; "Insert User")
                    {
                    }
                    field("Insert DateTime"; "Insert DateTime")
                    {
                    }
                    field("Modify User"; "Modify User")
                    {
                    }
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Process)
            {
                Caption = 'Process';
                action(FillByDefault)
                {
                    Caption = 'Fill By Default',;
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = IsInventory;

                    trigger OnAction();
                    begin
                        FillFALinesByDefault(Rec);
                    end;
                }
            }
            group(Releasing)
            {
                Caption = 'Release';
                action(ReleaseAct)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction();
                    begin
                        ReleaseManualy(Rec);
                    end;
                }
                action(ReopenAct)
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        ReOpen(Rec);
                    end;
                }
            }
            group("Mass Assign")
            {
                Caption = 'Mass Assign';
                action("Assign Employee")
                {
                    Caption = 'Assign Employee';
                    Image = Employee;

                    trigger OnAction();
                    var
                        pEmployeeList: Page "Employee List";
                        EmployeeNo: Code[20];
                        rEmployee: Record Employee;
                        rFixedAsset: Record "Fixed Asset";
                        iCount: Integer;
                        _FAActLine: Record "FA Act Line";
                        AB002: Label 'Apply %1 to %2 records?';
                        AB003: Label '%1 records updated.';
                    begin
                        TESTFIELD(Released, true);
                        if not (Type in [Type::Reception, Type::Transfer]) then
                            FIELDERROR(Type);

                        TESTFIELD("Act Statuss", "Act Statuss"::Completed);

                        _FAActLine.RESET;
                        _FAActLine.SETRANGE("Document No.", "No.");
                        _FAActLine.SETRANGE("Document Type", Type);
                        _FAActLine.FINDFIRST;

                        EmployeeNo := "New Responsible SP Code";
                        iCount := _FAActLine.COUNT;
                        if not CONFIRM(STRSUBSTNO(AB002, "New Responsible SP Name", FORMAT(iCount)), true) then
                            exit;

                        repeat
                            rFixedAsset.GET(_FAActLine."FA No.");
                            rFixedAsset.VALIDATE("Responsible Employee", EmployeeNo);
                            rFixedAsset.MODIFY(true);
                        until _FAActLine.NEXT = 0;

                        MESSAGE(STRSUBSTNO(AB003, FORMAT(iCount)));
                    end;
                }
                action("Assign Location")
                {
                    Caption = 'Assign Location';
                    Image = Map;

                    trigger OnAction();
                    var
                        pFALocations: Page "FA Locations";
                        FALocationCode: Code[20];
                        rFALocation: Record "FA Location";
                        rFixedAsset: Record "Fixed Asset";
                        iCount: Integer;
                        AB002: Label 'Apply %1 to %2 records?';
                        AB003: Label '%1 records updated.';
                        _FAActLine: Record "FA Act Line";
                    begin
                        TESTFIELD(Released, true);

                        if not (Type in [Type::Reception, Type::Transfer]) then
                            FIELDERROR(Type);

                        TESTFIELD("Act Statuss", "Act Statuss"::Completed);

                        _FAActLine.RESET;
                        _FAActLine.SETRANGE("Document No.", "No.");
                        _FAActLine.SETRANGE("Document Type", Type);
                        _FAActLine.FINDFIRST;

                        FALocationCode := "New Location Code";

                        if FALocationCode = '' then
                            exit;

                        iCount := _FAActLine.COUNT;
                        if not CONFIRM(STRSUBSTNO(AB002, FALocationCode, FORMAT(iCount)), true) then
                            exit;

                        repeat
                            rFixedAsset.GET(_FAActLine."FA No.");
                            rFixedAsset.VALIDATE("FA Location Code", FALocationCode);
                            rFixedAsset.MODIFY(true);
                        until _FAActLine.NEXT = 0;

                        MESSAGE(STRSUBSTNO(AB003, FORMAT(iCount)));
                    end;
                }
                action("Create Disposal Journal Entries")
                {
                    Caption = 'Create Disposal Journal Entries';
                    Image = FixedAssets;

                    trigger OnAction();
                    var
                        FixedAsset: Record "Fixed Asset";
                        GenJnlLine: Record "Gen. Journal Line";
                        GenJnlLine2: Record "Gen. Journal Line";
                        LineNo: Integer;
                        _FAActLine: Record "FA Act Line";
                        FAFilter: Text;
                        loop: Integer;
                        AB001: Label 'Do You want to dispose %1 fixed assets?';
                        AB002: Label 'You are not allowed to continue withou filters applied. Please, apply a filter and try again.';
                        AB003: Label 'Journal Template is not selected. Please, select one and try again.';
                        AB004: Label 'Journal Batch is not selected. Please, select one and try again.';
                        AB005: Label 'Posting Date cannot be empty. Please, enter it and try again.';
                        BookValue: Decimal;
                        FADeprBook: Record "FA Depreciation Book";
                        FASetup: Record "FA Setup";
                        pDisposalRequest: Page "FA Disposal Journal Selection";
                        JnlTemplate: Code[20];
                        JnlBatch: Code[20];
                        PostingDate: Date;
                        FALedgerEntry: Record "FA Ledger Entry";
                    begin
                        TESTFIELD(Released, true);

                        if not (Type = Type::Disposal) then
                            FIELDERROR(Type);

                        TESTFIELD("Act Statuss", "Act Statuss"::Completed);

                        loop := 0;
                        _FAActLine.RESET;
                        _FAActLine.SETRANGE("Document No.", "No.");
                        _FAActLine.SETRANGE("Document Type", Type);
                        _FAActLine.FINDFIRST;
                        repeat
                            FALedgerEntry.RESET;
                            FALedgerEntry.SETRANGE("FA No.", _FAActLine."FA No.");
                            FALedgerEntry.SETRANGE("FA Posting Category", FALedgerEntry."FA Posting Category"::Disposal);
                            if not FALedgerEntry.FINDFIRST then begin
                                loop += 1;
                                if loop = 1 then
                                    FAFilter := _FAActLine."FA No."
                                else
                                    FAFilter += '|' + _FAActLine."FA No.";
                            end;
                        until _FAActLine.NEXT = 0;

                        FixedAsset.SETFILTER("No.", '=%1', FAFilter);
                        FixedAsset.FINDFIRST;

                        if CONFIRM(STRSUBSTNO(AB001, FORMAT(FixedAsset.COUNT)), true) then begin
                            pDisposalRequest.LOOKUPMODE(true);
                            if pDisposalRequest.RUNMODAL = ACTION::OK then begin
                                pDisposalRequest.GetValues(JnlTemplate, JnlBatch, PostingDate);
                                if JnlTemplate = '' then
                                    ERROR(AB003);
                                if JnlBatch = '' then
                                    ERROR(AB004);
                                if PostingDate = 0D then
                                    ERROR(AB005);
                                CreateDisposalJnlLines(FixedAsset, JnlTemplate, JnlBatch, PostingDate);
                            end;
                        end;
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action(PrintCurrentAct)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        PrintAct(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        SetControlsEnabled;

        CurrPage.FAActDocSubpLines.PAGE.SetGlobalVariables(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    var
        OptText: Label 'Reception,Transfer,Disposal,Inventory';
        OptReq: Label 'Please, select document type';
    begin
        case STRMENU(OptText, Type::Reception, OptReq) of
            1:
                begin
                    VALIDATE(Type, Type::Reception);
                    SetDocumentNo();
                    SetControlsEnabled();
                end;
            2:
                begin
                    VALIDATE(Type, Type::Transfer);
                    SetDocumentNo();
                    SetControlsEnabled();
                end;
            3:
                begin
                    VALIDATE(Type, Type::Disposal);
                    SetDocumentNo();
                    SetControlsEnabled();
                end;
            4:
                begin
                    VALIDATE(Type, Type::Inventory);
                    SetDocumentNo();
                    SetControlsEnabled();
                end else
                        ERROR('');
        end;
    end;

    trigger OnOpenPage();
    begin
        SetControlsEnabled();
    end;

    var
        [InDataSet]
        IsFromControlsVisibled: Boolean;
        [InDataSet]
        IsToControlsVisibled: Boolean;
        [InDataSet]
        IsInventory: Boolean;
        [InDataSet]
        IsDisposal: Boolean;

    procedure SetControlsEnabled();
    begin
        case Type of
            Type::Reception:
                begin
                    IsDisposal := false;
                    IsInventory := false;
                    IsFromControlsVisibled := false;
                    IsToControlsVisibled := true;
                end;

            Type::Transfer:
                begin
                    IsDisposal := false;
                    IsInventory := false;
                    IsFromControlsVisibled := true;
                    IsToControlsVisibled := true;
                end;

            Type::Inventory:
                begin
                    IsDisposal := false;
                    IsInventory := true;
                    IsFromControlsVisibled := true;
                    IsToControlsVisibled := false;
                end;

            Type::Disposal:
                begin
                    IsDisposal := true;
                    IsInventory := false;
                    IsFromControlsVisibled := true;
                    IsToControlsVisibled := false;
                end;

        end;
    end;

    local procedure ReleaseManualy(var ActHeader: Record "FA Act Header");
    var
        errorNo: Integer;
    begin
        Release(ActHeader);
    end;

    local procedure Release(var ActHeader: Record "FA Act Header");
    begin
        if ActHeader.Released then
            exit;

        ReleasePre(ActHeader);

        ActHeader.VALIDATE(Released, true);
        ActHeader.MODIFY(false);
    end;

    local procedure ReleasePre(var ActHeader: Record "FA Act Header");
    begin
        case ActHeader.Type of
            ActHeader.Type::Reception:
                begin
                    ActHeader.TESTFIELD("New Location Code");
                    ActHeader.TESTFIELD("New Responsible SP Code");
                end;

            ActHeader.Type::Transfer:
                begin
                    ActHeader.TESTFIELD("Old Location Code");
                    ActHeader.TESTFIELD("Old Responsible SP Code");
                    ActHeader.TESTFIELD("New Location Code");
                    ActHeader.TESTFIELD("New Responsible SP Code");
                end;

            ActHeader.Type::Disposal, ActHeader.Type::Inventory:
                begin
                    ActHeader.TESTFIELD("Old Location Code");
                end;

            else
                ERROR('ReleasePre()');
        end;

        ActHeader.CALCFIELDS(Lines);
        ActHeader.TESTFIELD(Lines);
    end;

    local procedure ReOpen(var ActHeader: Record "FA Act Header");
    begin
        if not ActHeader.Released then
            exit;
        ActHeader.VALIDATE(Released, false);
        ActHeader.MODIFY(false);  //160104 EP.JG
    end;

    procedure PrintAct(var ActHeaderCurr: Record "FA Act Header");
    var
        ActHeader: Record "FA Act Header";
        FAReceiptAct: Report "FA Receipt Act";
        FAInventoryAct: Report "FA Inventory Act";
        FATransferAct: Report "FA Transfer Act";
        FADisposalAct: Report "FA Disposal Act";
    begin
        ActHeader.SETRANGE("No.", ActHeaderCurr."No.");
        ActHeader.SETRANGE(Type, ActHeaderCurr.Type);
        ActHeader.FINDFIRST;

        case ActHeader.Type of
            ActHeader.Type::Reception:
                begin
                    ActHeader.TESTFIELD("New Location Code");
                    ActHeader.TESTFIELD("New Responsible SP Code");
                    CLEAR(FAReceiptAct);
                    FAReceiptAct.SETTABLEVIEW(ActHeader);
                    FAReceiptAct.RUNMODAL;
                end;
            ActHeader.Type::Transfer:
                begin
                    ActHeader.TESTFIELD(Released, true);
                    CLEAR(FATransferAct);
                    FATransferAct.SETTABLEVIEW(ActHeader);
                    FATransferAct.RUNMODAL;
                end;
            ActHeader.Type::Inventory:
                begin
                    ActHeader.TESTFIELD("Old Location Code");
                    ActHeader.TESTFIELD("Old Responsible SP Code");
                    CLEAR(FAInventoryAct);
                    FAInventoryAct.SETTABLEVIEW(ActHeader);
                    FAInventoryAct.RUNMODAL;
                end;
            ActHeader.Type::Disposal:
                begin
                    ActHeader.TESTFIELD("Old Location Code");
                    ActHeader.TESTFIELD("Old Responsible SP Code");
                    CLEAR(FADisposalAct);
                    FADisposalAct.SETTABLEVIEW(ActHeader);
                    FADisposalAct.RUNMODAL;
                end;
            else
                ERROR('Not jet implemented!');
        end;
    end;

    procedure CreateDisposalJnlLines(var _FixedAsset: Record "Fixed Asset"; _JnlTemplate: Code[20]; _JnlBatch: Code[20]; _PostingDate: Date);
    var
        FASetup: Record "FA Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        DocNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        d: Dialog;
        bShowJournal: Boolean;
        pGenJournal: Page "Fixed Asset G/L Journal";
    begin

        if _FixedAsset.COUNT = 0 then
            ERROR('No FA found!');

        d.OPEN('Fixed Asset: ########1##########\' +
               '   Line No.: ########2##########');

        LineNo := 10000;
        GenJnlLine2.SETRANGE("Journal Template Name", _JnlTemplate);
        GenJnlLine2.SETRANGE("Journal Batch Name", _JnlBatch);
        if GenJnlLine2.FINDLAST then
            LineNo := GenJnlLine2."Line No." + 10000;

        GenJnlBatch.GET(_JnlTemplate, _JnlBatch);
        if GenJnlBatch."No. Series" <> '' then begin
            CLEAR(NoSeriesMgt);
            DocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", WORKDATE, false);
        end else
            DocNo := 'Disposal';

        bShowJournal := false;
        _FixedAsset.FIND('-');
        repeat
            d.UPDATE(1, _FixedAsset."No.");
            d.UPDATE(2, FORMAT(LineNo));
            GenJnlLine.INIT;
            GenJnlLine.VALIDATE("Journal Template Name", _JnlTemplate);
            GenJnlLine.VALIDATE("Journal Batch Name", _JnlBatch);
            GenJnlLine."Line No." := LineNo;
            GenJnlLine.VALIDATE("Posting Date", _PostingDate);
            GenJnlLine.VALIDATE("Document Date", _PostingDate);
            GenJnlLine.VALIDATE("FA Posting Date", _PostingDate);
            GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"Fixed Asset");
            GenJnlLine.VALIDATE("Account No.", _FixedAsset."No.");
            GenJnlLine.VALIDATE("Document No.", DocNo);
            GenJnlLine.VALIDATE("FA Posting Type", GenJnlLine."FA Posting Type"::Disposal);
            GenJnlLine.VALIDATE("Amount (LCY)", 0);
            GenJnlLine.INSERT(true);
            bShowJournal := true;
            LineNo += 10000;
        until _FixedAsset.NEXT = 0;

        d.CLOSE;

        if bShowJournal then begin
            GenJnlLine2.RESET;
            GenJnlLine2.SETRANGE("Journal Template Name", _JnlTemplate);
            GenJnlLine2.SETRANGE("Journal Batch Name", _JnlBatch);
            pGenJournal.SETTABLEVIEW(GenJnlLine2);
            pGenJournal.RUN;
        end;
    end;
}

