object fmvtProgreso: TfmvtProgreso
  Left = 234
  Top = 212
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Progreso ...'
  ClientHeight = 91
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 336
    Height = 46
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object lMensaje: TLabel
      Left = 2
      Top = 2
      Width = 332
      Height = 42
      Align = alClient
      Alignment = taCenter
      AutoSize = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 63
    Width = 336
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btCancelar: TBitBtn
      Left = 184
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 0
      Kind = bkCancel
    end
    object btAyuda: TBitBtn
      Left = 261
      Top = 3
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkHelp
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 46
    Width = 336
    Height = 17
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pBar: TProgressBar
      Left = 0
      Top = 0
      Width = 336
      Height = 17
      Align = alClient
      Min = 0
      Max = 100
      TabOrder = 0
    end
  end
end
