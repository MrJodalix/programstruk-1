(* Moritz Richter, Joshua-Scott Sch�ttke
  Das Programm berechnet wie viele Couch ben�tigt werden,
  sowie das Maximum und das Minimum von Gruppen.
*)

program Project_Couch;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.Math;

const
  COUCH_GR��E = 6;
  GRUPPE1 = 'HSV-Fans';
  GRUPPE2 = 'St.Pauli-Fans';
  GRUPPE3 = 'Bayern-Fans';

var
  Gruppengr��e1, Gruppengr��e2, Gruppengr��e3: byte;

  DivGruppengr��e, ModGruppengr��e, AnzahlCouch, AnzahlCouchWahr: byte;

  RestGruppengr��e, KeinRestPerson, KeinePerson: boolean;

  AnzahlPerson: byte;

  max1_2, min1_2: byte;

  MaxGruppe1, MaxGruppe2, MaxGruppe3, MinGruppe1, MinGruppe2,
    MinGruppe3: boolean; (* Vergleichsoperatoren im minimum und maximum *)

  Mind1proGruppe: boolean;
  (* Vergleichsoperator f�r die Unterscheidung ob jeweils einer in der Gruppe ist *)

  Nur1Gr��teGruppe: boolean;
  (* Vergleichoperator ob es exakt eine gr��te Gruppe gibt *)

begin
  (* Benutzer nach Gruppengr��en abfragen *)

  write('Bitte geben sie die Gruppengr��e der ', GRUPPE1, 'an: ');
  readln(Gruppengr��e1);

  write('Bitte geben sie die Gruppengr��e der ', GRUPPE2, 'an: ');
  readln(Gruppengr��e2);

  write('Bitte geben sie die Gruppengr��e der ', GRUPPE3, 'an: ');
  readln(Gruppengr��e3);

  (* Rechnung zur Ermittlung wie viele Couch ben�tigt werden und wie viele auf
    der letzten Couch sitzen, sowie die Anzahl aller Personen. *)

  DivGruppengr��e := (Gruppengr��e1 + Gruppengr��e2 + Gruppengr��e3)
    div COUCH_GR��E;
  ModGruppengr��e := (Gruppengr��e1 + Gruppengr��e2 + Gruppengr��e3)
    mod COUCH_GR��E;

  RestGruppengr��e := ModGruppengr��e > 0;
  AnzahlCouch := DivGruppengr��e + byte(RestGruppengr��e);

  KeinRestPerson := (ModGruppengr��e = 0);
  KeinePerson := Gruppengr��e1 + Gruppengr��e2 + Gruppengr��e3 <> 0;
  AnzahlCouchWahr := (ModGruppengr��e + (COUCH_GR��E * byte(KeinRestPerson)) *
    byte(KeinePerson));

  writeln('Es werden insgesamt ', AnzahlCouch, ' Couch der Gr��e ', COUCH_GR��E,
    ' ben�tigt.');
  writeln('auf der letzten Couch befinden sich  ', AnzahlCouchWahr, ' Person.');

  AnzahlPerson := (Gruppengr��e1 + Gruppengr��e2 + Gruppengr��e3);
  writeln('Es sind ', AnzahlPerson, ' Personen da.');

  (* Vergleichung aller Gruppen auf Maximum und Minimum der Gruppengr��en.
    Sowie die Ermittlung der gr��ten und kleinsten Gruppe *)

  max1_2 := max(Gruppengr��e1, Gruppengr��e2);
  min1_2 := min(Gruppengr��e1, Gruppengr��e2);

  writeln('Die maximale Anzahl in einer Gruppe ist ',
    max(max1_2, Gruppengr��e3), ', die minimale ist ',
    (min(min1_2, Gruppengr��e3)), '.');

  MaxGruppe1 := Gruppengr��e1 = max(max1_2, Gruppengr��e3);
  MaxGruppe2 := Gruppengr��e2 = max(max1_2, Gruppengr��e3);
  MaxGruppe3 := Gruppengr��e3 = max(max1_2, Gruppengr��e3);

  writeln('Die HSV Fans sind die Gr��te Gruppe: ', MaxGruppe1);
  writeln('Die St.Pauli Fans sind die Gr��te Gruppe: ', MaxGruppe2);
  writeln('Die Bayern Fans sind die Gr��te Gruppe: ', MaxGruppe3);

  MinGruppe1 := Gruppengr��e1 = min(min1_2, Gruppengr��e3);
  MinGruppe2 := Gruppengr��e2 = min(min1_2, Gruppengr��e3);
  MinGruppe3 := Gruppengr��e3 = min(min1_2, Gruppengr��e3);

  writeln('Die HSV Fans sind die kleinste Gruppe: ', MinGruppe1);
  writeln('Die St.Pauli Fans sind die kleinste Gruppe: ', MinGruppe2);
  writeln('Die Bayern Fans sind die kleinste Gruppe: ', MinGruppe3);

  (* Erkennung ob keine Gruppe leer ist und ob es nur eine gr��te Gruppe gibt. *)

  Mind1proGruppe := (min(min1_2, Gruppengr��e3) <> 0);
  Nur1Gr��teGruppe := byte(MaxGruppe1) + byte(MaxGruppe2) +
    byte(MaxGruppe3) = 1;

  writeln('In jeder Gruppe ist mindestens einer da: ', Mind1proGruppe);
  writeln('Es gibt eindeutig eine gr��te Gruppe: ', Nur1Gr��teGruppe);

  readln

end.
