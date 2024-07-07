program Liste;
{ Joshua-Scott Sch�ttke und Moritz Richter Gruppe 81 Programm zum erstellen
einer Liste von Zahlen, welches einen auch noch die Anzahl positiver und
negativer Zahlen ausgibt.}


{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

type
  PListe = ^TElement;

  TElement = record
    Wert: integer;
    Naechste: PListe;
  end;
 // Prozedur dir der Liste ein Elemet hinzuf�gt
 //@param
 //Start gibt den Ersten Wert der Liste an
 //I ist der Wert der hinzugef�gt wird
 //@out
 // Die neue Liste
procedure ElementHinzufuegen(var Start: PListe; I: integer);
var
  Element: PListe;
begin
  new(Element);
  Element^.Wert := I;
  Element^.Naechste := Start;
  Start := Element;
end;

//Prozedur die die Liste ausgibt
//@param
//Start gibt den ersten Wert der Liste an von den er dann auf die n�chsten Werte
//kommt
procedure ListeAusgeben(Start: PListe);
var
  LaufZeiger: PListe;
begin
  writeln('Die Liste enth�lt folgende Werte: ');
  LaufZeiger := Start;
  while LaufZeiger <> nil do
  begin
    write(LaufZeiger^.Wert, ' ');
    LaufZeiger := LaufZeiger^.Naechste;
  end;
  writeln;
end;

// Prozedur die die Anzahl der positiven und negativen Zahlen in der Liste ausgibt
//@param
//Start als Anfangswert der Liste
procedure Anzahl(Start: PListe);
var
  Positiv, Negativ: integer;
begin
  Positiv := 0;
  Negativ := 0;


  while Start <> nil do
  begin
    if Start^.Wert >= 0 then
      inc(Positiv)
      else
      inc(Negativ);
    Start := Start^.Naechste;
  end;
  writeln('Die Liste enth�lt diese Anzahl positiver Werte: ',Positiv);
  writeln;
  writeln('Die Liste enth�lt diese Anzahl negativer Werte: ',Negativ);
  writeln;
end;

//Gibt den Stack f�r die einzelnen Zeiger wieder frei
//@param
//Start f�r den ersten Wert der List
//@out
//Leere Liste
procedure ListeL�schen(var Start: PListe);
var
  LaufZeiger: PListe;
begin
  while LaufZeiger <> nil do
  begin
    LaufZeiger := Start;
    Start := LaufZeiger^.Naechste;
    Dispose(LaufZeiger);
  end;
end;
 //Hauptprogramm
var
  Eingabe: string;
  Code, I: integer;
  Start: PListe;

begin
  Start := nil;
  repeat
    writeln('Bitte geben Sie eine Zahl ein!');
    readln(Eingabe);
      val(Eingabe, I, Code);
      if (Code = 0)  then
        ElementHinzufuegen(Start, I)
      else
        if Uppercase(Eingabe) <> 'X' then
        writeln('Ung�ltige Eingabe!');
  until (Uppercase(Eingabe) = 'X');
  writeln;
  ListeAusgeben(Start);
  Anzahl(Start);
  ListeL�schen(Start);
  readln;
end.
