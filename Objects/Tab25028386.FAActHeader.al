table 25028386 "FA Act Header"
{
    Caption = 'FA Act Header';

    DrillDownPageID = "FA Act Documents";
    LookupPageID = "FA Act Documents";

    fields
    {
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Reception,Transfer,Disposal,Inventory';
            OptionMembers = Reception,Transfer,Disposal,Inventory;
        }
        field(5; Date; Date)
        {
            Caption = 'Date';

            trigger OnValidate();
            begin
                SetDocumentNo();
            end;
        }
        field(6; "Low Value"; Boolean)
        {
            Caption = 'Low Value';
        }
        field(10; Released; Boolean)
        {
            Caption = 'Released';
            Editable = false;

            trigger OnValidate();
            var
                FixedAsset: Record "Fixed Asset";
                text_Block: Label 'Do you want to block current Fixed Asset?';
            begin
                if Released then
                    VALIDATE("Released Date", TODAY)
                else
                    VALIDATE("Released Date", 0D);
            end;
        }
        field(11; "Released Date"; Date)
        {
            Caption = 'Released Date';
            Editable = false;
        }
        field(20; "New Location Code"; Code[10])
        {
            Caption = 'New Location Code';
            TableRelation = "FA Location";
        }
        field(21; "New Responsible SP Code"; Code[20])
        {
            Caption = 'New Responsible Employee Code';
            TableRelation = Employee."No.";

            trigger OnValidate();
            var
                OldRespons: Boolean;
            begin
                "New Responsible SP Name" := GetEmployeeName("New Responsible SP Code");
            end;
        }
        field(22; "New Location Name"; Text[50])
        {
            CalcFormula = Lookup ("FA Location".Name WHERE(Code = FIELD("New Location Code")));
            Caption = 'New Location';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "New Responsible SP Name"; Text[100])
        {
            Caption = 'New Responsible Employee';
            Editable = false;
        }
        field(24; "New Subclass Code"; Code[10])
        {
            Caption = 'FA Subclass Code';
            TableRelation = "FA Subclass";
        }
        field(30; "Old Location Code"; Code[10])
        {
            Caption = 'Old Location Code';
            TableRelation = "FA Location";
        }
        field(31; "Old Responsible SP Code"; Code[20])
        {
            Caption = 'Old Responsible Employee';
            TableRelation = Employee."No.";

            trigger OnValidate();
            var
                NewRespons: Boolean;
            begin
                "Old Responsible SP Name" := GetEmployeeName("Old Responsible SP Code");
            end;
        }
        field(32; "Old Location Name"; Text[50])
        {
            CalcFormula = Lookup ("FA Location".Name WHERE(Code = FIELD("Old Location Code")));
            Caption = 'New Location';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Old Responsible SP Name"; Text[100])
        {
            Caption = 'Old Responsible Employee';
            Editable = false;
        }
        field(34; "Old Subclass Code"; Code[10])
        {
            Caption = 'FA Subclass Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50; "President Of Commission Code"; Code[20])
        {
            Caption = 'President Of Commission Code';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                "President Of Commission Name" := GetEmployeeName("President Of Commission Code");
            end;
        }
        field(51; "President Of Commission Name"; Text[100])
        {
            Caption = 'President Of Commission Name';
            Editable = false;
        }
        field(52; "Members Of Commission 1 Code"; Code[20])
        {
            Caption = 'Members Of Commission 1 Code';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                "Members Of Commission 1 Name" := GetEmployeeName("Members Of Commission 1 Code")
            end;
        }
        field(53; "Members Of Commission 1 Name"; Text[100])
        {
            Caption = 'Members Of Commission 1 Name';
            Editable = false;
        }
        field(54; "Members Of Commission 2 Code"; Code[20])
        {
            Caption = 'Members Of Commission 2 Code';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                "Members Of Commission 2 Name" := GetEmployeeName("Members Of Commission 2 Code")
            end;
        }
        field(55; "Members Of Commission 2 Name"; Text[100])
        {
            Caption = 'Members Of Commission 2 Name';
            Editable = false;
        }
        field(56; "Members Of Commission 3 Code"; Code[20])
        {
            Caption = 'Members Of Commission 3 Code';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                "Members Of Commission 3 Name" := GetEmployeeName("Members Of Commission 3 Code")
            end;
        }
        field(57; "Members Of Commission 3 Name"; Text[100])
        {
            Caption = 'Members Of Commission 3 Name';
            Editable = false;
        }
        field(58; "Members Of Commission 4 Code"; Code[20])
        {
            Caption = 'Members Of Commission 4 Code';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                "Members Of Commission 4 Name" := GetEmployeeName("Members Of Commission 4 Code")
            end;
        }
        field(59; "Members Of Commission 4 Name"; Text[100])
        {
            Caption = 'Members Of Commission 4 Name';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(60; "Aproved by person code"; Code[20])
        {
            Caption = 'Aproved by person code';
            TableRelation = Employee."No.";

            trigger OnValidate();
            var
                Employee: Record Employee;
            begin
                "Aproved by person name" := GetEmployeeName("Aproved by person code");
            end;
        }
        field(70; "Aproved by person name"; Text[100])
        {
            Caption = 'Aproved by person name';
            Editable = false;
        }
        field(250; Lines; Integer)
        {
            CalcFormula = Count ("FA Act Line" WHERE("Document No." = FIELD("No."),
                                                     "FA No." = FILTER(<> ''),
                                                     "Document Type" = FIELD(Type)));
            Caption = 'Lines';
            Editable = false;
            FieldClass = FlowField;
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
            Caption = 'Modifying Date',;
            Editable = false;
        }
        field(310; "ResponsAct Number"; Code[50])
        {
            Caption = 'Act number';
        }
        field(318; "Temp First Resp. Act No."; Code[50])
        {
            Caption = 'Temp First Resp. Act No.';
        }
        field(319; "Temp SalesPerson"; Code[20])
        {
            Caption = 'Temp SalesPerson';
        }
        field(651; "President Of Comm. Job Title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE("No." = FIELD("President Of Commission Code")));
            Caption = 'President Of Comm. Job Title';
            Editable = false;
            FieldClass = FlowField;
        }
        field(653; "Members Of Comm. 1 Job Title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE("No." = FIELD("Members Of Commission 1 Code")));
            Caption = 'Members Of Comm. 1 Job Title';
            Editable = false;
            FieldClass = FlowField;
        }
        field(655; "Members Of Comm. 2 Job Title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE("No." = FIELD("Members Of Commission 2 Code")));
            Caption = 'Members Of Comm. 2 Job Title';
            Editable = false;
            FieldClass = FlowField;
        }
        field(657; "Members Of Comm. 3 Job Title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE("No." = FIELD("Members Of Commission 3 Code")));
            Caption = 'Members Of Comm. 3 Job Title';
            Editable = false;
            FieldClass = FlowField;
        }
        field(659; "Members Of Comm. 4 Job Title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE("No." = FIELD("Members Of Commission 4 Code")));
            Caption = 'Members Of Comm. 4 Job Title';
            Editable = false;
            FieldClass = FlowField;
        }
        field(670; "Aproved by person job title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE("No." = FIELD("Aproved by person code")));
            Caption = 'Aproved by person job title';
            Editable = false;
            FieldClass = FlowField;
        }
        field(671; "Warrant Number"; Code[50])
        {
            Caption = 'Warrant Number';
        }
        field(672; "Warrant date"; Date)
        {
            Caption = 'Warrant Date';
        }
        field(673; "Reason Of Disposal"; Text[100])
        {
            Caption = 'Reason Of Disposal';
        }
        field(674; "Comission Closure"; Text[100])
        {
            Caption = 'Comission Closure';
        }
        field(675; "Act Statuss"; Option)
        {
            Caption = 'Act Statuss';
            DataClassification = ToBeClassified;
            OptionCaption = 'Prepared,Completed,Canceled';
            OptionMembers = Prepared,Completed,Canceled;
        }
    }

    keys
    {
        key(Key1; Type, "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TESTFIELD(Released, false);
        CALCFIELDS(Lines);
        TESTFIELD(Lines, 0);
    end;

    trigger OnInsert();
    begin
        "Insert User" := USERID;
        "Insert DateTime" := CURRENTDATETIME();
        "Modify User" := USERID;
        "Modify DateTime" := CURRENTDATETIME();

        if Date = 0D then
            Date := TODAY();

        SetDocumentNo();
        if "No." <> '' then
            "ResponsAct Number" := "No.";
    end;

    trigger OnModify();
    begin

        TESTFIELD(Released, false);

        "Modify User" := USERID;
        "Modify DateTime" := CURRENTDATETIME();
    end;

    trigger OnRename();
    begin
        "Modify User" := USERID;
        "Modify DateTime" := CURRENTDATETIME();
    end;

    var
        FASetup: Record "FA Setup";
        Employee: Record Employee;

    procedure SetDocumentNo();
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Reportsetup: Record "Report setup";
    begin
        if "No." <> '' then
            exit;

        Reportsetup.GET;
        case Type of
            Type::Reception:
                begin
                    NoSeriesMgt.InitSeries(
                      Reportsetup."FA Receipt Act No. Series",
                      Reportsetup."FA Receipt Act No. Series",
                      Date,
                      "No.",
                      Reportsetup."FA Receipt Act No. Series");
                end;
            Type::Transfer:
                begin
                    NoSeriesMgt.InitSeries(
                      Reportsetup."FA Transfer Act No. Series",
                      Reportsetup."FA Transfer Act No. Series",
                      Date,
                      "No.",
                      Reportsetup."FA Transfer Act No. Series");
                end;
            Type::Disposal:
                begin
                    NoSeriesMgt.InitSeries(
                        Reportsetup."FA Disposal Act No. Series",
                        Reportsetup."FA Disposal Act No. Series",
                        Date,
                        "No.",
                        Reportsetup."FA Disposal Act No. Series");
                end;
            Type::Inventory:
                begin
                    NoSeriesMgt.InitSeries(
                        Reportsetup."FA Inventory Act No. Series",
                        Reportsetup."FA Inventory Act No. Series",
                        Date,
                        "No.",
                        Reportsetup."FA Inventory Act No. Series");
                end;
        end;
    end;

    procedure ChangeDocType();
    begin
        if xRec.Type = Rec.Type then
            exit;

        case Type of
            Type::Reception:
                begin
                    if "Old Location Code" <> '' then
                        VALIDATE("Old Location Code", '');
                    if "Old Responsible SP Code" <> '' then
                        VALIDATE("Old Responsible SP Code", '');
                end;

            Type::Transfer:
                begin
                end;

            Type::Disposal:
                begin
                end;

            else
                ERROR('ChangeDocType(). Code is not implemented!');
        end;
    end;

    procedure GetEmployeeName(employeeCode: Code[20]): Text;
    var
        employee: Record Employee;
    begin
        if employeeCode = '' then
            exit('');
        employee.get(employeeCode);
        exit(employee.FullName());
    end;

    procedure FillFALinesByDefault(var _rec: Record "FA Act Header");
    var
        FAActLine: Record "FA Act Line";
        FixedAsset: Record "Fixed Asset";
        FALedgerEntry: Record "FA Ledger Entry";
    begin
        _rec.TESTFIELD(Released, false);
        _rec.CALCFIELDS(Lines);
        _rec.TESTFIELD(Lines, 0);
        _rec.TESTFIELD("Old Responsible SP Code");

        FixedAsset.RESET;
        FixedAsset.SETRANGE("Responsible Employee", "Old Responsible SP Code");
        FixedAsset.SETRANGE(Blocked, false);
        FixedAsset.SETRANGE(Inactive, false);
        FixedAsset.FINDFIRST;
        repeat
            FALedgerEntry.RESET;
            FALedgerEntry.SETRANGE("FA No.", FixedAsset."No.");
            FALedgerEntry.SETRANGE("FA Posting Category", FALedgerEntry."FA Posting Category"::Disposal);
            if not FALedgerEntry.FINDFIRST then begin
                FAActLine.INIT;
                FAActLine."Document No." := _rec."No.";
                FAActLine."Document Type" := _rec.Type;
                FAActLine."Line No." := 0;
                FAActLine.INSERT(true);
                FAActLine.VALIDATE("FA No.", FixedAsset."No.");
                FAActLine.MODIFY(true);
            end;
        until FixedAsset.NEXT = 0;
    end;
}

