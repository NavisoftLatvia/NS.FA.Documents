table 50280 "FA Act Header"
{

    CaptionML = ENU = 'FA Act Header',
                LVI = 'Pamatlīdzekļu dokumenta galvene';

    DrillDownPageID = "FA Act Documents";
    LookupPageID = "FA Act Documents";

    fields
    {
        field(3; "No."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        LVI = 'Nr.';
        }
        field(4; Type; Option)
        {
            CaptionML = ENU = 'Type',
                        LVI = 'Tips';
            OptionCaptionML = ENU = 'Reception,Transfer,Disposal,Inventory',
                              LVI = 'Pieņemšana,Pārvietošana,Norakstīšana,Inventarizācija';
            OptionMembers = Reception,Transfer,Disposal,Inventory;
        }
        field(5; Date; Date)
        {
            CaptionML = ENU = 'Date',
                        LVI = 'Datums';

            trigger OnValidate();
            begin
                SetDocumentNo();
            end;
        }
        field(6; "Low Value"; Boolean)
        {
            CaptionML = ENU = 'Low Value',
                        LVI = 'Mazvērtīgais inventārs';
        }
        field(10; Released; Boolean)
        {
            CaptionML = ENU = 'Released',
                        LVI = 'Nodots';
            Editable = false;

            trigger OnValidate();
            var
                FixedAsset: Record "Fixed Asset";
                text_Block: TextConst ENU = 'Do you want to block current Fixed Asset?', LVI = 'Vai Jūs vēlaties lai attiecīgais pamatlīdzeklis tiktu bloķēts?';
            begin
                if Released then
                    VALIDATE("Released Date", TODAY)
                else
                    VALIDATE("Released Date", 0D);
            end;
        }
        field(11; "Released Date"; Date)
        {
            CaptionML = ENU = 'Released Date',
                        LVI = 'Nodota datums';
            Editable = false;
        }
        field(20; "New Location Code"; Code[10])
        {
            CaptionML = ENU = 'New Location Code',
                        LVI = 'Jauns novietojuma kods';
            TableRelation = "FA Location";
        }
        field(21; "New Responsible SP Code"; Code[20])
        {
            CaptionML = ENU = 'New Responsible Employee Code',
                        LVI = 'Jaunā PL lietotāja kods';
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
            CalcFormula = Lookup ("FA Location".Name WHERE (Code = FIELD ("New Location Code")));
            CaptionML = ENU = 'New Location',
                        LVI = 'Jauns novietojums';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "New Responsible SP Name"; Text[100])
        {
            //CalcFormula = Lookup (Employee.Field50004 WHERE ("No." = FIELD ("New Responsible SP Code")));
            CaptionML = ENU = 'New Responsible Employee',
                        LVI = 'Jaunais PL lietotājs';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(24; "New Subclass Code"; Code[10])
        {
            CaptionML = ENU = 'FA Subclass Code',
                        LVI = 'Jauns lietotāja kods';
            TableRelation = "FA Subclass";
        }
        field(30; "Old Location Code"; Code[10])
        {
            CaptionML = ENU = 'Old Location Code',
                        LVI = 'Vecais novietojuma kods';
            TableRelation = "FA Location";
        }
        field(31; "Old Responsible SP Code"; Code[20])
        {
            CaptionML = ENU = 'Old Responsible Employee',
                        LVI = 'Vecā PL lietotāja kods';
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
            CalcFormula = Lookup ("FA Location".Name WHERE (Code = FIELD ("Old Location Code")));
            CaptionML = ENU = 'New Location',
                        LVI = 'Vecais novietojums';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Old Responsible SP Name"; Text[100])
        {
            //CalcFormula = Lookup (Employee.Field50004 WHERE ("No." = FIELD ("Old Responsible SP Code")));
            CaptionML = ENU = 'Old Responsible Employee',
                        LVI = 'Vecais PL lietotājs';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(34; "Old Subclass Code"; Code[10])
        {
            CaptionML = ENU = 'FA Subclass Code',
                        LVI = 'Vecais lietotāja kods';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50; "President Of Commission Code"; Code[20])
        {
            CaptionML = ENU = 'President Of Commission Code',
                        LVI = 'Komisijas priekšsēdētāja kods';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                //CALCFIELDS("President Of Commission Name");
                "President Of Commission Name" := GetEmployeeName("President Of Commission Code");
            end;
        }
        field(51; "President Of Commission Name"; Text[100])
        {
            //CalcFormula = Lookup (Employee.Field50004 WHERE ("No." = FIELD ("President Of Commission Code")));
            CaptionML = ENU = 'President Of Commission Name',
                        LVI = 'Komisijas priekšsēdētāja vārds';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(52; "Members Of Commission 1 Code"; Code[20])
        {
            CaptionML = ENU = 'Members Of Commission 1 Code',
                        LVI = 'Komisijas locekļa 1 kods';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                "Members Of Commission 1 Name" := GetEmployeeName("Members Of Commission 1 Code")
                //CALCFIELDS("Members Of Commission 1 Name");
            end;
        }
        field(53; "Members Of Commission 1 Name"; Text[100])
        {
            //CalcFormula = Lookup (Employee.Field50004 WHERE ("No." = FIELD ("Members Of Commission 1 Code")));
            CaptionML = ENU = 'Members Of Commission 1 Name',
                        LVI = 'Komisijas locekļa 1 vārds';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(54; "Members Of Commission 2 Code"; Code[20])
        {
            CaptionML = ENU = 'Members Of Commission 2 Code',
                        LVI = 'Komisijas locekļa 2 kods';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                //CALCFIELDS("Members Of Commission 2 Name");
                "Members Of Commission 2 Name" := GetEmployeeName("Members Of Commission 2 Code")
            end;
        }
        field(55; "Members Of Commission 2 Name"; Text[100])
        {
            //CalcFormula = Lookup (Employee.Field50004 WHERE ("No." = FIELD ("Members Of Commission 2 Code")));
            CaptionML = ENU = 'Members Of Commission 2 Name',
                        LVI = 'Komisijas locekļa 2 vārds';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(56; "Members Of Commission 3 Code"; Code[20])
        {
            CaptionML = ENU = 'Members Of Commission 3 Code',
                        LVI = 'Komisijas locekļa 3 kods';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                "Members Of Commission 3 Name" := GetEmployeeName("Members Of Commission 3 Code")
                //CALCFIELDS("Members Of Commission 3 Name");
            end;
        }
        field(57; "Members Of Commission 3 Name"; Text[100])
        {
            //CalcFormula = Lookup (Employee.Field50004 WHERE ("No." = FIELD ("Members Of Commission 3 Code")));
            CaptionML = ENU = 'Members Of Commission 3 Name',
                        LVI = 'Komisijas locekļa 3 vārds';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(58; "Members Of Commission 4 Code"; Code[20])
        {
            CaptionML = ENU = 'Members Of Commission 4 Code',
                        LVI = 'Komisijas locekļa 4 kods';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                //CALCFIELDS("Members Of Commission 4 Name");
                "Members Of Commission 4 Name" := GetEmployeeName("Members Of Commission 4 Code")
            end;
        }
        field(59; "Members Of Commission 4 Name"; Text[100])
        {
            //CalcFormula = Lookup (Employee.Field50004 WHERE ("No." = FIELD ("Members Of Commission 4 Code")));
            CaptionML = ENU = 'Members Of Commission 4 Name',
                        LVI = 'Komisijas locekļa 4 vārds';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(60; "Aproved by person code"; Code[20])
        {
            CaptionML = ENU = 'Aproved by person code',
                        LVI = 'Apstiprinātāja kods';
            TableRelation = Employee."No.";

            trigger OnValidate();
            var
                Employee: Record Employee;
            begin
                //CALCFIELDS("Members Of Commission 4 Name");
                "Aproved by person name" := GetEmployeeName("Aproved by person code");
            end;
        }
        field(70; "Aproved by person name"; Text[100])
        {
            //CalcFormula = Lookup (Employee.Field50004 WHERE ("No." = FIELD ("Aproved by person code")));
            CaptionML = ENU = 'Aproved by person name',
                        LVI = 'Apstiprinātāja vārds';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(250; Lines; Integer)
        {
            CalcFormula = Count ("FA Act Line" WHERE ("Document No." = FIELD ("No."),
                                                     "FA No." = FILTER (<> ''),
                                                     "Document Type" = FIELD (Type)));
            CaptionML = ENU = 'Lines',
                        LVI = 'Rindas';
            Editable = false;
            FieldClass = FlowField;
        }
        field(300; "Insert User"; Code[50])
        {
            CaptionML = ENU = 'Entering User',
                        LVI = 'Ievades lietotājs';
            Editable = false;
            TableRelation = User;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                LoginMgt: Codeunit "User Management";
            begin
                LoginMgt.LookupUserID("Insert User");
            end;
        }
        field(301; "Insert DateTime"; DateTime)
        {
            CaptionML = LVI = 'Ievades laiks',
                        ENG = 'Entering Date';
            Editable = false;
        }
        field(302; "Modify User"; Code[50])
        {
            CaptionML = ENU = 'Modifying User',
                        LVI = 'Koriģēšanas lietotājs';
            Editable = false;
            TableRelation = User;

            ValidateTableRelation = false;

            trigger OnLookup();
            var
                LoginMgt: Codeunit "User Management";
            begin
                LoginMgt.LookupUserID("Modify User");
            end;

            trigger OnValidate();
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(303; "Modify DateTime"; DateTime)
        {
            CaptionML = ENU = 'Modifying Date',
                        LVI = 'Koriģēšanas laiks';
            Editable = false;
        }
        field(310; "ResponsAct Number"; Code[50])
        {
            CaptionML = ENU = 'Act number',
                        LVI = 'Akta numurs';
        }
        field(318; "Temp First Resp. Act No."; Code[50])
        {
            CaptionML = ENU = 'Temp First Resp. Act No.',
                        LVI = 'Pagaidu Akta numurs';
        }
        field(319; "Temp SalesPerson"; Code[20])
        {
            CaptionML = ENU = 'Temp SalesPerson',
                        LVI = 'Pagaidu Pārdevējs';
        }
        field(651; "President Of Comm. Job Title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE ("No." = FIELD ("President Of Commission Code")));
            CaptionML = ENU = 'President Of Comm. Job Title',
                        LVI = 'Komisijas priekšsēdētāja amats';
            Editable = false;
            FieldClass = FlowField;
        }
        field(653; "Members Of Comm. 1 Job Title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE ("No." = FIELD ("Members Of Commission 1 Code")));
            CaptionML = ENU = 'Members Of Comm. 1 Job Title',
                        LVI = 'Komisijas locekļa 1 amats';
            Editable = false;
            FieldClass = FlowField;
        }
        field(655; "Members Of Comm. 2 Job Title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE ("No." = FIELD ("Members Of Commission 2 Code")));
            CaptionML = ENU = 'Members Of Comm. 2 Job Title',
                        LVI = 'Komisijas locekļa 2 amats';
            Editable = false;
            FieldClass = FlowField;
        }
        field(657; "Members Of Comm. 3 Job Title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE ("No." = FIELD ("Members Of Commission 3 Code")));
            CaptionML = ENU = 'Members Of Comm. 3 Job Title',
                        LVI = 'Komisijas locekļa 3 amats';
            Editable = false;
            FieldClass = FlowField;
        }
        field(659; "Members Of Comm. 4 Job Title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE ("No." = FIELD ("Members Of Commission 4 Code")));
            CaptionML = ENU = 'Members Of Comm. 4 Job Title',
                        LVI = 'Komisijas locekļa 4 amats';
            Editable = false;
            FieldClass = FlowField;
        }
        field(670; "Aproved by person job title"; Text[100])
        {
            CalcFormula = Lookup (Employee."Job Title" WHERE ("No." = FIELD ("Aproved by person code")));
            CaptionML = ENU = 'Aproved by person job title',
                        LVI = 'Apstiprinātāja amats';
            Editable = false;
            FieldClass = FlowField;
        }
        field(671; "Warrant Number"; Code[50])
        {
            CaptionML = ENU = 'Warrant Number',
                        LVI = 'Rīkojuma Nr.';
        }
        field(672; "Warrant date"; Date)
        {
            CaptionML = ENU = 'Warrant Date',
                        LVI = 'Rīkojuma datums.';
        }
        field(673; "Reason Of Disposal"; Text[100])
        {
            CaptionML = ENU = 'Reason Of Disposal',
                        LVI = 'Likvidācijas iemesls';
        }
        field(674; "Comission Closure"; Text[100])
        {
            CaptionML = ENU = 'Comission Closure',
                        LVI = 'Komisijas slēdziens';
        }
        field(675; "Act Statuss"; Option)
        {
            CaptionML = ENU = 'Act Statuss',
                        LVI = 'Akta statuss';
            DataClassification = ToBeClassified;
            OptionCaptionML = ENU = 'Prepared,Completed,Canceled',
                              LVI = 'Sagatavots,Pabeigts,Atcelts';
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

        // act has been creteated with default type from FA Card and can be changed

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

