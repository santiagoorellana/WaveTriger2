unit UGuardaEnRegistro;

interface

uses Registry;

var
  Ini: TRegIniFile;

implementation

initialization
  Ini := TRegIniFile.Create('\Software\RCI_ATS\GM8x44100');
finalization
  Ini.Free;
  Ini := nil;
end.
