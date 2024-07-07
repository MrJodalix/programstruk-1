(* Moritz Richter, Joshua-Scott Schöttke
  Das Programm sagt uns welches Restaurant an welchem tag offen hat und gibt uns
  ein Gericht für unsere Vorlieben aus.
*)

program Project_Restaurant;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

var
  Wochentag, Gemuesesorten: byte;

  RestaurantTag, VegetarischJ, ScharfJ, ExotischJ, Erbsensuppe, Fruehlingsrolle,
    Gyros, Salatteller: boolean;

  Vegetarisch, Scharf, Exotisch, GrünesGemüse, Knoblauch, Bambussprossen: char;

begin
  VegetarischJ := False;
  ScharfJ := False;
  ExotischJ := False;

  writeln('Welchen Wochentag haben wir heute (1 = Mo .. 7 = So)?');
  readln(Wochentag);
  (* Die Case Anweisung gibt uns das Restaurant aus in dem wir an dem jeweiligen
    Wochentag essen gehen können. *)
  case Wochentag of
    1, 2, 7:
      writeln('An diesem Tag hat leider kein Restaurant geöffnet :-(');
    3:
      writeln('Willkommen bei "Auflauf-Andi"!');
    4:
      writeln('Willkommen bei "Burger-Bernd"!');
    5:
      writeln('Willkommen bei "Chili-Claus"!');
    6:
      writeln('Willkommen bei "Döner-Dieter"!');
  else
    writeln('Diesen Wochentag gibt es gar nicht!')
  end;

  RestaurantTag := (Wochentag = 3) or (Wochentag = 4) or (Wochentag = 5) or
    (Wochentag = 6);

  (* Diese if Anweisung fragt die vorlieben ab, wenn ein Restaurant offen hat. *)

  if RestaurantTag then
  begin
    writeln('Mögen Sie es vegetarisch? (J/N) ');
    readln(Vegetarisch);
    VegetarischJ := Vegetarisch = 'J';

    writeln('Mögen Sie es scharf? (J/N) ');
    readln(Scharf);
    ScharfJ := Scharf = 'J';

    writeln('Mögen Sie es exotisch? (J/N) ');
    readln(Exotisch);
    ExotischJ := Exotisch = 'J';

    (* Diese logischen Schaltungen geben die Voraussetzungen für das jeweilige Gericht. *)

    Erbsensuppe := (not VegetarischJ) and (not ScharfJ) and (not ExotischJ);
    Fruehlingsrolle := (VegetarischJ) and ((ScharfJ) or (ExotischJ));
    Gyros := (not VegetarischJ) and (not ScharfJ) and (ExotischJ);
    Salatteller := (VegetarischJ) and (not ScharfJ) and (not ExotischJ);

    (* Hier wird noch einmal gefragt ob man das Gericht wirklich essen will. *)

    if Erbsensuppe xor Gyros xor Fruehlingsrolle xor Salatteller then
    begin
      if Erbsensuppe then
      begin
        writeln('Sie möchten Erbsensuppe essen.');
        writeln('Mögen Sie grünes Gemüse? (J/N)');
        readln(GrünesGemüse);
        if GrünesGemüse = 'J' then
          writeln('Guten Appetit')
        else
          writeln('Sie mögen keine Erbsensuppe')
      end
      else

        if Gyros then
      begin
        writeln('Sie möchten Gyros essen.');
        writeln('Mögen Sie Knoblauch? (J/N)');
        readln(Knoblauch);
        if Knoblauch = 'J' then
          writeln('Guten Appetit')
        else
          writeln('Sie mögen kein Gyros')
      end

      else

        if Fruehlingsrolle then
      begin
        writeln('Sie möchten Frühlingsrollen essen.');
        writeln('Mögen Sie Bambussprossen? (J/N)');
        readln(Bambussprossen);
        if Bambussprossen = 'J' then
          writeln('Guten Appetit')
        else
          writeln('Sie mögen keine Frühlingsrollen')
      end

      else

        if Salatteller then
      begin
        writeln('Sie möchten einen Salatteller essen.');
        writeln('Wie viele verschiedene Gemüsesorten mögen Sie?');
        readln(Gemuesesorten);
        if Gemuesesorten >= 5 then
          writeln('Guten Appetit')
        else
          writeln('Sie möchten keinen Salatteller')
      end

    end

    else
    begin

      writeln('Viel Spaß beim Fasten!');

    end;
  end;


readln;

end.
