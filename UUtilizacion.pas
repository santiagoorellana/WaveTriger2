///////////////////////////////////////////////////////////////////////////////
// Autor: Santiago Alejandro Orellana Pérez
// Creado: 29/06/2013
// Email: tecnochago@gmail.com
// Movil: +53 54635944
///////////////////////////////////////////////////////////////////////////////

unit UUtilizacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList;

type
  TFormUtilizacion = class(TForm)
    Memo1: TMemo;
    ActionList1: TActionList;
    ActionCerrar: TAction;
    procedure ActionCerrarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUtilizacion: TFormUtilizacion;

implementation

{$R *.dfm}

procedure TFormUtilizacion.ActionCerrarExecute(Sender: TObject);
begin
Close;
end;

end.
