program Zeiger_und_Listen;
{ Joshua-Scott Sch�ttke und Moritz Richter Gruppe 81
}

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

type
  PZeichen = ^char;

  { Deklariere Dir nun alle Typen, die f�r eine Liste mit Integerwerten ben�tigt werden
    und lege Dir eine Variable vom Listentyp an und initialisiere diese mit nil. }

  PIntRec = ^TIntRec;

  TIntRec = record
    Zahl: Integer;
    Zeiger: PIntRec;
  end;



{ Schreibe dann eine Funktion anhaengen, die der Liste am Anfang ein Element hinzuf�gt.
  Die Funktion soll einen Parameter mit dem Integerwert des neuen Elementes sowie den
  Einstiegszeiger der Liste bekommen und gibt den neuen Einstiegszeiger als Funktionsergebnis zur�ck. }

function anhaengen(var IntRec, Zahl : PIntRec) : integer;
var
  Temp : integer;
begin
new(Temp);
Temp^.Zahl := Temp;
Temp^.Zeiger := IntRec;
Liste := Temp;

end;
  { Deklariere Dir einen Typen f�r einen Zeiger auf char und lege zwei Variablen
    davon an sowie eine normale char-Variable an. Weise der char-Variable einen gro�en
    Buchstaben zu und lasse dann beide Zeiger auf diese Variable zeigen. }
var
  Gro�, Klein: PZeichen;
  Normal: char;
  IntRec, Zahl: PIntRec;


begin
  Normal := 'A';
  Gro� := @Normal;
  Klein := @Normal;

  { Zwischenfrage: Ist bis jetzt ein new erforderlich? Falls ja: wo? Falls nein: warum nicht?
    Antwort nein da wir nur auf eine feste Speicheradresse des Typs Char verweisen. }

  { Lasse Dir in einem writeln die char-Variable und die beiden Werte, auf die die Zeiger
    zeigen ausgeben (alle drei sollten nat�rlich gleich sein). }

  writeln(Normal, Gro�^, Klein^);
  writeln;

  { �ndere jetzt erst den Wert der char-Variablen, dann den Wert, auf den der 1. Zeiger
    zeigt und dann den vom 2. Zeiger und lasse Dir nach jeder �nderung wieder die drei
    Werte mit dem writeln anzeigen. Jedes Mal sollten sich alle drei ge�ndert haben! }

  Normal := 'B';
  writeln(Normal, Gro�^, Klein^);
  writeln;

  Gro�^ := 'C';
  writeln(Normal, Gro�^, Klein^);
  writeln;

  Klein^ := 'D';
  writeln(Normal, Gro�^, Klein^);
  writeln;

  IntRec := nil;

  readln;

end.


{ Zus�tzlich soll es eine Prozedur ausgeben geben, die eine per Parameter �bergebene
  Liste von vorn bis hinten zeilenweise ausgibt. Wenn die Liste leer ist (der Einstiegszeiger
  also nil), soll 'Die Liste ist leer' ausgegeben werden.

  Als letztes soll die Liste noch freigegeben werden, um den Speicher sauber zu hinterlassen.
  Erg�nzt nun also noch eine Prozedur freigeben, die den gesamten Speicher mit dispose wieder
  aufr�umt und gebt die Liste danach noch einmal aus. }
