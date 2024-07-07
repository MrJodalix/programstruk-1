program Project_Prozeduren_und_Funktionen;
(* Joshua-Scott Schöttke, Moritz Richter Gruppe81 Prozeduren und Funktionen zur
Bearbeitung und Ausgabe von Strings *)

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

function lettersOnly(s: string): boolean;
{Man geht anhand einer Repeat-Schleife die einzelen Zeichen unseres Strings
durch und kontrolliert ob es Buchstaben sind. Die Funktion gibt uns dann einen
Boolschen-Wert aus, der uns angibt ob es nur Buchstaben sind. Das Leerezeichen
ist durch ein If-Anweisung auf true gesetzt.}
var
  ZaehlerZeichen: byte;

begin
  ZaehlerZeichen := 0;

  if s = '' then
    lettersOnly := true
  else
    repeat
      inc(ZaehlerZeichen);
      if (upcase(s[ZaehlerZeichen]) >= 'A') and  //durchlauf aller Buchstaben
        (upcase(s[ZaehlerZeichen]) <= 'Z') then
        lettersOnly := true
      else
        lettersOnly := false

    until not((upcase(s[ZaehlerZeichen]) >= 'A') and
      (upcase(s[ZaehlerZeichen]) <= 'Z')) or (ZaehlerZeichen = Length(s));

end;

procedure deleteAllButLetters(var s: string);
{Man geht anhand einer Repeat-Schleife die einzelen Zeichen unseres Strings
durch und kontrolliert ob es Buchstaben sind. Die Prozedur löscht alle Zeichen
raus die Kein Buchstabe sind. }
var
  Ziffer: byte;
begin
  Ziffer := 0;
  repeat
    inc(Ziffer);
    if s = '' then  //notwendig für Abbruchbedingung
      Ziffer := 0
    else
    begin

      if not((upcase(s[Ziffer]) >= 'A') and (upcase(s[Ziffer]) <= 'Z')) then
      begin
        delete(s, Ziffer, 1); //löschen aller nicht Buchstaben
        Ziffer := Ziffer - 1;
      end;
    end;
  until (Ziffer = Length(s));

end;

function countVowels(s: string): byte;
{Man geht anhand einer Repeat-Schleife die einzelen Zeichen unseres Strings
durch und kontrolliert ob es Vokale sind. Die Funktion gibt uns dann die Anzahl
der Vokale.}
var
  Vocal, AnzahlVocal: byte;
begin
  if s = '' then      //Leereszeichen als 0 Vokale definiert
    countVowels := 0
  else
  begin
    Vocal := 0;
    AnzahlVocal := 0;
    repeat

      inc(Vocal);

      begin
        if (upcase(s[Vocal]) = 'A') or (upcase(s[Vocal]) = 'E') or
          (upcase(s[Vocal]) = 'I') or (upcase(s[Vocal]) = 'O') or
          (upcase(s[Vocal]) = 'U') then
          AnzahlVocal := AnzahlVocal + 1;   //Summe der Vokale

      end;

    until (Vocal = Length(s));
    countVowels := AnzahlVocal
  end;
end;

function countConsonants(s: string): byte;
{Man geht anhand einer Repeat-Schleife die einzelen Zeichen unseres Strings
durch und kontrolliert ob es Konsonaten sind. Die Funktion gibt uns dann die
Anzahl der Konsonaten aus.}
var
  Konsonant, AnzahlKonsonanten: byte;
begin
  if s = '' then         //Leereszeichen als 0 Konsonanten definiert
    countConsonants := 0
  else
  begin
    Konsonant := 0;
    AnzahlKonsonanten := 0;
    repeat

      inc(Konsonant);

      begin
        if (not((upcase(s[Konsonant]) = 'E') or (upcase(s[Konsonant]) = 'I') or
          (upcase(s[Konsonant]) = 'O') or (upcase(s[Konsonant]) = 'U'))) and
          (((upcase(s[Konsonant]) >= 'B') and (upcase(s[Konsonant]) <= 'Z')))
        then
          AnzahlKonsonanten := AnzahlKonsonanten + 1; //Summe der Konsonanten

      end;

    until (Konsonant = Length(s));
    countConsonants := AnzahlKonsonanten
  end;
end;

function countNonLetters(s: string): byte;
{Diese Funktion gibt alle nicht Buchstaben aus}
var
  nonBuchstabe, AnzahlNonBuchstabe: byte;
begin
  if s = '' then
    countNonLetters := 0
  else
    countNonLetters := Length(s) - countVowels(s) - countConsonants(s)
//Wir ziehen die Vokale und Konsonanten von der Länge des Satzes ab
end;

procedure duplicateVowels(var s: string);
{Man geht anhand einer Repeat-Schleife die einzelen Zeichen unseres Strings
durch und kontrolliert ob es Vokale sind. Die Prozedur verdoppelt alle Vokale.}
var
  DoubleVocal: byte;
begin
  if s = '' then //Leereszeichen wieder als Sonderfall definiert
     s := ''
  else
  begin
    DoubleVocal := 0;

    repeat

      inc(DoubleVocal);

      begin
        if (upcase(s[DoubleVocal]) = 'A') or (upcase(s[DoubleVocal]) = 'E') or
           (upcase(s[DoubleVocal]) = 'I') or (upcase(s[DoubleVocal]) = 'O') or
           (upcase(s[DoubleVocal]) = 'U') then
        begin
          //einfügen des duplizierten Vokals und überspringen der Kopie
          insert(s[DoubleVocal], s , DoubleVocal);
          DoubleVocal := DoubleVocal + 1;
        end;
      end;

    until (DoubleVocal = Length(s));

  end;

end;



var
  input: string;

 //Überprüfung von verschieden Beispielen für die Funktionen und Prozeduren

begin
{lettersOnly}
  writeln('Nur Wörter: ');
  writeln('String: ''''           Erwartet -> TRUE  bekommen: ',lettersOnly(''));
  writeln('String: ''Hallo''      Erwartet -> TRUE  bekommen: ',lettersOnly('Hallo'));
  writeln('String: ''Hallo Welt'' Erwartet -> False bekommen: ',lettersOnly('Hallo Welt'));
  writeln('String: ''Hallo6''     Erwartet -> False bekommen: ',lettersOnly('Hallo6'));
  writeln('String: ''Hallo78&()'' Erwartet -> False bekommen: ',lettersOnly('Hallo78&()'));
  writeln;

{deleteAllButLetters}
  writeln('Nur Buchstaben: ');
  input := '';
  deleteAllButLetters(input);
  writeln('String: ''''                  Erwartet -> ''''      bekommen: ',input);
  input := 'Hallo';
  deleteAllButLetters(input);
  writeln('String: ''Hallo''             Erwartet -> ''Hallo'' bekommen: ',input);
  input := 'H466o We6t';
  deleteAllButLetters(input);
  writeln('String: ''H466o We6t''        Erwartet -> ''HoWet'' bekommen: ',input);
  input := '32125746{[]}/)%&/';
  deleteAllButLetters(input);
  writeln('String: ''32125746{[]}/)%&/'' Erwartet -> ''''      bekommen: ',input);
  input := '()a&/  ()%';
  deleteAllButLetters(input);
  writeln('String: ''()a&/  ()%''        Erwartet -> ''a''     bekommen: ',input);
  writeln;

{countVowels}
  writeln('Anzahl Vokale: ');
  writeln('String: ''''           Erwartet -> ''0'' bekommen: ', countVowels(''));
  writeln('String: ''Hallo''      Erwartet -> ''2'' bekommen: ', countVowels('Hallo'));
  writeln('String: ''Hallo Welt'' Erwartet -> ''3'' bekommen: ', countVowels('Hallo Welt'));
  writeln('String: ''H4ll0 W3lt'' Erwartet -> ''0'' bekommen: ', countVowels('H4ll0 W3lt'));
  writeln('String: ''(&%$&a§)''   Erwartet -> ''1'' bekommen: ', countVowels('(&%$&a§)'));
  writeln;

{countConsonants}
  writeln('Anzahl Konsonanten: ');
  writeln('String: ''''           Erwartet -> ''0'' bekommen: ', countConsonants(''));
  writeln('String: ''Hallo''      Erwartet -> ''3'' bekommen: ', countConsonants('Hallo'));
  writeln('String: ''Hallo Welt'' Erwartet -> ''6'' bekommen: ', countConsonants('Hallo Welt'));
  writeln('String: ''H4770 W3lt'' Erwartet -> ''4'' bekommen: ', countConsonants('H4770 W3lt'));
  writeln('String: ''(&%$&a§)''   Erwartet -> ''0'' bekommen: ', countConsonants('(&%$&a§)'));
  writeln;

{countNonLetters}
  writeln('Anzahl Zeichen: ');
  writeln('String: ''''            Erwartet -> ''0''  bekommen: ', countNonLetters(''));
  writeln('String: ''Hallo''       Erwartet -> ''0''  bekommen: ', countNonLetters('Hallo'));
  writeln('String: ''Hallo Welt''  Erwartet -> ''1''  bekommen: ', countNonLetters('Hallo Welt'));
  writeln('String: ''H4ll0 W3lt''  Erwartet -> ''3''  bekommen: ', countNonLetters('H4ll0 W3lt'));
  writeln('String: ''!"§$%&/()=\'' Erwartet -> ''11'' bekommen: ', countNonLetters('!"§$%&/()=\'));
  writeln;

{duplicateVowels}
  writeln('Duplizierte Vokale: ');
  input := '';
  duplicateVowels(input);
  writeln('String: ''''              Erwartet -> ''''              bekommen: ',input);
  input := 'abc';
  duplicateVowels(input);
  writeln('String: ''aabc''          Erwartet -> ''aabc''          bekommen: ',input);
  input := 'cde';
  duplicateVowels(input);
  writeln('String: ''cdee''          Erwartet -> ''cdee''          bekommen: ',input);
  input := 'Hallo';
  duplicateVowels(input);
  writeln('String: ''Hallo''         Erwartet -> ''Haalloo''       bekommen: ',input);
  input := 'H466o We6t';
  duplicateVowels(input);
  writeln('String: ''H466o We6t''    Erwartet -> ''H466oo Wee6t''  bekommen: ',input);
  input := '32125746/)%&/';
  duplicateVowels(input);
  writeln('String: ''32125746/)%&/'' Erwartet -> ''32125746/)%&/'' bekommen: ',input);
  input := '()a&/  ()%';
  duplicateVowels(input);
  writeln('String: ''()a&/  ()%''    Erwartet -> ''()aa&/  ()%''   bekommen: ',input);
  writeln;
  readln;
end.
