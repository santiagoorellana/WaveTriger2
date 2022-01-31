///////////////////////////////////////////////////////////////////////////////
// Autor: Santiago Alejandro Orellana Pérez
// Creado: 29/06/2013
// Email: tecnochago@gmail.com
// Movil: +53 54635944
///////////////////////////////////////////////////////////////////////////////

unit USeleccionarDirectorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, FileCtrl;

type
  TFormSeleccionarDirectorio = class(TForm)
    Panel1: TPanel;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSeleccionarDirectorio: TFormSeleccionarDirectorio;

implementation

uses Main;

{$R *.dfm}

procedure TFormSeleccionarDirectorio.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TFormSeleccionarDirectorio.Button1Click(Sender: TObject);
begin
MainForm.RutaParaGuardarGrabaciones := DirectoryListBox1.Directory + '\';
Close;
end;

procedure TFormSeleccionarDirectorio.FormCreate(Sender: TObject);
begin
Panel1.DoubleBuffered := True;
DirectoryListBox1.DoubleBuffered := True;
DriveComboBox1.DoubleBuffered := True;

DriveComboBox1.Drive := MainForm.RutaParaGuardarGrabaciones[1];
DirectoryListBox1.Directory := MainForm.RutaParaGuardarGrabaciones;
end;

end.
