report 50282 "FA Transfer Act"
{
    // version NS.MK.Acts.2018

    WordLayout = './Objects/FA Transfer Act.docx';
    CaptionML = ENU = 'FA Transfer Act',
                LVI = 'PL Pārvietošanas akts';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("FA Act Header"; "FA Act Header")
        {
            column(HeaderNo; "FA Act Header"."ResponsAct Number")
            {
            }
            column(HeaderDate; Convert2Words.Date2Words("FA Act Header".Date, FALSE))
            {
            }
            column(HeaderDate1; Convert2Words.Date2Words("FA Act Header".Date, TRUE))
            {
            }
            column(HeaderDate2; FORMAT("FA Act Header".Date, 0, '<Day,2>.<Month,2>.<Year4>'))
            {
            }
            column(EmployeeName; Employee.FullName())
            {
            }
            column(EmployeeJobTitle; Employee."Job Title")
            {
            }
            column(NewRespEmployeeName; "FA Act Header"."New Responsible SP Name")
            {
            }
            column(NewRespEmployeeCode; "FA Act Header"."New Responsible SP Code")
            {
            }
            column(OldRespEmployeeName; "FA Act Header"."Old Responsible SP Name")
            {
            }
            column(OldRespEmployeeCode; "FA Act Header"."Old Responsible SP Code")
            {
            }
            column(R_EmployeeJobTitle; Employee2."Job Title")
            {
            }
            column(NewEmployeeJobTitle; Employee3."Job Title")
            {
            }
            column(CompanyInformationName; CompanyInformation.Name)
            {
            }
            column(CompanyInformationVATRegistrationNo; CompanyInformation."VAT Registration No.")
            {
            }
            column(CompanyInformationCompanyAddress; CompanyAddress)
            {
            }
            column(ApprovedByPerson; ApprovedByPerson)
            {
            }
            column(WarrantNum; WarrantNum)
            {
            }
            column(WarrantDate; WarrantDate)
            {
            }
            column(PresidentOfCommissionName_FAActHeader; "FA Act Header"."President Of Commission Name")
            {
            }
            column(MembersOfCommission1Name_FAActHeader; "FA Act Header"."Members Of Commission 1 Name")
            {
            }
            column(MembersOfCommission2Name_FAActHeader; "FA Act Header"."Members Of Commission 2 Name")
            {
            }
            column(MembersOfCommission3Name_FAActHeader; "FA Act Header"."Members Of Commission 3 Name")
            {
            }
            column(MembersOfCommission4Name_FAActHeader; "FA Act Header"."Members Of Commission 4 Name")
            {
            }
            column(MembersOfCommission5Name_FAActHeader; "FA Act Header"."Aproved by person name")
            {
            }
            column(PresidentOfCommJobTitle_FAActHeader; "FA Act Header"."President Of Comm. Job Title")
            {
            }
            column(MembersOfComm1JobTitle_FAActHeader; "FA Act Header"."Members Of Comm. 1 Job Title")
            {
            }
            column(MembersOfComm2JobTitle_FAActHeader; "FA Act Header"."Members Of Comm. 2 Job Title")
            {
            }
            column(MembersOfComm3JobTitle_FAActHeader; "FA Act Header"."Members Of Comm. 3 Job Title")
            {
            }
            column(MembersOfComm4JobTitle_FAActHeader; "FA Act Header"."Members Of Comm. 4 Job Title")
            {
            }
            column(MembersOfComm5JobTitle_FAActHeader; "FA Act Header"."Aproved by person job title")
            {
            }
            column(GetActTitle; GetActTitle("FA Act Header"))
            {
            }
            dataitem("FA Act Line"; "FA Act Line")
            {
                DataItemLink = "Document No." = FIELD ("No."), "Document Type" = FIELD ("Type");
                DataItemTableView = SORTING ("Document No.", "Line No.") ORDER(Ascending);
                column(LineFANo; "FA Act Line"."FA No.")
                {
                }
                column(LineDescr; LineDescr)
                {
                }
                column(LineQty; "FA Act Line".Quantity)
                {
                }
                column(LinePrice; "FA Act Line"."Unit Cost")
                {
                }
                column(LineAmount; "FA Act Line".Amount)
                {
                }
                column(UnitCost; UnitPrice)
                {
                }
                column(DeprBookCode; FADepreciationBook."Depreciation Book Code")
                {
                }
                column(AquisitionAccount; FAPostingGroup."Acquisition Cost Account")
                {
                }
                column(FALocationCode; FA."FA Location Code")
                {
                }
                column(FALedgerEntryDate; FORMAT("FA Act Line"."FA Ledger Entry Date", 0, '<Day,2>.<Month,2>.<Year4>'))
                {
                }
                column(AcquisitionCost_FAActLine; "FA Act Line"."Acquisition Cost")
                {
                }
                column(Depreciation_FAActLine; "FA Act Line".Depreciation * -1)
                {
                }
                column(BookValue_FAActLine; "FA Act Line"."Book Value")
                {
                }
                column(NoOfDeprYears; FADepreciationBook."No. of Depreciation Years")
                {
                }
                column(FAVendorName; Vendor.Name)
                {
                }
                column(ProfitCenterCode; FA."Global Dimension 1 Code")
                {
                }
                column(ProjectCode; FA."Global Dimension 2 Code")
                {
                }
                column(VehicleCode; FA."Global Dimension 1 Code")
                {
                }
                column(CostCenterCode; FA."Global Dimension 2 Code")
                {
                }
                column(VendorDocument; VendorDocument)
                {
                }

                trigger OnAfterGetRecord();
                var
                    DeprBook: Record "FA Depreciation Book";
                    _FALedgerEntry: Record "FA Ledger Entry";
                    _PurchInvHeader: Record "Purch. Inv. Header";
                begin
                    LinePrice := 0;
                    LineAmount := 0;
                    LineDescr := '';

                    CALCFIELDS("FA Description"
                                , "FA Description 2"
                                , "Acquisition Cost"
                                , Depreciation
                                , "Book Value"
                              );


                    Totals[1] += "Acquisition Cost";
                    Totals[2] += Depreciation * -1;
                    Totals[3] += "Book Value";
                    Totals[4] += 1;

                    LineDescr := "FA Act Line"."FA Description";
                    LineDescr += ' ' + "FA Act Line"."FA Description 2";

                    FA.RESET;
                    IF FA.GET("FA Act Line"."FA No.") THEN BEGIN
                        IF FA."Serial No." <> '' THEN
                            LineDescr += ', ' + FA."Serial No.";
                        if Vendor.Get(fa."Vendor No.") then;
                    END;

                    UnitPrice := 0;
                    FALedgerEntry.RESET;
                    FALedgerEntry.SETRANGE(FALedgerEntry."FA No.", "FA Act Line"."FA No.");
                    FALedgerEntry.SETFILTER(FALedgerEntry."FA Posting Type", '%1', FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                    IF FALedgerEntry.FINDFIRST THEN
                        REPEAT
                            UnitPrice += FALedgerEntry.Amount;
                        UNTIL FALedgerEntry.NEXT = 0;

                    FASetup.GET();
                    FADepreciationBook.RESET;
                    FADepreciationBook.SETRANGE("FA No.", "FA No.");
                    FADepreciationBook.SETRANGE("Depreciation Book Code", FASetup."Default Depr. Book");
                    IF NOT FADepreciationBook.FINDFIRST THEN BEGIN
                        FADepreciationBook.SETRANGE("Depreciation Book Code");
                        IF FADepreciationBook.FINDFIRST THEN;
                    END;

                    IF FAPostingGroup.GET(FADepreciationBook."FA Posting Group") THEN;

                    VendorDocument := '';
                    VendorDocument += 'PL: ' + "FA Act Line"."FA No.";
                    IF "FA Act Line"."FA Ledger Entry No." <> 0 THEN BEGIN
                        _FALedgerEntry.GET("FA Act Line"."FA Ledger Entry No.");

                        "FA Act Line".CALCFIELDS("FA Act Line"."FA Ledger Entry Date", "FA Act Line"."FA Ledger Entry Document No.");
                        VendorDocument += ', Dok. datums: ' + Convert2Words.Date2Words("FA Act Line"."FA Ledger Entry Date", FALSE);
                        _PurchInvHeader.GET("FA Act Line"."FA Ledger Entry Document No.");
                        IF _PurchInvHeader."Vendor Invoice No." <> '' THEN
                            VendorDocument += ', Dok.Nr. ' + _PurchInvHeader."Vendor Invoice No."
                        ELSE
                            VendorDocument += ', Dok.Nr. ' + _PurchInvHeader."Vendor Order No.";
                        VendorDocument += ', Pieg. ' + _PurchInvHeader."Buy-from Vendor Name";
                    END ELSE
                        VendorDocument += ', Iepirkuma dokuments nav norādīts!'

                end;
            }
            dataitem(LineTotals; "Integer")
            {
                DataItemTableView = SORTING (Number) ORDER(Ascending) WHERE (Number = CONST (1));
                column(t_Acquisition; Totals[1])
                {
                }
                column(t_Depreciation; Totals[2])
                {
                }
                column(t_bookValue; Totals[3])
                {
                }
                column(t_Quantity; Totals[4])
                {
                }
            }
            dataitem(Comission; "Integer")
            {
                DataItemTableView = SORTING (Number) ORDER(Ascending) WHERE (Number = CONST (1));
                column(ShowCommision; ShowCommision)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF NOT ShowCommision THEN
                        CurrReport.SKIP;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                "FA Act Header".CALCFIELDS("President Of Comm. Job Title", "Members Of Comm. 1 Job Title"
                                           , "Members Of Comm. 2 Job Title", "Members Of Comm. 3 Job Title"
                                           , "Members Of Comm. 4 Job Title", "Aproved by person job title"
                                           );

                UserSetup.GET("Insert User");
                UserSetup.TestField("Salespers./Purch. Code");
                Employee.RESET;
                Employee.SetRange("Salespers./Purch. Code", UserSetup."Salespers./Purch. Code");
                Employee.FindFirst();

                Employee2.GET("Old Responsible SP Code");
                Employee3.GET("New Responsible SP Code");

                CompanyInformation.GET();
                CompanyAddress := '';
                CompanyAddress := CompanyInformation.Address;
                IF CompanyInformation."Address 2" <> '' THEN
                    CompanyAddress += ' ' + CompanyInformation."Address 2";
                IF CompanyInformation.City <> '' THEN
                    CompanyAddress += ', ' + CompanyInformation.City;
                IF CompanyInformation."Post Code" <> '' THEN
                    CompanyAddress += ', ' + CompanyInformation."Post Code";

                IF "Aproved by person name" <> '' THEN
                    ApprovedByPerson := "Aproved by person name" + ', ' + "FA Act Header"."Aproved by person job title"
                ELSE
                    ApprovedByPerson := '______________________';

                WarrantNum := '______________________';
                WarrantDate := '___.___.________';

                IF "FA Act Header"."Warrant Number" <> '' THEN
                    WarrantNum := "FA Act Header"."Warrant Number";
                IF "FA Act Header"."Warrant date" <> 0D THEN
                    WarrantDate := FORMAT(WarrantDate, 0, '<Day,2>.<Month,2>.<Year4>');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                LVI = 'Opcijas';
                    field(ShowCommision; ShowCommision)
                    {
                        CaptionML = ENU = 'Show Commission Members',
                                    LVI = 'Rādīt komisijas locekļus';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportCapt1 = 'Pamatlīdzekļu un inventāra'; ReportCapt2 = 'Datortehnikas'; IzsniedzejsLbl = 'Izsniedzējs(-a):'; SanemejsLbl = 'Saņēmējs(-a):'; IzsniedzaLbl = 'Izsniedza:'; SanemaLbl = 'Saņēma:'; Signature1Lbl = '(Amats, vārds, uzvārds)'; Signature2Lbl = '(datums, paraksts, paraksta atšifrējums)'; Phrase1lbl = 'Pamatojoties uz Valsts kontroles darba procesa "Valsts kontroles materiāltehniskās darbības nodrošināšana" aprakstu, sastāda šādu aktu:'; Phrase2lbl = '1. Izsniedzējs izsniedz, bet saņēmējs pieņem lietošanā šādus pamatlīdzekļus un inventāru:'; label(LineCounterCapt; ENU = 'No.',
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                LVI = 'Nr. p.k.')
        LineDescrCapt = 'Materiālās vērtības nosaukums, sērijas Nr.'; LineNoCapt = 'Inventāra Nr.'; label(LineQtyCapt; ENU = 'Quantity',
                                                                                                                    LVI = 'Daudzums')
        label(LineCenaCapt; ENU = 'Price',
                           LVI = 'Cena')
        label(LineAmountCapt; ENU = 'Total',
                             LVI = 'Summa')
        label(LabelPurchaseValue; ENU = 'Purchase value',
                                 LVI = 'Iegādes vērtība')
        IT_1 = 'Saskaņā ar Valsts kontroles darba procesa "Informācijas tehnoloģiju pārvaldība" aprakstu, sastāda šādu aktu:'; IT_2 = '1. Izsniedzējs izsniedz, bet saņēmējs pieņem lietošanā šādu datortehniku vai piederumus:'; IT_3 = '2. Datortehnika vai piederumi ir izsniegti saņēmējam Valsts kontroles telpās kabineta numurs. kabinetā, Skanstes ielā 50, Rīgā.'; IT_4 = '3. Saņēmējs ir pārbaudījis pieņemšanas un nodošanas aktā minētās datortehnikas vai piederumu atbilstību, salīdzinot pieņemšanas un nodošanas aktā minētās datortehnikas vai piederumu inventāra numurus ar inventāra numuriem uz datortehnikas vai piederumiem.'; IT_5 = '4. Saņēmējs, lietojot datortehniku apņemas ievērot Valsts kontroles darba procesa "Informācijas tehnoloģiju pārvaldība" apraksta 6.24.7.apakšpunktā noteiktos ekspluatācijas nosacījumus.'; IT_6 = '5. Šis pieņemšanas un nodošanas akts ir sastādīts uz vienas lapas divos eksemplāros pa vienam eksemplāram katrai pusei.';
    }

    var
        Salespers: Record "Salesperson/Purchaser";
        FALedgerEntry: Record "FA Ledger Entry";
        Text001_RepHdr2: TextConst ENU = 'pieņemšanas un nodošanas (kustības) akts Nr. %1', LVI = 'pieņemšanas un nodošanas (kustības) akts Nr. %1';
        Text002_City: Label 'Rīgā';
        Text003_Phrase0: Label 'Pamatojoties uz Valsts kontroles darba procesa "Valsts kontroles materiāltehniskās darbības nodrošināšana" aprakstu, sastāda šādu aktu:';
        Text004_Phrase1: Label '1. Izsniedzējs izsniedz, bet saņēmējs pieņem lietošanā šādus pamatlīdzekļus un inventāru:';
        Text005_Phrase2: Label '2. Pamatlīdzekļi un inventārs tiek nodoti lietošanai Valsts kontroles telpās %1. kabinetā, Skanstes ielā 50, Rīgā.';
        Text006_Phrase3: Label '3. Saņēmējs ir pārbaudījis pieņemšanas un nodošanas aktā minēto pamatlīdzekļu un inventāra atbilstību, salīdzinot pieņemšanas aktā minēto pamatlīdzekļu un inventāra  numurus ar inventāra numuriem uz pamatlīdzekļiem un inventāra.';
        Text007_Phrase4: Label '"4. Saņēmējs, lietojot pamatlīdzekļus un inventāru, apņemas ievērot Valsts kontroles darba procesa ""Valsts kontroles materiāltehniskās darbības nodrošināšana"" apraksta 3.8. apakšpunktā noteiktos ekspluatācijas nosacījumus. "';
        Text008_Phrase5: Label '5. Šis pieņemšanas un nodošanas akts ir sastādīts uz vienas lapas trijos eksemplāros pa vienam eksemplāram katrai pusei un Finanšu un budžeta plānošanas daļai.';
        IT_3: Label '2. Datortehnika vai piederumi ir izsniegti saņēmējam Valsts kontroles telpās %1. kabinetā, Skanstes ielā 50, Rīgā.';
        FADepreciationBook: Record "FA Depreciation Book";
        FASetup: Record "FA Setup";
        FAPostingGroup: Record "FA Posting Group";
        LinePrice: Decimal;
        LineAmount: Decimal;
        LineDescr: Text;
        UnitPrice: Decimal;
        FA: Record "Fixed Asset";
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        Employee2: Record Employee;
        Employee3: Record Employee;
        Convert2Words: Codeunit "Convert To Words";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        ApprovedByPerson: Text;
        VendorDocument: Text;
        WarrantNum: Text;
        WarrantDate: Text;
        Totals: array[4] of Decimal;
        ShowCommision: Boolean;
        Vendor: Record Vendor;

    local procedure GetActTitle(var FAActHeader: Record "FA Act Header"): Text;
    begin
        IF FAActHeader."Low Value" THEN
            EXIT('mazvērtīgā inventāra')
        ELSE
            EXIT('pamatlīdzekļu')
    end;
}

