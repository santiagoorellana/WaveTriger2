///////////////////////////////////////////////////////////////////////////////
// Autor: Santiago Alejandro Orellana Pérez
// Creado: 29/06/2013
// Utilización: Se emplea para interpolar colores. pueden hacerse
//              interpolaciones de dos o más colores.
///////////////////////////////////////////////////////////////////////////////

unit UColoreadoDeGraficos;

interface

uses Graphics, Windows;

// Estos son los identificadores de las rampas de colores.
type TRampa = (rBlancoSobreNegro,
               rVerdeSobreNegro,
               rAzulSobreNegro,
               rRojoSobreNegro,
               rAguaSobreNegro,
               rBlancoSobreAzul,
               rVerdeSobreAzul,
               rAmarilloSobreAzul,
               rRojoSobreAzul,
               rAguaSobreAzul,
               rNegroAzulBlanco,
               rHieloDeFuego,
               rAlcoirisDelDia,
               rAlcoirisNocturno,
               rRojoVerdeAzul,
               rRojoPurpura,
               rAmarilloPurpura,
               rAmarilloSangriento,
               rNaranjaEnElMar,
               rHieloEnElMar,
               rHieloEnElPantano,
               rSangreEnElSol,
               rAzulEnElSol,
               rCieloSolYFuego,
               rHieloPurpura1,
               rHieloPurpura2,
               rVioletasDeSol,
               rPapelPurpura,
               rPapelConSangre,
               rPapelYCarboncillo
               );

// Estos son los nombres de las rampas de colores.

const NombresDeRampas: Array [0..29] of String = (
      'Blanco Sobre Negro',
      'Verde Sobre Negro',
      'Azul Sobre Negro',
      'Rojo Sobre Negro',
      'Agua Sobre Negro',
      'Blanco Sobre Azul',
      'Verde Sobre Azul',
      'Amarillo Sobre Azul',
      'Rojo Sobre Azul',
      'Agua Sobre Azul',
      'Negro Azul Blanco',
      'Hielo de Fuego',
      'Alcoiris del Día',
      'Alcoiris Nocturno',
      'Rojo Verde Azul',
      'Rojo Purpura',
      'Amarillo Purpura',
      'Amarillo Sangriento',
      'Naranja en el Mar',
      'Hielo en el Mar',
      'Hielo en el Pantano',
      'Sangre en el Sol',
      'Azul en el Sol',
      'Cielo Sol y Fuego',
      'Hielo Purpura1',
      'Hielo Purpura2',
      'Violetas de Sol',
      'Papel Purpura',
      'Papel con Sangre',
      'Papel y Carboncillo'
      );

// Estas son las rampas de colores que se emplean en el programa.
const BlancoSobreNegro: Array [0..1] of TColor = (clBlack, clWhite);
const VerdeSobreNegro: Array [0..1] of TColor = (clBlack, clLime);
const AzulSobreNegro: Array [0..1] of TColor = (clBlack, clBlue);
const RojoSobreNegro: Array [0..1] of TColor = (clBlack, clRed);
const AguaSobreNegro: Array [0..1] of TColor = (clBlack, clAqua);
const BlancoSobreAzul: Array [0..1] of TColor = ($00330000, clWhite);
const VerdeSobreAzul: Array [0..1] of TColor = ($00330000, clLime);
const AmarilloSobreAzul: Array [0..1] of TColor = ($00330000, clYellow);
const RojoSobreAzul: Array [0..1] of TColor = ($00330000, clRed);
const AguaSobreAzul: Array [0..1] of TColor = ($00330000, clAqua);
const NegroAzulBlanco: Array [0..2] of TColor = (clBlack, clBlue, clWhite);
const HieloDeFuego: Array [0..4] of TColor = (clBlack, clBlack, clMaroon, clRed, clWhite);
const ArcoirisDelDia: Array [0..6] of TColor = ($00330000, $00330000, clBlue, clAqua, clLime, clYellow, clRed);
const ArcoirisNocturno: Array [0..6] of TColor = (clBlack, clBlack, clBlue, clAqua, clLime, clYellow, clRed);
const RojoVerdeAzul: Array [0..3] of TColor = (clBlack, clNavy, clLime, clRed);
const RojoPurpura: Array [0..2] of TColor = (clBlack, clPurple, clRed);
const AmarilloPurpura: Array [0..3] of TColor = (clBlack, clPurple, clRed, clYellow);
const AmarilloSangriento: Array [0..3] of TColor = (clBlack, clMaroon, $000082FF, clYellow);
const NaranjaEnElMar: Array [0..2] of TColor = (clBlack, clBlue, $0000B0FF);
const HieloEnElMar: Array [0..3] of TColor = (clBlack, clBlue, clSkyBlue, clWhite);
const HieloEnElPantano: Array [0..4] of TColor = (clBlack, clOlive, clGreen, clLime, clWhite);
const SangreEnElSol: Array [0..3] of TColor = (clBlack, clOlive, clYellow, clRed);
const AzulEnElSol: Array [0..4] of TColor = (clBlack, clOlive, clYellow, clRed, clBlue);
const CieloSolYFuego: Array [0..4] of TColor = (clBlack, clMaroon, clBlue, clOlive, clYellow);
const HieloPurpura1: Array [0..2] of TColor = ($00330000, clPurple, clWhite);
const HieloPurpura2: Array [0..3] of TColor = ($00330000, clPurple, clSilver, clWhite);
const VioletasDeSol: Array [0..3] of TColor = ($00330000, clPurple, clFuchsia, clYellow);
const PapelPurpura: Array [0..2] of TColor = (clWhite, $0080C0C0, clPurple);
const PapelConSangre: Array [0..2] of TColor = (clWhite, $0080C0C0, clRed);
const PapelYCarboncillo: Array [0..2] of TColor = (clWhite, clMedGray, clBlack);


// Estas son las funciones para el trabajo con las rampas de colores.
function InterpolarrDosColores(Fraccion: Double; Color1, Color2: TColor): TColor;
function InterpolarRampa(Rampa: Array of TColor; valor: Double): TColor;
function CalcularColor(EstiloDeColoreado: TRampa; valor: Double): TColor;

implementation

// Devuelve la interpolación de dos colores.
// Entradas:
// Fraccion = Valor entre 0 y 1 que representa la posición a interpolar.
// Color1 = Color inicial de la interpolación que representa el cero.
// Color2 = Color final de la interpolación que representa el uno.
function InterpolarrDosColores(Fraccion: Double; Color1, Color2: TColor): TColor;
var complement: Double;
    R1, R2, G1, G2, B1, B2: BYTE;
begin
Fraccion := Sqr(Fraccion);

if Fraccion <= 0 then
   Result := Color1
else
   if Fraccion >= 1.0 then
      Result := Color2
   else
      begin
      R1 := GetRValue(Color1);
      G1 := GetGValue(Color1);
      B1 := GetBValue(Color1);
      R2 := GetRValue(Color2);
      G2 := GetGValue(Color2);
      B2 := GetBValue(Color2);
      complement := 1.0 - Fraccion;
      Result := RGB( Round(complement * R1 + Fraccion * R2),
                     Round(complement * G1 + Fraccion * G2),
                     Round(complement * B1 + Fraccion * B2));
      end
end;


// Devuelve la interpolación de una rampa de colores.
function InterpolarRampa(Rampa: Array of TColor; valor: Double): TColor;
var p: Double;
begin
if valor > 1 then valor := 1;
p := (Length(Rampa)-1) * valor;
Result := InterpolarrDosColores(Frac(p),
                                Rampa[Trunc(p)],
                                Rampa[Trunc(p) + 1]
                                );
end;

// Devuelve un color según el estilo (Rampa) y la posición
// dle color dentro del estilo (Rampa).
function CalcularColor(EstiloDeColoreado: TRampa; valor: Double): TColor;
var RampaSeleccionada: Array of TColor;
begin
case EstiloDeColoreado of
     rBlancoSobreNegro: Result := InterpolarRampa(BlancoSobreNegro, valor);
     rVerdeSobreNegro: Result := InterpolarRampa(VerdeSobreNegro, valor);
     rAzulSobreNegro: Result := InterpolarRampa(AzulSobreNegro, valor);
     rRojoSobreNegro: Result := InterpolarRampa(RojoSobreNegro, valor);
     rAguaSobreNegro: Result := InterpolarRampa(AguaSobreNegro, valor);
     rBlancoSobreAzul: Result := InterpolarRampa(BlancoSobreAzul, valor);
     rVerdeSobreAzul: Result := InterpolarRampa(VerdeSobreAzul, valor);
     rAmarilloSobreAzul: Result := InterpolarRampa(AmarilloSobreAzul, valor);
     rRojoSobreAzul: Result := InterpolarRampa(RojoSobreAzul, valor);
     rAguaSobreAzul: Result := InterpolarRampa(AguaSobreAzul, valor);
     rNegroAzulBlanco: Result := InterpolarRampa(NegroAzulBlanco, valor);
     rHieloDeFuego: Result := InterpolarRampa(HieloDeFuego, valor);
     rAlcoirisDelDia: Result := InterpolarRampa(ArcoirisDelDia, valor);
     rAlcoirisNocturno: Result := InterpolarRampa(ArcoirisNocturno, valor);
     rRojoVerdeAzul: Result := InterpolarRampa(RojoVerdeAzul, valor);
     rRojoPurpura: Result := InterpolarRampa(RojoPurpura, valor);
     rAmarilloPurpura: Result := InterpolarRampa(AmarilloPurpura, valor);
     rAmarilloSangriento: Result := InterpolarRampa(AmarilloSangriento, valor);
     rNaranjaEnElMar: Result := InterpolarRampa(NaranjaEnElMar, valor);
     rHieloEnElMar: Result := InterpolarRampa(HieloEnElMar, valor);
     rHieloEnElPantano: Result := InterpolarRampa(HieloEnElPantano, valor);
     rSangreEnElSol: Result := InterpolarRampa(SangreEnElSol, valor);
     rAzulEnElSol: Result := InterpolarRampa(AzulEnElSol, valor);
     rCieloSolYFuego: Result := InterpolarRampa(CieloSolYFuego, valor);
     rHieloPurpura1: Result := InterpolarRampa(HieloPurpura1, valor);
     rHieloPurpura2: Result := InterpolarRampa(HieloPurpura2, valor);
     rVioletasDeSol: Result := InterpolarRampa(VioletasDeSol, valor);
     rPapelPurpura: Result := InterpolarRampa(PapelPurpura, valor);
     rPapelConSangre: Result := InterpolarRampa(PapelConSangre, valor);
     rPapelYCarboncillo: Result := InterpolarRampa(PapelYCarboncillo, valor);
     else Result := InterpolarRampa(VerdeSobreNegro, valor);
     end;
end;


end.
