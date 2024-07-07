program Zeiger_und_Listen;
{ Joshua-Scott Schöttke und Moritz Richter Gruppe 81
}

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

type
  PZeichen = ^char;

  { Deklariere Dir nun alle Typen, die für eine Liste mit Integerwerten benötigt werden
    und lege Dir eine Variable vom Listentyp an und initialisiere diese mit nil. }

  PIntRec = ^TIntRec;

  TIntRec = record
    Zahl: Integer;
    Zeiger: PIntRec;
  end;



{ Schreibe dann eine Funktion anhaengen, die der Liste am Anfang ein Element hinzufügt.
  Die Funktion soll einen Parameter mit dem Integerwert des neuen Elementes sowie den
  Einstiegszeiger der Liste bekommen und gibt den neuen Einstiegszeiger als Funktionsergebnis zurück. }

function anhaengen(var IntRec, Zahl : PIntRec) : integer;
var
  Temp : integer;
begin
new(Temp);
Temp^.Zahl := Temp;
Temp^.Zeiger := IntRec;
Liste := Temp;

end;
  { Deklariere Dir einen Typen für einen Zeiger auf char und lege zwei Variablen
    davon an sowie eine normale char-Variable an. Weise der char-Variable einen großen
    Buchstaben zu und lasse dann beide Zeiger auf diese Variable zeigen. }
var
  Groß, Klein: PZeichen;
  Normal: char;
  IntRec, Zahl: PIntRec;


begin
  Normal := 'A';
  Groß := @Normal;
  Klein := @Normal;

  { Zwischenfrage: Ist bis jetzt ein new erforderlich? Falls ja: wo? Falls nein: warum nicht?
    Antwort nein da wir nur auf eine feste Speicheradresse des Typs Char verweisen. }

  { Lasse Dir in einem writeln die char-Variable und die beiden Werte, auf die die Zeiger
    zeigen ausgeben (alle drei sollten natürlich gleich sein). }

  writeln(Normal, Groß^, Klein^);
  writeln;

  { Ändere jetzt erst den Wert der char-Variablen, dann den Wert, auf den der 1. Zeiger
    zeigt und dann den vom 2. Zeiger und lasse Dir nach jeder Änderung wieder die drei
    Werte mit dem writeln anzeigen. Jedes Mal sollten sich alle drei geändert haben! }

  Normal := 'B';
  writeln(Normal, Groß^, Klein^);
  writeln;

  Groß^ := 'C';
  writeln(Normal, Groß^, Klein^);
  writeln;

  Klein^ := 'D';
  writeln(Normal, Groß^, Klein^);
  writeln;

  IntRec := nil;

  readln;

end.


{ Zusätzlich soll es eine Prozedur ausgeben geben, die eine per Parameter übergebene
  Liste von vorn bis hinten zeilenweise ausgibt. Wenn die Liste leer ist (der Einstiegszeiger
  also nil), soll 'Die Liste ist leer' ausgegeben werden.

  Als letztes soll die Liste noch freigegeben werden, um den Speicher sauber zu hinterlassen.
  Ergänzt nun also noch eine Prozedur freigeben, die den gesamten Speicher mit dispose wieder
  aufräumt und gebt die Liste danach noch einmal aus. }
