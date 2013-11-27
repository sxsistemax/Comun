object fmRegistro: TfmRegistro
  Left = 200
  Top = 106
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Registro del producto'
  ClientHeight = 256
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 69
    Height = 13
    Caption = 'Número Serial:'
  end
  object Label2: TLabel
    Left = 32
    Top = 48
    Width = 281
    Height = 25
    AutoSize = False
    Caption = 
      'Este número es suministrado por el proveedor del programa al adq' +
      'uirir su licencia.'
    WordWrap = True
  end
  object lbMachineID: TLabel
    Left = 200
    Top = 96
    Width = 72
    Height = 13
    Caption = 'lbMachineID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 32
    Top = 96
    Width = 115
    Height = 13
    Caption = 'Identificador de Usuario:'
  end
  object Label5: TLabel
    Left = 32
    Top = 120
    Width = 281
    Height = 33
    AutoSize = False
    Caption = 
      'Al registrar su programa en el sitio Web le será solicitado este' +
      ' número.'
    WordWrap = True
  end
  object Label6: TLabel
    Left = 32
    Top = 168
    Width = 98
    Height = 13
    Caption = 'Clave de Activación:'
  end
  object Label7: TLabel
    Left = 32
    Top = 192
    Width = 297
    Height = 25
    AutoSize = False
    Caption = 
      'La Clave de Activación es entregada al registrar su programa  en' +
      ' nuestro sitio Web.'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 32
    Top = 224
    Width = 230
    Height = 13
    Caption = 'Si aún no se ha registrado, puede hacerlo ahora.'
  end
  object LMDSimpleLabel1: TLMDSimpleLabel
    Left = 272
    Top = 224
    Width = 86
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    Caption = 'Registro en línea.'
    Jump = 'www.visiontecnologica.com'
    JumpMode = jmInternet
    Options = []
  end
  object edSerial: TMaskEdit
    Left = 200
    Top = 16
    Width = 121
    Height = 21
    EditMask = '>AAAA\-AAAA\-AAAA\-AAAA;0;_'
    MaxLength = 19
    TabOrder = 0
  end
  object edClave: TMaskEdit
    Left = 200
    Top = 160
    Width = 121
    Height = 21
    EditMask = '>AAAA\-AAAA\-AAAA\-AAAA;0;_'
    MaxLength = 19
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 360
    Top = 16
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 360
    Top = 48
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object BitBtn3: TBitBtn
    Left = 360
    Top = 80
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkHelp
  end
end
