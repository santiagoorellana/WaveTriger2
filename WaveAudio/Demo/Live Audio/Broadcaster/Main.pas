{------------------------------------------------------------------------------}
{                                                                              }
{  Wave Audio Package - Audio Broadcasting Demo (Server)                       }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, mmSystem, WaveUtils, WaveIO, WaveIn, WaveRecorders, Buttons,
  Spin, ComCtrls, ScktComp;

const
  MaxSilenceLevel = 5; // in precent

type
  TMainForm = class(TForm)
    LiveAudioRecorder: TLiveAudioRecorder;
    gbBroadcasting: TGroupBox;
    lblFormat: TLabel;
    cbFormat: TComboBox;
    btnStop: TButton;
    btnStart: TButton;
    gbConnection: TGroupBox;
    lblClients: TLabel;
    lstClients: TListBox;
    lblLocalAddress: TLabel;
    edLocalAddress: TEdit;
    lblLocalPort: TLabel;
    seLocalPort: TSpinEdit;
    pbLevel: TProgressBar;
    tcpServer: TServerSocket;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure LiveAudioRecorderLevel(Sender: TObject; Level: Integer);
    procedure LiveAudioRecorderData(Sender: TObject; const Buffer: Pointer;
      BufferSize: Cardinal; var FreeIt: Boolean);
    procedure LiveAudioRecorderActivate(Sender: TObject);
    procedure LiveAudioRecorderDeactivate(Sender: TObject);
    procedure tcpServerClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure tcpServerClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure tcpServerAccept(Sender: TObject; Socket: TCustomWinSocket);
    procedure tcpServerClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure tcpServerClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    AudioLevel: Integer;
    procedure BuildAudioFormatList;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  WinSock;

{ Helper Functions }

function DNSLookup(const HostName: String): String;
var
  IP: TInAddr;
  HostEntry: PHostEnt;
begin
  Result := HostName;
  HostEntry := gethostbyname(PChar(HostName));
  if (HostEntry <> nil) and (HostEntry.h_addrtype = AF_INET) then
  begin
    IP := PInAddr(HostEntry^.h_addr^)^;
    Result := inet_ntoa(IP);
  end;
end;

function ReverseDNSLookup(const IPAddress: String): String;
var
  IP: TInAddr;
  HostEntry: PHostEnt;
begin
  Result := IPAddress;
  IP := TInAddr(inet_addr(PChar(IPAddress)));
  if Integer(IP.S_addr) <> Integer(INADDR_NONE) then
  begin
    HostEntry := gethostbyaddr(@IP, 4, AF_INET);
    if HostEntry <> nil then
      Result := HostEntry^.h_name;
  end;
end;

function FormatAddress(const HostName: String; const IPAddress: String): String;
var
  Name, IP: String;
begin
  if IPAddress = '' then
    IP := DNSLookup(HostName)
  else
    IP := IPAddress;
  if HostName = '' then
    Name := ReverseDNSLookup(IP)
  else
    Name :=  HostName;
  if Name <> IP then
    Result := Format('%s (%s)', [Name, IP])
  else
    Result := Name;
end;

{ TMainForm }

procedure TMainForm.BuildAudioFormatList;
var
  pcm: TPCMFormat;
  WaveFormat: TWaveFormatEx;
begin
  with cbFormat.Items do
  begin
    BeginUpdate;
    try
      Clear;
      for pcm := Succ(Low(TPCMFormat)) to High(TPCMFormat) do
      begin
        SetPCMAudioFormatS(@WaveFormat, pcm);
        Add(GetWaveAudioFormat(@WaveFormat));
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  BuildAudioFormatList;
  cbFormat.ItemIndex := Ord(LiveAudioRecorder.PCMFormat) - 1;
  edLocalAddress.Text := FormatAddress('', '');
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  LiveAudioRecorder.Active := False;
  LiveAudioRecorder.WaitForStop;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
//  LiveAudioRecorder.Active := False;
//  LiveAudioRecorder.WaitForStop;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  edLocalAddress.Text := FormatAddress('', '');
  tcpServer.Port := seLocalPort.Value;
  LiveAudioRecorder.PCMFormat := TPCMFormat(cbFormat.ItemIndex + 1);
  LiveAudioRecorder.Active := True;
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  LiveAudioRecorder.Active := False;
end;

procedure TMainForm.LiveAudioRecorderActivate(Sender: TObject);
begin
  btnStop.Visible := True;
  btnStart.Visible := False;
  cbFormat.Enabled := False;
  seLocalPort.Enabled := False;
  tcpServer.Active := True;
end;

procedure TMainForm.LiveAudioRecorderDeactivate(Sender: TObject);
begin
  tcpServer.Active := False;
  btnStart.Visible := True;
  btnStop.Visible := False;
  cbFormat.Enabled := True;
  seLocalPort.Enabled := True;
  lstClients.Items.Clear;
end;

procedure TMainForm.LiveAudioRecorderLevel(Sender: TObject; Level: Integer);
begin
  AudioLevel := Level;
  if Level > MaxSilenceLevel then
    pbLevel.Position := Level
  else
    pbLevel.Position := 0;
end;

procedure TMainForm.LiveAudioRecorderData(Sender: TObject;
  const Buffer: Pointer; BufferSize: Cardinal; var FreeIt: Boolean);
var
  I: Integer;
begin
  FreeIt := True;
  if AudioLevel > MaxSilenceLevel then
    for I := tcpServer.Socket.ActiveConnections - 1 downto 0 do
      with tcpServer.Socket.Connections[I] do
        if Data = Self then // the client is ready
          SendBuf(Buffer^, BufferSize);
end;

procedure TMainForm.tcpServerClientConnect(Sender: TObject; Socket: TCustomWinSocket);
var
  ClientName: String;
begin
  ClientName := FormatAddress(Socket.LocalHost, Socket.LocalAddress);
  lstClients.Items.AddObject(ClientName, Socket);
end;

procedure TMainForm.tcpServerClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
var
  Index: Integer;
begin
  Socket.Data := nil;
  Index := lstClients.Items.IndexOfObject(Socket);
  if Index >= 0 then lstClients.Items.Delete(Index);
end;

procedure TMainForm.tcpServerAccept(Sender: TObject; Socket: TCustomWinSocket);
var
  WaveFormat: TWaveFormatEx;
  WaveFormatSize: Integer;
begin
  SetPCMAudioFormatS(@WaveFormat, LiveAudioRecorder.PCMFormat);
  WaveFormatSize := SizeOf(WaveFormat);
  Socket.SendBuf(WaveFormatSize, SizeOf(WaveFormatSize));
  Socket.SendBuf(WaveFormat, WaveFormatSize);
end;

procedure TMainForm.tcpServerClientRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  if Socket.ReceiveText = 'READY' then
    Socket.Data := Self;
end;

procedure TMainForm.tcpServerClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
var
  Index: Integer;
  ErrorStr: String;
begin
  Socket.Data := nil;
  Index := lstClients.Items.IndexOfObject(Socket);
  if Index >= 0 then
  begin
    if ErrorEvent = eeDisconnect then
      lstClients.Items.Delete(Index)
    else
    begin
      case ErrorEvent of
        eeGeneral: ErrorStr := 'General Error';
        eeSend: ErrorStr := 'Send Error';
        eeReceive: ErrorStr := 'Receive Error';
      else
        ErrorStr := 'Error';
      end;
      lstClients.Items.Strings[Index] := Format('%s - %s (%d)',
        [FormatAddress(Socket.LocalHost, Socket.LocalAddress), ErrorStr, ErrorCode]);
    end;
  end;
  ErrorCode := 0; // do not raise exception
end;

end.
