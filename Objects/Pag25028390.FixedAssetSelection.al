page 25028390 "Fixed Asset Selection"
{
    Caption = 'Fixed Asset List';
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
                    ToolTip = 'Specifies a number for the fixed asset.';
                }
                field(Description; Description)
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies a description of the fixed asset.';
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
                    Caption = 'Disposal Date';
                }
                field("Responsible Employee"; "Responsible Employee")
                {
                    ToolTip = 'Specifies which employee is responsible for the fixed asset.';
                }
                field("FA Class Code"; "FA Class Code")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the class that the fixed asset belongs to.';
                }
                field(FaClassName; FaClassName)
                {
                    Caption = 'FA Class Name';
                    Editable = false;
                }
                field("FA Subclass Code"; "FA Subclass Code")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the subclass of the class that the fixed asset belongs to.';
                }
                field(FASubClassName; FASubClassName)
                {
                    Caption = 'FA Subclass Name';
                    Editable = false;
                }
                field("FA Location Code"; "FA Location Code")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the location, such as a building, where the fixed asset is located.';
                }
                field(FALocationName; FALocationName)
                {
                    Caption = 'FA Location Name';
                    Editable = false;
                }
                field("FA Posting Group"; "FA Posting Group")
                {
                }
                field("Search Description"; "Search Description")
                {
                    ToolTip = 'Specifies a search description for the fixed asset.';
                    Visible = false;
                }
                field(Acquired; Acquired)
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies that the fixed asset has been acquired.';
                }
                field(DeprBookName; DeprBookName)
                {
                    Caption = 'Depreciation Book Code';
                    Editable = false;
                    TableRelation = "FA Depreciation Book"."Depreciation Book Code";
                }
                field(AcquisitionCost; AcquisitionCost)
                {
                    Caption = 'Acquisition Cost';
                    Editable = false;
                }
                field(DeprBookValue; DeprBookValue)
                {
                    Caption = 'Book Value';
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
                    ToolTip = 'Specifies if the asset is for budgeting purposes.';
                    Visible = false;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the number of the vendor from which you purchased this fixed asset.';
                }
                field("Maintenance Vendor No."; "Maintenance Vendor No.")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the number of the vendor who performs repairs and maintenance on the fixed asset.';
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
                Caption = 'Fixed &Asset';
                Image = FixedAssets;
                action("Depreciation &Books")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Depreciation &Books';
                    Image = DepreciationBooks;
                    RunObject = Page "FA Depreciation Books";
                    RunPageLink = "FA No." = FIELD("No.");
                    ToolTip = 'View or edit the depreciation book or books that must be used for each of the fixed assets. Here you also specify the way depreciation must be calculated.';
                }
                action(Statistics)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Fixed Asset Statistics";
                    RunPageLink = "FA No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'View detailed historical information about the fixed asset.';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(5600),
                                      "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Suite;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        Promoted = true;
                        PromotedCategory = Process;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction();
                        var
                            FA: Record "Fixed Asset";
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(FA);
                            DefaultDimMultiple.SetMultiRecord(FA, FieldNo("No."));
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("Main&tenance Ledger Entries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Main&tenance Ledger Entries';
                    Image = MaintenanceLedgerEntries;
                    RunObject = Page "Maintenance Ledger Entries";
                    RunPageLink = "FA No." = FIELD("No.");
                    RunPageView = SORTING("FA No.");
                    ToolTip = 'View all the maintenance ledger entries for a fixed asset. ';
                }
                action(Picture)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Picture';
                    Image = Picture;
                    RunObject = Page "Fixed Asset Picture";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'Add or view a picture of the fixed asset.';
                }
                action("FA Posting Types Overview")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Posting Types Overview';
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FA Posting Types Overview";
                    ToolTip = 'View accumulated amounts for each field, such as book value, acquisition cost, and depreciation, and for each fixed asset. For every fixed asset, a separate line is shown for each depreciation book linked to the asset.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Fixed Asset"),
                                  "No." = FIELD("No.");
                }
            }
            group("Main Asset")
            {
                Caption = 'Main Asset';
                Image = Components;
                action("M&ain Asset Components")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'M&ain Asset Components';
                    Image = Components;
                    RunObject = Page "Main Asset Components";
                    RunPageLink = "Main Asset No." = FIELD("No.");
                    ToolTip = 'View or edit fixed asset components of the main fixed asset that is represented by the fixed asset card.';
                }
                action("Ma&in Asset Statistics")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Ma&in Asset Statistics';
                    Image = StatisticsDocument;
                    RunObject = Page "Main Asset Statistics";
                    RunPageLink = "FA No." = FIELD("No.");
                    ToolTip = 'View detailed historical information about all the components that make up the main asset.';
                }
                separator(Separator45)
                {
                    Caption = '';
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Ledger E&ntries';
                    Image = FixedAssetLedger;
                    RunObject = Page "FA Ledger Entries";
                    RunPageLink = "FA No." = FIELD("No.");
                    RunPageView = SORTING("FA No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View detailed information about transactions made for the fixed asset.';
                }
                action("Error Ledger Entries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Error Ledger Entries';
                    Image = ErrorFALedgerEntries;
                    RunObject = Page "FA Error Ledger Entries";
                    RunPageLink = "Canceled from FA No." = FIELD("No.");
                    RunPageView = SORTING("Canceled from FA No.")
                                  ORDER(Descending);
                    ToolTip = 'View the entries that have been posted as a result of you using the Cancel function to cancel an entry.';
                }
                action("Maintenance &Registration")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Maintenance &Registration';
                    Image = MaintenanceRegistrations;
                    RunObject = Page "Maintenance Registration";
                    RunPageLink = "FA No." = FIELD("No.");
                    ToolTip = 'View or edit maintenance codes for the various types of maintenance, repairs, and services performed on your fixed assets. You can then enter the code in the Maintenance Code field on journals.';
                }
            }
        }
        area(processing)
        {
            action("Fixed Asset Journal")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Fixed Asset Journal';
                Image = Journal;
                RunObject = Page "Fixed Asset Journal";
                ToolTip = '"Post fixed asset transactions with a depreciation book that is not integrated with the general ledger, for internal management. Only fixed asset ledger entries are created. "';
            }
            action("Fixed Asset G/L Journal")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Fixed Asset G/L Journal';
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
                Caption = 'Fixed Asset Reclassification Journal';
                Image = Journal;
                RunObject = Page "FA Reclass. Journal";
                ToolTip = 'Transfer, split, or combine fixed assets.';
            }
            action("Recurring Fixed Asset Journal")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Recurring Fixed Asset Journal';
                Image = Journal;
                RunObject = Page "Recurring Fixed Asset Journal";
                ToolTip = 'Post recurring entries to a depreciation book without integration with general ledger.';
            }
            action(CalculateDepreciation)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Calculate Depreciation';
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
                Caption = 'C&opy Fixed Asset';
                Ellipsis = true;
                Image = CopyFixedAssets;
                ToolTip = 'Create one or more new fixed assets by copying from an existing fixed asset that has similar information.';

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
                    Caption = 'Assign Location';
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
                            Error(AB001);

                        rFixedAsset.COPYFILTERS(Rec);
                        if not rFixedAsset.FIND('-') then
                            Error('');
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
                Caption = 'Fixed Assets List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - List";
                ToolTip = 'View the list of fixed assets that exist in the system .';
            }
            action("Acquisition List")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Acquisition List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Acquisition List";
                ToolTip = 'View the related acquisitions.';
            }
            action(Details)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Details';
                Image = View;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Details";
                ToolTip = 'View detailed information about the fixed asset ledger entries that have been posted to a specified depreciation book for each fixed asset.';
            }
            action("FA Book Value")
            {
                ApplicationArea = FixedAssets;
                Caption = 'FA Book Value';
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
                ToolTip = 'View detailed information about acquisition cost, depreciation, appreciation, write-down and book value for both individual assets and groups of assets. For each of these categories, amounts are calculated at the beginning and at the end of a specified period, as well as for the period itself.';
            }
            action(Analysis)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Analysis";
                ToolTip = 'View an analysis of your fixed assets with various types of data for both individual assets and groups of fixed assets.';
            }
            action("Projected Value")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Projected Value';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Projected Value";
                ToolTip = 'View the calculated future depreciation and book value. You can print the report for one depreciation book at a time.';
            }
            action("G/L Analysis")
            {
                ApplicationArea = FixedAssets;
                Caption = 'G/L Analysis';
                Image = "Report";
                RunObject = Report "Fixed Asset - G/L Analysis";
                ToolTip = 'View an analysis of your fixed assets with various types of data for individual assets and/or groups of fixed assets.';
            }
            action(Register)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Register';
                Image = Confirm;
                RunObject = Report "Fixed Asset Register";
                ToolTip = 'View registers containing all the fixed asset entries that are created. Each register shows the first and last entry number of its entries.';
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
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

        WriteDownDate := 0D;
        if FADepreciationBook."Book Value" = 0 then begin
            FALedgerEntry.SETRANGE("FA No.", "No.");
            FALedgerEntry.SETRANGE("FA Posting Category", FALedgerEntry."FA Posting Category"::Disposal);
            if FALedgerEntry.FINDLAST then
                WriteDownDate := FALedgerEntry."Posting Date";
        end;
    end;

    var
        AB001: Label 'No filters applied. Apply a filter and try again.';
        AB002: Label 'Apply %1 to %2 records?';
        AB003: Label '%1 records updated.';
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

