object FormSeleccionarDirectorio: TFormSeleccionarDirectorio
  Left = 410
  Top = 143
  Width = 250
  Height = 320
  Caption = 'Seleccionar carpeta'
  Color = clBtnFace
  Constraints.MinHeight = 320
  Constraints.MinWidth = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  DesignSize = (
    242
    289)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 4
    Width = 215
    Height = 13
    Caption = 'Carpeta donde guardar'#225' los ficheros de audio'
  end
  object Panel1: TPanel
    Left = 1
    Top = 19
    Width = 238
    Height = 238
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      238
      238)
    object DriveComboBox1: TDriveComboBox
      Left = 4
      Top = 5
      Width = 230
      Height = 19
      Anchors = [akLeft, akTop, akRight]
      DirList = DirectoryListBox1
      TabOrder = 0
    end
    object DirectoryListBox1: TDirectoryListBox
      Left = 4
      Top = 28
      Width = 227
      Height = 203
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 16
      TabOrder = 1
    end
  end
  object Button1: TButton
    Left = 166
    Top = 261
    Width = 73
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Seleccionar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 86
    Top = 261
    Width = 73
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = Button2Click
  end
end
