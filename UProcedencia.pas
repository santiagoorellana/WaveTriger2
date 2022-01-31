unit UProcedencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, jpeg, ExtCtrls, ImgList;

type
  TFormProcedencia = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    ActionList1: TActionList;
    ActionSalir: TAction;
    Label5: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    procedure ActionSalirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProcedencia: TFormProcedencia;

implementation

{$R *.dfm}

procedure TFormProcedencia.ActionSalirExecute(Sender: TObject);
begin
Close;
end;

end.
