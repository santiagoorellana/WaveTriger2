///////////////////////////////////////////////////////////////////////////////
// Autor: Santiago Alejandro Orellana Pérez
// Creado: 29/06/2013
// Email: tecnochago@gmail.com
// Movil: +53 54635944
///////////////////////////////////////////////////////////////////////////////

unit UBase;

interface

uses
   Graphics, WaveUtils;

// Parámetros.

const NombrePrograma = 'WaveTriger';
const VersionPrograma = '2.0.0';

const CNombreFicheroConfiguracion = 'WaveTriger.ini';
//const CNumMuestras = 1024;                         //Longitud de la Transformada Rápida de Fourier.
const CMaximaEscala = 5000000;                      //Escala máxima que se puede tomar en la gráfica.
const CLongitudCascada = 70;
//const CVelocMuestreo = 44100;                      //Velocidad de muestreo a la que se realiza la grabación.
const CDeltaUmbral = 10;
const CAnchoMinimoUmbral = 0.01;                   //Ancho mínimo del umbral expresado de 0 a 1.
const CMultBMP = 1;

//const CVelocMuestreoDiv2 = CVelocMuestreo div 2;   //Mitad de la velocidad de muestreo.
const CSubidaInicialDeUmbralEspectral = 1000;

const clFondo = clBlack;                           //Color para el fondo de los gráficos.
const clUmbralesLaterales = clYellow;              //Color para los extremos laterales del umbral.
const clUmbralSuperior = clRed;                    //Color para la línea superior umbral.
const clEspectroBajoUmbal = clGreen;               //Color para el espectro que no sobrepasa el umbral.
const clEspectroSobreUmbal = clBlue;               //Color para el espectro que sobrepasa el umbral.


type TDisparadorDeGrabacion = (dgUmbralLineal, dgUmbralEspectral, dgNinguno);
type TEstadoDeUmbralEspectral = (eueCapturandoEspectro, eueEspectroFijo);
type TEstiloDeGraficaFourier = (egfBarras, egfCurvas, egfPuntos);
type TTiemposDeInercia = (UnSegundo, CincoSegundos, DiesSegundos, TreintaSegundos, UnMinuto, CincoMinutos, DiesMinutos);

function LongitudDelBufferEnMilisegundos(FrecuenciaDeMuestreo: Integer;
                                         PuntosEnFFT: Integer
                                         ): Integer;

function Formato8Bits(Indice: Integer): TPCMFormat;
function Formato16Bits(Indice: Integer): TPCMFormat;
function FrecuenciaDeMuestreo(Formato: TPCMFormat): Integer;

implementation

// Devuelve la longitud del buffer en milisegundos.
//
// Se utiliza para calcular la longitud del buffer del Filtro de señal
// a partir de la Frecuencia de Muestreo y la cantidad de muestras que
// toma la transformada de Fourier (FFT). La longitud del Buffer se
// devuelve en milisegundos.
function LongitudDelBufferEnMilisegundos(FrecuenciaDeMuestreo: Integer;
                                         PuntosEnFFT: Integer
                                         ): Integer;
var Valor: Double;
begin
Valor := PuntosEnFFT / (FrecuenciaDeMuestreo / 1000);
Result := Trunc(Valor) + 1;
end;

// Devuelve un formato de 8 Bits a partir de un índice.
function Formato8Bits(Indice: Integer): TPCMFormat;
begin
case Indice of
     0: Result := Mono8Bit8000Hz;
     1: Result := Mono8bit11025Hz;
     2: Result := Mono8bit22050Hz;
     3: Result := Mono8bit44100Hz;
     4: Result := Mono8bit48000Hz;
     end;
end;

// Devuelve un formato de 16 Bits a partir de un índice.
function Formato16Bits(Indice: Integer): TPCMFormat;
begin
case Indice of
     0: Result := Mono16bit8000Hz;
     1: Result := Mono16bit11025Hz;
     2: Result := Mono16bit22050Hz;
     3: Result := Mono16bit44100Hz;
     4: Result := Mono16bit48000Hz;
     end;
end;

// Devuelve la frecuencia de muestreo de un TPCMFormat.
function FrecuenciaDeMuestreo(Formato: TPCMFormat): Integer;
begin
case Formato of
     Mono8Bit8000Hz, Stereo8bit8000Hz,
     Mono16bit8000Hz, Stereo16bit8000Hz: Result := 8000;

     Mono8bit11025Hz, Stereo8bit11025Hz,
     Mono16bit11025Hz, Stereo16bit11025Hz: Result := 11025;

     Mono8bit22050Hz, Stereo8bit22050Hz,
     Mono16bit22050Hz, Stereo16bit22050Hz: Result := 22050;

     Mono8bit44100Hz, Stereo8bit44100Hz,
     Mono16bit44100Hz, Stereo16bit44100Hz: Result := 44100;

     Mono8bit48000Hz, Stereo8bit48000Hz,
     Mono16bit48000Hz, Stereo16bit48000Hz: Result := 48000;
     end;
end;

end.
