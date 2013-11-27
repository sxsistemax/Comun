object fmRegistro: TfmRegistro
  Left = 0
  Top = 0
  ActiveControl = eUsuario
  BorderStyle = bsDialog
  Caption = 'Registro'
  ClientHeight = 383
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 388
    Height = 97
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Por favor llene la informaci'#243'n a continuaci'#243'n y envie el archivo' +
      ' serial.ini a su proveedor.'#13#10#13#10'Por medio del correo electr'#243'nico ' +
      'se le regresar'#225' el archivo con el codigo de activaci'#243'n, copielo ' +
      'en el directorio de la aplicaci'#243'n luego inicie el programa.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Serial: TLabel
    Left = 8
    Top = 117
    Width = 26
    Height = 13
    Caption = 'Serial'
  end
  object Label2: TLabel
    Left = 8
    Top = 163
    Width = 104
    Height = 13
    Caption = 'Identificador Maquina'
  end
  object Label3: TLabel
    Left = 8
    Top = 257
    Width = 36
    Height = 13
    Caption = 'Usuario'
  end
  object Label4: TLabel
    Left = 8
    Top = 303
    Width = 88
    Height = 13
    Caption = 'Correo Electr'#243'nico'
  end
  object Label5: TLabel
    Left = 8
    Top = 209
    Width = 100
    Height = 13
    Caption = 'C'#243'digo de Activaci'#243'n'
  end
  object eSerial: TEdit
    Left = 8
    Top = 136
    Width = 145
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object eIdentificador: TEdit
    Left = 8
    Top = 182
    Width = 241
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object eUsuario: TEdit
    Left = 8
    Top = 276
    Width = 434
    Height = 21
    TabOrder = 3
  end
  object eCorreo: TEdit
    Left = 8
    Top = 320
    Width = 434
    Height = 21
    TabOrder = 4
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 350
    Width = 75
    Height = 25
    Caption = 'Guardar'
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 88
    Top = 350
    Width = 75
    Height = 25
    Caption = 'Cerrar'
    DoubleBuffered = True
    Kind = bkClose
    ParentDoubleBuffered = False
    TabOrder = 6
  end
  object eCodigoActivacion: TEdit
    Left = 8
    Top = 228
    Width = 241
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
end
