object FormCambiarColores: TFormCambiarColores
  Left = 745
  Top = 117
  BorderStyle = bsToolWindow
  Caption = 'Cambiar colores'
  ClientHeight = 134
  ClientWidth = 204
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    204
    134)
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 33
    Top = 7
    Width = 146
    Height = 14
    Caption = 'Color de fondo de los gr'#225'ficos'
  end
  object Label2: TLabel
    Left = 33
    Top = 28
    Width = 157
    Height = 14
    Caption = 'Color del espectro bajo el umbral'
  end
  object Label3: TLabel
    Left = 33
    Top = 48
    Width = 165
    Height = 14
    Caption = 'Color del espectro sobre el umbral'
  end
  object Label4: TLabel
    Left = 33
    Top = 69
    Width = 120
    Height = 14
    Caption = 'Color del umbral superior'
  end
  object Label5: TLabel
    Left = 33
    Top = 90
    Width = 133
    Height = 14
    Caption = 'Color del umbrales laterales'
  end
  object Panel1: TPanel
    Left = 4
    Top = 5
    Width = 24
    Height = 17
    TabOrder = 0
    OnClick = CambiarColorDe
  end
  object Panel2: TPanel
    Left = 4
    Top = 26
    Width = 24
    Height = 17
    TabOrder = 1
    OnClick = CambiarColorDe
  end
  object Panel3: TPanel
    Left = 4
    Top = 46
    Width = 24
    Height = 17
    TabOrder = 2
    OnClick = CambiarColorDe
  end
  object Panel4: TPanel
    Left = 4
    Top = 67
    Width = 24
    Height = 17
    TabOrder = 3
    OnClick = CambiarColorDe
  end
  object Button1: TButton
    Left = 4
    Top = 110
    Width = 62
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 72
    Top = 110
    Width = 62
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Aplicar'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 139
    Top = 110
    Width = 62
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Aceptar'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Panel5: TPanel
    Left = 4
    Top = 88
    Width = 24
    Height = 17
    TabOrder = 7
    OnClick = CambiarColorDe
  end
  object ActionList1: TActionList
    Left = 176
    Top = 72
    object ActionCerrar: TAction
      Caption = 'ActionCerrar'
      ShortCut = 27
      OnExecute = ActionCerrarExecute
    end
  end
end
