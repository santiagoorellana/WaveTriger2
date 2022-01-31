///////////////////////////////////////////////////////////////////////////////
// Autor: Santiago Alejandro Orellana Pérez
// Creado: 29/06/2013
// Email: tecnochago@gmail.com
// Movil: +53 54635944
///////////////////////////////////////////////////////////////////////////////

unit UCambiarColores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ActnList;

type
  TFormCambiarColores = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    Label3: TLabel;
    Panel4: TPanel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel5: TPanel;
    Label5: TLabel;
    ActionList1: TActionList;
    ActionCerrar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CambiarColorDe(Sender: TObject);
    procedure AplicarCambios;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ActionCerrarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCambiarColores: TFormCambiarColores;

implementation

uses Main;

{$R *.dfm}

// Inicia el formulario y sus valores.
procedure TFormCambiarColores.FormCreate(Sender: TObject);
begin
Panel1.Color := MainForm.ColorFondo;
Panel2.Color := MainForm.ColorEspectroBajoUmbal;
Panel3.Color := MainForm.ColorEspectroSobreUmbal;
Panel4.Color := MainForm.ColorUmbralSuperior;
Panel5.Color := MainForm.ColorUmbralesLaterales;
end;

// Cierra la ventana.
procedure TFormCambiarColores.Button1Click(Sender: TObject);
begin
Close;
end;

// Cambia el color de un Panel.
procedure TFormCambiarColores.CambiarColorDe(Sender: TObject);
var dlg: TColorDialog;
begin
dlg := TColorDialog.Create(Self);
dlg.Color := TPanel(Sender).Color;
if dlg.Execute then TPanel(Sender).Color := dlg.Color;
end;

// Aplica los cambios de color.
procedure TFormCambiarColores.AplicarCambios;
begin
MainForm.ColorFondo := Panel1.Color;
MainForm.ColorEspectroBajoUmbal := Panel2.Color;
MainForm.ColorEspectroSobreUmbal := Panel3.Color;
MainForm.ColorUmbralSuperior := Panel4.Color;
MainForm.ColorUmbralesLaterales := Panel5.Color;
end;

// Aplica los cambios de color sin cerrar la ventana.
procedure TFormCambiarColores.Button2Click(Sender: TObject);
begin
AplicarCambios;
end;

// Aplica los cambios de color y cierra la ventana.
procedure TFormCambiarColores.Button3Click(Sender: TObject);
begin
AplicarCambios;
Close;
end;

// Cierra la ventana sin guradar los cambios.
procedure TFormCambiarColores.ActionCerrarExecute(Sender: TObject);
begin
Close;
end;

end.
