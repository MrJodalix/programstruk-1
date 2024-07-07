(* Moritz Richter, Joshua-Scott Schöttke
  Das Programm berechnet wie viele Couch benötigt werden,
  sowie das Maximum und das Minimum von Gruppen.
*)

program Project_Couch;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.Math;

const
  COUCH_GRÖßE = 6;
  GRUPPE1 = 'HSV-Fans';
  GRUPPE2 = 'St.Pauli-Fans';
  GRUPPE3 = 'Bayern-Fans';

var
  Gruppengröße1, Gruppengröße2, Gruppengröße3: byte;

  DivGruppengröße, ModGruppengröße, AnzahlCouch, AnzahlCouchWahr: byte;

  RestGruppengröße, KeinRestPerson, KeinePerson: boolean;

  AnzahlPerson: byte;

  max1_2, min1_2: byte;

  MaxGruppe1, MaxGruppe2, MaxGruppe3, MinGruppe1, MinGruppe2,
    MinGruppe3: boolean; (* Vergleichsoperatoren im minimum und maximum *)

  Mind1proGruppe: boolean;
  (* Vergleichsoperator für die Unterscheidung ob jeweils einer in der Gruppe ist *)

  Nur1GrößteGruppe: boolean;
  (* Vergleichoperator ob es exakt eine größte Gruppe gibt *)

begin
  (* Benutzer nach Gruppengrößen abfragen *)

  write('Bitte geben sie die Gruppengröße der ', GRUPPE1, 'an: ');
  readln(Gruppengröße1);

  write('Bitte geben sie die Gruppengröße der ', GRUPPE2, 'an: ');
  readln(Gruppengröße2);

  write('Bitte geben sie die Gruppengröße der ', GRUPPE3, 'an: ');
  readln(Gruppengröße3);

  (* Rechnung zur Ermittlung wie viele Couch benötigt werden und wie viele auf
    der letzten Couch sitzen, sowie die Anzahl aller Personen. *)

  DivGruppengröße := (Gruppengröße1 + Gruppengröße2 + Gruppengröße3)
    div COUCH_GRÖßE;
  ModGruppengröße := (Gruppengröße1 + Gruppengröße2 + Gruppengröße3)
    mod COUCH_GRÖßE;

  RestGruppengröße := ModGruppengröße > 0;
  AnzahlCouch := DivGruppengröße + byte(RestGruppengröße);

  KeinRestPerson := (ModGruppengröße = 0);
  KeinePerson := Gruppengröße1 + Gruppengröße2 + Gruppengröße3 <> 0;
  AnzahlCouchWahr := (ModGruppengröße + (COUCH_GRÖßE * byte(KeinRestPerson)) *
    byte(KeinePerson));

  writeln('Es werden insgesamt ', AnzahlCouch, ' Couch der Größe ', COUCH_GRÖßE,
    ' benötigt.');
  writeln('auf der letzten Couch befinden sich  ', AnzahlCouchWahr, ' Person.');

  AnzahlPerson := (Gruppengröße1 + Gruppengröße2 + Gruppengröße3);
  writeln('Es sind ', AnzahlPerson, ' Personen da.');

  (* Vergleichung aller Gruppen auf Maximum und Minimum der Gruppengrößen.
    Sowie die Ermittlung der größten und kleinsten Gruppe *)

  max1_2 := max(Gruppengröße1, Gruppengröße2);
  min1_2 := min(Gruppengröße1, Gruppengröße2);

  writeln('Die maximale Anzahl in einer Gruppe ist ',
    max(max1_2, Gruppengröße3), ', die minimale ist ',
    (min(min1_2, Gruppengröße3)), '.');

  MaxGruppe1 := Gruppengröße1 = max(max1_2, Gruppengröße3);
  MaxGruppe2 := Gruppengröße2 = max(max1_2, Gruppengröße3);
  MaxGruppe3 := Gruppengröße3 = max(max1_2, Gruppengröße3);

  writeln('Die HSV Fans sind die Größte Gruppe: ', MaxGruppe1);
  writeln('Die St.Pauli Fans sind die Größte Gruppe: ', MaxGruppe2);
  writeln('Die Bayern Fans sind die Größte Gruppe: ', MaxGruppe3);

  MinGruppe1 := Gruppengröße1 = min(min1_2, Gruppengröße3);
  MinGruppe2 := Gruppengröße2 = min(min1_2, Gruppengröße3);
  MinGruppe3 := Gruppengröße3 = min(min1_2, Gruppengröße3);

  writeln('Die HSV Fans sind die kleinste Gruppe: ', MinGruppe1);
  writeln('Die St.Pauli Fans sind die kleinste Gruppe: ', MinGruppe2);
  writeln('Die Bayern Fans sind die kleinste Gruppe: ', MinGruppe3);

  (* Erkennung ob keine Gruppe leer ist und ob es nur eine größte Gruppe gibt. *)

  Mind1proGruppe := (min(min1_2, Gruppengröße3) <> 0);
  Nur1GrößteGruppe := byte(MaxGruppe1) + byte(MaxGruppe2) +
    byte(MaxGruppe3) = 1;

  writeln('In jeder Gruppe ist mindestens einer da: ', Mind1proGruppe);
  writeln('Es gibt eindeutig eine größte Gruppe: ', Nur1GrößteGruppe);

  readln

end.
