{------------------------------------------------------------------------------}
{                                                                              }
{  WaveRedirector - A component to redirect wave audio                         }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

{$I DELPHIAREA.INC}

unit WaveRedirector;

interface

uses
  Windows, Messages, Classes, mmSystem, WaveUtils, WaveIn, WaveOut;

type

  TAudioInput = class;
  TAudioOutput = class;

  // Reocords audio from an input device and plays it on an output device
  TAudioRedirector = class(TComponent)
  private
    fInput: TAudioInput;
    fOutput: TAudioOutput;
    fOnActivate: TWaveAudioEvent;
    fOnDeactivate: TWaveAudioEvent;
    fOnError: TWaveAudioEvent;
    fWaveFormat: PWaveFormatEx;
    function GetActive: Boolean;
    procedure SetActive(Value: Boolean);
    function GetAsync: Boolean;
    procedure SetAsync(Value: Boolean);
    function GetLastError: MMRESULT;
    function GetLastErrorText: String;
    function GetBufferCount: WORD;
    procedure SetBufferCount(Value: WORD);
    function GetBufferLength: WORD;
    procedure SetBufferLength(Value: WORD);
    procedure AudioActivate(Sender: TObject);
    procedure AudioDeactivate(Sender: TObject);
    procedure AudioError(Sender: TObject);
  protected
    function HandlesAllocated: Boolean;
    property WaveFormat: PWaveFormatEx read fWaveFormat write fWaveFormat;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property LastError: MMRESULT read GetLastError;
    property LastErrorText: String read GetLastErrorText;
    property Active: Boolean read GetActive write SetActive;
    {$IFNDEF DELPHI6_UP}
    property AudioIn: TAudioInput read fInput;
    property AudioOut: TAudioOutput read fOutput;
    {$ENDIF}
  published
    {$IFDEF DELPHI6_UP}
    property AudioIn: TAudioInput read fInput;
    property AudioOut: TAudioOutput read fOutput;
    {$ENDIF}
    property BufferLength: WORD read GetBufferLength write SetBufferLength default 50; // Milliseconds
    property BufferCount: WORD read GetBufferCount write SetBufferCount default 5;
    property Async: Boolean read GetAsync write SetAsync default False;
    property OnActivate: TWaveAudioEvent read fOnActivate write fOnActivate;
    property OnDeactivate: TWaveAudioEvent read fOnDeactivate write fOnDeactivate;
    property OnError: TWaveAudioEvent read fOnError write fOnError;
  end;

  // Manages audio input for TAudioRedirector
  TAudioInput = class(TWaveAudioIn)
  private
    fRedirector: TAudioRedirector;
  protected
    procedure GetWaveFormat(out pWaveFormat: PWaveFormatEx;
      var FreeIt: Boolean); override;
    procedure WaveDataReady(const Buffer: Pointer; BufferSize: DWORD;
      var FreeIt: Boolean); override;
    property Redirector: TAudioRedirector read fRedirector;
    property Active;
    property BufferLength;      // Seconds
    property BufferCount;
    property LastError;
    property LastErrorText;
    property OnActivate;
    property OnDeactivate;
    property OnError;
  public
    {$IFDEF DELPHI4_UP}
    constructor Create(AOwner: TAudioRedirector); reintroduce; virtual;
    {$ELSE}
    constructor Create(AOwner: TAudioRedirector); virtual;
    {$ENDIF}
    property NumDevs;
    property DeviceName;
    property DeviceFormats;
    property DeviceID;
  published
    property OnLevel;
    property PCMFormat;
    property OnFormat;
  end;

  // Manages audio output for TAudioRedirector
  TAudioOutput = class(TWaveAudioOut)
  private
    fRedirector: TAudioRedirector;
  protected
    procedure GetWaveFormat(out pWaveFormat: PWaveFormatEx;
      var FreeIt: Boolean); override;
    procedure DoWaveOutDeviceDone(pWaveHeader: PWaveHdr); override;
    procedure DefineBuffers; override;
    property Redirector: TAudioRedirector read fRedirector;
    property Active;
    property BufferLength;      // Seconds
    property BufferCount;
    property LastError;
    property LastErrorText;
    property OnActivate;
    property OnDeactivate;
    property OnError;
  public
    {$IFDEF DELPHI4_UP}
    constructor Create(AOwner: TAudioRedirector); reintroduce; virtual;
    {$ELSE}
    constructor Create(AOwner: TAudioRedirector); virtual;
    {$ENDIF}
    property NumDevs;
    property DeviceName;
    property DeviceFormats;
    property DeviceSupports;
    property DeviceID;
  published
    property Options;
    property Volume;            // Percent (Both channels)
    property Pitch;
    property PlaybackRate;
    property OnLevel;
    property OnFilter;
  end;

implementation

uses WaveIO;

{ TAudioRedirector }

constructor TAudioRedirector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fInput := TAudioInput.Create(Self);
  {$IFDEF DELPHI6_UP}
  fInput.SetSubcomponent(True);
  {$ENDIF}
  fInput.Name := 'AudioIn';
  fInput.BufferLength := 50;
  fInput.BufferCount := 5;
  fInput.OnActivate := AudioActivate;
  fInput.OnDeactivate := AudioDeactivate;
  fInput.OnError := AudioError;
  fOutput := TAudioOutput.Create(Self);
  {$IFDEF DELPHI6_UP}
  fOutput.SetSubcomponent(True);
  {$ENDIF}
  fOutput.Name := 'AudioOut';
  fOutput.BufferCount := 0;
  fOutput.OnActivate := AudioActivate;
  fOutput.OnDeactivate := AudioDeactivate;
  fOutput.OnError := AudioError;
end;

destructor TAudioRedirector.Destroy;
begin
  fOutput.Active := False;
  fInput.Active := False;
  fInput.Free;
  fOutput.Free;
  if Assigned(fWaveFormat) then
    FreeMem(fWaveFormat);
  inherited Destroy;
end;

function TAudioRedirector.HandlesAllocated: Boolean;
begin
  Result := AudioIn.HandleAllocated and AudioOut.HandleAllocated;
end;

function TAudioRedirector.GetActive: Boolean;
begin
  Result := AudioIn.Active or AudioIn.Active;
end;

procedure TAudioRedirector.SetActive(Value: Boolean);
begin
  if Value then
  begin
    AudioIn.Active := True;
    AudioOut.Active := True;
  end
  else
  begin
    AudioOut.Active := False;
    AudioIn.Active := False;
  end;
end;

function TAudioRedirector.GetAsync: Boolean;
begin
  Result := AudioIn.Async;
end;

procedure TAudioRedirector.SetAsync(Value: Boolean);
begin
  AudioIn.Async := Value;
  AudioOut.Async := Value;
end;

function TAudioRedirector.GetBufferCount: WORD;
begin
  Result := fInput.BufferCount;
end;

procedure TAudioRedirector.SetBufferCount(Value: WORD);
begin
  AudioIn.BufferCount := Value;
end;

function TAudioRedirector.GetBufferLength: WORD;
begin
  Result := AudioIn.BufferLength;
end;

procedure TAudioRedirector.SetBufferLength(Value: WORD);
begin
  AudioIn.BufferLength := Value;
end;

function TAudioRedirector.GetLastError: MMRESULT;
begin
  if AudioIn.LastError <> MMSYSERR_NOERROR then
    Result := AudioIn.LastError
  else if AudioOut.LastError <> MMSYSERR_NOERROR then
    Result := AudioOut.LastError
  else
    Result := MMSYSERR_NOERROR;
end;

function TAudioRedirector.GetLastErrorText: String;
begin
  if AudioIn.LastError <> MMSYSERR_NOERROR then
    Result := AudioIn.LastErrorText
  else if AudioOut.LastError <> MMSYSERR_NOERROR then
    Result := AudioOut.LastErrorText
  else
    Result := '';
end;

procedure TAudioRedirector.AudioActivate(Sender: TObject);
begin
  if (Sender = AudioOut) and Assigned(fOnActivate) then
    fOnActivate(Self);
end;

procedure TAudioRedirector.AudioDeactivate(Sender: TObject);
begin
  if (Sender = AudioIn) and Assigned(fOnDeactivate) and
     not (csDestroying in ComponentState)
  then
    fOnDeactivate(Self);
end;

procedure TAudioRedirector.AudioError(Sender: TObject);
begin
  if Assigned(fOnError) then
    fOnError(Self)
  else
    raise EWaveAudioSysError.Create(LastErrorText);
end;

{ TAudioInput }

constructor TAudioInput.Create(AOwner: TAudioRedirector);
begin
  inherited Create(AOwner);
  fRedirector := AOwner;
end;

procedure TAudioInput.GetWaveFormat(out pWaveFormat: PWaveFormatEx;
  var FreeIt: Boolean);
var
  FormatSize: Integer;
  Format: PWaveFormatEx;
begin
  if Assigned(Redirector.WaveFormat) then
  begin
    FreeMem(Redirector.WaveFormat);
    Redirector.WaveFormat := nil;
  end;
  inherited GetWaveFormat(pWaveFormat, FreeIt);
  if FreeIt then
  begin
    FreeIt := False;
    Redirector.WaveFormat := pWaveFormat;
  end
  else
  begin
    FormatSize := SizeOf(TWaveFormatEx) + pWaveFormat^.cbSize;
    GetMem(Format, FormatSize);
    CopyMemory(Format, pWaveFormat, FormatSize);
    Redirector.WaveFormat := Format;
  end;
end;

procedure TAudioInput.WaveDataReady(const Buffer: Pointer; BufferSize: DWORD;
  var FreeIt: Boolean);
begin
  FreeIt := False;
  if Redirector.AudioOut.HandleAllocated then
  begin
    Redirector.AudioOut.Lock;
    try
      Redirector.AudioOut.WriteBuffer(Buffer, BufferSize, 0, True);
    finally
      Redirector.AudioOut.Unlock;
    end;
  end;
end;

{ TAudioOutput }

constructor TAudioOutput.Create(AOwner: TAudioRedirector);
begin
  inherited Create(AOwner);
  fRedirector := AOwner;
end;

procedure TAudioOutput.GetWaveFormat(out pWaveFormat: PWaveFormatEx;
  var FreeIt: Boolean);
begin
  FreeIt := True;
  pWaveFormat := Redirector.WaveFormat;
  Redirector.WaveFormat := nil;
end;

procedure TAudioOutput.DefineBuffers;
begin
  // Nothing to do!
end;

procedure TAudioOutput.DoWaveOutDeviceDone(pWaveHeader: PWaveHdr);
begin
  try
    if Assigned(pWaveHeader) then
    begin
      Success(WaveOutUnprepareHeader(Handle, pWaveHeader, SizeOf(TWaveHdr)));
      ReallocateBuffer(pWaveHeader, 0, nil);
    end;
  finally
    if Closing and (ActiveBufferCount = 0) then
      Success(WaveOutClose(Handle));
  end;
end;

end.
