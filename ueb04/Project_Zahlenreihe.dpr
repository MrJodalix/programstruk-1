(* Moritz Richter, Joshua-Scott Schöttke, Gruppe81, 29.11.2019
  Das Programm soll Zahlen ausgeben, dazu kommt die Überprüfung ob die Zahlen
  Gerade oder Primzahlen sind. Dazu kommt eine neu Sortierung der Reihenfolge
  von 0 bis 9.
*)

program Project_Zahlenreihe;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.Math;

const
  LOWER_BORDER = 1;
  UPPER_BORDER = 200;

var
  Zahl, Ziffer, Teiler, Rest, Sortierer: word;
  ZahlGerade, Primzahl: boolean;

begin
  // Ausgabe der Folge der Konstanten
  for Zahl := LOWER_BORDER to UPPER_BORDER do

  // Prüfung ob Zahl Gerade
  begin
    ZahlGerade := Zahl mod 2 = 0;

    Teiler := 2;

    // Prüfung auf Primzahl
    if Zahl > 1 then
    begin
      Rest := Zahl mod Teiler;
      while Rest <> 0 do
      begin
        Teiler := Teiler + 1;
        Rest := Zahl mod Teiler;
      end;

      if Teiler = Zahl then
        Primzahl := True

      else
        Primzahl := False;

    end;


    // Erste Ausgabe

    write(Zahl:6, ' Gerade: ', ZahlGerade:6, '    Prim: ', Primzahl:6,
      ' Ziffern sortiert: ');


    // Sortierung der Reihenfolge

    for Sortierer := 0 to 9 do
    begin

      Ziffer := Zahl;
      repeat
        if Ziffer mod 10 = Sortierer then
          write(Ziffer mod 10);
        Ziffer := Ziffer div 10;
      until (Ziffer = 0);

    end;

    // Ausgabe der Reihenfolge

    writeln;

  end;

  readln;

end.
