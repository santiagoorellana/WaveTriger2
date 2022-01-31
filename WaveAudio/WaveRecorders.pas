{------------------------------------------------------------------------------}
{                                                                              }
{  WaveRecorders - Wave recorder components                                    }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

{$I DELPHIAREA.INC}

unit WaveRecorders;

interface

uses
  Windows, Messages, Classes, mmSystem, WaveUtils, WaveStorage, WaveIn;

type

  // Records wave into a wave stream
  TAudioRecorder = class(TWaveAudioIn)
  private
    mmIO: HMMIO;
    ckRIFF: TMMCKInfo;
    ckData: TMMCKInfo;
    fWave: TWave;
    procedure CleanUp;
  protected
    procedure GetWaveFormat(out pWaveFormat: PWaveFormatEx;
      var FreeIt: Boolean); override;
    procedure WaveDataReady(const Buffer: Pointer; BufferSize: DWORD;
      var FreeIt: Boolean); override;
    procedure DoWaveInDeviceClose; override;
    procedure DoError; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property NumDevs;
    property DeviceName;
    property DeviceFormats;
    property LastError;
    property LastErrorText;
    property Position;          // Milliseconds
    property DeviceID;
    property Paused;
    property Active;
    property Wave: TWave read fWave;
  published
    property PCMFormat;
    property BufferLength;      // Milliseconds
    property BufferCount;
    property Async;
    property OnActivate;
    property OnDeactivate;
    property OnPause;
    property OnResume;
    property OnError;
    property OnLevel;
    property OnFormat;
  end;

  // Records wave into user defined buffers
  TLiveAudioRecorder = class(TWaveAudioIn)
  private
    fOnData: TWaveAudioDataReadyEvent;
  protected
    procedure WaveDataReady(const Buffer: Pointer; BufferSize: DWORD;
      var FreeIt: Boolean); override;
  public
    property NumDevs;
    property DeviceName;
    property DeviceFormats;
    property LastError;
    property LastErrorText;
    property Position;          // Milliseconds
    property DeviceID;
    property Paused;
    property Active;
  published
    property PCMFormat;
    property BufferLength;      // Milliseconds
    property BufferCount;
    property Async;
    property OnActivate;
    property OnDeactivate;
    property OnPause;
    property OnResume;
    property OnError;
    property OnLevel;
    property OnFormat;
    property OnData: TWaveAudioDataReadyEvent read fOnData write fOnData;
  end;

  // Records wave into a file, or stream
  TStockAudioRecorder = class(TWaveAudioIn)
  private
    mmIO: HMMIO;
    ckRIFF: TMMCKInfo;
    ckData: TMMCKInfo;
    Stream: TStream;
    FreeStream: Boolean;
    fStock: TCustomWaveStorage;
    procedure SetStock(Value: TCustomWaveStorage);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetActive(Value: Boolean); override;
    procedure GetWaveFormat(out pWaveFormat: PWaveFormatEx;
      var FreeIt: Boolean); override;
    procedure WaveDataReady(const Buffer: Pointer; BufferSize: DWORD;
      var FreeIt: Boolean); override;
    procedure DoWaveInDeviceClose; override;
    procedure DoError; override;
    function InternalRecord(AStream: TStream; FreeIt: Boolean): Boolean; virtual;
    procedure CleanUp; virtual;
  public
    function RecordToStream(AStream: TStream): Boolean;
    function RecordToFile(const FileName: String): Boolean;
    function RecordToStock(Index: Integer): Boolean;
    function Stop: Boolean;
    property NumDevs;
    property DeviceName;
    property DeviceFormats;
    property LastError;
    property LastErrorText;
    property Position;          // Milliseconds
    property DeviceID;
    property Paused;
    property Active;
  published
    property Stock: TCustomWaveStorage read fStock write SetStock;
    property PCMFormat;
    property BufferLength;      // Milliseconds
    property BufferCount;
    property Async;
    property OnActivate;
    property OnDeactivate;
    property OnPause;
    property OnResume;
    property OnError;
    property OnLevel;
    property OnFormat;
  end;


implementation

uses
  SysUtils;

{ TAudioRecorder }

constructor TAudioRecorder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fWave := TWave.Create;
end;

destructor TAudioRecorder.Destroy;
begin
  inherited Destroy;
  fWave.Free;
end;

procedure TAudioRecorder.WaveDataReady(const Buffer: Pointer;
  BufferSize: DWORD; var FreeIt: Boolean);
begin
  if mmioWrite(mmIO, PChar(Buffer), BufferSize) <> Integer(BufferSize) then
    Success(MMSYSERR_ERROR); // Raises an OnError event
end;

procedure TAudioRecorder.GetWaveFormat(out pWaveFormat: PWaveFormatEx;
  var FreeIt: Boolean);
begin
  inherited GetWaveFormat(pWaveFormat, FreeIt);
  if Assigned(pWaveFormat) then
    mmIO := CreateStreamWaveAudio(Wave, pWaveFormat, ckRIFF, ckData);
end;

procedure TAudioRecorder.DoWaveInDeviceClose;
begin
  try
    CleanUp;
  finally
    inherited DoWaveInDeviceClose;
  end;
end;

procedure TAudioRecorder.DoError;
begin
  try
    if not Active then
      CleanUp;
  finally
    inherited DoError;
  end;
end;

procedure TAudioRecorder.CleanUp;
begin
  if mmIO <> 0 then
  begin
    CloseWaveAudio(mmIO, ckRIFF, ckData);
    mmIO := 0;
  end;
end;

{ TLiveAudioRecorder }

procedure TLiveAudioRecorder.WaveDataReady(const Buffer: Pointer;
  BufferSize: DWORD; var FreeIt: Boolean);
begin
  if Assigned(fOnData) then
    fOnData(Self, Buffer, BufferSize, FreeIt);
end;

{ TStockAudioRecorder }

procedure TStockAudioRecorder.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Stock) then
    Stock := nil;
end;

procedure TStockAudioRecorder.SetStock(Value: TCustomWaveStorage);
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

procedure TStockAudioRecorder.SetActive(Value: Boolean);
begin
  if Active <> Value then
  begin
    if Value then
      RecordToStock(0)
    else
      Stop;
  end;
end;

procedure TStockAudioRecorder.WaveDataReady(const Buffer: Pointer;
  BufferSize: DWORD; var FreeIt: Boolean);
begin
  if mmioWrite(mmIO, PChar(Buffer), BufferSize) <> Integer(BufferSize) then
    Success(MMSYSERR_ERROR); // Raises an OnError event
end;

procedure TStockAudioRecorder.GetWaveFormat(out pWaveFormat: PWaveFormatEx;
  var FreeIt: Boolean);
begin
  inherited GetWaveFormat(pWaveFormat, FreeIt);
  if Assigned(pWaveFormat) then
    mmIO := CreateStreamWaveAudio(Stream, pWaveFormat, ckRIFF, ckData);
end;

procedure TStockAudioRecorder.DoWaveInDeviceClose;
begin
  try
    CleanUp;
  finally
    inherited DoWaveInDeviceClose;
  end;
end;

procedure TStockAudioRecorder.DoError;
begin
  try
    if not Active then
      CleanUp;
  finally
    inherited DoError;
  end;
end;

procedure TStockAudioRecorder.CleanUp;
begin
  if mmIO <> 0 then
  begin
    CloseWaveAudio(mmIO, ckRIFF, ckData);
    mmIO := 0;
  end;
  if FreeStream and Assigned(Stream) then
    Stream.Free;
  Stream := nil;
end;

function TStockAudioRecorder.InternalRecord(AStream: TStream;
  FreeIt: Boolean): Boolean;
begin
  Result := False;
  inherited Active := False;
  Stream := AStream;
  FreeStream := FreeIt;
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

function TStockAudioRecorder.RecordToStream(AStream: TStream): Boolean;
begin
  Result := InternalRecord(AStream, False);
end;

function TStockAudioRecorder.RecordToFile(const FileName: String): Boolean;
begin
  Result := InternalRecord(TFileStream.Create(FileName, fmCreate or fmShareDenyWrite), True);
end;

function TStockAudioRecorder.RecordToStock(Index: Integer): Boolean;
begin
  if not Assigned(Stock) then
    raise EWaveAudioInvalidOperation.Create('Stock property is not assigned');
  Result := InternalRecord(Stock.WaveStream[Index], False);
end;

function TStockAudioRecorder.Stop: Boolean;
begin
  Result := InternalClose;
end;

end.
