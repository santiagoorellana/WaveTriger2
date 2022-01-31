object FormUtilizacion: TFormUtilizacion
  Left = 670
  Top = 113
  Width = 537
  Height = 522
  Caption = 'Utilizacion'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 529
    Height = 491
    Align = alClient
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'WaveTriger 2.0'
      ''
      
        'Esta herramienta permite grabar en un fichero WAV el audio que s' +
        'e captura con la '
      
        'tarjeta de sonido del PC. La captura se puede hacer hasta 44100 ' +
        'muestras por '
      
        'segundo y con una resoluci'#243'n de hasta 16 bits. Los ficheros de a' +
        'udio se guardan con '
      
        'un nombre compuesto por la fecha y hora en que se inici'#243' la grab' +
        'aci'#243'n, de la '
      
        'siguiente forma: A'#241'o-Mes-D'#237'a_Hora-Minuto-Segundo. Se pueden grab' +
        'ar se'#241'ales de '
      'audio en el rango de 0 a 22 Khz.'
      ''
      
        'La carpeta en la que se guardan los ficheros, puede ser seleccio' +
        'nada por el usuario. '
      'La grabaci'#243'n se puede realizar de las siguientes formas:'
      ''
      'Manual'
      'El usuario inicia y detiene la grabaci'#243'n a voluntad.'
      ''
      'Por cruce de umbral'
      
        'El usuario establece un umbral que al ser sobrepasado por el esp' +
        'ectro, se inicia el '
      'proceso de grabaci'#243'n de forma autom'#225'tica.'
      
        'Se puede realizar con dos tipos de umbrales, que son: Umbral lin' +
        'eal y Umbral '
      'Espectral.'
      
        'El par'#225'metro inercia de grabaci'#243'n permite ajustar la demora entr' +
        'e la desaparici'#243'n de '
      
        'la se'#241'al de audio que se est'#225' grabando y el fin de la grabaci'#243'n.' +
        ' '
      ''
      
        'Cuando la se'#241'al de audio satura la entrada de la tarjeta de audi' +
        'o de la computadora, '
      
        'el programa muestra una alerta visual para indicarle al usuario ' +
        'lo ocurrido. El usuario '
      
        'debe entonces disminuir la ganacia de audio (Volumen) en la entr' +
        'ada.'
      '')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WantReturns = False
    WantTabs = True
  end
  object ActionList1: TActionList
    Left = 8
    Top = 16
    object ActionCerrar: TAction
      Caption = 'ActionCerrar'
      ShortCut = 27
      OnExecute = ActionCerrarExecute
    end
  end
end
