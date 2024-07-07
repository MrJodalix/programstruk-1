program Mengen_und_Records_Fertig;
{ Joshua-Scott Schöttke und Moritz Richter Gruppe 81 Der Benutzer kann in diesen
Programm Angaben über Name, Erwchsen und Hobbys von Personen machen, welche
dann in ein Arry mit mehren Records gespeichert werden und ausgegeben werden.
Außerdem vergleicht das Programm noch die Hobbys auf mehrfach verwendet und
gar nicht verwendet}

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

type
  THobby = (hbAtmen, hbDschungelcamp, hbEssen, hbSchlafen, hbTrinken);
  THobbySet = set of THobby;

  TPerson = record
    Name: string;
    Adult: boolean;
    Hobby: THobbySet;
  end;

const
  HOBBY_NAMES: array [THobby] of string = ('Atmen', 'Dschungelcamp', 'Essen',
    'Schlafen', 'Trinken');
  NO_OF_PERSONS = 5;   //Veränderbare Anzahl der Personen

type
  TGroup = array [1 .. NO_OF_PERSONS] of TPerson;

{Funktion welche den Benutzer nach den Namen der Person abfragt und überprüft
ob dieser auch wirklich 5 Zeichen lang ist, sonst wird der Benutzer nachmal nach
ein Namen gefragt.
Wenn ein 'X' eingegeben wird dann wird CancelName = True gesetzt, was die
Abfrage des Benutzers beendet.}
function readName(var CancelName: boolean): string;
var
  Cancel: boolean;
  Name: string;
begin
  Cancel := false;
  Name := '';
  repeat
    CancelName := false;
    writeln('Bitte geben sie einen Namen mit mindestens 5 Zeichen ein oder brechen sie mit X ab!');
    readln(Name);

    if (length(Name) >= 5) or (uppercase(Name) = 'X') then
    begin
      Cancel := true;
      CancelName := (uppercase(Name) = 'X');
      readName := Name;
    end;
  until Cancel;
end;

{Funktion welche den Benutzer fragt ob die Person erwachsen ist oder nicht.
Wenn ein 'X' eingegeben wird dann wird CancelAdult = True gesetzt, was die
Abfrage des Benutzers beendet.}
function readIsAdult(var CancelAdult: boolean): boolean;
var
  AdultInput: string;
  Cancel: boolean;
begin
  Cancel := false;
  AdultInput := '';
  repeat
    CancelAdult := false;
    writeln('Bitte geben Sie ein ob die Person erwachsen ist(JA/NEIN) oder brechen sie mit X ab!');
    readln(AdultInput);
    if (uppercase(AdultInput) = 'JA') or (uppercase(AdultInput) = 'NEIN') or
      (uppercase(AdultInput) = 'X') then
    begin
      if (uppercase(AdultInput) = 'JA') then
        readIsAdult := true
      else
      begin
        if (uppercase(AdultInput) = 'NEIN') then
          readIsAdult := false
        else
        begin
          if (uppercase(AdultInput) = 'X') then
            CancelAdult := (uppercase(AdultInput) = 'X');
        end;

      end;
      Cancel := true;
    end;
  until Cancel;
end;

{Funktion welche den Benutzer  nach den Hobbys der Person fragt. Hierbei kann
der Benutzer zwichen 5 verschiedenen Hobbys auswählen und diese jeweils durch
ein + oder - davor hinzufügen oder abziehen.
Man beendet die Eingabe der Hobbys durch ein X.}
function readHobbys(var Hobby: THobbySet): THobbySet;
var
  HobbyInput: string;
  HobbyIndex: THobby;
  Cancel: boolean;

begin
  Cancel := false;
  Hobby := [];

  writeln('Bitte geben sie die Hobbys der Person mit einem + oder - davor ein. Zum Beenden X eingeben!');
  for HobbyIndex := Low(THobby) to High(THobby) do
    write(HOBBY_NAMES[HobbyIndex], ' ');
  writeln;
  repeat
    readln(HobbyInput);
    if uppercase(HobbyInput) = 'X' then
    begin
      Cancel := true
    end
    else
    begin
      for HobbyIndex := Low(THobby) to High(THobby) do
      begin
        if HOBBY_NAMES[HobbyIndex] = copy(HobbyInput, 2, length(HobbyInput) - 1)
        then
        begin
          if (HobbyInput[1]) = '+' then
            include(Hobby, HobbyIndex);
          if (HobbyInput[1]) = '-' then
            exclude(Hobby, HobbyIndex);
        end;

      end;
    end;

  until (Cancel);
  readHobbys := Hobby;
  writeln;
end;

{Funktion welche nach einander die Funktionen readName, readIsAdult und
readHobbys aufruft dann jeweils den Werten der 1. Person im Record zuweist.
Dieses wird dann für die nächsten Personen wiederholt, bis entweder durch
CancelName oder CancelAdult abgebrochen wird oder die maximale Anzahl an
Personen erreicht wird.}
procedure readAll(var NumberPersons: byte; var Group: TGroup);
var
  count: byte;
  Adult, Cancel, CancelAdult, CancelName: boolean;
  Hobby, Hobbys: THobbySet;
  Name: string;

begin
  NumberPersons := 0;
  count := 0;
  Cancel := false;
  Hobby := [];

  repeat
    inc(count);
    CancelName := true;
    CancelAdult := true;
    Name := readName(CancelName);
    if CancelName then
    begin
      Cancel := true;
      writeln;
    end
    else
    begin
      Adult := readIsAdult(CancelAdult);
      writeln;
      if CancelAdult then
        Cancel := true
      else
      begin
        Hobbys := readHobbys(Hobby);
        Group[count].Name := Name;
        Group[count].Adult := Adult;
        Group[count].Hobby := Hobbys;
        inc(NumberPersons);
      end
    end;
  until (count = NO_OF_PERSONS) or Cancel;
end;

{Prozedur welche die zuvor Eingegeben Daten zu einer Person aufschreibt, wenn
zu keiner Person was eingetragen wurde, wird auch nichts ausgegeben.}
procedure printPerson(PersonIndex: byte; var Group: TGroup);
var
  HobbysIndex: THobby;
  HobbyOutput: string;
begin
  writeln(PersonIndex, '. Eingegebene Person:');
  writeln('Name: ', Group[PersonIndex].Name);
  writeln('Erwachsen: ', Group[PersonIndex].Adult);
  write('Hobbys: ');
  for HobbysIndex in Group[PersonIndex].Hobby do
  begin
    HobbyOutput := HOBBY_NAMES[HobbysIndex];
    write(HobbyOutput, ' ');
  end;
  writeln;
end;

{Prozedeur welche mithilfe der Prozedur printPerson die Daten aller Personen
untereinander aufschreibt}
procedure printAllPersons(var NumberPersons: byte; var Group: TGroup);
var
  PersonIndex: byte;
begin
  if NumberPersons > 0 then
    for PersonIndex := 1 to NumberPersons do
    begin
      printPerson(PersonIndex, Group);
      writeln;
    end;

end;

{Przedur welche überprüft welche Hobbys bei mehreren Person eingetragen wurden}
procedure multipleUsedHobbys(var NumberPersons: byte; var Group: TGroup);
var
  p1, p2: byte;
  HobbyIndex: THobby;
  SameHobbys: THobbySet;
  HobbyOutput: string;
begin
  SameHobbys := [];
  if NumberPersons <> 0 then
  begin
    write('Hobbys die mehrfach vorkommen: ');
    for p1 := 1 to NumberPersons do
    begin
      for p2 := p1 + 1 to NumberPersons do
      begin
        SameHobbys := SameHobbys + (Group[p1].Hobby * Group[p2].Hobby);
      end;
    end;
    for HobbyIndex in SameHobbys do
    begin
      HobbyOutput := HOBBY_NAMES[HobbyIndex];
      write(HobbyOutput, ' ');
    end;
  end;
  writeln;

end;

{Prozedur welche überprüft welche Hobbys bei keiner Person eingetragen wurde.}
procedure unusedHobbys(var NumberPersons: byte; var Group: TGroup);
var
  AllHobbys, UsedHobbys, NotUsedHobbys: THobbySet;
  HobbyIndex: THobby;
  PersonIndex: byte;
  HobbyOutput: string;
begin
  if NumberPersons <> 0 then
  begin
    UsedHobbys := [];
    AllHobbys := [low(THobby)..high(THobby)];
    for PersonIndex := 1 to NumberPersons do
      UsedHobbys := UsedHobbys + Group[PersonIndex].Hobby;
    NotUsedHobbys := AllHobbys - UsedHobbys;
    write('Nicht verwendete Hobbys: ');
    for HobbyIndex in NotUsedHobbys do
    begin
      HobbyOutput := HOBBY_NAMES[HobbyIndex];
      write(HobbyOutput, ' ');
    end;
    writeln;
  end;
end;

var
  Group: TGroup;
  NummberPerson: byte;

begin
  readAll(NummberPerson, Group);
  printAllPersons(NummberPerson, Group);
  multipleUsedHobbys(NummberPerson, Group);
  unusedHobbys(NummberPerson, Group);

  readln;

end.
