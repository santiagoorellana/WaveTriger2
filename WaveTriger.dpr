///////////////////////////////////////////////////////////////////////////////
// Autor: Santiago Alejandro Orellana Pérez
// Creado: 29/06/2013
// Email: tecnochago@gmail.com
// Movil: +53 54635944
///////////////////////////////////////////////////////////////////////////////

program WaveTriger;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  USeleccionarDirectorio in 'USeleccionarDirectorio.pas' {FormSeleccionarDirectorio},
  UProcedencia in 'UProcedencia.pas' {FormProcedencia},
  UCambiarColores in 'UCambiarColores.pas' {FormCambiarColores},
  UBase in 'UBase.pas',
  UUtilizacion in 'UUtilizacion.pas' {FormUtilizacion},
  UColoreadoDeGraficos in 'UColoreadoDeGraficos.pas',
  WaveUtils in './WaveAudio/WaveUtils.pas',
  WaveStorage in './WaveAudio/WaveStorage.pas',
  WaveIn in './WaveAudio/WaveIn.pas',
  WaveRecorders in './WaveAudio/WaveRecorders.pas',
  WaveIO in './WaveAudio/WaveIO.pas',
  WaveOut in './WaveAudio/WaveOut.pas',
  WavePlayers in './WaveAudio/WavePlayers.pas',
  WaveRedirector in './WaveAudio/WaveRedirector.pas';


{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'WaveTriger';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormProcedencia, FormProcedencia);
  Application.CreateForm(TFormCambiarColores, FormCambiarColores);
  Application.Run;
end.
