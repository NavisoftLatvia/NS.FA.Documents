page 50284 "Fixed Asset Selection"
{
    CaptionML = ENU = 'Fixed Asset List',
                LVI = 'Pamatlīdzekļu saraksts';
    CardPageID = "Fixed Asset Card";
    PageType = List;
    SourceTable = "Fixed Asset";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    ApplicationArea = FixedAssets;
                    ToolTipML = ENU = 'Specifies a number for the fixed asset.',
                                LVI = 'Norāda pamatlīdzekļa numuru.';
                }
                field(Description; Description)
                {
                    ApplicationArea = FixedAssets;
                    ToolTipML = ENU = 'Specifies a description of the fixed asset.',
                                LVI = 'Norāda pamatlīdzekļa aprakstu.';
                }
                field("Description 2"; "Description 2")
                {
                    Visible = false;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                }
                field(Blocked; Blocked)
                {
                }
                field(Inactive; Inactive)
                {
                }
                field(DisposalDate; WriteDownDate)
                {
                    CaptionML = ENU = 'Disposal Date',
                                LVI = 'Noņemts no uzskaites';
                }
                field("Responsible Employee"; "Responsible Employee")
                {
                    ToolTipML = ENU = 'Specifies which employee is responsible for the fixed asset.',
                                LVI = 'Norāda, kurš darbinieks ir atbildīgs par pamatlīdzekli.';
                }
                field("FA Class Code"; "FA Class Code")
                {
                    ApplicationArea = FixedAssets;
                    ToolTipML = ENU = 'Specifies the class that the fixed asset belongs to.',
                                LVI = 'Norāda klasi, kurai pieder pamatlīdzeklis.';
                }
                field(FaClassName; FaClassName)
                {
                    CaptionML = ENU = 'FA Class Name',
                                LVI = 'PL klases nosaukums';
                    Editable = false;
                }
                field("FA Subclass Code"; "FA Subclass Code")
                {
                    ApplicationArea = FixedAssets;
                    ToolTipML = ENU = 'Specifies the subclass of the class that the fixed asset belongs to.',
                                LVI = 'Norāda apakšklasi - klasei, kurai pieder pamatlīdzeklis.';
                }
                field(FASubClassName; FASubClassName)
                {
                    CaptionML = ENU = 'FA Subclass Name',
                                LVI = 'PL apakāšklases nosaukums';
                    Editable = false;
                }
                field("FA Location Code"; "FA Location Code")
                {
                    ApplicationArea = FixedAssets;
                    ToolTipML = ENU = 'Specifies the location, such as a building, where the fixed asset is located.',
                                LVI = 'Nosaka novietojumu, piemēram, ēku, kur atrodas pamatlīdzeklis.';
                }
                field(FALocationName; FALocationName)
                {
                    CaptionML = ENU = 'FA Location Name',
                                LVI = 'PL Novietojuma nosaukums';
                    Editable = false;
                }
                field("FA Posting Group"; "FA Posting Group")
                {
                }
                field("Search Description"; "Search Description")
                {
                    ToolTipML = ENU = 'Specifies a search description for the fixed asset.',
                                LVI = 'Norāda pamatlīdzekļa meklēšanas aprakstu.';
                    Visible = false;
                }
                field(Acquired; Acquired)
                {
                    ApplicationArea = FixedAssets;
                    ToolTipML = ENU = 'Specifies that the fixed asset has been acquired.',
                                LVI = 'Norāda, ka pamatlīdzeklis ir iegādāts.';
                }
                field(DeprBookName; DeprBookName)
                {
                    CaptionML = ENU = 'Depreciation Book Code',
                                LVI = 'Nolietojuma grāmata';
                    Editable = false;
                    TableRelation = "FA Depreciation Book"."Depreciation Book Code";
                }
                field(AcquisitionCost; AcquisitionCost)
                {
                    CaptionML = ENU = 'Acquisition Cost',
                                LVI = 'Iepirkuma vērtība';
                    Editable = false;
                }
                field(DeprBookValue; DeprBookValue)
                {
                    CaptionML = ENU = 'Book Value',
                                LVI = 'Grāmatvedības vērtība';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                }
                field("Budgeted Asset"; "Budgeted Asset")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies if the asset is for budgeting purposes.',
                                LVI = 'Norāda, vai pamatlīdzeklis ir paredzēts budžeta veidošanas nolūkiem.';
                    Visible = false;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = FixedAssets;
                    ToolTipML = ENU = 'Specifies the number of the vendor from which you purchased this fixed asset.',
                                LVI = 'Norāda piegādātāja numuru, no kura tika iepirkts šis pamatlīdzeklis.';
                }
                field("Maintenance Vendor No."; "Maintenance Vendor No.")
                {
                    ApplicationArea = FixedAssets;
                    ToolTipML = ENU = 'Specifies the number of the vendor who performs repairs and maintenance on the fixed asset.',
                                LVI = 'Norāda piegādātāja numuru, kas veic pamatlīdzekļa remontu un uzturēšanu.';
                    Visible = false;
                }
                field(Image; Image)
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Fixed &Asset")
            {
                CaptionML = ENU = 'Fixed &Asset',
                            LVI = 'P&amatlīdzeklis';
                Image = FixedAssets;
                action("Depreciation &Books")
                {
                    ApplicationArea = FixedAssets;
                    CaptionML = ENU = 'Depreciation &Books',
                                LVI = 'Nolietojuma &grāmatas';
                    Image = DepreciationBooks;
                    RunObject = Page "FA Depreciation Books";
                    RunPageLink = "FA No." = FIELD ("No.");
                    ToolTip = 'View or edit the depreciation book or books that must be used for each of the fixed assets. Here you also specify the way depreciation must be calculated.';
                }
                action(Statistics)
                {
                    ApplicationArea = FixedAssets;
                    CaptionML = ENU = 'Statistics',
                                LVI = 'Statistika';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Fixed Asset Statistics";
                    RunPageLink = "FA No." = FIELD ("No.");
                    ShortCutKey = 'F7';
                    ToolTipML = ENU = 'View detailed historical information about the fixed asset.',
                                LVI = 'Skatīt detalizētu vēsturisko informāciju par pamatlīdzekļiem.';
                }
                group(Dimensions)
                {
                    CaptionML = ENU = 'Dimensions',
                                LVI = 'Dimensijas';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Dimensions-Single',
                                    LVI = 'Dimensijas-viena';
                        Image = Dimensions;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST (5600),
                                      "No." = FIELD ("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                        ToolTipML = ENU = 'View or edit the single set of dimensions that are set up for the selected record.',
                                    LVI = 'Skatīt vai rediģēt atsevišķu dimensiju kopu, kas iestatīta izvēlētajam ierakstam.';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Dimensions-&Multiple',
                                    LVI = 'Dimensijas-&vairākas';
                        Image = DimensionSets;
                        Promoted = true;
                        PromotedCategory = Process;
                        ToolTipML = ENU = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.',
                                    LVI = 'Skatīt vai rediģēt dimensijas ierakstu grupai. Varat piešķirt dimensiju kodus transakcijām, lai sadalītu izmaksas un analizētu vēsturisko informāciju.';

                        trigger OnAction();
                        var
                            FA: Record "Fixed Asset";
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(FA);
                            DefaultDimMultiple.SetMultiFA(FA);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("Main&tenance Ledger Entries")
                {
                    ApplicationArea = FixedAssets;
                    CaptionML = ENU = 'Main&tenance Ledger Entries',
                                LVI = 'Uz&turēšanas grāmatas ieraksti';
                    Image = MaintenanceLedgerEntries;
                    RunObject = Page "Maintenance Ledger Entries";
                    RunPageLink = "FA No." = FIELD ("No.");
                    RunPageView = SORTING ("FA No.");
                    ToolTipML = ENU = 'View all the maintenance ledger entries for a fixed asset. ',
                                LVI = 'Skatīt visus uzturēšanas grāmatas ierakstus - pamatlīdzeklim. ';
                }
                action(Picture)
                {
                    ApplicationArea = FixedAssets;
                    CaptionML = ENU = 'Picture',
                                LVI = 'Attēls';
                    Image = Picture;
                    RunObject = Page "Fixed Asset Picture";
                    RunPageLink = "No." = FIELD ("No.");
                    ToolTipML = ENU = 'Add or view a picture of the fixed asset.',
                                LVI = 'Pievienot vai skatīt pamatlīdzekļa attēlu.';
                }
                action("FA Posting Types Overview")
                {
                    ApplicationArea = FixedAssets;
                    CaptionML = ENU = 'FA Posting Types Overview',
                                LVI = 'PL kontējuma tipu pārskats';
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FA Posting Types Overview";
                    ToolTip = 'View accumulated amounts for each field, such as book value, acquisition cost, and depreciation, and for each fixed asset. For every fixed asset, a separate line is shown for each depreciation book linked to the asset.';
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                LVI = 'Ko&mentāri';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST ("Fixed Asset"),
                                  "No." = FIELD ("No.");
                }
            }
            group("Main Asset")
            {
                CaptionML = ENU = 'Main Asset',
                            LVI = 'Galvenais PL';
                Image = Components;
                action("M&ain Asset Components")
                {
                    ApplicationArea = FixedAssets;
                    CaptionML = ENU = 'M&ain Asset Components',
                                LVI = 'G&alvenā PL komponenti';
                    Image = Components;
                    RunObject = Page "Main Asset Components";
                    RunPageLink = "Main Asset No." = FIELD ("No.");
                    ToolTipML = ENU = 'View or edit fixed asset components of the main fixed asset that is represented by the fixed asset card.',
                                LVI = 'Skatīt vai rediģēt galvenā pamatlīdzekļa komponentes, ko attēlo pamatlīdzekļa karte.';
                }
                action("Ma&in Asset Statistics")
                {
                    ApplicationArea = FixedAssets;
                    CaptionML = ENU = 'Ma&in Asset Statistics',
                                LVI = 'Galvenā PL stat&istika';
                    Image = StatisticsDocument;
                    RunObject = Page "Main Asset Statistics";
                    RunPageLink = "FA No." = FIELD ("No.");
                    ToolTip = 'View detailed historical information about all the components that make up the main asset.';
                }
                separator(Separator45)
                {
                    CaptionML = ENU = '',
                                LVI = '';
                }
            }
            group(History)
            {
                CaptionML = ENU = 'History',
                            LVI = 'Vēsture';
                Image = History;
                action("Ledger E&ntries")
                {
                    ApplicationArea = FixedAssets;
                    CaptionML = ENU = 'Ledger E&ntries',
                                LVI = 'Grāmatas ie&raksti';
                    Image = FixedAssetLedger;
                    RunObject = Page "FA Ledger Entries";
                    RunPageLink = "FA No." = FIELD ("No.");
                    RunPageView = SORTING ("FA No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTipML = ENU = 'View detailed information about transactions made for the fixed asset.',
                                LVI = 'Skatīt detalizētu informāciju par transakcijām, kas veiktas pamatlīdzeklim.';
                }
                action("Error Ledger Entries")
                {
                    ApplicationArea = FixedAssets;
                    CaptionML = ENU = 'Error Ledger Entries',
                                LVI = 'Kļūdu grāmatas ieraksti';
                    Image = ErrorFALedgerEntries;
                    RunObject = Page "FA Error Ledger Entries";
                    RunPageLink = "Canceled from FA No." = FIELD ("No.");
                    RunPageView = SORTING ("Canceled from FA No.")
                                  ORDER(Descending);
                    ToolTipML = ENU = 'View the entries that have been posted as a result of you using the Cancel function to cancel an entry.',
                                LVI = 'Skatīt ierakstus, kas tika iegrāmatoti izmantojot atcelšanas funkciju, lai atceltu ierakstu.';
                }
                action("Maintenance &Registration")
                {
                    ApplicationArea = FixedAssets;
                    CaptionML = ENU = 'Maintenance &Registration',
                                LVI = 'Uzturēšanas &reģistrācija';
                    Image = MaintenanceRegistrations;
                    RunObject = Page "Maintenance Registration";
                    RunPageLink = "FA No." = FIELD ("No.");
                    ToolTip = 'View or edit maintenance codes for the various types of maintenance, repairs, and services performed on your fixed assets. You can then enter the code in the Maintenance Code field on journals.';
                }
            }
        }
        area(processing)
        {
            action("Fixed Asset Journal")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Fixed Asset Journal',
                            LVI = 'Pamatlīdzekļu žurnāls';
                Image = Journal;
                RunObject = Page "Fixed Asset Journal";
                ToolTip = '"Post fixed asset transactions with a depreciation book that is not integrated with the general ledger, for internal management. Only fixed asset ledger entries are created. "';
            }
            action("Fixed Asset G/L Journal")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Fixed Asset G/L Journal',
                            LVI = 'Pamatlīdzekļu V/G žurnāls';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Fixed Asset G/L Journal";
                ToolTip = '"Post fixed asset transactions with a depreciation book that is integrated with the general ledger, for financial reporting. Both fixed asset ledger entries are general ledger entries are created. "';
            }
            action("Fixed Asset Reclassification Journal")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Fixed Asset Reclassification Journal',
                            LVI = 'Pamatlīdzekļu pārklasif. žurnāls';
                Image = Journal;
                RunObject = Page "FA Reclass. Journal";
                ToolTipML = ENU = 'Transfer, split, or combine fixed assets.',
                            LVI = 'Pamatlīdzekļu pārvietošana, sadalīšana vai apvienošana.';
            }
            action("Recurring Fixed Asset Journal")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Recurring Fixed Asset Journal',
                            LVI = 'Periodiskais PL žurnāls';
                Image = Journal;
                RunObject = Page "Recurring Fixed Asset Journal";
                ToolTip = 'Post recurring entries to a depreciation book without integration with general ledger.';
            }
            action(CalculateDepreciation)
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Calculate Depreciation',
                            LVI = 'Aprēķināt nolietojumu';
                Ellipsis = true;
                Image = CalculateDepreciation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Calculate depreciation according to conditions that you specify. If the related depreciation book is set up to integrate with the general ledger, then the calculated entries are transferred to the fixed asset general ledger journal. Otherwise, the calculated entries are transferred to the fixed asset journal. You can then review the entries and post the journal.';

                trigger OnAction();
                begin
                    REPORT.RUNMODAL(REPORT::"Calculate Depreciation", true, false, Rec);
                end;
            }
            action("C&opy Fixed Asset")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'C&opy Fixed Asset',
                            LVI = 'K&opēt pamatlīdzekli';
                Ellipsis = true;
                Image = CopyFixedAssets;
                ToolTipML = ENU = 'Create one or more new fixed assets by copying from an existing fixed asset that has similar information.',
                            LVI = 'Izveidot vienu vai vairākus jaunus pamatlīdzekļus, kopējot datus no esoša pamatlīdzekļa, kam ir līdzīgi parametri.';

                trigger OnAction();
                var
                    CopyFA: Report "Copy Fixed Asset";
                begin
                    CopyFA.SetFANo("No.");
                    CopyFA.RUNMODAL;
                end;
            }
            group("Mass Assign")
            {
                CaptionML = ENU = 'Mass Assign',
                            LVI = 'Masveida izmaiņas';
                action("Assign Employee")
                {
                    CaptionML = ENU = 'Assign Employee',
                                LVI = 'Mainīt atbildīgo personu';
                    Image = Employee;

                    trigger OnAction();
                    var
                        pEmployeeList: Page "Employee List";
                        EmployeeNo: Code[20];
                        rEmployee: Record Employee;
                        rFixedAsset: Record "Fixed Asset";
                        iCount: Integer;
                    begin

                        if Rec.GETFILTERS = '' then
                            ERROR(AB001);

                        rFixedAsset.COPYFILTERS(Rec);
                        if not rFixedAsset.FIND('-') then
                            exit;

                        EmployeeNo := '';
                        pEmployeeList.LOOKUPMODE(true);
                        if pEmployeeList.RUNMODAL = ACTION::LookupOK then begin
                            pEmployeeList.GETRECORD(rEmployee);
                            EmployeeNo := rEmployee."No.";
                            rEmployee.GET(EmployeeNo);
                        end;

                        if EmployeeNo = '' then
                            exit;

                        iCount := rFixedAsset.COUNT;
                        if not CONFIRM(STRSUBSTNO(AB002, rEmployee."First Name" + ' ' + rEmployee."Last Name", FORMAT(iCount)), true) then
                            exit;

                        repeat
                            rFixedAsset.VALIDATE("Responsible Employee", EmployeeNo);
                            rFixedAsset.MODIFY(true);
                        until rFixedAsset.NEXT = 0;

                        MESSAGE(STRSUBSTNO(AB003, FORMAT(iCount)));
                    end;
                }
                action("Assign Location")
                {
                    CaptionML = ENU = 'Assign Location',
                                LVI = 'Mainīt novietojumu';
                    Image = Map;

                    trigger OnAction();
                    var
                        pFALocations: Page "FA Locations";
                        FALocationCode: Code[20];
                        rFALocation: Record "FA Location";
                        rFixedAsset: Record "Fixed Asset";
                        iCount: Integer;
                    begin

                        if Rec.GETFILTERS = '' then
                            ERROR(AB001);

                        rFixedAsset.COPYFILTERS(Rec);
                        if not rFixedAsset.FIND('-') then
                            exit;

                        FALocationCode := '';
                        pFALocations.LOOKUPMODE(true);
                        if pFALocations.RUNMODAL = ACTION::LookupOK then begin
                            pFALocations.GETRECORD(rFALocation);
                            FALocationCode := rFALocation.Code;
                            rFALocation.GET(FALocationCode);
                        end;

                        if FALocationCode = '' then
                            exit;

                        iCount := rFixedAsset.COUNT;
                        if not CONFIRM(STRSUBSTNO(AB002, FALocationCode, FORMAT(iCount)), true) then
                            exit;

                        repeat
                            rFixedAsset.VALIDATE("FA Location Code", FALocationCode);
                            rFixedAsset.MODIFY(true);
                        until rFixedAsset.NEXT = 0;

                        MESSAGE(STRSUBSTNO(AB003, FORMAT(iCount)));
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Fixed Assets List")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Fixed Assets List',
                            LVI = 'Pamatlīdzekļu saraksts';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - List";
                ToolTipML = ENU = 'View the list of fixed assets that exist in the system .',
                            LVI = 'Skatiet sistēmā esošo pamatlīdzekļu sarakstu.';
            }
            action("Acquisition List")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Acquisition List',
                            LVI = 'Iepirkumu saraksts';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Acquisition List";
                ToolTipML = ENU = 'View the related acquisitions.',
                            LVI = 'Skatīt saistītos Iepirkumus.';
            }
            action(Details)
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Details',
                            LVI = 'Detaļas';
                Image = View;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Details";
                ToolTip = 'View detailed information about the fixed asset ledger entries that have been posted to a specified depreciation book for each fixed asset.';
            }
            action("FA Book Value")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'FA Book Value',
                            LVI = 'PL grāmatas vērtība';
                Image = "Report";
                RunObject = Report "Fixed Asset - Book Value 01";
                ToolTip = 'View detailed information about acquisition cost, depreciation and book value for both individual assets and groups of assets. For each of these three amount types, amounts are calculated at the beginning and at the end of a specified period as well as for the period itself.';
            }
            action("FA Book Val. - Appr. & Write-D")
            {
                ApplicationArea = FixedAssets;
                Caption = 'FA Book Val. - Appr. & Write-D';
                Image = "Report";
                RunObject = Report "Fixed Asset - Book Value 02";
                ToolTipML = ENU = 'View detailed information about acquisition cost, depreciation, appreciation, write-down and book value for both individual assets and groups of assets. For each of these categories, amounts are calculated at the beginning and at the end of a specified period, as well as for the period itself.',
                            LVI = 'Skatīt detalizētu informāciju par iepirkuma vērtību, nolietojumu, vērtības pieaugumu, vērtības samazināšanos un grāmatvedības vērtības an atsevišķiem aktīviem , gan aktīvu grupām. Katrai no šīm kategorijām summas tiek aprēķinātas norādītā perioda sākumā un beigās, kā arī par pašu periodu.';
            }
            action(Analysis)
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Analysis',
                            LVI = 'Analīze';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Analysis";
                ToolTipML = ENU = 'View an analysis of your fixed assets with various types of data for both individual assets and groups of fixed assets.',
                            LVI = 'Skatīt savu pamatlīdzekļu analīzi ar dažādiem datu tipiem gan atsevišķiem aktīviem, gan pamatlīdzekļu grupām.';
            }
            action("Projected Value")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Projected Value',
                            LVI = 'Paredzamā vērtība';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Projected Value";
                ToolTip = 'View the calculated future depreciation and book value. You can print the report for one depreciation book at a time.';
            }
            action("G/L Analysis")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'G/L Analysis',
                            LVI = 'V/G analīze';
                Image = "Report";
                RunObject = Report "Fixed Asset - G/L Analysis";
                ToolTipML = ENU = 'View an analysis of your fixed assets with various types of data for individual assets and/or groups of fixed assets.',
                            LVI = 'Skatīt savu pamatlīdzekļu analīzi ar dažādiem datu tipiem - atsevišķiem aktīviem un/vai pamatlīdzekļu grupām.';
            }
            action(Register)
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Register',
                            LVI = 'Reģistrs';
                Image = Confirm;
                RunObject = Report "Fixed Asset Register";
                ToolTip = 'View registers containing all the fixed asset entries that are created. Each register shows the first and last entry number of its entries.';
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //CRI-2061
        if FAClass.GET(Rec."FA Class Code") then
            FaClassName := FAClass.Name;
        if FASubclass.GET(Rec."FA Subclass Code") then
            FASubClassName := FASubclass.Name;
        if FALocation.GET(Rec."FA Location Code") then
            FALocationName := FALocation.Name;

        FADeprBook.SETRANGE("FA No.", "No.");
        if FADeprBook.FINDFIRST then begin
            DeprBookName := FADeprBook."Depreciation Book Code";
            FADeprBook.CALCFIELDS("Acquisition Cost", "Book Value");
            AcquisitionCost := FADeprBook."Acquisition Cost";
            DeprBookValue := FADeprBook."Book Value";
        end;
        //CRI-2061

        //FKD-PAM, CRI-2061 ->
        WriteDownDate := 0D;
        if FADepreciationBook."Book Value" = 0 then begin
            FALedgerEntry.SETRANGE("FA No.", "No.");
            FALedgerEntry.SETRANGE("FA Posting Category", FALedgerEntry."FA Posting Category"::Disposal);
            if FALedgerEntry.FINDLAST then
                WriteDownDate := FALedgerEntry."Posting Date";
        end;
        //FKD-PAM, CRI-2061 <-
    end;

    var
        AB001: TextConst ENU = 'No filters applied. Apply a filter and try again.', LVI = 'Nav piemēroti filtri. Piemērojiet tos un pamēģiniet vēlreiz. ';
        AB002: TextConst ENU = 'Apply %1 to %2 records?', LVI = 'Piemērot %1 attiecībā uz %2 ierakstiem?';
        AB003: TextConst ENU = '%1 records updated.', LVI = '%1 ieraksti ir atjaunināti.';
        AB004: TextConst ENU = 'No filters applied. Continue?', LVI = 'Nav piemēroti filtri. Turpināt darbību?';
        FAClass: Record "FA Class";
        FASubclass: Record "FA Subclass";
        FALocation: Record "FA Location";
        FADeprBook: Record "FA Depreciation Book";
        DeprBookName: Text[250];
        FaClassName: Text[250];
        FASubClassName: Text[250];
        FALocationName: Text[250];
        DeprBookValue: Decimal;
        AcquisitionCost: Decimal;
        "__CRI-2061__": Integer;
        WriteDownDate: Date;
        FADepreciationBook: Record "FA Depreciation Book";
        FALedgerEntry: Record "FA Ledger Entry";

    local procedure GetSelectionFilter(var TempRecRef: RecordRef; SelectionFieldID: Integer): Text;
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        FirstRecRef: Text;
        LastRecRef: Text;
        SelectionFilter: Text;
        SavePos: Text;
        TempRecRefCount: Integer;
        More: Boolean;
    begin
        if TempRecRef.ISTEMPORARY then begin
            RecRef := TempRecRef.DUPLICATE;
            RecRef.RESET;
        end else
            RecRef.OPEN(TempRecRef.NUMBER);

        TempRecRefCount := TempRecRef.COUNT;
        if TempRecRefCount > 0 then begin
            TempRecRef.ASCENDING(true);
            TempRecRef.FIND('-');
            while TempRecRefCount > 0 do begin
                TempRecRefCount := TempRecRefCount - 1;
                RecRef.SETPOSITION(TempRecRef.GETPOSITION);
                RecRef.FIND;
                FieldRef := RecRef.FIELD(SelectionFieldID);
                FirstRecRef := FORMAT(FieldRef.VALUE);
                LastRecRef := FirstRecRef;
                More := TempRecRefCount > 0;
                while More do
                    if RecRef.NEXT = 0 then
                        More := false
                    else begin
                        SavePos := TempRecRef.GETPOSITION;
                        TempRecRef.SETPOSITION(RecRef.GETPOSITION);
                        if not TempRecRef.FIND then begin
                            More := false;
                            TempRecRef.SETPOSITION(SavePos);
                        end else begin
                            FieldRef := RecRef.FIELD(SelectionFieldID);
                            LastRecRef := FORMAT(FieldRef.VALUE);
                            TempRecRefCount := TempRecRefCount - 1;
                            if TempRecRefCount = 0 then
                                More := false;
                        end;
                    end;
                if SelectionFilter <> '' then
                    SelectionFilter := SelectionFilter + '|';
                if FirstRecRef = LastRecRef then
                    SelectionFilter := SelectionFilter + AddQuotes(FirstRecRef)
                else
                    SelectionFilter := SelectionFilter + AddQuotes(FirstRecRef) + '..' + AddQuotes(LastRecRef);
                if TempRecRefCount > 0 then
                    TempRecRef.NEXT;
            end;
            exit(SelectionFilter);
        end;
    end;

    procedure AddQuotes(inString: Text[1024]): Text;
    begin
        if DELCHR(inString, '=', ' &|()*') = inString then
            exit(inString);
        exit('''' + inString + '''');
    end;

    procedure GetSelectionFilterForAssets(var FixedAsset: Record "Fixed Asset"): Text;
    var
        RecRef: RecordRef;
    begin
        CurrPage.SETSELECTIONFILTER(FixedAsset);
        RecRef.GETTABLE(FixedAsset);
        exit(GetSelectionFilter(RecRef, FixedAsset.FIELDNO("No.")));
    end;
}

