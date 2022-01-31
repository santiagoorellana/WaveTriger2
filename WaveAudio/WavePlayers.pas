{------------------------------------------------------------------------------}
{                                                                              }
{  WavePlayers - Wave player components                                        }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

{$I DELPHIAREA.INC}

unit WavePlayers;

interface

uses
  Windows, Messages, Classes, mmSystem, WaveUtils, WaveStorage, WaveOut;

type

  // Plays wave from a wave stream
  TAudioPlayer = class(TWaveAudioOut)
  private
    fWave: TWave;
    CurPos: DWORD;
    EndPos: DWORD;
    procedure SetWave(Value: TWave);
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
    procedure WaveChanged(Sender: TObject);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure GetWaveFormat(out pWaveFormat: PWaveFormatEx;
      var FreeIt: Boolean); override;
    function GetWaveDataPtr(out Buffer: Pointer;
      var NumLoops: DWORD; var FreeIt: Boolean): DWORD; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property NumDevs;
    property DeviceName;
    property DeviceFormats;
    property DeviceSupports;
    property LastError;
    property LastErrorText;
    property Position;          // Milliseconds
    property DeviceID;
    property Paused;
    property Active;
  published
    property Wave: TWave read fWave write SetWave;
    property Options;
    property Volume;            // Percent (Both channels)
    property Pitch;
    property PlaybackRate;
    property BufferLength;      // Milliseconds
    property BufferCount;
    property Async;
    property OnActivate;
    property OnDeactivate;
    property OnPause;
    property OnResume;
    property OnError;
    property OnLevel;
  end;

  // Plays wave from user defined buffer
  TLiveAudioPlayer = class(TWaveAudioOut)
  private
    fPCMFormat: TPCMFormat;
    fOnFormat: TWaveAudioGetFormatEvent;
    fOnData: TWaveAudioGetDataEvent;
    fOnDataPtr: TWaveAudioGetDataPtrEvent;
    procedure SetPCMFormat(Value: TPCMFormat);
  protected
    procedure GetWaveFormat(out pWaveFormat: PWaveFormatEx;
      var FreeIt: Boolean); override;
    function GetWaveData(const Buffer: Pointer; BufferSize: DWORD;
      var NumLoops: DWORD): DWORD; override;
    function GetWaveDataPtr(out Buffer: Pointer;
      var NumLoops: DWORD; var FreeIt: Boolean): DWORD; override;
  public
    constructor Create(AOwner: TComponent); override;
    property PreferredBufferSize;
    property NumDevs;
    property DeviceName;
    property DeviceFormats;
    property DeviceSupports;
    property LastError;
    property LastErrorText;
    property Position;          // Milliseconds
    property DeviceID;
    property Paused;
    property Active;
  published
    property PCMFormat: TPCMFormat read fPCMFormat write SetPCMFormat default Mono16Bit8000Hz;
    property Options;
    property Volume;            // Percent (Both channels)
    property Pitch;
    property PlaybackRate;
    property BufferInternally;
    property BufferLength;      // Milliseconds
    property BufferCount;
    property Async;
    property OnActivate;
    property OnDeactivate;
    property OnPause;
    property OnResume;
    property OnError;
    property OnLevel;
    property OnFormat: TWaveAudioGetFormatEvent read fOnFormat write fOnFormat;
    property OnData: TWaveAudioGetDataEvent read fOnData write fOnData;
    property OnDataPtr: TWaveAudioGetDataPtrEvent read fOnDataPtr write fOnDataPtr;
  end;

  // Plays wave as file, resource, or stream
  TStockAudioPlayer = class(TWaveAudioOut)
  private
    mmIO: HMMIO;
    DataSize: DWORD;
    DataOffset: DWORD;
    Stream: TStream;
    FreeStream: Boolean;
    fStock: TCustomWaveStorage;
    procedure SetStock(Value: TCustomWaveStorage);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetActive(Value: Boolean); override;
    procedure GetWaveFormat(out pWaveFormat: PWaveFormatEx;
      var FreeIt: Boolean); override;
    function GetWaveData(const Buffer: Pointer; BufferSize: DWORD;
      var NumLoops: DWORD): DWORD; override;
    procedure DoWaveOutDeviceClose; override;
    procedure DoError; override;
    function InternalPlay(AStream: TStream; FreeIt: Boolean): Boolean; virtual;
    procedure CleanUp; virtual;
  public
    function PlayStream(AStream: TStream): Boolean;
    function PlayFile(const FileName: String): Boolean;
    function PlayResName(Instance: THandle; const ResName: String): Boolean;
    function PlayResID(Instance: THandle; ResID: Integer): Boolean;
    function PlayStock(Index: Integer): Boolean;
    function Stop: Boolean;
    property NumDevs;
    property DeviceName;
    property DeviceFormats;
    property DeviceSupports;
    property LastError;
    property LastErrorText;
    property Position;          // Milliseconds
    property DeviceID;
    property Paused;
    property Active;
  published
    property Stock: TCustomWaveStorage read fStock write SetStock;
    property Options;
    property Volume;            // Percent (Both channels)
    property Pitch;
    property PlaybackRate;
    property BufferLength;      // Milliseconds
    property BufferCount;
    property Async;
    property OnActivate;
    property OnDeactivate;
    property OnPause;
    property OnResume;
    property OnError;
    property OnLevel;
  end;

implementation

uses
  SysUtils;

{ TAudioPlayer }

constructor TAudioPlayer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fWave := TWave.Create;
  fWave.OnChange := WaveChanged;
  BufferInternally := False;
end;

destructor TAudioPlayer.Destroy;
begin
  inherited Destroy;
  fWave.Free;
end;

procedure TAudioPlayer.WaveChanged(Sender: TObject);
begin
  Active := False;
end;

procedure TAudioPlayer.SetWave(Value: TWave);
begin
  if Wave <> Value then
  begin
    Active := False;
    if Assigned(Value) then
      Wave.LoadFromStream(Value)
    else
      Wave.Clear;
  end;
end;

procedure TAudioPlayer.ReadData(Stream: TStream);
begin
  Wave.LoadFromStream(Stream);
end;

procedure TAudioPlayer.WriteData(Stream: TStream);
begin
  Wave.SaveToStream(Stream);
end;

procedure TAudioPlayer.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, Wave.Size > 0);
end;

procedure TAudioPlayer.GetWaveFormat(out pWaveFormat: PWaveFormatEx;
  var FreeIt: Boolean);
begin
  FreeIt := False;
  pWaveFormat := Wave.WaveFormat;
  CurPos := Wave.DataOffset;
  EndPos := CurPos + Wave.DataSize;
end;

function TAudioPlayer.GetWaveDataPtr(out Buffer: Pointer;
  var NumLoops: DWORD; var FreeIt: Boolean): DWORD;
begin
  FreeIt := False;
  if CurPos < EndPos then
  begin
    Buffer := Pointer(DWORD(Wave.Memory) + CurPos);
    Result := PreferredBufferSize;
    if (CurPos + Result) > EndPos then
      Result := EndPos - CurPos;
    Inc(CurPos, Result);
  end
  else
    Result := 0;
end;

{ TLiveAudioPlayer }

constructor TLiveAudioPlayer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fPCMFormat := Mono16Bit8000Hz;
end;

procedure TLiveAudioPlayer.SetPCMFormat(Value: TPCMFormat);
begin
  if PCMFormat <> Value then
  begin
    if Active then
      raise EWaveAudioInvalidOperation.Create('Audio format cannot be changed while device is open')
    else
      fPCMFormat := Value;
  end;
end;

procedure TLiveAudioPlayer.GetWaveFormat(out pWaveFormat: PWaveFormatEx;
  var FreeIt: Boolean);
begin
  if PCMFormat <> nonePCM then
  begin
    GetMem(pWaveFormat, SizeOf(TWaveFormatEx));
    SetPCMAudioFormatS(pWaveFormat, PCMFormat)
  end
  else if Assigned(fOnFormat) then
    fOnFormat(Self, pWaveFormat, FreeIt);
end;

function TLiveAudioPlayer.GetWaveData(const Buffer: Pointer;
  BufferSize: DWORD; var NumLoops: DWORD): DWORD;
begin
  if Assigned(fOnData) then
    Result := fOnData(Self, Buffer, BufferSize, NumLoops)
  else
    Result := 0;
end;

function TLiveAudioPlayer.GetWaveDataPtr(out Buffer: Pointer;
  var NumLoops: DWORD; var FreeIt: Boolean): DWORD;
begin
  if Assigned(fOnDataPtr) then
    Result := fOnDataPtr(Self, Buffer, NumLoops, FreeIt)
  else
    Result := 0;
end;

{ TStockAudioPlayer }

procedure TStockAudioPlayer.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Stock) then
    Stock := nil;
end;

procedure TStockAudioPlayer.SetStock(Value: TCustomWaveStorage);
begin
  if Stock <> Value then
  begin
    {$IFDEF DELPHI5_UP}
    if Assigned(Stock) then
      Stock.RemoveFreeNotification(Self);
    {$ENDIF}
    fStock := Value;
    if Assigned(Stock) then
      Stock.FreeNotification(Self);
  end;
end;

procedure TStockAudioPlayer.SetActive(Value: Boolean);
begin
  if Active <> Value then
  begin
    if Value then
      PlayStock(0)
    else
      Stop;
  end;
end;

procedure TStockAudioPlayer.GetWaveFormat(out pWaveFormat: PWaveFormatEx;
  var FreeIt: Boolean);
begin
  if GetWaveAudioInfo(mmIO, pWaveFormat, DataSize, DataOffset) then
    mmioSeek(mmIO, DataOffset, SEEK_SET);
end;

function TStockAudioPlayer.GetWaveData(const Buffer: Pointer;
  BufferSize: DWORD; var NumLoops: DWORD): DWORD;
begin
  if DataSize = 0 then
    Result := 0
  else if DataSize <= BufferSize then
  begin
    Result := mmioRead(mmIO, Buffer, DataSize);
    DataSize := 0;
  end
  else
  begin
    Result := mmioRead(mmIO, Buffer, BufferSize);
    Dec(DataSize, BufferSize);
  end;
end;

procedure TStockAudioPlayer.DoWaveOutDeviceClose;
begin
  try
    CleanUp;
  finally
    inherited DoWaveOutDeviceClose;
  end;
end;

procedure TStockAudioPlayer.DoError;
begin
  try
    if not Active then
      CleanUp;
  finally
    inherited DoError;
  end;
end;

procedure TStockAudioPlayer.CleanUp;
begin
  if mmIO <> 0 then
  begin
    mmioClose(mmIO, 0);
    mmIO := 0;
  end;
  if FreeStream and Assigned(Stream) then
    Stream.Free;
  Stream := nil;
end;

function TStockAudioPlayer.InternalPlay(AStream: TStream;
  FreeIt: Boolean): Boolean;
var
  mmIOInfo: TMMIOINFO;
begin
  Result := False;
  if Active then
  begin
    inherited Active := False;
    Sleep(0);
  end;
  Stream := AStream;
  FreeStream := FreeIt;
  FillChar(mmIOInfo, SizeOf(mmIOInfo), 0);
  mmIOInfo.pIOProc := @mmIOStreamProc;
  mmIOInfo.adwInfo[0] := DWORD(Stream);
  mmIO := mmioOpen(nil, @mmIOInfo, MMIO_READ);
  try
    if InternalOpen then
      Result := True
    else
      CleanUp;
  except
    CleanUp;
    raise;
  end;
end;

function TStockAudioPlayer.PlayStream(AStream: TStream): Boolean;
begin
  Result := InternalPlay(AStream, False);
end;

function TStockAudioPlayer.PlayFile(const FileName: String): Boolean;
begin
  Result := InternalPlay(TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite), True);
end;

function TStockAudioPlayer.PlayResName(Instance: THandle;
  const ResName: String): Boolean;
begin
  Result := InternalPlay(TResourceStream.Create(Instance, ResName, 'WAVE'), True);
end;

function TStockAudioPlayer.PlayResID(Instance: THandle; ResID: Integer): Boolean;
begin
  Result := InternalPlay(TResourceStream.CreateFromID(Instance, ResID, 'WAVE'), True);
end;

function TStockAudioPlayer.PlayStock(Index: Integer): Boolean;
begin
  if not Assigned(Stock) then
    raise EWaveAudioInvalidOperation.Create('Stock property is not assigned');
  Result := InternalPlay(Stock.WaveStream[Index], False);
end;

function TStockAudioPlayer.Stop: Boolean;
begin
  Result := InternalClose;
end;

end.
