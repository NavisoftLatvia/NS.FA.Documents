codeunit 50280 "Convert To Words"
{
    trigger OnRun();
    begin
    end;

    var
        AndText: Text[30];
        ZeroText: Text[30];
        OnesText: array[19] of Text[30];
        TensText: array[9] of Text[30];
        HundredText1: Text[30];
        HundredTextM: Text[30];
        ExponentText1: array[4] of Text[30];
        ExponentTextM: array[4] of Text[30];
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        _AmountTextIndex: Integer;
        Exponent: Integer;

        EURText1: Text[30];
        EURTextM: Text[30];
        CentText1: Text[30];
        CentTextM: Text[30];
        MonthText: array[12] of Text[30];
        YearText: Text[30];
        ForeignCurrency: Record Currency;
        Text002: TextConst ENU = '%1 results in a written number that is too long.', LVI = '%1 rezultātā ierakstās pārāk garš numurs.';
        GeneralLedgerSetup: Record "General Ledger Setup";
        TextLanguage: Text;

    procedure Amount2Words(_Amount: Decimal; CurrencyCode: Code[10]): Text[250];
    var
        Check: Report Check;
        NoText: array[2] of Text[80];
        NoText2: array[3] of Text[80];
    begin
        InitAmountTexts;
        AmountToWords(_Amount, NoText2, CurrencyCode);
        exit(NoText2[1] + NoText2[2] + NoText2[3]);
    end;

    procedure Date2Words(Date: Date; Declined: Boolean): Text[250];
    var
        DateText: Text[250];
    begin
        if (GLOBALLANGUAGE = 1033) or (TextLanguage = 'E') then begin
            exit(FORMAT(Date, 0, '<Month Text> <Day>, <year4>'));
        end else begin // Local
            InitDateTexts(Declined);
            DateToWords(Date, DateText, Declined);
            exit(DateText);
        end;
    end;

    local procedure AmountToWords(Amount: Decimal; var _AmountText: array[3] of Text[80]; CurrencyCode: Code[10]);
    var
        TranslatedCurrDescription: Text[30];
    begin
        Amount := ABS(Amount);
        CLEAR(_AmountText);
        _AmountTextIndex := 1;

        if Amount < 1 then
            AddToAmountText(_AmountText, _AmountTextIndex, ZeroText)
        else begin
            for Exponent := 4 downto 1 do begin
                Ones := Amount div POWER(1000, Exponent - 1);
                if Ones <> 0 then begin
                    Amount := Amount mod POWER(1000, Exponent - 1);

                    Hundreds := Ones div 100;
                    Tens := (Ones mod 100) div 10;
                    Ones := Ones mod 10;

                    if Hundreds > 0 then begin
                        AddToAmountText(_AmountText, _AmountTextIndex, OnesText[Hundreds]);
                        if Hundreds = 1 then
                            AddToAmountText(_AmountText, _AmountTextIndex, HundredText1)
                        else
                            AddToAmountText(_AmountText, _AmountTextIndex, HundredTextM);
                    end;

                    if Tens >= 2 then begin
                        AddToAmountText(_AmountText, _AmountTextIndex, TensText[Tens]);
                        if Ones > 0 then
                            AddToAmountText(_AmountText, _AmountTextIndex, OnesText[Ones]);
                    end else
                        if (Tens * 10 + Ones) > 0 then
                            AddToAmountText(_AmountText, _AmountTextIndex, OnesText[Tens * 10 + Ones]);

                    if Exponent > 1 then
                        if (Ones = 1) and (Tens <> 1) then
                            AddToAmountText(_AmountText, _AmountTextIndex, ExponentText1[Exponent])
                        else
                            AddToAmountText(_AmountText, _AmountTextIndex, ExponentTextM[Exponent]);
                end;
            end;
        end;

        GeneralLedgerSetup.GET;
        if GeneralLedgerSetup."LCY Code" <> '' then begin
            if (CurrencyCode = '') or (CurrencyCode = GeneralLedgerSetup."LCY Code") then begin //Currency must be LCY from GLS

                AddToAmountText(_AmountText, _AmountTextIndex, AndText);
                AddToAmountText(_AmountText, _AmountTextIndex, FORMAT(Amount * 100) + '/100');

                if (Ones = 1) and (Tens <> 1) then
                    AddToAmountText(_AmountText, _AmountTextIndex, EURText1)
                else
                    AddToAmountText(_AmountText, _AmountTextIndex, EURTextM);
            end;
        end;

        if (CurrencyCode <> '') then begin
            if (CurrencyCode <> GeneralLedgerSetup."LCY Code") then begin
                ForeignCurrency.GET(CurrencyCode);
                AddToAmountText(_AmountText, _AmountTextIndex, AndText);
                AddToAmountText(_AmountText, _AmountTextIndex, FORMAT(Amount * 100) + '/100');
                case TextLanguage of
                    'E':
                        TranslatedCurrDescription := ForeignCurrency.Description;
                    else
                        TranslatedCurrDescription := ForeignCurrency.Description;
                end;
                AddToAmountText(_AmountText, _AmountTextIndex, TranslatedCurrDescription);
            end;
        end;
    end;

    local procedure DateToWords(Date: Date; var DateText: Text[250]; Declined: Boolean): Text[250];
    var
        MonthIndex: Integer;
    begin
        if not EVALUATE(MonthIndex, FORMAT(Date, 0, '<Month>')) then begin
            DateText := '';
            exit(DateText);
        end;

        DateText := FORMAT(Date, 0, '<Year4>') + '. ' + YearText + ' ' + FORMAT(Date, 0, '<Day,2>') + '. ' + MonthText[MonthIndex];
        exit(DateText);
    end;

    local procedure InitAmountTexts();
    begin
        if TextLanguage <> 'E' then begin
            TensText[1] := '';
            ExponentText1[1] := '';
            ExponentTextM[1] := '';

            AndText := 'UN';
            ZeroText := 'NULLE';

            OnesText[1] := 'VIENS';
            OnesText[2] := 'DIVI';
            OnesText[3] := 'TRĪS';
            OnesText[4] := 'ČETRI';
            OnesText[5] := 'PIECI';
            OnesText[6] := 'SEŠI';
            OnesText[7] := 'SEPTIŅI';
            OnesText[8] := 'ASTOŅI';
            OnesText[9] := 'DEVIŅI';
            OnesText[10] := 'DESMIT';
            OnesText[11] := 'VIENPADSMIT';
            OnesText[12] := 'DIVPADSMIT';
            OnesText[13] := 'TRĪSPADSMIT';
            OnesText[14] := 'ČETRPADSMIT';
            OnesText[15] := 'PIECPADSMIT';
            OnesText[16] := 'SEŠPADSMIT';
            OnesText[17] := 'SEPTIŅPADSMIT';
            OnesText[18] := 'ASTOŅPADSMIT';
            OnesText[19] := 'DEVIŅPADSMIT';

            TensText[2] := 'DIVDESMIT';
            TensText[3] := 'TRĪSDESMIT';
            TensText[4] := 'ČETRDESMIT';
            TensText[5] := 'PIECDESMIT';
            TensText[6] := 'SEŠDESMIT';
            TensText[7] := 'SEPTIŅDESMIT';
            TensText[8] := 'ASTOŅDESMIT';
            TensText[9] := 'DEVIŅDESMIT';

            HundredText1 := 'SIMTS';
            HundredTextM := 'SIMTI';

            ExponentText1[2] := 'TŪKSTOTIS';
            ExponentText1[3] := 'MILJONS';
            ExponentText1[4] := 'MILJARDS';

            ExponentTextM[2] := 'TŪKSTOŠI';
            ExponentTextM[3] := 'MILJONI';
            ExponentTextM[4] := 'MILJARDI';
        end;

        if TextLanguage = 'E' then begin
            AndText := '&';
            ZeroText := 'zero';

            OnesText[1] := 'one';
            OnesText[2] := 'two';
            OnesText[3] := 'three';
            OnesText[4] := 'four';
            OnesText[5] := 'five';
            OnesText[6] := 'six';
            OnesText[7] := 'seven';
            OnesText[8] := 'eight';
            OnesText[9] := 'nine';
            OnesText[10] := 'ten';
            OnesText[11] := 'eleven';
            OnesText[12] := 'twelve';
            OnesText[13] := 'thirteen';
            OnesText[14] := 'fourteen';
            OnesText[15] := 'fifteen';
            OnesText[16] := 'sixteen';
            OnesText[17] := 'seventeen';
            OnesText[18] := 'eighteen';
            OnesText[19] := 'nineteen';

            TensText[2] := 'twenty';
            TensText[3] := 'thirty';
            TensText[4] := 'forty';
            TensText[5] := 'fifty';
            TensText[6] := 'sixty';
            TensText[7] := 'seventy';
            TensText[8] := 'eighty';
            TensText[9] := 'ninety';

            HundredText1 := 'hundred';
            HundredTextM := 'hundred';

            ExponentText1[2] := 'thousand';
            ExponentText1[3] := 'million';
            ExponentText1[4] := 'milliard';

            ExponentTextM[2] := 'thousand';
            ExponentTextM[3] := 'million';
            ExponentTextM[4] := 'milliard';
        end;

        if TextLanguage = 'E' then begin
            EURText1 := 'EURO';
            EURTextM := 'EURO';
            CentText1 := 'CENTS';
            CentTextM := 'CENTS';
        end else begin
            EURText1 := 'EURO';
            EURTextM := 'EURO';
            CentText1 := 'CENTS';
            CentTextM := 'CENTI';
        end;
    end;

    local procedure InitDateTexts(Declined: Boolean);
    begin
        YearText := 'gada';

        if Declined then begin
            MonthText[1] := 'janvārī';
            MonthText[2] := 'februārī';
            MonthText[3] := 'martā';
            MonthText[4] := 'aprīlī';
            MonthText[5] := 'maijā';
            MonthText[6] := 'jūnijā';
            MonthText[7] := 'jūlijā';
            MonthText[8] := 'augustā';
            MonthText[9] := 'septembrī';
            MonthText[10] := 'oktobrī';
            MonthText[11] := 'novembrī';
            MonthText[12] := 'decembrī';
        end else begin
            MonthText[1] := 'janvāris';
            MonthText[2] := 'februāris';
            MonthText[3] := 'marts';
            MonthText[4] := 'aprīlis';
            MonthText[5] := 'maijs';
            MonthText[6] := 'jūnijs';
            MonthText[7] := 'jūlijs';
            MonthText[8] := 'augusts';
            MonthText[9] := 'septembris';
            MonthText[10] := 'oktobris';
            MonthText[11] := 'novembris';
            MonthText[12] := 'decembris';
        end;
    end;

    local procedure AddToAmountText(var _AmountText: array[3] of Text[80]; var ArrayIndex: Integer; AddText: Text[30]);
    begin
        if AddText = '' then
            exit;

        if STRLEN(_AmountText[ArrayIndex] + ' ' + AddText) > MAXSTRLEN(_AmountText[1]) then
            ArrayIndex := ArrayIndex + 1;

        if ArrayIndex > ARRAYLEN(_AmountText) then
            ERROR(Text002, AddText);

        if _AmountText[ArrayIndex] = '' then
            _AmountText[ArrayIndex] := AddText
        else
            _AmountText[ArrayIndex] := _AmountText[ArrayIndex] + ' ' + AddText;
    end;

    procedure SetTextLanguage(LanguageCode: Code[10]);
    begin
        TextLanguage := LanguageCode;
    end;
}