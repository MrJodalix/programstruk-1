program TIC_TAC_TOE_FERTIG2;
(* Joshua-Scott Schöttke, Moritz Richter Gruppe81 Programm für das Spiel
  Tic Tac Toe mit verstellbarer Spielfeldgröße *)

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils,
  Windows;

const
  SIZE = 3; // Einstellbare quadratische Spielfeldgröße

type
  TSize = 1 .. SIZE;
  TState = (stLeer, st1, st2);
  TField = array [TSize, TSize] of TState;

  (* Prozedur welche den Cursor an die Stelle (x,y) in der Konsole plaziert, damit
    mit man das Feld nicht x-mal untereinanderschreiben muss, sondern immer nur ein
    Feld hat *)
procedure setConsolePosition(x, y: byte);
var
  coord: _COORD;
begin
  coord.x := x;
  coord.y := y;
  if SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord) then;
end;

(* Funktion überprüft ob die Koordinaten x,y auch im Tic Tac Toe-Feld liegen *)
function isValidCoord(x, y: integer): boolean;
begin
  isValidCoord := (x >= 1) and (x <= SIZE) and (y >= 1) and (y <= SIZE);
end;

(* Prozedur welche uns zu Anfang mithilfe von zwei For-Schleifen alle Stellen
  des Feldes mit "_" füllt *)
procedure initField(var field: TField);
var
  I, J: TSize;
begin
  for J := Low(TSize) to High(TSize) do
  begin
    for I := Low(TSize) to High(TSize) do

      field[I, J] := stLeer;
  end;
end;

(* Prozedur die uns das Feld mit allen bis dahin eingegebenen Zeichern durch
  eine Case-Anweisung rausgibt, also für stLeer ein "_", für st1 ein "O" und für
  st2 ein "X".
  Funktioniert wie initField auch wieder mit zwei For-Schleifen um durch das
  ganze Feld zugehen *)
procedure printField(field: TField);
var
  I, J: TSize;
begin
  setConsolePosition(0, 0);
  for J := High(TSize) downto Low(TSize) do
  begin
    for I := Low(TSize) to High(TSize) do
      case field[J, I] of
        stLeer:
          write('_');
        st1:
          write('O');
        st2:
          write('X');
      end;
    writeln;
  end;
  writeln;
end;

(* Funktion, die den Spieler erst nach der Spalte und dann nach der Zeile
  abfragt, in der er sein Zeichen haben will und dann die Eingaben den
  x,y-Koordinaten zuweist oder ihn die Möglichkeit gibt durch "X" das
  Spiel abzubrechen.
  Die Funktion überprüft ob die Eingabe des Benutzers auch gültige Angeaben
  sind, also x,y auch im Feld liegen und aucgh wirklich Koordinaten sind und
  weist sonst den Spieler darauf hin das die Eingabe ungültig ist. *)
function readInput(var x, y: TSize; var cancel: boolean): boolean;
var
  Input: string;
  Code: integer;

begin
  cancel := false;
  Input := '';

  repeat
    repeat
      setConsolePosition(0, SIZE + 2);
      writeln('Bitte eine Zahl für die Spalte von 1 bis ', SIZE,
        ' eingeben oder ''X'' für Abbruch: ');
      readln(Input);
      if Uppercase(Input) = 'X' then
      begin
        cancel := true;
        setConsolePosition(0, SIZE + 8);
        writeln('Spiel abgebrochen!');
      end
      else
      begin
        val(Input, y, Code);
        if (y >= 1) and (y <= SIZE) then
          y := y
        else
        begin
          setConsolePosition(0, SIZE + 4);
          writeln('Eingabe Ungültig! Bitte Enter drücken!                                                 ');
          readln;
        end;
      end;
    until (cancel) or ((y >= 1) and (y <= SIZE));
    if not(cancel) then
    begin
      repeat
        setConsolePosition(0, SIZE + 4);
        writeln('Bitte eine Zahl für die Zeile  von 1 bis ', SIZE,
          ' eingeben oder ''X'' für Abbruch: ');
        readln(Input);

        if Uppercase(Input) = 'X' then
        begin
          cancel := true;
          setConsolePosition(0, SIZE + 8);
          writeln('Spiel abgebrochen!');
        end

        else
        begin
          val(Input, x, Code);
          if (x >= 1) and (x <= SIZE) then
            x := x
          else
          begin
            setConsolePosition(0, SIZE + 2);
            writeln('Eingabe Ungültig! Bitte Enter drücken!                                            ');

            readln;
          end;

        end;
      until (cancel) or ((x >= 1) and (x <= SIZE));
    end;

  until (cancel) or (isValidCoord(x, y));

  if isValidCoord(x, y) then
    readInput := true;
end;

(* Funktion überprüft ob das Feld an der Stelle x,y noch Leer ist, also an der
  Stelle ein "_" steht *)
function isCellPossible(field: TField; x, y: TSize): boolean;
begin
  isCellPossible := field[x, y] = stLeer;
end;

(* Prozedur die das Feld an der Stelle x,y mit den Zeichen des Spielers bellegt,
  welcher gerade dran ist *)
procedure setSign(var field: TField; x, y: TSize; state: TState);
begin
  if isCellPossible(field, x, y) then
    field[x, y] := state;
end;

(* Hilfsfunktion für isGameWon. Zählt im Feld ausgehend von der Position
  x/y, wie viele Zeichen zusammenhängend gleich wie das an
  xStart/yStart sind. Die Richtung, in der von xStart/yStart ausgehend gezählt
  wird, wird durch xOffset und yOffset, welche in isGameWon vorgegeben werden,
  angegeben.
  xOffset=1 und yOffset=0 wäre z.B. nach rechts, xOffset=0 und yOffset=1
  wäre nach oben, xOffset=1 und yOffset=-1 wäre nach unten rechts und xOffset=1
  und yOffset=1 wäre nach oben rechts (die Koordinate 1/1 ist also jeweils unten
  links). *)
function countSignsInDir(field: TField; xStart, yStart: TSize;
  xOffset, yOffset: integer): byte;
var
  CountState, Count: byte;
  x, y: integer;
begin
  CountState := 0;
  Count := 0;
  x := xStart;
  y := yStart;
  repeat
    inc(Count);
    if field[xStart, yStart] = field[x, y] then
      inc(CountState);
    x := x + xOffset;
    y := y + yOffset;
    if not(isValidCoord(x, y)) then
    begin
      x := x - (SIZE * xOffset);
      y := y - (SIZE * yOffset);
    end;
  until (Count = SIZE) or (not(isValidCoord(x, y)));
  countSignsInDir := CountState;
end;

(* Funktion die mit hilfe der Funktion countSignsInDir die verschiedene
  Gewinnmöglichkeiten, also alle Reihen, Zeilen und die beiden Schrägen
  überprüft und bestimmt ob ein Spieler gewonnen hat.
  Die Variablen x,y geben xStart und yStart für countSignsInDir an *)
function isGameWon(field: TField; x, y: TSize): boolean;
begin
  isGameWon := false;
  if (countSignsInDir(field, x, y, 1, 0) = SIZE) or
    (countSignsInDir(field, x, y, 0, 1) = SIZE) or
    (countSignsInDir(field, x, y, 1, 1) = SIZE) or
    (countSignsInDir(field, x, y, 1, -1) = SIZE) then
    isGameWon := true;
end;

(* Funktion überprüft ob das Feld voll ist mithilfe von zwei For-Schleifen *)
function isFieldFull(field: TField): boolean;
var
  CounterF: byte;
  I, J: TSize;

begin
  isFieldFull := false;
  CounterF := 0;
  for J := Low(TSize) to High(TSize) do
  begin
    for I := Low(TSize) to High(TSize) do
      if field[I, J] <> stLeer then
      begin
        CounterF := CounterF + 1;
      end;
     
  end;
  if CounterF = (SIZE * SIZE) then
     isFieldFull := true;
end;

var
  field: TField;
  x, y: TSize;
  cancel: boolean;
  Counter: byte;



begin
  Counter := 0;
  cancel := false;
  initField(field);
  printField(field);
  repeat
    if readInput(x, y, cancel) then
    begin
      if isValidCoord(x, y) then
      begin
        if isCellPossible(field, x, y) then
        begin
          Counter := Counter + 1;
          if Counter mod 2 = 1 then // Bestimmung ob Spieler 1 oder 2 dran ist
            setSign(field, x, y, st1)
          else
            setSign(field, x, y, st2);
          if (field[x, y] = st1) or (field[x, y] = st2) then
            printField(field);
          setConsolePosition(0, SIZE + 3);
          writeln('      ');
          setConsolePosition(0, SIZE + 5);
          writeln('      ');
          if isGameWon(field, x, y) then
          begin
            if field[x, y] = st1 then
            begin
              writeln('Spieler 1 gewinnt!');
            end
            else
              writeln('Spieler 2 gewinnt!');
            cancel := true;
            readln;
          end
          else
          begin
            if isFieldFull(field) then
            begin
              writeln('Feld ist voll! Spiel beendet!');
              cancel := true;
              readln;
            end;
          end;
        end;
      end;
    end
    until (cancel);
end.
