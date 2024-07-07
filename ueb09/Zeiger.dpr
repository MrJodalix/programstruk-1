// Aufgabe 9
// Einstieg und erste einfache Aufgaben mit Zeigern
// Gruppe 81, Moritz Richter und Joshua-Scott Schöttke

{$APPTYPE CONSOLE}
{$R+,Q+,X-}
program ueb09a;

uses
  System.SysUtils;

type
  { 1)  Legt einen Typ fuer einen Zeiger auf eine Bytevariable an.] }
  PByte = ^byte;

  { 7)  Legt nun einen Typ fuer einen Record mit 3 Bytewerten an. }
  TByteRec = record
    BVar1: byte;
    BVar2: byte;
    BVar3: byte;
  end;

  { 11) Legt einen weiteren Typ fuer einen Record mit 3 Integerwerten sowie einen Typ
    Zeiger auf integer an. }

  PInteg = ^integer;

  TIntRec = record
    Int1: integer;
    Int2: integer;
    Int3: integer;
  end;

  { 16) Zeiger koennen auf alles moegliche zeigen - auch auf einen Record.

    Z.B. auch auf einen Record, der einen Bytewert und einen Zeiger vom Typ
    Zeiger auf diesen Record beinhaltet.
    Legt Euch einen passenden Typ dazu an!
    Der Typ Zeiger auf diesen Record muss dazu natuerlich vorab deklariert werden.

    Deklariert folgend zwei Variablen vom Typ Zeiger auf den Record.

    Holt Euch dann mit der Funktion new(...) jeweils Speicher fuer den Record, auf den die Zeiger zeigen.

    Belegt bei beiden Zeigern auf die Records den Bytewert mit einer beliebigen (aber verschiedenen) Zahl.

    Lasst dann den im Record enthaltenen Zeiger der ersten Variable auf den zweiten Record zeigen und
    den Zeiger der zweiten Variable auf nil. Schon haben wir unsere erste kleine Liste gebaut! }

  PZeigRec = ^TZeigRec;

  TZeigRec = record
    Wert: byte;
    Next: PZeigRec;
  end;

  { 15) Legt ueber dem Hauptprogramm drei kleine Prozeduren mal2_a, mal2_b und mal2_c an, die jeweils
    einen Parameter haben, dessen Wert im Rumpf mal 2 genommen wird.

    Die erste Prozedur soll dabei einen Bytewert als Wertparameter bekommen,

    die zweite Prozedur einen Bytewert als Referenzparameter

    und die dritte Prozedur einen Zeiger auf einen Bytewert.

    Ergaenzt danach dreimal nacheinander folgenden Code:
    - das Setzen einer Bytevariable auf den Wert 3
    - einen Aufruf einer der Prozeduren mit diesem Bytewert (jede 1x)
    - eine Ausgabe des Bytewertes nach dem Aufruf mit writeln

    FRAGE: Welche Erkenntnis kann man aus den ausgegebenen Werten ziehen?

    Der Zeiger ist ähnlich wie ein Referenzparameter. Er gibt uns den Berechneten Wert aus. }

procedure mal2_a(Nummer: byte);
begin
  Nummer := Nummer * 2;
end;

procedure mal2_b(var Nummer: byte);
begin
  Nummer := Nummer * 2;
end;

procedure mal2_c(Nummer: PByte);
begin
  Nummer^ := Nummer^ * 2;
end;

var
  { 2)  Deklariert eine Variable vom Typ byte und 2 Variablen vom Typ Zeiger auf byte. }
  Zahl, Nummer: byte;
  ErsterZeiger, ZahlZeiger, Zeiger1, Zeiger2, Zeiger3, NummerZeiger: PByte;
  { 8)  Deklariert Euch eine Variable von diesem Recordtyp und drei weitere Variablen vom Typ
    Zeiger auf Byte. }
  ByteRec: TByteRec;
  { 12) Deklariert Euch eine Variable vom neuen Recordtyp und drei weitere Variablen vom Typ
    Zeiger auf integer. }
  IntZeig1, IntZeig2, IntZeig3: PInteg;
  IntRec: TIntRec;
  ZeigRec1, ZeigRec2: PZeigRec;

begin
  { 3)  Belegt die Bytevariable mit dem Wert 3 und lasst beide Zeiger auf diese Variable zeigen.
    Hinweis: Ein new ist hier nicht erforderlich! }
  Zahl := 3;
  ErsterZeiger := @Zahl;
  ZahlZeiger := @Zahl;
  { 4)  Gebt mit writeln die Bytevariable, die dereferenzierten Zeigervariablen sowie die Adressen,
    auf die die Zeigervariablen zeigen durch Leerzeichen getrennt aus (insg. also 5 Werte). }
  writeln(Zahl, ' ', ErsterZeiger^, ' ', ZahlZeiger^, ' ',
    integer(ErsterZeiger), ' ', integer(ZahlZeiger));
  { 5)  Setzt jetzt den Wert, auf den die erste Zeigervariable zeigt, von 3 auf 5. }
  ErsterZeiger^ := 5;
  writeln(Zahl, ' ', ErsterZeiger^, ' ', ZahlZeiger^, ' ',
    integer(ErsterZeiger), ' ', integer(ZahlZeiger));
  { 6)  Wiederholt dieselbe Ausgabe der 5 Werte wie in Schritt 4.

    FRAGE: Was hat sich in der Ausgabe geaendert?

    Der Wert der Variable und der Wert auf den die Zeiger zeigen hat sich auf 5 gesetzt.

    FRAGE: Warum haben sich genau diese Werte geaendert?

    Da die Zeiger auf die Variable dauerhaft zeigen und sich nur die Variable ändert. }

  { 9)  Lasst die drei neuen Zeiger jetzt jeweils auf einen der drei Bytewerte aus dem Record zeigen. }
  Zeiger1 := @ByteRec.BVar1;
  Zeiger2 := @ByteRec.BVar2;
  Zeiger3 := @ByteRec.BVar3;

  { 10) Lasst Euch die Adressen und die Inhalte der drei Zeiger jeweils durch Leerzeichen getrennt
    ausgeben (also insg. 6 Werte).

    FRAGE: Was faellt bei den Adressen auf?

    Es sind direkte nachfolge Adressen.

    FRAGE: Welche Inhalte werden ausgegeben? Warum genau diese?

    Für die Variable wird 0 ausgegeben. Eigentlich ist es ein zufälliger Speicherwert,
    da wir die Variable nicht initialisiert haben. }
  writeln(Zeiger1^, ' ', integer(Zeiger1), ' ', Zeiger2^, ' ', integer(Zeiger2),
    ' ', Zeiger3^, ' ', integer(Zeiger3));

  { 13) Lasst dann die drei neuen Zeiger jeweils auf einen der drei Integerwerte aus dem Record zeigen. }
  IntZeig1 := @IntRec.Int1;
  IntZeig2 := @IntRec.Int2;
  IntZeig3 := @IntRec.Int3;
  { 14) Lasst Euch die Adressen, auf die die drei Integer-Zeiger zeigen jeweils durch Leerzeichen getrennt ausgeben
    (also insg. 3 Werte).

    FRAGE: Was faellt bei den Adressen diesmal auf, auch im Vergleich zu vorher?

    Die Integer Zeiger brauchen mehr Speicher Platz. Deswegen werden drei Reihen frei gelassen.
  }
  writeln(integer(IntZeig1), ' ', integer(IntZeig2), ' ', integer(IntZeig3));
  writeln;
  // 15
  Nummer := 3;
  mal2_a(Nummer);
  writeln(Nummer);
  writeln;

  Nummer := 3;
  mal2_b(Nummer);
  writeln(Nummer);
  writeln;

  Nummer := 3;
  NummerZeiger := @Nummer;
  mal2_c(NummerZeiger);
  writeln(NummerZeiger^);
  writeln;
  // 16
  new(ZeigRec1);
  new(ZeigRec2);
  ZeigRec1^.Wert := 3;
  ZeigRec2^.Wert := 5;
  ZeigRec1^.Next := ZeigRec2;
  ZeigRec2^.Next := nil;

  { 17) Lasst Euch mit writeln die beiden Bytewerte ausgeben. Ihr duerft dabei allerdings nur den ersten Zeiger
    benutzen!!
    FRAGE: Koennte man auch beide Bytewerte ausgeben, wenn man nur den zweiten Zeiger benutzen duerfte?

    Falls ja: Wie? Falls nein: Warum nicht?
    Nein, da man immer den Startwert vom ersten Zeiger braucht.
  }
  writeln(ZeigRec1^.Wert, ' ', ZeigRec1^.Next^.Wert);

  readln;

end.
