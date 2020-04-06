table 25028387 "FA Act Line"
{
    Caption = 'FA Act Line';

    fields
    {
        field(4; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Reception,Transfer,Disposal,Inventory';
            OptionMembers = Reception,Transfer,Disposal,Inventory;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "FA Act Header"."No.";
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(10; "FA No."; Code[20])
        {
            Caption = 'FA No.';
            TableRelation = "Fixed Asset"."No.";

            trigger OnLookup();
            var
                FA: Record "Fixed Asset";
                FAList: Page "Fixed Asset List";
                FA_position: Record "Fixed Asset";
                FADepreciationBook: Record "FA Depreciation Book";
                Reportsetup: Record "Report setup";
            begin
                GetAndCheckHdr();

                Reportsetup.GET();
                Reportsetup.TESTFIELD("FA Dep. Book code for Assets");
                Reportsetup.TESTFIELD("FA Dep. Book code for Low Val.");

                ActHdr.GET("Document Type", "Document No.");

                FA.SETRANGE(Inactive, false);
                FA.SETRANGE(Blocked, false);
                if "FA No." <> '' then begin
                    FA_position.SETRANGE(FA_position."No.", "FA No.");
                    if FA_position.FINDFIRST then;
                end;

                ActHdr.GET("Document Type", "Document No.");
                if ActHdr."Old Responsible SP Code" <> '' then
                    FA.SETRANGE(FA."Responsible Employee", ActHdr."Old Responsible SP Code");
                if ActHdr."Old Location Code" <> '' then
                    FA.SETRANGE(FA."FA Location Code", ActHdr."Old Location Code");

                //FA.CALCFIELDS("FA Depr. Book Code");
                FA.CLEARMARKS;
                IF FA.FINDFIRST THEN
                    REPEAT
                        if ActHdr."Low Value" then begin
                            IF FADepreciationBook.GET(FA."No.", Reportsetup."FA Dep. Book code for Low Val.") THEN
                                FA.MARK(TRUE);
                        end else begin
                            IF FADepreciationBook.GET(FA."No.", Reportsetup."FA Dep. Book code for Assets") THEN
                                FA.MARK(TRUE);
                        end;
                    UNTIL FA.NEXT = 0;

                FA.MARKEDONLY(TRUE);

                FA.SETCURRENTKEY("No.");
                FAList.SETTABLEVIEW(FA);
                FAList.SETRECORD(FA_position);
                FAList.EDITABLE(false);
                FAList.LOOKUPMODE(true);
                if FAList.RUNMODAL = ACTION::LookupOK then begin
                    FAList.GETRECORD(FA);
                    VALIDATE("FA No.", FA."No.");
                end;
            end;

            trigger OnValidate();
            var
                ActLine: Record "FA Act Line";
                DeprBook: Record "FA Depreciation Book";
                FALedgerEntry: Record "FA Ledger Entry";
            begin
                CALCFIELDS("FA Description", "Location Code", "Responsible SP Code");

                // set amount & others
                VALIDATE(Quantity, 1);
                DeprBook.SETRANGE("FA No.", "FA No.");
                if DeprBook.FINDLAST then begin
                    DeprBook.CALCFIELDS("Book Value");
                    VALIDATE("Unit Cost", DeprBook."Book Value");
                end;

                //SET OLD RESPONSIBLE PERSON AND LOCATION
                if ActHdr.GET("Document Type", "Document No.") then begin
                    ActHdr.VALIDATE(ActHdr."Old Location Code", "Location Code");
                    ActHdr.VALIDATE(ActHdr."Old Responsible SP Code", "Responsible SP Code");
                    if "Document Type" = "Document Type"::Reception then begin
                        ActHdr.Validate("New Location Code", "Location Code");
                        ActHdr.Validate("New Responsible SP Code", "Responsible SP Code");
                    end;
                    ActHdr.Modify(true);
                end;

                FALedgerEntry.RESET;
                FALedgerEntry.SETRANGE("FA No.", "FA No.");
                FALedgerEntry.SETRANGE("Document Type", FALedgerEntry."Document Type"::Invoice);
                FALedgerEntry.SETRANGE("Posting Date", 0D, ActHdr.Date);
                FALedgerEntry.SETRANGE("FA Posting Type", FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                if FALedgerEntry.FINDFIRST then
                    Rec.VALIDATE("FA Ledger Entry No.", FALedgerEntry."Entry No.");
            end;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                VALIDATE(Amount, GetAmount());
            end;
        }
        field(16; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';

            trigger OnValidate();
            begin
                VALIDATE(Amount, GetAmount());
            end;
        }
        field(17; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(48; "FA Description"; Text[100])
        {
            CalcFormula = Lookup ("Fixed Asset".Description WHERE("No." = FIELD("FA No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "FA History Entry No."; Integer)
        {
            Caption = 'FA History Entry No.';
            Editable = false;
        }
        field(300; "Insert User"; Code[50])
        {
            Caption = 'Entering User';
            Editable = false;
            TableRelation = User;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                LoginMgt: Codeunit "User Management";
            begin
                LoginMgt.DisplayUserInformation("Insert User");
            end;
        }
        field(301; "Insert DateTime"; DateTime)
        {
            Caption = 'Entering Date';
            Editable = false;
        }
        field(302; "Modify User"; Code[50])
        {
            Caption = 'Modifying User';
            Editable = false;
            TableRelation = User;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                LoginMgt: Codeunit "User Management";
            begin
                LoginMgt.DisplayUserInformation("Modify User");
            end;

            trigger OnValidate();
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(303; "Modify DateTime"; DateTime)
        {
            Caption = 'Modifying Date';
            Editable = false;
        }
        field(50000; "Disposal reason"; Text[250])
        {
            Caption = 'Disposal reason';
        }
        field(50010; "Responsible SP Code"; Code[20])
        {
            CalcFormula = Lookup ("Fixed Asset"."Responsible Employee" WHERE("No." = FIELD("FA No.")));
            Caption = 'Responsible Employee';
            FieldClass = FlowField;
        }
        field(50015; "Location Code"; Code[10])
        {
            CalcFormula = Lookup ("Fixed Asset"."FA Location Code" WHERE("No." = FIELD("FA No.")));
            Caption = 'Location Code';
            FieldClass = FlowField;
        }
        field(50020; "FA Subclass Code"; Code[10])
        {
            CalcFormula = Lookup ("Fixed Asset"."FA Subclass Code" WHERE("No." = FIELD("FA No.")));
            Caption = 'FA Subclass Code';
            FieldClass = FlowField;
        }
        field(50021; "FA Description 2"; Text[100])
        {
            CalcFormula = Lookup ("Fixed Asset"."Description 2" WHERE("No." = FIELD("FA No.")));
            Caption = 'Description 2';
            FieldClass = FlowField;
        }
        field(50022; "FA Ledger Entry No."; Integer)
        {
            Caption = 'FA Ledger Entry No.';
            TableRelation = "FA Ledger Entry"."Entry No." WHERE("FA No." = FIELD("FA No."),
                                                                 "FA Posting Type" = FILTER("Acquisition Cost"),
                                                                 "Document Type" = FILTER(Invoice | " "));
        }
        field(50023; "FA Ledger Entry Date"; Date)
        {
            CalcFormula = Lookup ("FA Ledger Entry"."Posting Date" WHERE("Entry No." = FIELD("FA Ledger Entry No.")));
            Caption = 'FA Ledger Entry Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "FA Ledger Entry Document No."; Code[20])
        {
            CalcFormula = Lookup ("FA Ledger Entry"."Document No." WHERE("Entry No." = FIELD("FA Ledger Entry No.")));
            Caption = 'FA Ledger Entry Document No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Acquisition Cost"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("FA Ledger Entry".Amount WHERE("FA No." = FIELD("FA No."),
                                                              "Depreciation Book Code" = FIELD("FA Depreciation Book Code"),
                                                              "FA Posting Category" = CONST(" "),
                                                              "FA Posting Type" = CONST("Acquisition Cost"),
                                                              "FA Posting Date" = FIELD("FA Posting Date Filter")));
            Caption = 'Acquisition Cost';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; Depreciation; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("FA Ledger Entry".Amount WHERE("FA No." = FIELD("FA No."),
                                                              "Depreciation Book Code" = FIELD("FA Depreciation Book Code"),
                                                              "FA Posting Category" = CONST(" "),
                                                              "FA Posting Type" = CONST(Depreciation),
                                                              "FA Posting Date" = FIELD("FA Posting Date Filter")));
            Caption = 'Depreciation';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50027; "Book Value"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("FA Ledger Entry".Amount WHERE("FA No." = FIELD("FA No."),
                                                              "Depreciation Book Code" = FIELD("FA Depreciation Book Code"),
                                                              "Part of Book Value" = CONST(true),
                                                              "FA Posting Date" = FIELD("FA Posting Date Filter")));
            Caption = 'Book Value';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50028; "FA Posting Date Filter"; Date)
        {
            Caption = 'FA Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(50029; "FA Depreciation Book Filter"; Code[20])
        {
            Caption = 'FA Depreciation Book Filter';
            FieldClass = FlowFilter;
            TableRelation = "Depreciation Book";
        }
        field(50030; "FA Depreciation Book Code"; Code[20])
        {
            CalcFormula = Lookup ("FA Setup"."Default Depr. Book");
            Caption = 'FA Depreciation Book Filter';
            FieldClass = FlowField;
            TableRelation = "Depreciation Book";
        }
    }

    keys
    {
        key(Key1; "Document No.", "Document Type", "Line No.")
        {
        }
        key(Key2; "FA No.", "FA History Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        CheckOnModify();
    end;

    trigger OnInsert();
    begin
        CheckOnModify;
        SetLineNo();

        "Insert User" := USERID;
        "Insert DateTime" := CURRENTDATETIME();
        "Modify User" := USERID;
        "Modify DateTime" := CURRENTDATETIME();
    end;

    trigger OnModify();
    begin
        CheckOnModify;

        "Modify User" := USERID;
        "Modify DateTime" := CURRENTDATETIME();
    end;

    trigger OnRename();
    begin
        "Modify User" := USERID;
        "Modify DateTime" := CURRENTDATETIME();
    end;

    var
        ActHdr: Record "FA Act Header";

    procedure SetLineNo();
    var
        FAActLine: Record "FA Act Line";
    begin
        if "Line No." <> 0 then
            exit;

        FAActLine.SETRANGE("Document No.", "Document No.");
        FAActLine.SETRANGE("Document Type", "Document Type");
        if FAActLine.FINDLAST then
            "Line No." := FAActLine."Line No." + 10000
        else
            "Line No." := 10000;
    end;

    procedure GetAndCheckHdr();
    begin
        ActHdr.RESET;
        ActHdr.GET("Document Type", "Document No.");
    end;

    procedure CheckOnModify();
    begin
        GetAndCheckHdr();
        ActHdr.TESTFIELD(Released, false);
    end;

    local procedure GetAmount() amount: Decimal;
    begin
        exit(ROUND(Quantity * "Unit Cost", 0.01));
    end;
}

