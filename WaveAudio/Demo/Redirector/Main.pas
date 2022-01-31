{------------------------------------------------------------------------------}
{                                                                              }
{  Wave Audio Package - Audio Redirector Demo                                  }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, WaveRedirector;

type

  TMainForm = class(TForm)
    Redirector: TAudioRedirector;
    ckActive: TCheckBox;
    AudioLevel: TProgressBar;
    Label1: TLabel;
    procedure ckActiveClick(Sender: TObject);
    procedure RedirectorActivate(Sender: TObject);
    procedure RedirectorDeactivate(Sender: TObject);
    procedure RedirectorAudioInLevel(Sender: TObject; Level: Integer);
    procedure FormCreate(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.ckActiveClick(Sender: TObject);
begin
  Redirector.Active := ckActive.Checked;
end;

procedure TMainForm.RedirectorActivate(Sender: TObject);
begin
  ckActive.Checked := True;
end;

procedure TMainForm.RedirectorDeactivate(Sender: TObject);
begin
  ckActive.Checked := False;
end;

procedure TMainForm.RedirectorAudioInLevel(Sender: TObject; Level: Integer);
begin
  AudioLevel.Position := Level;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Deplhi 6 and higher: the following event can be set at designtime
  Redirector.AudioIn.OnLevel := RedirectorAudioInLevel;
end;

end.
