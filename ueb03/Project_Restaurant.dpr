(* Moritz Richter, Joshua-Scott Sch�ttke
  Das Programm sagt uns welches Restaurant an welchem tag offen hat und gibt uns
  ein Gericht f�r unsere Vorlieben aus.
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

  Vegetarisch, Scharf, Exotisch, Gr�nesGem�se, Knoblauch, Bambussprossen: char;

begin
  VegetarischJ := False;
  ScharfJ := False;
  ExotischJ := False;

  writeln('Welchen Wochentag haben wir heute (1 = Mo .. 7 = So)?');
  readln(Wochentag);
  (* Die Case Anweisung gibt uns das Restaurant aus in dem wir an dem jeweiligen
    Wochentag essen gehen k�nnen. *)
  case Wochentag of
    1, 2, 7:
      writeln('An diesem Tag hat leider kein Restaurant ge�ffnet :-(');
    3:
      writeln('Willkommen bei "Auflauf-Andi"!');
    4:
      writeln('Willkommen bei "Burger-Bernd"!');
    5:
      writeln('Willkommen bei "Chili-Claus"!');
    6:
      writeln('Willkommen bei "D�ner-Dieter"!');
  else
    writeln('Diesen Wochentag gibt es gar nicht!')
  end;

  RestaurantTag := (Wochentag = 3) or (Wochentag = 4) or (Wochentag = 5) or
    (Wochentag = 6);

  (* Diese if Anweisung fragt die vorlieben ab, wenn ein Restaurant offen hat. *)

  if RestaurantTag then
  begin
    writeln('M�gen Sie es vegetarisch? (J/N) ');
    readln(Vegetarisch);
    VegetarischJ := Vegetarisch = 'J';

    writeln('M�gen Sie es scharf? (J/N) ');
    readln(Scharf);
    ScharfJ := Scharf = 'J';

    writeln('M�gen Sie es exotisch? (J/N) ');
    readln(Exotisch);
    ExotischJ := Exotisch = 'J';

    (* Diese logischen Schaltungen geben die Voraussetzungen f�r das jeweilige Gericht. *)

    Erbsensuppe := (not VegetarischJ) and (not ScharfJ) and (not ExotischJ);
    Fruehlingsrolle := (VegetarischJ) and ((ScharfJ) or (ExotischJ));
    Gyros := (not VegetarischJ) and (not ScharfJ) and (ExotischJ);
    Salatteller := (VegetarischJ) and (not ScharfJ) and (not ExotischJ);

    (* Hier wird noch einmal gefragt ob man das Gericht wirklich essen will. *)

    if Erbsensuppe xor Gyros xor Fruehlingsrolle xor Salatteller then
    begin
      if Erbsensuppe then
      begin
        writeln('Sie m�chten Erbsensuppe essen.');
        writeln('M�gen Sie gr�nes Gem�se? (J/N)');
        readln(Gr�nesGem�se);
        if Gr�nesGem�se = 'J' then
          writeln('Guten Appetit')
        else
          writeln('Sie m�gen keine Erbsensuppe')
      end
      else

        if Gyros then
      begin
        writeln('Sie m�chten Gyros essen.');
        writeln('M�gen Sie Knoblauch? (J/N)');
        readln(Knoblauch);
        if Knoblauch = 'J' then
          writeln('Guten Appetit')
        else
          writeln('Sie m�gen kein Gyros')
      end

      else

        if Fruehlingsrolle then
      begin
        writeln('Sie m�chten Fr�hlingsrollen essen.');
        writeln('M�gen Sie Bambussprossen? (J/N)');
        readln(Bambussprossen);
        if Bambussprossen = 'J' then
          writeln('Guten Appetit')
        else
          writeln('Sie m�gen keine Fr�hlingsrollen')
      end

      else

        if Salatteller then
      begin
        writeln('Sie m�chten einen Salatteller essen.');
        writeln('Wie viele verschiedene Gem�sesorten m�gen Sie?');
        readln(Gemuesesorten);
        if Gemuesesorten >= 5 then
          writeln('Guten Appetit')
        else
          writeln('Sie m�chten keinen Salatteller')
      end

    end

    else
    begin

      writeln('Viel Spa� beim Fasten!');

    end;
  end;


readln;

end.
