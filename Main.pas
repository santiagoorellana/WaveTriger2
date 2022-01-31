///////////////////////////////////////////////////////////////////////////////
// Autor: Santiago Alejandro Orellana Pérez
// Creado: 29/06/2013
// Email: tecnochago@gmail.com
// Movil: +53 54635944
// Utilización: Programa para grabar audio desde la tarjeta del PC.
//              EL grabador comienza a grabar cuando e sucede un evento de
//              cruce de umbral.
///////////////////////////////////////////////////////////////////////////////

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls, mmSystem, Menus,
  Spin, ActnList, ToolWin, ImgList, IniFiles, UBase, Math,
  UColoreadoDeGraficos, Dialogs, ComCtrls,
  WaveUtils, WaveIn, WaveRecorders, WaveIO, WaveOut, WavePlayers, WaveRedirector;

                
// Definición del formulario.
type
  TMainForm = class(TForm)
    SaveDialog: TSaveDialog;
    PanelFourier: TPanel;
    Splitter1: TSplitter;
    PaintBoxFourier: TPaintBox;
    PanelCascada: TPanel;
    PaintBoxCascada: TPaintBox;
    TimerGraficador: TTimer;
    ActionList1: TActionList;
    ActionAumentarLimiteSuperior: TAction;
    ActionDisminuirLimiteSuperior: TAction;
    ActionDesplazarBandaPasanteAIzquierda: TAction;
    ActionDesplazarBandaPasanteADerecha: TAction;
    ActionDisminuirBandaPasante: TAction;
    ActionAumentarBandaPasante: TAction;
    MainMenu1: TMainMenu;
    Fichero1: TMenuItem;
    ActionSeleccionarDestino: TAction;
    ActionGrabar: TAction;
    ActionDetenerGrabacion: TAction;
    Grabacin1: TMenuItem;
    iniciargrabacin1: TMenuItem;
    Detenergrabacin1: TMenuItem;
    ActionUtilizacion: TAction;
    ActionProcedencia: TAction;
    Ayuda1: TMenuItem;
    Procedencia1: TMenuItem;
    Utilizacin1: TMenuItem;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    ActionCerrarPrograma: TAction;
    Cerrarprograma1: TMenuItem;
    Seleccionardestino1: TMenuItem;
    N1: TMenuItem;
    ActionFijarUmbral: TAction;
    ActionActivarSonido: TAction;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    ActionUmbralLineal: TAction;
    ActionUmbralEspectral: TAction;
    ActionManual: TAction;
    ActionReconocimiento: TAction;
    Manual1: TMenuItem;
    Umbrallineal1: TMenuItem;
    Umbralespectral1: TMenuItem;
    Disparadordegrabacin1: TMenuItem;
    Manual2: TMenuItem;
    Umbrallineal2: TMenuItem;
    Umbralespectral2: TMenuItem;
    N2: TMenuItem;
    ActionColores: TAction;
    Configuracin1: TMenuItem;
    Activarsonido1: TMenuItem;
    Cambiarcolores1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton4: TToolButton;
    ToolButton9: TToolButton;
    ToolButton8: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ActionCrearUmbralEspectral: TAction;
    ToolButton20: TToolButton;
    Actualizarumbralespectral1: TMenuItem;
    Fijarumbral1: TMenuItem;
    ToolButton21: TToolButton;
    ActionConfiguracionOriginal: TAction;
    ActionColoresOriginales1: TMenuItem;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    ActionFourierDeBarras: TAction;
    ActionFourierDeCurvas: TAction;
    ActionFourierDePuntos: TAction;
    EstilodegrficaFourier1: TMenuItem;
    Barras1: TMenuItem;
    Curvas1: TMenuItem;
    Puntos1: TMenuItem;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    TrackBarEscala: TTrackBar;
    TrackBarLongitudCascada: TTrackBar;
    TrackBarVolumenAudio: TTrackBar;
    ToolButton11: TToolButton;
    ActionIniciarConWindows: TAction;
    IniciarconWindows1: TMenuItem;
    N3: TMenuItem;
    ActionInercia1segundo: TAction;
    ActionInercia5segundos: TAction;
    ActionInercia10segundos: TAction;
    ActionInercia30segundos: TAction;
    ActionInercia1Minuto: TAction;
    ActionInercia5Minutos: TAction;
    ActionInercia10Minutos: TAction;
    Inerciadegrabacin1: TMenuItem;
    PopupMenu2: TPopupMenu;
    N1segundo1: TMenuItem;
    N5segundos1: TMenuItem;
    N10segundos1: TMenuItem;
    N30segundos1: TMenuItem;
    N1minuto1: TMenuItem;
    N5minutos1: TMenuItem;
    N10minutos1: TMenuItem;
    N1segundo2: TMenuItem;
    N5segundos2: TMenuItem;
    N10segundos2: TMenuItem;
    N30segundos2: TMenuItem;
    N1minuto2: TMenuItem;
    N5minutos2: TMenuItem;
    N10minutos2: TMenuItem;
    N4: TMenuItem;
    ActionInerciaDeGrabacion: TAction;
    ToolButton12: TToolButton;
    ComboBoxDispositivo: TComboBox;
    ComboBoxRampa: TComboBox;
    ComboBoxFrecuencia: TComboBox;
    ComboBoxMuestras: TComboBox;
    SpinEditLongitudDelBuffer: TSpinEdit;

    procedure FormCreate(Sender: TObject);
    procedure StockAudioRecorderActivate(Sender: TObject);
    procedure StockAudioRecorderDeactivate(Sender: TObject);
    procedure StockAudioRecorderLevel(Sender: TObject; Level: Integer);
    procedure RedirectorAudioOutFilter(Sender: TObject; const Buffer: Pointer; BufferSize: Cardinal);
    procedure PaintBoxFourierPaint(Sender: TObject);
    procedure PaintBoxCascadaPaint(Sender: TObject);
    procedure TimerGraficadorTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PanelFourierResize(Sender: TObject);
    procedure PanelCascadaResize(Sender: TObject);
    procedure ActionAumentarLimiteSuperiorExecute(Sender: TObject);
    procedure ActionDisminuirLimiteSuperiorExecute(Sender: TObject);
    procedure ActionAumentarBandaPasanteExecute(Sender: TObject);
    procedure ActionDisminuirBandaPasanteExecute(Sender: TObject);
    procedure ActionDesplazarBandaPasanteAIzquierdaExecute(Sender: TObject);
    procedure ActionDesplazarBandaPasanteADerechaExecute(Sender: TObject);
    procedure ActionSeleccionarDestinoExecute(Sender: TObject);
    procedure ActionGrabarExecute(Sender: TObject);
    procedure ActionDetenerGrabacionExecute(Sender: TObject);
    procedure ActionUtilizacionExecute(Sender: TObject);
    procedure ActionProcedenciaExecute(Sender: TObject);
    procedure ActionCerrarProgramaExecute(Sender: TObject);
    procedure PaintBoxFourierMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ActionFijarUmbralExecute(Sender: TObject);
    procedure ActionActivarSonidoExecute(Sender: TObject);
    procedure PaintBoxFourierMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxFourierMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ActionManualExecute(Sender: TObject);
    procedure ActionUmbralLinealExecute(Sender: TObject);
    procedure ActionUmbralEspectralExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionCrearUmbralEspectralExecute(Sender: TObject);
    procedure ActionCrearUmbralEspectralUpdate(Sender: TObject);
    procedure ActionColoresExecute(Sender: TObject);
    procedure ActionConfiguracionOriginalExecute(Sender: TObject);
    procedure ActionFijarUmbralUpdate(Sender: TObject);
    procedure ActionFourierDeBarrasExecute(Sender: TObject);
    procedure ActionFourierDeCurvasExecute(Sender: TObject);
    procedure ActionFourierDePuntosExecute(Sender: TObject);
    procedure ActionFourierDeBarrasUpdate(Sender: TObject);
    procedure ActionFourierDeCurvasUpdate(Sender: TObject);
    procedure ActionFourierDePuntosUpdate(Sender: TObject);
    procedure TrackBarLongitudCascadaChange(Sender: TObject);
    procedure TrackBarEscalaChange(Sender: TObject);
    procedure TrackBarVolumenAudioChange(Sender: TObject);
    procedure ActionIniciarConWindowsExecute(Sender: TObject);
    procedure ActionIniciarConWindowsUpdate(Sender: TObject);
    procedure ActionInercia1segundoExecute(Sender: TObject);
    procedure ActionInercia5segundosExecute(Sender: TObject);
    procedure ActionInercia10segundosExecute(Sender: TObject);
    procedure ActionInercia30segundosExecute(Sender: TObject);
    procedure ActionInercia1MinutoExecute(Sender: TObject);
    procedure ActionInercia5MinutosExecute(Sender: TObject);
    procedure ActionInercia10MinutosExecute(Sender: TObject);
    procedure ActionInercia1segundoUpdate(Sender: TObject);
    procedure ActionInercia5segundosUpdate(Sender: TObject);
    procedure ActionInercia10segundosUpdate(Sender: TObject);
    procedure ActionInercia30segundosUpdate(Sender: TObject);
    procedure ActionInercia1MinutoUpdate(Sender: TObject);
    procedure ActionInercia5MinutosUpdate(Sender: TObject);
    procedure ActionInercia10MinutosUpdate(Sender: TObject);
    procedure ActionManualUpdate(Sender: TObject);
    procedure ActionUmbralLinealUpdate(Sender: TObject);
    procedure ActionUmbralEspectralUpdate(Sender: TObject);
    procedure ActionReconocimientoUpdate(Sender: TObject);
    procedure ActionInerciaDeGrabacionUpdate(Sender: TObject);
    function DeInerciaAInteger(TiemposDeInercia: TTiemposDeInercia): Integer;
    function DeIntegerAInercia(Valor: Integer): TTiemposDeInercia;
    procedure ActionInerciaDeGrabacionExecute(Sender: TObject);
    procedure ComboBoxDispositivoChange(Sender: TObject);
    procedure ComboBoxMuestrasChange(Sender: TObject);

  private
    BMPFourier: TBitmap;
    BMPCascada: TBitmap;
    RealIn: Array of Smallint;
    ImagIn: Array of Double;
    RealOut: Array of Double;
    ImagOut: Array of Double;
    UmbralEspectral: Array of Double;
    EstadoDeUmbralEspectral: TEstadoDeUmbralEspectral;
    IniciarConWindows: Boolean;
    TiemposDeInercia: TTiemposDeInercia;
    Dibujar: Byte;

    function EsPotenciaDeDos(x: word): boolean;
    function NumeroDeBitsNecesarios(PotenciaDeDos: word): word;
    function BitsInversos(index, NumBits: word ):word;
    procedure FFT(AngleNumerator: double;
                  NumSamples: word;
                  var RealIn: array of Smallint;
                  var ImagIn: array of double;
                  var RealOut: array of double;
                  var ImagOut: array of double);
    procedure CalcularTransformadaRapidaDeFourier;
    function EscalarValores(n: Double): Double;
    procedure GraficarCascada;
    function GetCurrentDirectory: String;
    procedure ReadIni;
    procedure WriteIni;
    function OptenerNombre: String;
    function Sobresaturacion: Boolean;
    procedure DesactivarBotonesDeGrabacion;
    procedure BloqueoDeUmbrales(Bloqueado: Boolean);
    procedure TerminarCreacionDeUmbralEspectral;
    procedure DesactivarBotonesDeEstilosDeFourier;
    procedure ActualizarBotonesDeEstilosDeFourier;
    function ArcoTangente(a: Double): Double;
    function Modulo(R, I: Extended): Extended;
    function Fase(R, I: Extended): Extended;
    procedure InicioAutomatico(Arrancar: Boolean);
    procedure RedimensionarArreglos(Longitud: Integer);

    procedure WMQueryEndSession(var Msg: TWMQueryEndSession); message WM_QUERYENDSESSION;

  public
    NumMuestras: Integer;
    VelocMuestreo: Integer;
    VelocMuestreoDiv2: Integer;

    MaximaEscala: Integer;
    InstanteInicial: Cardinal;
    TiempoDeCaida: Integer;
    NombreFicheroActual: String;
    NombreRutaFicheroWavActual: String;
    NombreRutaFicheroXmlActual: String;
    DisparadorDeGrabacion: TDisparadorDeGrabacion;
    LimiteSuperiorBandaAct: Double;
    AnchoMedioBandaAct: Double;
    CentroBandaAct: Double;
    UmbralesBloqueados: Boolean;
    Sonido: Boolean;
    MouseInicial: TPoint;
    RutaParaGuardarGrabaciones: String;
    EstiloDeGraficaFourier: TEstiloDeGraficaFourier;

    ColorFondo: TColor;                       //Color para el fondo de los gráficos.
    ColorUmbralesLaterales: TColor;           //Color para los extremos laterales del umbral.
    ColorUmbralSuperior: TColor;              //Color para la línea superior umbral.
    ColorEspectroBajoUmbal: TColor;           //Color para el espectro que no sobrepasa el umbral.
    ColorEspectroSobreUmbal: TColor;          //Color para el espectro que sobrepasa el umbral.

    Filtrador: TAudioRedirector;
    Grabador: TStockAudioRecorder;
    function NuevoDispositivoDeAnalisis(ID: Integer; Formato: TPCMFormat; MuestrasNecesitadas: Integer): TAudioRedirector;
    function NuevoDispositivoDeGrabacion(ID: Integer; Formato: TPCMFormat; LongitudDelBuffer: Integer): TStockAudioRecorder;
  end;


var
  MainForm: TMainForm;

implementation

uses Registry, USeleccionarDirectorio, Types, UProcedencia, UCambiarColores,
     UUtilizacion;

{$R *.dfm}

// Asigna las nuevas dimensiones para los arreglos de datos.
procedure TMainForm.RedimensionarArreglos(Longitud: Integer);
var n: Integer;
begin
SetLength(RealIn, NumMuestras);                                   //Asigna tamaño a los arreglos de entrada
SetLength(ImagIn, NumMuestras);                                   //de la transformada rápida de Fourier.
SetLength(RealOut, NumMuestras);
SetLength(ImagOut, NumMuestras);
SetLength(UmbralEspectral, NumMuestras div 2);
for n := 0 to NumMuestras - 1 do ImagIn[n] := 0;                  //Inicia el arreglos de números complejos.
end;

// Inicia la aplicación.
procedure TMainForm.FormCreate(Sender: TObject);
var n: Integer;
begin
TimerGraficador.Interval := 100;
NumMuestras := 1024;
ComboBoxMuestras.ItemIndex := 2;
VelocMuestreo := 22050;
VelocMuestreoDiv2 := VelocMuestreo div 2;
ComboBoxFrecuencia.ItemIndex := 2;
Dibujar := 0;

//Crea los dispositivos de filtrado y grabación de audio.
Filtrador := NuevoDispositivoDeAnalisis(0,
                                        Formato16Bits(ComboBoxFrecuencia.ItemIndex),
                                        NumMuestras
                                        );
Grabador := NuevoDispositivoDeGrabacion(0,
                                        Formato16Bits(ComboBoxFrecuencia.ItemIndex),
                                        SpinEditLongitudDelBuffer.Value
                                        );

if Filtrador.AudioIn.NumDevs > 0 then
   begin
   for n := 0 to Filtrador.AudioIn.NumDevs - 1 do
       begin
       Filtrador.AudioIn.DeviceID := n;
       ComboBoxDispositivo.Items.Add(Filtrador.AudioIn.DeviceName);
       end;
   Filtrador.AudioIn.DeviceID := 1;
   Grabador.DeviceID := Filtrador.AudioIn.DeviceID;
   ComboBoxDispositivo.ItemIndex := Filtrador.AudioIn.DeviceID;
   end;

Caption := NombrePrograma + ' ' + VersionPrograma;

DoubleBuffered := True;
PanelFourier.DoubleBuffered := True;
PanelCascada.DoubleBuffered := True;
StatusBar1.DoubleBuffered := True;

RedimensionarArreglos(NumMuestras);

BMPFourier := TBitmap.Create;                                     //Crea el BMP para el dibujado OfScreen de gráfico fourier.
BMPFourier.Width := (NumMuestras div 2) * CMultBMP;               //Establece el ancho del BMP.
BMPFourier.Height := 100;                                         //Establece también la altura del BMP.
BMPFourier.Canvas.Brush.Color := clFondo;                         //Selecciona el color de forndo.
with BMPFourier do Canvas.FillRect(Rect(0, 0, Width, Height));    //Inicia la gráfica con el color de fondo.

BMPCascada := TBitmap.Create;                                     //Crea el BMP para el dibujado OfScreen de cascada.
BMPCascada.Width := NumMuestras div 2;                            //Establece el ancho del BMP del fourier.
TrackBarLongitudCascada.Position := CLongitudCascada;             //Establece la altura de la cascada.
TrackBarLongitudCascadaChange(Self);
BMPCascada.Canvas.Brush.Color := clFondo;                         //Selecciona el color de forndo.
with BMPCascada do Canvas.FillRect(Rect(0, 0, Width, Height));    //Inicia la gráfica con el color de fondo del fourier.

MouseInicial.X := MaxInt;
MouseInicial.Y := MaxInt;
Sonido := True;
TiempoDeCaida := 1000 * 10;                            //El tiempo de caida será de 10 segundos por defecto.
ActionManualExecute(Self);                             //Establece por defecto la grabación manual.
LimiteSuperiorBandaAct := 200;
CentroBandaAct := VelocMuestreoDiv2 / 2;
AnchoMedioBandaAct := VelocMuestreoDiv2 * 0.35;
TrackBarEscala.Position := 300;                        //Establece la escala máxima actual del gráfico.
TrackBarEscalaChange(Self);
TrackBarVolumenAudio.Position := 50;                   //Establece el volumen de audio por defecto.
TrackBarVolumenAudioChange(Self);
ColorFondo := clFondo;                                 //Establece los colores por defecto del sistema.
ColorEspectroBajoUmbal := clEspectroBajoUmbal;
ColorEspectroSobreUmbal := clEspectroSobreUmbal;
ColorUmbralSuperior := clUmbralSuperior;
ColorUmbralesLaterales := clUmbralesLaterales;
UmbralesBloqueados := False;                           //Por defecto los umbrales no estarán bloqueados.
ActionFijarUmbral.Checked := UmbralesBloqueados;
EstiloDeGraficaFourier := egfBarras;                   //Tipo de gráfico de Fourier que se muestra por defecto.
IniciarConWindows := False;                            //Por defecto, la aplicación no debe iniciarse con Windows.
TiemposDeInercia := CincoSegundos;                     //Tiempo de inercia por defecto.
TiempoDeCaida := DeInerciaAInteger(TiemposDeInercia);  //Convierte el tiempo de inercia en un integer;
try ReadIni except end;                                //Lee la configuración anterior.


Filtrador.Active := True;                       //Activa la captura por la tarjeta de sonidos.
end;

// Convierte el tiempo de inercia en un integer;
function TMainForm.DeInerciaAInteger(TiemposDeInercia: TTiemposDeInercia): Integer;
begin
case TiemposDeInercia of
     UnSegundo:       Result := 1000;
     CincoSegundos:   Result := 1000 * 5;
     DiesSegundos:    Result := 1000 * 10;
     TreintaSegundos: Result := 1000 * 30;
     UnMinuto:        Result := 1000 * 60;
     CincoMinutos:    Result := 1000 * 60 * 5;
     DiesMinutos:     Result := 1000 * 60 * 10;
     end;
end;

// Convierte el tiempo de inercia en un integer;
function TMainForm.DeIntegerAInercia(Valor: Integer): TTiemposDeInercia;
begin
case Valor of
     1000:           Result := UnSegundo;
     1000 * 5:       Result := CincoSegundos;
     1000 * 10:      Result := DiesSegundos;
     1000 * 30:      Result := TreintaSegundos;
     1000 * 60:      Result := UnMinuto;
     1000 * 60 * 5:  Result := CincoMinutos;
     1000 * 60 * 10: Result := DiesMinutos;
     else Result := CincoSegundos;
     end;
end;

// Devuelve un nombre para el fichero con la hora y fecha de inicio de grabación.
function TMainForm.OptenerNombre: String;
var stSystemTime : TSystemTime;
begin
Windows.GetLocalTime( stSystemTime );
Result := IntToStr(stSystemTime.wYear) + '-';
Result := Result + IntToStr(stSystemTime.wMonth) + '-';
Result := Result + IntToStr(stSystemTime.wDay) + '_';
Result := Result + IntToStr(stSystemTime.wHour) + '-';
Result := Result + IntToStr(stSystemTime.wMinute) + '-';
Result := Result + IntToStr(stSystemTime.wSecond);
end;

// Crea los datos XML de la señal grabada.
procedure CrearDatosXML;
begin
//Fecha de inicio
//Hora de inicio
//Duración
//Frecuencia de recepción
//Recibido desde:
//  -Area (Puede ser el nombre de Provincia, Municipio, Consejo, Zona, etc)
//  -Lugar (Nombre de un lugar puntual bien definido: Fábrica, Edificio, dirección, Accidente geográfico, etc)
//  -Coordenada (Coordenada del lugar en WGS84)
end;

// Se ejecuta al activar el grabador.
procedure TMainForm.StockAudioRecorderActivate(Sender: TObject);
begin
ActionSeleccionarDestino.Enabled := False;
ActionGrabar.Enabled := False;
ActionDetenerGrabacion.Enabled := True;
StatusBar1.Panels[2].Text := 'Fichero: ' + NombreRutaFicheroWavActual;
end;

// Se ejecuta al desactivar el grabador.
procedure TMainForm.StockAudioRecorderDeactivate(Sender: TObject);
begin
ActionSeleccionarDestino.Enabled := True;
ActionGrabar.Enabled := True;
ActionDetenerGrabacion.Enabled := False;
StatusBar1.Panels[1].Text := '';
StatusBar1.Panels[2].Text := '';
CrearDatosXML;
NombreRutaFicheroWavActual := '';
NombreRutaFicheroXmlActual := '';
end;

// Muestra la longitud (tiempo de duración) de la grabación.
procedure TMainForm.StockAudioRecorderLevel(Sender: TObject; Level: Integer);
begin
StatusBar1.Panels[1].Text := 'Duración: ' + MS2Str(Grabador.Position, msAh) + ' s';
end;

// Transformada rápida de Fourier.
procedure TMainForm.FFT(AngleNumerator:  double;
                        NumSamples: word;
                        var RealIn: array of Smallint;
                        var ImagIn: array of double;
                        var RealOut: array of double;
                        var ImagOut: array of double);
var NumBits, i, j, k, n, BlockSize, BlockEnd: word;
    delta_angle, delta_ar: double;
    alpha, beta: double;
    tr, ti, ar, ai: double;
begin
if not EsPotenciaDeDos(NumSamples) or (NumSamples<2) then
   begin
   Application.MessageBox('El número de muestras debe ser una potencia de 2', 'ERROR', MB_ICONERROR);
   Application.Terminate;
   end;
NumBits := NumeroDeBitsNecesarios(NumSamples);
for i := 0 to NumSamples-1 do
    begin
    j := BitsInversos(i, NumBits);
    RealOut[j] := RealIn[i];
    ImagOut[j] := ImagIn[i];
    end;
BlockEnd := 1;
BlockSize := 2;
while BlockSize <= NumSamples do
      begin
      delta_angle := AngleNumerator / BlockSize;
      alpha := sin(0.5 * delta_angle);
      alpha := 2.0 * alpha * alpha;
      beta := sin(delta_angle);
      i := 0;
      while i < NumSamples do
            begin
            ar := 1.0;    (* cos(0) *)
            ai := 0.0;    (* sin(0) *)
            j := i;
            for n := 0 to BlockEnd-1 do
                begin
                k := j + BlockEnd;
                tr := ar * RealOut[k] - ai * ImagOut[k];
                ti := ar * ImagOut[k] + ai * RealOut[k];
                RealOut[k] := RealOut[j] - tr;
                ImagOut[k] := ImagOut[j] - ti;
                RealOut[j] := RealOut[j] + tr;
                ImagOut[j] := ImagOut[j] + ti;
                delta_ar := alpha * ar + beta * ai;
                ai := ai - (alpha * ai - beta * ar);
                ar := ar - delta_ar;
                INC(j);
                end;
            i := i + BlockSize;
            end;
      BlockEnd := BlockSize;
      BlockSize := BlockSize SHL 1;
      end;
end;

// Comprueba si el número es potencia de dos.
function TMainForm.EsPotenciaDeDos(x: word ): boolean;
var i, y: word;
begin
y := 2;
for i := 1 to 15 do
    begin
    if x = y then
       begin
       Result := TRUE;
       exit;
       end;
    y := y SHL 1;
    end;
Result := FALSE;
end;

function TMainForm.NumeroDeBitsNecesarios(PotenciaDeDos: word): word;
var i: word;
begin
Result := 0;
for i := 0 to 16 do
    if (PotenciaDeDos AND (1 SHL i)) <> 0 then
       begin
       Result := i;
       exit;
       end;
end;

function TMainForm.BitsInversos(index, NumBits: word ):word;
var i: word;
begin
Result := 0;
for i := 0 to NumBits-1 do
    begin
    Result := (Result SHL 1) OR (index AND 1);
    index := index SHR 1;
    end;
end;


// Se ejecuta cada vez que se optiene una muestra.
procedure TMainForm.RedirectorAudioOutFilter(Sender: TObject; const Buffer: Pointer; BufferSize: Cardinal);
begin
CopyMemory(RealIn, Buffer, NumMuestras);                     //Copia los datos del buffer.
if not Sonido then FillMemory(Buffer, BufferSize, 0);        //Elimina el audio si no está activado.
if Sobresaturacion then
   Label2.Visible := True
else
   Label2.Visible := False;
CalcularTransformadaRapidaDeFourier;                         //Calcula la transoformada rápida de Fourier.
end;


// Detecta sobresaturación en la entrada de audio.
function TMainForm.Sobresaturacion: Boolean;
var n, c: Integer;
begin
Result := False;
c := 0;
for n := 0 to NumMuestras - 1 do
    if (RealIn[n] = -32768) or (RealIn[n] = 32767) then Inc(c);
if c > (NumMuestras * 0.05) then Result := True;
end;

// Dado un número complejo, esta función calcula el módulo del vector
// a partir de la parte Real e Imaginaria. Los parámetros son:
// R = Parte real del número complejo.
// I = Parte imaginaria del número complejo.
function TMainForm.Modulo(R, I: Extended): Extended;
begin
Result := Sqrt(Sqr(R) + Sqr(I));
end;


// Dado un número complejo, esta función calcula la fase del vector
// a partir de la parte Real e Imaginaria. Los parámetros son:
// R = Parte real del número complejo.
// I = Parte imaginaria del número complejo.
function TMainForm.Fase(R, I: Extended): Extended;
begin
if R = 0 then
   begin
   if I = 0 then Result := 0 else                              //Si el vector tiene módulo 0.
   if I > 0 then Result := 90 else                             //Si coincide con la parte positiva del eje Y.
   if I < 0 then Result := 270;                                //Si coincide con la parte negativa del eje Y.
   end
else                                                       
   if R > 0 then
      begin
      if I = 0 then Result := 0 else                           //Si coincide con la parte positiva del eje X.
      if I > 0 then Result := ArcoTangente(I / R) else         //Si se encuentra en el primer cuadrante.
      if I < 0 then Result := 360 + ArcoTangente(I / R);       //Si se encuentra en el cuarto cuadrante.
      end
   else
      begin
      Result := 180;                                           //Si coincide con la parte negativa del eje X.
      if I <> 0 then Result := Result + ArcoTangente(I / R);   //Si se encuentra en el segundo o tercer cuadrante.
      end;
Result := 360 - Result;
end;


//  Devuelve el arco (ángulo) en grados, cuya tangente es igual al valor X.   //
function TMainForm.ArcoTangente(a: Double): Double;
begin
Result := RadToDeg(ArcTan(a));
end;


// Calcula el espectro de frecuencia (transformada de fourier)
// del trozo de señal capturado y si es necesario realiza los
// cálculos que determinan si se debe comenzar a grabar.
procedure TMainForm.CalcularTransformadaRapidaDeFourier;
var c, n, desde, hasta: Integer;
    m, f: Double;
begin
FFT( 2*PI, NumMuestras, RealIn, ImagIn, RealOut, ImagOut );                       //Calcula la Transformada Rápida de Fourier.
RealOut[0] := 0;                                                                  //Elimina del espectro la componente contínua resultante.

//Convierte el número complejo en módulo y fase.
for n := 1 to NumMuestras div 2 - 1 do
    begin                                                                         //Calcula el módulo y fase de cada frecuencia.
    m := Modulo(RealOut[n], ImagOut[n]);                                          //Esta función calcula el módulo.
    f := Fase(RealOut[n], ImagOut[n]);                                            //Esta otra, la fase.
    RealOut[n] := m;                                                              //Luego se colocan los resultados en el
    ImagOut[n] := f;                                                              //arreglo de salida de la FFT.
    end;

for n := NumMuestras div 2 + 1 to NumMuestras - 1 do RealOut[n] := 0;             //Pone a cero los elementos de la mitad superior del arreglo para pasarle en el mensajes al graficador.
case DisparadorDeGrabacion of
     dgUmbralLineal:                                                              //Si la grabación se dispara por umbral recto:
     begin                                                                        //Calcula los límites de la banda de activación.
     desde := Round((CentroBandaAct - AnchoMedioBandaAct) / VelocMuestreoDiv2 * (NumMuestras div 2));
     hasta := Round((CentroBandaAct + AnchoMedioBandaAct) / VelocMuestreoDiv2 * (NumMuestras div 2));
     c := hasta - desde + 1;                                                      //Calcula el ancho de la banda de activación.
     for n := desde to hasta do                                                   //Chequea el tramo sensible del umbral.
         if RealOut[n] >= LimiteSuperiorBandaAct then                             //Si el espectro sobrepasa la altura del tramo sensible, se activa la grabación.
            RealOut[NumMuestras div 2 + 1 + n] := 1                               //Indica al graficador la posición de los valores que sobrepasan.
         else
            Dec(c);
         if c > 0 then                                                            //Si la señal sobrepasa el umbral:
            begin
            InstanteInicial := GetTickCount;                                      //Marca el tiempo de este instante.
            if not Grabador.Active then                                           //Comienza a grabar si no se ha comenzado anteriormente.
               begin
               NombreFicheroActual := OptenerNombre;
               NombreRutaFicheroWavActual := RutaParaGuardarGrabaciones + NombreFicheroActual + '.wav';   //Obtiene un nombre para la grabación.
               NombreRutaFicheroXmlActual := RutaParaGuardarGrabaciones + NombreFicheroActual + '.xml';   //Obtiene un nombre para los datos de la grabación.
               Grabador.RecordToFile(NombreRutaFicheroWavActual);                                         //Comienza la grabación.
               end;
            end
         else                                                                     //Si la señal no sobrepasa el umbral:
            if GetTickCount - InstanteInicial >= TiempoDeCaida then               //Detiene la grabación solo si se ha agotado el
               Grabador.Active := False;                                          //tiempo de caida de la grabación.
         end;
     dgUmbralEspectral:
     begin
     if EstadoDeUmbralEspectral = eueCapturandoEspectro then
        begin                                                                     //Captura la amplitud del espectro en todas las frecuencias.
        for n := 0 to NumMuestras div 2 - 1 do                                    //Recorre todo el espectro.
            if RealOut[n] > UmbralEspectral[n] then
               UmbralEspectral[n] := RealOut[n];
        end
     else
        begin                                                                     //Detecta si se ha sobrepasado el umbral espectral.
        c := NumMuestras div 2;                                                   //Calcula el número total de comparaciones.
        for n := 0 to NumMuestras div 2 - 1 do                                    //Recorre todo el espectro.
            if RealOut[n] > UmbralEspectral[n] then
               RealOut[NumMuestras div 2 + 1 + n] := 1                            //Indica al graficador la posición de los valores que sobrepasan.
            else
               Dec(c);
        if c > 0 then                                                             //Si la señal sobrepasa el umbral:
           begin
           InstanteInicial := GetTickCount;                                       //Marca el tiempo de este instante.
           if not Grabador.Active then                                            //Comienza a grabar si no se ha comenzado anteriormente.
              begin
              NombreFicheroActual := OptenerNombre;
              NombreRutaFicheroWavActual := RutaParaGuardarGrabaciones + NombreFicheroActual + '.wav';   //Obtiene un nombre para la grabación.
              NombreRutaFicheroXmlActual := RutaParaGuardarGrabaciones + NombreFicheroActual + '.xml';   //Obtiene un nombre para los datos de la grabación.
              Grabador.RecordToFile(NombreRutaFicheroWavActual);                                         //Comienza la grabación.
              end;
           end
        else                                                                      //Si la señal no sobrepasa el umbral:
           if GetTickCount - InstanteInicial >= TiempoDeCaida then                //Detiene la grabación solo si se ha agotado el
              Grabador.Active := False;                                           //tiempo de caida de la grabación.
        end;
     end;
end;
end;


// Devuelve el valor ajustado entre 0 y 100.
function TMainForm.EscalarValores(n: Double): Double;
begin
Result := n / MaximaEscala * 100;
if Result > 0 then
   begin
//   Result := Power(Result, 5);
//   Result := LnXP1(Result);
   end;
end;

// Redibuja el gráfico de cascada.
procedure TMainForm.GraficarCascada;
var n: Integer;
    c: TColor;
begin
BMPCascada.Canvas.Draw(0, 1, BMPCascada);                            //Dibuja el cambas desplazado una linea hacia abajo.
for n := 1 to BMPCascada.Width - 1 do                                //Dibuja las nuevas marcas de señal en la primera linea..
    begin
    c := CalcularColor(TRampa(ComboBoxRampa.ItemIndex),
                       (EscalarValores(RealOut[n]) / (BMPFourier.Height / 4))
                       );
    BMPCascada.Canvas.Pixels[n, 0] := c;
    end;                                                             //Copia el color en el pixel que representa la componente.
SetStretchBltMode(Handle, COLORONCOLOR);                             //Establece el modo de copia de la imagen.
PaintBoxCascada.Canvas.StretchDraw(Rect(0,                           //Copia la imgaen del BMP al canvas visible.
                                        0,
                                        PaintBoxCascada.Width - 1,
                                        PaintBoxCascada.Height - 1),
                                        BMPCascada);
end;

// Dibuja la gráfica de fourier en un PaintBox y crea los umbrales.
procedure TMainForm.PaintBoxFourierPaint(Sender: TObject);
var LimSup, LimIzq, LimDer, n, Nivel1, Nivel2, Posicion1, Posicion2, X1, X2: Integer;
    Izq, Der, V, P: Double;
begin
ColorFondo := CalcularColor(TRampa(ComboBoxRampa.ItemIndex), 0);                //Calcula el color de fondo.
PaintBoxFourier.Canvas.Brush.Color := ColorFondo;                                    //Asigna el color para el fondo del gráfico.
PaintBoxFourier.Canvas.FillRect(Rect(0, 0, PaintBoxFourier.Width, PaintBoxFourier.Height));    //Dibuja el fondo del gráfico.
PaintBoxFourier.Canvas.Pen.Width := 1;
PaintBoxFourier.Canvas.Pen.Color := ColorEspectroBajoUmbal;                          //Asigna el color del espectro por debajo del umbral.
with PaintBoxFourier.Canvas do
     case EstiloDeGraficaFourier of
          egfBarras:
             for n := 1 to NumMuestras div 2 - 1 do
                 begin
                 V := EscalarValores(RealOut[n]);
                 if n < NumMuestras - 1 then
                    begin
                    //Dibuja las componentes del espectro.
                    ColorEspectroBajoUmbal := CalcularColor(TRampa(ComboBoxRampa.ItemIndex), V);
                    Pen.Color := ColorEspectroBajoUmbal;
                    X1 := Round(PaintBoxFourier.Width * (n / (NumMuestras div 2)));
                    MoveTo(X1, PaintBoxFourier.Height);
                    LineTo(X1, PaintBoxFourier.Height - Round(EscalarValores(RealOut[n])));
                    end;
                 end;
          egfCurvas:
             for n := 1 to NumMuestras div 2 - 1 do
                 begin
                 V := EscalarValores(RealOut[n]);
                 if n < NumMuestras - 1 then
                    begin
                    //Dibuja la envolvente del espectro.
                    ColorEspectroBajoUmbal := CalcularColor(TRampa(ComboBoxRampa.ItemIndex), 1);
                    Pen.Color := ColorEspectroBajoUmbal;
                    X1 := Round(PaintBoxFourier.Width * (n / (NumMuestras div 2)));
                    X2 := Round(PaintBoxFourier.Width * ((n + 1) / (NumMuestras div 2)));
                    MoveTo(X1, PaintBoxFourier.Height - Round(EscalarValores(RealOut[n + 0])));
                    LineTo(X2, PaintBoxFourier.Height - Round(EscalarValores(RealOut[n + 1])));
                    end;
                 end;
          egfPuntos:
             for n := 1 to NumMuestras div 2 - 1 do
                 begin
                 V := EscalarValores(RealOut[n]);
                 if n < NumMuestras - 1 then
                    begin
                    //Dibuja la envolvente del espectro.
                    ColorEspectroBajoUmbal := CalcularColor(TRampa(ComboBoxRampa.ItemIndex), 0.6);
                    Pen.Color := ColorEspectroBajoUmbal;
                    X1 := Round(PaintBoxFourier.Width * (n / (NumMuestras div 2)));
                    X2 := Round(PaintBoxFourier.Width * ((n + 1) / (NumMuestras div 2)));
                    MoveTo(X1, PaintBoxFourier.Height - Round(EscalarValores(RealOut[n + 0])));
                    LineTo(X2, PaintBoxFourier.Height - Round(EscalarValores(RealOut[n + 1])));

                    //Dibuja las componentes del espectro.
                    V := EscalarValores(RealOut[n]) / (BMPFourier.Height / 4);
                    ColorEspectroBajoUmbal := CalcularColor(TRampa(ComboBoxRampa.ItemIndex), V);
                    Pen.Color := ColorEspectroBajoUmbal;
                    X1 := Round(PaintBoxFourier.Width * (n / (NumMuestras div 2)));
                    MoveTo(X1, PaintBoxFourier.Height);
                    LineTo(X1, PaintBoxFourier.Height - Round(EscalarValores(RealOut[n])));
                    end;
                 end;
          end;                        

//Dibuja los umbrales lineales y espectral.
case DisparadorDeGrabacion of
     dgUmbralLineal:
        begin
        Izq := CentroBandaAct - AnchoMedioBandaAct;                                            //Calcula el límite izquierdo.
        Der := CentroBandaAct + AnchoMedioBandaAct;                                            //Calcula el límite derecho.
        LimSup := Round(LimiteSuperiorBandaAct / MaximaEscala * PaintBoxFourier.Height);
        LimIzq := Round((Izq / VelocMuestreoDiv2) * PaintBoxFourier.Width);                    //Límite izquierdo relativo al tamaño del BMP.
        LimDer := Round((Der / VelocMuestreoDiv2) * PaintBoxFourier.Width);                    //Límite derecho relativo al tamaño del BMP.
        PaintBoxFourier.Canvas.Pen.Color := ColorUmbralesLaterales;                            //Color para los límites del umbral.
        PaintBoxFourier.Canvas.Pen.Width := 1;                                                 //Grozor de las líneas que marcan los límites.
        PaintBoxFourier.Canvas.MoveTo(Round(LimIzq), 0);
        PaintBoxFourier.Canvas.LineTo(Round(LimIzq), PaintBoxFourier.Height - 1);              //Traza la línea izquierda.
        PaintBoxFourier.Canvas.MoveTo(Round(LimDer), 0);
        PaintBoxFourier.Canvas.LineTo(Round(LimDer), PaintBoxFourier.Height - 1);              //Traza la línea derecha.
        PaintBoxFourier.Canvas.Pen.Color := ColorUmbralSuperior;                               //Color para el límite superior del umbral.
        PaintBoxFourier.Canvas.MoveTo(Round(LimIzq), PaintBoxFourier.Height - LimSup);
        PaintBoxFourier.Canvas.LineTo(Round(LimDer), PaintBoxFourier.Height - LimSup);         //Traza la línea superior.
        end;
     dgUmbralEspectral:
        begin
        PaintBoxFourier.Canvas.Pen.Color := ColorUmbralSuperior;                               //Color para el umbral espectral.
        PaintBoxFourier.Canvas.Pen.Width := 1;                                                 //Grozor de la línea del umbral.
        for n := 0 to NumMuestras div 2 - 2 do
            begin
            Nivel1 := Round(UmbralEspectral[n] / MaximaEscala * PaintBoxFourier.Height);
            Nivel2 := Round(UmbralEspectral[n + 1] / MaximaEscala * PaintBoxFourier.Height);
            Posicion1 := Round((n / (NumMuestras div 2)) * PaintBoxFourier.Width);            //Posición relativa al tamaño del BMP.
            Posicion2 := Round(((n + 1) / (NumMuestras div 2)) * PaintBoxFourier.Width);      //Posición relativa al tamaño del BMP.
            PaintBoxFourier.Canvas.MoveTo(Posicion1, PaintBoxFourier.Height - Nivel1);
            PaintBoxFourier.Canvas.LineTo(Posicion2, PaintBoxFourier.Height - Nivel2);        //Traza la línea del umbral espectral.
            end;
        end;
     end;
if Dibujar > 0 then Dec(Dibujar);                                                             //Indica que se terminó de dibujar este PaintBox.
end;

// Dibuja la gráfica de cascada en un PaintBox.
procedure TMainForm.PaintBoxCascadaPaint(Sender: TObject);
begin
GraficarCascada;                                //Dibuja el PaintBox.
if Dibujar > 0 then Dec(Dibujar);               //Indica que se terminó de dibujar este PaintBox.
end;

// Muestra las representaciones de las gráficas de frecuencia y cascada.
// Si el dibujado anterior no ha sido terminado, entonces sale de la función.
procedure TMainForm.TimerGraficadorTimer(Sender: TObject);
begin
if Dibujar > 0 then Exit;           //Sale si no se ha terminado de dibujar.
Dibujar := 2;                       //Declara que se estan dibujando dos PaintBox.
PaintBoxFourier.Invalidate;         //Dibuja el gráfico de frecuencia.
PaintBoxCascada.Invalidate;         //Dibuja la cascada.
end;


// Obtiene el directorio actual de la aplicación.
function TMainForm.GetCurrentDirectory: String;
var Length: DWORD;
    Buffer: PChar;
begin
Length := MAX_PATH + 1;
GetMem(Buffer, Length );
try
   if Windows.GetCurrentDirectory(Length, Buffer) > 0 then Result := Buffer;
finally
   FreeMem(Buffer);
end;
end;

// Lee del registro los valores de configuración.
procedure TMainForm.ReadIni;
var Ini: TIniFile;
begin
try
   Ini := TIniFile.Create(CNombreFicheroConfiguracion);
   RutaParaGuardarGrabaciones := Ini.ReadString('PARAMETROS', 'RutaParaGuardarGrabaciones', 'D:\');
   TrackBarEscala.Position := Ini.ReadInteger('PARAMETROS', 'EscalaMaximaDeLosGraficos', CMaximaEscala);
   TrackBarEscalaChange(Self);
   TrackBarLongitudCascada.Position := Ini.ReadInteger('PARAMETROS', 'LongitudDelGraficoDeCascada', CLongitudCascada);
   TrackBarLongitudCascadaChange(Self);
   PanelFourier.Height := Ini.ReadInteger('PARAMETROS', 'AlturaDeGraficoFourier', 130);
   LimiteSuperiorBandaAct := StrToFloat(Ini.ReadString('PARAMETROS', 'LimiteSuperiorDeUmbral', FloatToStr(CMaximaEscala / 2)));
   AnchoMedioBandaAct := StrToFloat(Ini.ReadString('PARAMETROS', 'AnchoMedioDeUmbral', FloatToStr(VelocMuestreoDiv2 / 3)));
   CentroBandaAct := StrToFloat(Ini.ReadString('PARAMETROS', 'CentroDeUmbral', FloatToStr(VelocMuestreoDiv2 / 2)));
   ColorFondo := StrToInt(Ini.ReadString('PARAMETROS', 'ColorDeFondo', IntToStr(clFondo)));
   ColorEspectroBajoUmbal := StrToInt(Ini.ReadString('PARAMETROS', 'ColorEspectroBajoUmbal', IntToStr(clEspectroBajoUmbal)));
   ColorEspectroSobreUmbal := StrToInt(Ini.ReadString('PARAMETROS', 'ColorEspectroSobreUmbal', IntToStr(clEspectroSobreUmbal)));
   ColorUmbralSuperior := StrToInt(Ini.ReadString('PARAMETROS', 'ColorUmbralSuperior', IntToStr(clUmbralSuperior)));
   ColorUmbralesLaterales := StrToInt(Ini.ReadString('PARAMETROS', 'ColorUmbralesLaterales', IntToStr(clUmbralesLaterales)));
   case Ini.ReadInteger('PARAMETROS', 'EstiloDeGraficaFourier', 0) of
        0 : ActionFourierDeBarrasExecute(Self);
        1 : ActionFourierDeCurvasExecute(Self);
        2 : ActionFourierDePuntosExecute(Self);
        end;
   case Ini.ReadInteger('PARAMETROS', 'DisparadorDeGrabacion', 0) of
        0 : ActionManualExecute(Self);
        1 : ActionUmbralLinealExecute(Self);
        2 : ActionUmbralEspectralExecute(Self);
        end;
   TiempoDeCaida := Ini.ReadInteger('PARAMETROS', 'TiempoDeInerciaDeGrabacion', DeInerciaAInteger(CincoSegundos));
   TiemposDeInercia := DeIntegerAInercia(TiempoDeCaida);
   if Ini.ReadBool('PARAMETROS', 'VentanaMaximizada', False) then WindowState := wsMaximized;
   TrackBarVolumenAudio.Position := Ini.ReadInteger('PARAMETROS', 'VolumenDeAudio', TrackBarVolumenAudio.Position);
   TrackBarVolumenAudioChange(Self);
   Sonido := Ini.ReadBool('PARAMETROS', 'AudioActivo', True);
   UmbralesBloqueados := Ini.ReadBool('PARAMETROS', 'UmbralesBloqueados', False);
   IniciarConWindows := Ini.ReadBool('PARAMETROS', 'IniciarConWindows', False);
   ActionFijarUmbral.Checked := UmbralesBloqueados;
   Ini.Free;
except
   Application.MessageBox('No se ha podido cargar la configuración anterior.', 'ERROR', MB_ICONERROR);
end;
end;

// Escribe en el registro los valores de configuración.
procedure TMainForm.WriteIni;
var Ini: TIniFile;
begin
try
   Ini := TIniFile.Create(CNombreFicheroConfiguracion);
   Ini.WriteString('PARAMETROS', 'RutaParaGuardarGrabaciones', RutaParaGuardarGrabaciones);
   Ini.WriteInteger('PARAMETROS', 'EscalaMaximaDeLosGraficos', TrackBarEscala.Position);
   Ini.WriteInteger('PARAMETROS', 'LongitudDelGraficoDeCascada', TrackBarLongitudCascada.Position);
   Ini.WriteInteger('PARAMETROS', 'AlturaDeGraficoFourier', PanelFourier.Height);
   Ini.WriteString('PARAMETROS', 'LimiteSuperiorDeUmbral', FloatToStr(LimiteSuperiorBandaAct));
   Ini.WriteString('PARAMETROS', 'AnchoMedioDeUmbral', FloatToStr(AnchoMedioBandaAct));
   Ini.WriteString('PARAMETROS', 'CentroDeUmbral', FloatToStr(CentroBandaAct));
   Ini.WriteString('PARAMETROS', 'ColorDeFondo', IntToStr(ColorFondo));
   Ini.WriteString('PARAMETROS', 'ColorEspectroBajoUmbal', IntToStr(ColorEspectroBajoUmbal));
   Ini.WriteString('PARAMETROS', 'ColorEspectroSobreUmbal', IntToStr(ColorEspectroSobreUmbal));
   Ini.WriteString('PARAMETROS', 'ColorUmbralSuperior', IntToStr(ColorUmbralSuperior));
   Ini.WriteString('PARAMETROS', 'ColorUmbralesLaterales', IntToStr(ColorUmbralesLaterales));
   case EstiloDeGraficaFourier of
        egfBarras: Ini.WriteInteger('PARAMETROS', 'EstiloDeGraficaFourier', 0);
        egfCurvas: Ini.WriteInteger('PARAMETROS', 'EstiloDeGraficaFourier', 1);
        egfPuntos: Ini.WriteInteger('PARAMETROS', 'EstiloDeGraficaFourier', 2);
        end;
   case DisparadorDeGrabacion of
        dgNinguno: Ini.WriteInteger('PARAMETROS', 'DisparadorDeGrabacion', 0);
        dgUmbralLineal: Ini.WriteInteger('PARAMETROS', 'DisparadorDeGrabacion', 1);
        dgUmbralEspectral: Ini.WriteInteger('PARAMETROS', 'DisparadorDeGrabacion', 2);
        end;
   Ini.WriteInteger('PARAMETROS', 'TiempoDeInerciaDeGrabacion', DeInerciaAInteger(TiemposDeInercia));
   if WindowState = wsMaximized then
      Ini.WriteBool('PARAMETROS', 'VentanaMaximizada', True)
   else   
      Ini.WriteBool('PARAMETROS', 'VentanaMaximizada', False);
   Ini.WriteInteger('PARAMETROS', 'VolumenDeAudio', TrackBarVolumenAudio.Position);
   Ini.WriteBool('PARAMETROS', 'AudioActivo', Sonido);
   Ini.WriteBool('PARAMETROS', 'UmbralesBloqueados', UmbralesBloqueados);
   Ini.WriteBool('PARAMETROS', 'IniciarConWindows', IniciarConWindows);
   InicioAutomatico(IniciarConWindows);
   Ini.Free;
except
   Application.MessageBox('No se ha podido guardar la configuración.', 'ERROR', MB_ICONERROR);
end;
end;

// Guarda la configuración en el registro de Windows.
procedure TMainForm.FormDestroy(Sender: TObject);
begin
try WriteIni except end;            //Guarda la configuración.
end;

procedure TMainForm.PanelFourierResize(Sender: TObject);
begin
PaintBoxFourier.Invalidate;         //Dibuja el gráfico de frecuencia.
end;

procedure TMainForm.PanelCascadaResize(Sender: TObject);
begin
PaintBoxCascada.Invalidate;         //Dibuja la cascada.
end;

//  Controlan los desplazamientos de los límites da banda pasante (Umbrales)

procedure TMainForm.ActionAumentarLimiteSuperiorExecute(Sender: TObject);
var n: Integer;
begin
if UmbralesBloqueados then Exit;
case DisparadorDeGrabacion of
     dgUmbralLineal:
     begin
     LimiteSuperiorBandaAct := LimiteSuperiorBandaAct + (MaximaEscala * 0.01);  //Modifica el valor.
     if LimiteSuperiorBandaAct > MaximaEscala then
        LimiteSuperiorBandaAct := MaximaEscala;                                 //Establece los límites.
     PaintBoxFourier.Invalidate;                                                //Dibuja el gráfico de frecuencia.
     end;
     dgUmbralEspectral:
     begin
     for n := 0 to NumMuestras div 2 - 1 do                                     //Desplaza hacia arriba el umbral espectral.
         UmbralEspectral[n] := UmbralEspectral[n] + (MaximaEscala * 0.01);
     PaintBoxFourier.Invalidate;                                                //Dibuja el gráfico de frecuencia.
     end;
end;
end;

procedure TMainForm.ActionDisminuirLimiteSuperiorExecute(Sender: TObject);
var n: Integer;
begin
if UmbralesBloqueados then Exit;
case DisparadorDeGrabacion of
     dgUmbralLineal:
     begin
     LimiteSuperiorBandaAct := LimiteSuperiorBandaAct - (MaximaEscala * 0.01);  //Modifica el valor.
     if LimiteSuperiorBandaAct < 0 then LimiteSuperiorBandaAct := 0;            //Establece los límites.
     PaintBoxFourier.Invalidate;                                                //Dibuja el gráfico de frecuencia.
     end;
     dgUmbralEspectral:
     begin
     for n := 0 to NumMuestras div 2 - 1 do                                    //Desplaza hacia abajo el umbral espectral.
         begin
         UmbralEspectral[n] := UmbralEspectral[n] - (MaximaEscala * 0.01);
         if UmbralEspectral[n] < 0 then UmbralEspectral[n] := 0;                //Establece el límite inferior.
         end;
     PaintBoxFourier.Invalidate;                                                //Dibuja el gráfico de frecuencia.
     end;
end;
end;

procedure TMainForm.ActionAumentarBandaPasanteExecute(Sender: TObject);
begin
if UmbralesBloqueados then Exit;
AnchoMedioBandaAct := AnchoMedioBandaAct + CDeltaUmbral * 10;       //Modifica el valor.
if AnchoMedioBandaAct > VelocMuestreoDiv2 then
   AnchoMedioBandaAct := VelocMuestreoDiv2;
PaintBoxFourier.Invalidate;                                         //Dibuja el gráfico de frecuencia.
end;

procedure TMainForm.ActionDisminuirBandaPasanteExecute(Sender: TObject);
begin
if UmbralesBloqueados then Exit;
AnchoMedioBandaAct := AnchoMedioBandaAct - CDeltaUmbral * 10;         //Modifica el valor.
if AnchoMedioBandaAct < VelocMuestreoDiv2 * CAnchoMinimoUmbral then
   AnchoMedioBandaAct := VelocMuestreoDiv2 * CAnchoMinimoUmbral;     //Establece los límites.
PaintBoxFourier.Invalidate;                                           //Dibuja el gráfico de frecuencia.
end;

procedure TMainForm.ActionDesplazarBandaPasanteAIzquierdaExecute(Sender: TObject);
begin
if UmbralesBloqueados then Exit;
CentroBandaAct := CentroBandaAct - CDeltaUmbral * 10;               //Modifica el valor.
if CentroBandaAct < 0 then CentroBandaAct := 0;                     //Establece los límites.
PaintBoxFourier.Invalidate;                                         //Dibuja el gráfico de frecuencia.
end;

procedure TMainForm.ActionDesplazarBandaPasanteADerechaExecute(Sender: TObject);
begin
if UmbralesBloqueados then Exit;
CentroBandaAct := CentroBandaAct + CDeltaUmbral * 10;               //Modifica el valor.
if CentroBandaAct > VelocMuestreoDiv2 then
   CentroBandaAct := VelocMuestreoDiv2;                             //Establece los límites.
PaintBoxFourier.Invalidate;                                         //Dibuja el gráfico de frecuencia.
end;


// Permite selecciona la ruta de destino de las grabaciones.
procedure TMainForm.ActionSeleccionarDestinoExecute(Sender: TObject);
var msg: String;
    RutaAnterior: String;
begin
RutaAnterior := RutaParaGuardarGrabaciones;
with TFormSeleccionarDirectorio.Create(Self) do ShowModal;
if RutaParaGuardarGrabaciones <> RutaAnterior then
   begin
   msg := 'Las grabaciones se guardarán en: ' + #13 + MainForm.RutaParaGuardarGrabaciones;
   Application.MessageBox(PChar(msg), 'Atención:', MB_OK)
   end;
end;

// Inicia la grabación del fichero.
procedure TMainForm.ActionGrabarExecute(Sender: TObject);
begin
NombreFicheroActual := OptenerNombre;
NombreRutaFicheroWAVActual := RutaParaGuardarGrabaciones + NombreFicheroActual + '.wav';
NombreRutaFicheroXMLActual := RutaParaGuardarGrabaciones + NombreFicheroActual + '.xml';
Grabador.RecordToFile(NombreRutaFicheroWavActual);
end;

// Se ejecuta al activar el grabador.
procedure TMainForm.ActionDetenerGrabacionExecute(Sender: TObject);
begin
Grabador.Stop;
Grabador.WaitForStop;
end;

// Muestra la ayuda del programa.
procedure TMainForm.ActionUtilizacionExecute(Sender: TObject);
var msg: String;
begin
with TFormUtilizacion.Create(Self) do ShowModal;
end;

// Muestra la información del grupo de desarrollo.
procedure TMainForm.ActionProcedenciaExecute(Sender: TObject);
begin
with TFormProcedencia.Create(Self) do ShowModal;
end;

// Cierra el programa.
procedure TMainForm.ActionCerrarProgramaExecute(Sender: TObject);
begin
Close;
end;

// Muestra el valor de frecuencia de la localización del cursor.
procedure TMainForm.PaintBoxFourierMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var Frec, DesX, DesY: Double;
begin
Frec := X / PaintBoxFourier.Width * (VelocMuestreoDiv2 / 1000);
StatusBar1.Panels[0].Text := ' ' + FloatToStrF(Frec, ffNumber, 4, 1) + ' Khz';
Exit;
if ssLeft in Shift then
   begin
   case DisparadorDeGrabacion of
        dgUmbralLineal:
        begin
        DesX := X / PaintBoxFourier.Width * VelocMuestreoDiv2;
        DesY := MaximaEscala - (Y / PaintBoxFourier.Height * MaximaEscala);
        CentroBandaAct := DesX;
        LimiteSuperiorBandaAct := DesY;
        if LimiteSuperiorBandaAct > MaximaEscala then LimiteSuperiorBandaAct := MaximaEscala;
        if LimiteSuperiorBandaAct < 0 then LimiteSuperiorBandaAct := 0;
        if CentroBandaAct > VelocMuestreoDiv2 then CentroBandaAct := VelocMuestreoDiv2;
        if CentroBandaAct < 0 then CentroBandaAct := 0;
        PaintBoxFourier.Invalidate;
        end;
        dgUmbralEspectral:
        begin
        end;
   end;
   end
else
   if (ssRight in Shift) and (DisparadorDeGrabacion = dgUmbralLineal) then
      begin
      DesX := (X - MouseInicial.X) / PaintBoxFourier.Width * VelocMuestreoDiv2;
      AnchoMedioBandaAct := DesX;
      if AnchoMedioBandaAct > VelocMuestreoDiv2 then AnchoMedioBandaAct := VelocMuestreoDiv2;
      if AnchoMedioBandaAct < 0 then AnchoMedioBandaAct := 0;
      PaintBoxFourier.Invalidate;
      end;
end;

// Acción que activa o desactiva la posibilidad
// de mover manualmente los umbrales.
procedure TMainForm.ActionFijarUmbralExecute(Sender: TObject);
begin
ActionCrearUmbralEspectralExecute(Self);
end;

procedure TMainForm.ActionFijarUmbralUpdate(Sender: TObject);
begin
ActionFijarUmbral.Checked := not ActionCrearUmbralEspectral.Checked;
end;

// Activa o desactiva la posibilidad de mover manualmente los umbrales.
// Entrada:
// Bloqueado  = True si se deben bloquear. False si se deben desbloquear.
procedure TMainForm.BloqueoDeUmbrales(Bloqueado: Boolean);
begin
UmbralesBloqueados := Bloqueado;
ActionFijarUmbral.Checked := Bloqueado;
end;

// Activa o desactiva el sonido.
procedure TMainForm.ActionActivarSonidoExecute(Sender: TObject);
begin
if Sonido = False then
   begin
   Sonido := True;
   ActionActivarSonido.Checked := True;
   end
else
   begin
   Sonido := False;
   ActionActivarSonido.Checked := False;
   end;
end;

// Guarda la posición inicial del mouse.
procedure TMainForm.PaintBoxFourierMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
MouseInicial := Point(X, Y);
end;

// Calcula el desplazamiento del mouse.
procedure TMainForm.PaintBoxFourierMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Frec, DesX, DesY: Double;
    n: Integer;
begin
Frec := X / PaintBoxFourier.Width * (VelocMuestreoDiv2 / 1000);
StatusBar1.Panels[0].Text := ' ' + FloatToStrF(Frec, ffNumber, 4, 1) + ' Khz';
if UmbralesBloqueados then Exit;
case DisparadorDeGrabacion of
     dgUmbralLineal:
     begin
     if MouseInicial.Y >= PaintBoxFourier.Height then Exit;
     if MouseInicial.X >= PaintBoxFourier.Width then Exit;
     if Button = mbLeft then
        begin
        DesX := (X - MouseInicial.X) / PaintBoxFourier.Width * VelocMuestreoDiv2;
        DesY := (Y - MouseInicial.Y) / PaintBoxFourier.Height * MaximaEscala;
        CentroBandaAct := CentroBandaAct + DesX;
        LimiteSuperiorBandaAct := LimiteSuperiorBandaAct - DesY;
        if LimiteSuperiorBandaAct > MaximaEscala then LimiteSuperiorBandaAct := MaximaEscala;
        if LimiteSuperiorBandaAct < 0 then LimiteSuperiorBandaAct := 0;
        if CentroBandaAct > VelocMuestreoDiv2 then CentroBandaAct := VelocMuestreoDiv2;
        if CentroBandaAct < 0 then CentroBandaAct := 0;
        PaintBoxFourier.Invalidate;
        end;
     if Button = mbRight then
        begin
        DesX := (X - MouseInicial.X) / PaintBoxFourier.Width * VelocMuestreoDiv2;
        AnchoMedioBandaAct := AnchoMedioBandaAct + DesX;
        if AnchoMedioBandaAct > (VelocMuestreoDiv2 div 2) then
           AnchoMedioBandaAct := VelocMuestreoDiv2 div 2;
        if AnchoMedioBandaAct < VelocMuestreoDiv2 * CAnchoMinimoUmbral then
           AnchoMedioBandaAct := VelocMuestreoDiv2 * CAnchoMinimoUmbral;
        PaintBoxFourier.Invalidate;
        end;
     end;
     dgUmbralEspectral:
     begin
     if MouseInicial.Y >= PaintBoxFourier.Height then Exit;
     if Button = mbLeft then
        begin
        DesY := (Y - MouseInicial.Y) / PaintBoxFourier.Height * MaximaEscala;
        for n := 0 to NumMuestras div 2 - 1 do                               //Desplaza el umbral espectral.
            begin
            UmbralEspectral[n] := UmbralEspectral[n] - DesY;
            if UmbralEspectral[n] < 0 then UmbralEspectral[n] := 0;          //Establece el límite inferior.
            end;
        PaintBoxFourier.Invalidate;
        end;
     end;
end;
end;



// Seleccionan el tipo de disparador de grabación.

procedure TMainForm.DesactivarBotonesDeGrabacion;
begin
ActionGrabar.Enabled := False;
ActionDetenerGrabacion.Enabled := False;
ActionDesplazarBandaPasanteAIzquierda.Enabled := False;
ActionDesplazarBandaPasanteADerecha.Enabled := False;
ActionAumentarLimiteSuperior.Enabled := False;
ActionDisminuirLimiteSuperior.Enabled := False;
ActionAumentarBandaPasante.Enabled := False;
ActionDisminuirBandaPasante.Enabled := False;
ActionCrearUmbralEspectral.Enabled := False;
ActionFijarUmbral.Enabled := False;
ActionInerciaDeGrabacion.Enabled := False;

ActionGrabar.Visible := False;
ActionDetenerGrabacion.Visible := False;
ActionDesplazarBandaPasanteAIzquierda.Visible := False;
ActionDesplazarBandaPasanteADerecha.Visible := False;
ActionAumentarLimiteSuperior.Visible := False;
ActionDisminuirLimiteSuperior.Visible := False;
ActionAumentarBandaPasante.Visible := False;
ActionDisminuirBandaPasante.Visible := False;
ActionCrearUmbralEspectral.Visible := False;
ActionFijarUmbral.Visible := False;
ActionInerciaDeGrabacion.Visible := False;

Label1.Visible := False;
end;

// Seleccionan el disparador manual.
procedure TMainForm.ActionManualExecute(Sender: TObject);
begin
//Desactiva cualquier grabación anterior.
Grabador.Active := False;

DisparadorDeGrabacion := dgNinguno;

//Unde el botón activado.
ActionManual.Checked := True;

//Activa los botones necesarios.
DesactivarBotonesDeGrabacion;
ActionGrabar.Enabled := True;
ActionGrabar.Visible := True;
ActionDetenerGrabacion.Visible := True;
end;

// Seleccionan el disparador por umbral lineal.
procedure TMainForm.ActionUmbralLinealExecute(Sender: TObject);
begin
//Desactiva cualquier grabación anterior.
Grabador.Active := False;

BloqueoDeUmbrales(False);
DisparadorDeGrabacion := dgUmbralLineal;

//Unde el botón activado.
ActionUmbralLineal.Checked := True;

//Activa los botones necesarios.
DesactivarBotonesDeGrabacion;
ActionDesplazarBandaPasanteAIzquierda.Enabled := True;
ActionDesplazarBandaPasanteADerecha.Enabled := True;
ActionAumentarLimiteSuperior.Enabled := True;
ActionDisminuirLimiteSuperior.Enabled := True;
ActionAumentarBandaPasante.Enabled := True;
ActionDisminuirBandaPasante.Enabled := True;
ActionInerciaDeGrabacion.Enabled := True;

ActionDesplazarBandaPasanteAIzquierda.Visible := True;
ActionDesplazarBandaPasanteADerecha.Visible := True;
ActionAumentarLimiteSuperior.Visible := True;
ActionDisminuirLimiteSuperior.Visible := True;
ActionAumentarBandaPasante.Visible := True;
ActionDisminuirBandaPasante.Visible := True;
ActionInerciaDeGrabacion.Visible := True;
end;

// Seleccionan el disparador por umbral espectral.
procedure TMainForm.ActionUmbralEspectralExecute(Sender: TObject);
var n: Integer;
begin
//Desactiva cualquier grabación anterior.
Grabador.Active := False;

//Selecciona el tipo de disparador de grabación.
DisparadorDeGrabacion := dgUmbralEspectral;

//Inicia el mecanismo de creación del umbral espectral.
EstadoDeUmbralEspectral := eueEspectroFijo;
ActionCrearUmbralEspectralExecute(Self);

//Unde el botón activado.
ActionUmbralEspectral.Checked := True;

//Activa los botones necesarios.
DesactivarBotonesDeGrabacion;
ActionAumentarLimiteSuperior.Enabled := True;
ActionDisminuirLimiteSuperior.Enabled := True;
ActionCrearUmbralEspectral.Enabled := True;
ActionFijarUmbral.Enabled := True;
ActionInerciaDeGrabacion.Enabled := True;

ActionAumentarLimiteSuperior.Visible := True;
ActionDisminuirLimiteSuperior.Visible := True;
ActionCrearUmbralEspectral.Visible := True;
ActionFijarUmbral.Visible := True;
ActionInerciaDeGrabacion.Visible := True;

//Muestra el botón de "Terminar construcción"
Label1.Visible := True;
BitBtn1.Visible := True;
BitBtn1.Enabled := True;
end;

// Desactiva los objetos de audio al cerrar el formulario.
procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
TimerGraficador.Enabled := False;
Grabador.Active := False;
Filtrador.Active := False;
end;


// Activa o desactiva la creación del umbral espectral
// a partir del contenido real del espectro.
procedure TMainForm.ActionCrearUmbralEspectralExecute(Sender: TObject);
var n: Integer;
begin
if DisparadorDeGrabacion = dgUmbralEspectral then
   begin
   if EstadoDeUmbralEspectral = eueCapturandoEspectro then
      begin
      for n := 0 to NumMuestras div 2 - 1 do                               //Desplaza hacia arriba el umbral espectral.
          UmbralEspectral[n] := UmbralEspectral[n] + CSubidaInicialDeUmbralEspectral;
      EstadoDeUmbralEspectral := eueEspectroFijo;                          //Indica que el espectro está fijo en una posición
      ActionCrearUmbralEspectral.Checked := False;                         //y que no se está actualizando el umbral.
      //Oculta el botón de "Terminar construcción"
      Label1.Visible := False;
      BitBtn1.Visible := False;
      BitBtn1.Enabled := False;
      end
   else
      begin
      //Muestra el botón de "Terminar construcción"
      Label1.Visible := True;
      BitBtn1.Visible := True;
      BitBtn1.Enabled := True;

      BloqueoDeUmbrales(False);                                            //Desbloquea el umbral para que pueda ser movido manualmente.
      Grabador.Active := False;                                            //Detiene cualquier grabación previa que se esté realizando.
      ActionCrearUmbralEspectral.Checked := True;                          //Indica que se está actualizando el umbral espectral
      EstadoDeUmbralEspectral := eueCapturandoEspectro;                    //y que se está capturando el espectro.
      for n := 0 to NumMuestras div 2 - 1 do UmbralEspectral[n] := 0;      //Pone en cero el umbral espectral.
      end;
   PaintBoxFourier.Invalidate;                                             //Dibuja el gráfico de frecuencia.
   end;
end;

procedure TMainForm.ActionCrearUmbralEspectralUpdate(Sender: TObject);
begin
if DisparadorDeGrabacion = dgUmbralEspectral then
   ActionCrearUmbralEspectral.Checked := EstadoDeUmbralEspectral = eueCapturandoEspectro;
end;

procedure TMainForm.TerminarCreacionDeUmbralEspectral;
var n: Integer;
begin
for n := 0 to NumMuestras div 2 - 1 do                               //Desplaza hacia arriba el umbral espectral.
    UmbralEspectral[n] := UmbralEspectral[n] + CSubidaInicialDeUmbralEspectral;
EstadoDeUmbralEspectral := eueEspectroFijo;                          //Indica que el espectro está fijo en una posición
ActionCrearUmbralEspectral.Checked := False;                         //y que no se está actualizando el umbral.
//Oculta el botón de "Terminar construcción"
Label1.Visible := False;
BitBtn1.Visible := False;
BitBtn1.Enabled := False;
end;


// Cambia los colores de la aplicación.
procedure TMainForm.ActionColoresExecute(Sender: TObject);
begin
with TFormCambiarColores.Create(Self) do ShowModal;
end;

// Establece los colores originales de la aplicación.
procedure TMainForm.ActionConfiguracionOriginalExecute(Sender: TObject);
begin
RutaParaGuardarGrabaciones := 'D:\';
MaximaEscala := CMaximaEscala;
LimiteSuperiorBandaAct := CMaximaEscala / 2;
AnchoMedioBandaAct := VelocMuestreoDiv2 / 3;
CentroBandaAct := VelocMuestreoDiv2 / 2;

//Establece los colores originales.
ColorFondo := clFondo;
ColorEspectroBajoUmbal := clEspectroBajoUmbal;
ColorEspectroSobreUmbal := clEspectroSobreUmbal;
ColorUmbralSuperior := clUmbralSuperior;
ColorUmbralesLaterales := clUmbralesLaterales;
end;


// Establece el estilo de gráfico de Fourier que se utilizará.

procedure TMainForm.DesactivarBotonesDeEstilosDeFourier;
begin
ActionFourierDeBarras.Checked := False;
ActionFourierDeCurvas.Checked := False;
ActionFourierDePuntos.Checked := False;
end;

procedure TMainForm.ActualizarBotonesDeEstilosDeFourier;
begin
DesactivarBotonesDeEstilosDeFourier;
case EstiloDeGraficaFourier of
     egfBarras: ActionFourierDeBarras.Checked := True;
     egfCurvas: ActionFourierDeCurvas.Checked := True;
     egfPuntos: ActionFourierDePuntos.Checked := True;
     end;
end;

procedure TMainForm.ActionFourierDeBarrasExecute(Sender: TObject);
begin
EstiloDeGraficaFourier := egfBarras;
ActualizarBotonesDeEstilosDeFourier;
end;

procedure TMainForm.ActionFourierDeCurvasExecute(Sender: TObject);
begin
EstiloDeGraficaFourier := egfCurvas;
ActualizarBotonesDeEstilosDeFourier;
end;

procedure TMainForm.ActionFourierDePuntosExecute(Sender: TObject);
begin
EstiloDeGraficaFourier := egfPuntos;
ActualizarBotonesDeEstilosDeFourier;
end;

procedure TMainForm.ActionFourierDeBarrasUpdate(Sender: TObject);
begin
ActionFourierDeBarras.Checked := EstiloDeGraficaFourier = egfBarras;
end;

procedure TMainForm.ActionFourierDeCurvasUpdate(Sender: TObject);
begin
ActionFourierDeCurvas.Checked := EstiloDeGraficaFourier = egfCurvas;
end;

procedure TMainForm.ActionFourierDePuntosUpdate(Sender: TObject);
begin
ActionFourierDePuntos.Checked := EstiloDeGraficaFourier = egfPuntos;
end;

// Establece la longitud del gráfico de cascada.
procedure TMainForm.TrackBarLongitudCascadaChange(Sender: TObject);
begin
with TrackBarLongitudCascada do BMPCascada.Height := Max - Position + Min;
end;

// Establece la escala de profundidad de los gráficos.
procedure TMainForm.TrackBarEscalaChange(Sender: TObject);
begin
with TrackBarEscala do MaximaEscala := Round(CMaximaEscala * (Position / Max));
end;

// Establece la intesidad del audio de salida por Speaker.
procedure TMainForm.TrackBarVolumenAudioChange(Sender: TObject);
begin
Filtrador.AudioOut.Volume := TrackBarVolumenAudio.Position;
end;

// Establecer si la aplicación debe arrancar con cada inicio de Windows.
procedure TMainForm.InicioAutomatico(Arrancar: Boolean);
var Registro: TRegistry;
    Llave: String;
begin
Registro := TRegistry.create;
Registro.RootKey := HKEY_LOCAL_MACHINE;
Llave := NombrePrograma+'_'+VersionPrograma;
if Registro.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',FALSE) then
   if Arrancar then
      Registro.WriteString(Llave, Application.ExeName)
   else
      Registro.DeleteValue(Llave);
IniciarConWindows := Arrancar;
Registro.Destroy;
end;

// Pemite al usuario iniciar la aplicación con cada arranque de Windows.
procedure TMainForm.ActionIniciarConWindowsExecute(Sender: TObject);
begin
IniciarConWindows := not IniciarConWindows;
ActionIniciarConWindows.Checked := IniciarConWindows;
end;

procedure TMainForm.ActionIniciarConWindowsUpdate(Sender: TObject);
begin
ActionIniciarConWindows.Checked := IniciarConWindows;
end;

// Procesa el mensaje que indica el cierre de Windows.
procedure TMainForm.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
Msg.Result := 1;
Close;
end;

// Establecen el tiempo de inercia de la grabación por umbrales.

procedure TMainForm.ActionInerciaDeGrabacionExecute(Sender: TObject);
begin
Exit;
end;

procedure TMainForm.ActionInercia1segundoExecute(Sender: TObject);
begin
TiemposDeInercia := UnSegundo;
TiempoDeCaida := DeInerciaAInteger(TiemposDeInercia);
end;

procedure TMainForm.ActionInercia5segundosExecute(Sender: TObject);
begin
TiemposDeInercia := CincoSegundos;
TiempoDeCaida := DeInerciaAInteger(TiemposDeInercia);
end;

procedure TMainForm.ActionInercia10segundosExecute(Sender: TObject);
begin
TiemposDeInercia := DiesSegundos;
TiempoDeCaida := DeInerciaAInteger(TiemposDeInercia);
end;

procedure TMainForm.ActionInercia30segundosExecute(Sender: TObject);
begin
TiemposDeInercia := TreintaSegundos;
TiempoDeCaida := DeInerciaAInteger(TiemposDeInercia);
end;

procedure TMainForm.ActionInercia1MinutoExecute(Sender: TObject);
begin
TiemposDeInercia := UnMinuto;
TiempoDeCaida := DeInerciaAInteger(TiemposDeInercia);
end;

procedure TMainForm.ActionInercia5MinutosExecute(Sender: TObject);
begin
TiemposDeInercia := CincoMinutos;
TiempoDeCaida := DeInerciaAInteger(TiemposDeInercia);
end;

procedure TMainForm.ActionInercia10MinutosExecute(Sender: TObject);
begin
TiemposDeInercia := DiesMinutos;
TiempoDeCaida := DeInerciaAInteger(TiemposDeInercia);
end;

// Actualizan los botones de establecimiento de tiempo de inercia.

procedure TMainForm.ActionInerciaDeGrabacionUpdate(Sender: TObject);
begin
ActionInerciaDeGrabacion.Visible := DisparadorDeGrabacion <> dgNinguno;
ActionInerciaDeGrabacion.Enabled := ActionInerciaDeGrabacion.Visible;
end;

procedure TMainForm.ActionInercia1segundoUpdate(Sender: TObject);
begin
ActionInercia1segundo.Checked := TiemposDeInercia = UnSegundo;
end;

procedure TMainForm.ActionInercia5segundosUpdate(Sender: TObject);
begin
ActionInercia5segundos.Checked := TiemposDeInercia = CincoSegundos;
end;

procedure TMainForm.ActionInercia10segundosUpdate(Sender: TObject);
begin
ActionInercia10segundos.Checked := TiemposDeInercia = DiesSegundos;
end;

procedure TMainForm.ActionInercia30segundosUpdate(Sender: TObject);
begin
ActionInercia30segundos.Checked := TiemposDeInercia = TreintaSegundos;
end;

procedure TMainForm.ActionInercia1MinutoUpdate(Sender: TObject);
begin
ActionInercia1Minuto.Checked := TiemposDeInercia = UnMinuto;
end;

procedure TMainForm.ActionInercia5MinutosUpdate(Sender: TObject);
begin
ActionInercia5Minutos.Checked := TiemposDeInercia = CincoMinutos;
end;

procedure TMainForm.ActionInercia10MinutosUpdate(Sender: TObject);
begin
ActionInercia10Minutos.Checked := TiemposDeInercia = DiesMinutos;
end;


// Actualizan los botones de establecimiento del tipo de grabación.

procedure TMainForm.ActionManualUpdate(Sender: TObject);
begin
ActionManual.Checked := DisparadorDeGrabacion = dgNinguno;
end;

procedure TMainForm.ActionUmbralLinealUpdate(Sender: TObject);
begin
ActionUmbralLineal.Checked := DisparadorDeGrabacion = dgUmbralLineal;
end;

procedure TMainForm.ActionUmbralEspectralUpdate(Sender: TObject);
begin
ActionUmbralEspectral.Checked := DisparadorDeGrabacion = dgUmbralEspectral;
end;

procedure TMainForm.ActionReconocimientoUpdate(Sender: TObject);
begin
//ActionManual.Checked := DisparadorDeGrabacion = dgNinguno;
end;

// Crear nuevo dispositivo de análisis.
// Parámetros:
// ID = Identificador del dispositivos de Audio al que se desea acceder.
//      En Windows el primero es 0, el segundo 1 y así en adelante.
// Formato = Formato del dispositivo de audio.
// MuestrasNecesitadas = Cantidad de muestras que debe almacenar el búffer.
function TMainForm.NuevoDispositivoDeAnalisis(ID: Integer; Formato: TPCMFormat; MuestrasNecesitadas: Integer): TAudioRedirector;
begin
Result := TAudioRedirector.Create(nil);                 //Crea un objeto para analizar lo que entra por un dispositivo de sonido.
Result.AudioIn.DeviceID := ID;                          //Identificador del dispositivo de audio al que se le analizará la entrada.
Result.Async := False;                                  //El filtrador debe trabajar sincronizado con el resto del sistema.
Result.AudioIn.PCMFormat := Formato;                    //Formato en el que se analizada la señal.
Result.BufferCount := 4;                                                                  //Cantidad de buffers del filtrador.
Result.BufferLength := LongitudDelBufferEnMilisegundos(FrecuenciaDeMuestreo(Formato),     //Calcula la longitud de buffers necesaria según la configuración.
                                                       MuestrasNecesitadas);
Result.AudioOut.OnFilter := RedirectorAudioOutFilter;                                     //Este evento llama al código de filtrado y análisis.
end;

// Crear nuevo dispositivo de grabación.
function TMainForm.NuevoDispositivoDeGrabacion(ID: Integer; Formato: TPCMFormat; LongitudDelBuffer: Integer): TStockAudioRecorder;
begin
Result := TStockAudioRecorder.Create(nil);              //Crea un objeto para grabar el sonido de un dispositivo de audio.
Result.DeviceID := ID;                                  //Identificador del dispositivo de audio del que se grabará el sonido.
Result.Async := True;                                   //El grabador trabaja de manera asincrónica.
Result.PCMFormat := Formato;                            //Establece el formato de grabación.
Result.BufferCount := 8;                                //Utiliza 8 buffers.
Result.BufferLength := LongitudDelBuffer;               //Establece la longitud de los buffers de audio.
Result.OnActivate := StockAudioRecorderActivate;        //Asigna un evento para la activación.
Result.OnDeactivate := StockAudioRecorderDeactivate;    //Asigna un evento para la desactivación.
Result.OnLevel := StockAudioRecorderLevel;              //Asigna un evento para el cambio de nivel.
end;

// Cambia el dispositivo de audio para el filtro y el grabador.
procedure TMainForm.ComboBoxDispositivoChange(Sender: TObject);
begin
try
   Filtrador.Free;                                                                      //Destruye el filtrador anteriormente creado.
   Grabador.Free;                                                                       //Destruye también el grabador.
   Filtrador := NuevoDispositivoDeAnalisis(ComboBoxDispositivo.ItemIndex,
                                           Formato16Bits(ComboBoxFrecuencia.ItemIndex),    //Crea un nuevo filtrador.
                                           NumMuestras);
   Grabador := NuevoDispositivoDeGrabacion(ComboBoxDispositivo.ItemIndex,
                                           Formato16Bits(ComboBoxFrecuencia.ItemIndex), //Crea un nuevo grabador.
                                           1000);
//                                           1000 * SpinEditLongitudDelBuffer.Value);
   Filtrador.Active := True;                                                            //Inicia el filtrado y análisis de las entradas.
except end;
end;


// Cambia la cantidad de muestras que se utilizan para crear el fourier.
procedure TMainForm.ComboBoxMuestrasChange(Sender: TObject);
begin
try
   Filtrador.Free;
   NumMuestras := Round(Power(2, 8 + ComboBoxMuestras.ItemIndex));             //Establece el número de muestras.
   RedimensionarArreglos(NumMuestras);                                         //Cambia el tamaño de los arreglos.
   BMPCascada.Width := NumMuestras div 2;                                      //Establece el ancho del BMP de la cascada.
   Filtrador := NuevoDispositivoDeAnalisis(ComboBoxDispositivo.ItemIndex,
                                           Formato16Bits(ComboBoxFrecuencia.ItemIndex),
                                           NumMuestras);
   Filtrador.Active := True;
except end;
end;


end.
