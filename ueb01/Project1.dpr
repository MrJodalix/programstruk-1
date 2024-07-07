program Project1;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

var
  ausgabeZahl: byte;

begin
  ausgabeZahl := 125;
  writeln('Hallo Welt ', ausgabeZahl);
  readln;

end.
