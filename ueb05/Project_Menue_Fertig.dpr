program Project_Menue_Fertig;
(*Joshua-Scott Schöttke, Moritz Richter Gruppe81 Ein Menü das einem verschiedene
Optionen zur Bearbeitung eines Satzes gibt*)
{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

var
  Satz, Satzzahl, Wort, WortLoesch, WortZiffer, SatzLoesch: string;
  Auswahl: char;
  Rot_13, ZifferAbfrage: byte;
  Counter, ZwischAblage, Ziffer, Zeichen, Pruefung: integer;

begin

  Satz := '';
 (*Eine Repeat-Schleife zur wiederholten abfrage des Menüs*)
  repeat
    writeln('Wählen Sie eine Opption!');
    writeln('A = Satz eingeben.');
    writeln('B = Anzahl Ziffern im Satz bestimmen.');
    writeln('C = Alle Buchstaben im Satz mit dem ROT13-Verfahren verschlüsseln.');
    writeln('D = Alle Wörter löschen, die Ziffern enthalten.');
    writeln('X = ENDE!');
    writeln;

    readln(Auswahl);
    writeln;
   (*Eine Case-Anweisung für die einzelnen Menüpunkte*)
    case Auswahl of

      'A', 'a':
        begin
          writeln('Satz eingeben');
          writeln;
          readln(Satz);
          writeln;
        end;
     (*Eine For-Scheife zum Überprüfen des Satzes auf Zahlen und angabe von wie
     vielen Zahlen*)
      'B', 'b':
      if satz <> '' then

        begin
          Satzzahl := Satz;
          Ziffer := 0;
          for ZifferAbfrage := 1 to length(Satzzahl) do
            if (Satzzahl[ZifferAbfrage] >= '0') and
              (Satzzahl[ZifferAbfrage] <= '9') then
              Ziffer := Ziffer + 1;
          writeln(Ziffer, ' Ziffern im Satz gefunden');
          writeln;
        end;
    (*Verschlüsseln der einzelnen Buchstaben nach dem Rot_13-Verfahren*)
      'C', 'c':
      if satz <> '' then
        begin

          for Rot_13 := 1 to length(Satz) do
          begin
            if (Satz[Rot_13] >= 'A') and (Satz[Rot_13] <= 'Z') then

            begin
              ZwischAblage := ord(Satz[Rot_13]);
              if ZwischAblage > 77 then
                ZwischAblage := ZwischAblage - 13
              else
                ZwischAblage := ZwischAblage + 13;
              Satz[Rot_13] := chr(ZwischAblage);
            end;

            if (Satz[Rot_13] >= 'a') and (Satz[Rot_13] <= 'z') then

            begin
              ZwischAblage := ord(Satz[Rot_13]);
              if ZwischAblage > 109 then
                ZwischAblage := ZwischAblage - 13
              else
                ZwischAblage := ZwischAblage + 13;
              Satz[Rot_13] := chr(ZwischAblage);
            end;

          end;
          writeln(Satz);

          writeln;
        end;

      'D', 'd':
      if satz <> '' then

        begin
          SatzLoesch := Satz;
          Wort := '';
          WortZiffer := '';
          Counter := 0;

          (*Aufteilen der des Satzes in einzelne Wörter, die durch Leerzeichen
          getrennt werden*)
          for Zeichen := 1 to length(SatzLoesch) do

            if SatzLoesch[Zeichen] <> ' ' then

              Wort := Wort + SatzLoesch[Zeichen]
            else
            (*Überprüfung ob die Wörter Zahlen enthalten und löschen der Wörter
            mit Zahlen*)
              repeat
                for Pruefung := 1 to length(Wort) do
                begin
                  WortLoesch := WortLoesch + Wort[Pruefung];

                  if (Wort[Pruefung] >= '0') and (Wort[Pruefung] <= '9') then
                    WortZiffer := WortZiffer + Wort[Pruefung];

                end;
                if Wort = WortLoesch then

                  if (WortZiffer >= '0') and (WortZiffer <= '9') then
                  begin
                    delete(Wort, 1, length(Wort));
                    delete(WortLoesch, 1, length(WortLoesch));
                  end;
                if Wort <> '' then
                    Counter := Counter + 1;
                write(Wort);
                if Counter > 0 then
                  write(' ');
                Counter := 0;
                Wort := '';
                WortZiffer := '';
                WortLoesch := '';
              until (Wort = WortLoesch);
          (*Siehe oben nur für das letzte Wort des Satzes*)
          if Wort <> '' then
          begin
              repeat
                for Pruefung := 1 to length(Wort) do
                begin
                  WortLoesch := WortLoesch + Wort[Pruefung];

                  if (Wort[Pruefung] >= '0') and (Wort[Pruefung] <= '9') then
                    WortZiffer := WortZiffer + Wort[Pruefung];
                end;
                if Wort = WortLoesch then

                  if (WortZiffer >= '0') and (WortZiffer <= '9') then
                  begin
                    delete(Wort, 1, length(Wort));
                    delete(WortLoesch, 1, length(WortLoesch));
                  end;

                write(Wort);
                Wort := '';
                WortLoesch := '';
                WortZiffer := '';

              until (Wort = WortLoesch);



          end;

          writeln;
          writeln;

        end;
    end;
    (*Beenden des Programms durch EIngabe von X*)
  until ((((Auswahl) = 'X') or ((Auswahl) = 'x')) = true);

end.
