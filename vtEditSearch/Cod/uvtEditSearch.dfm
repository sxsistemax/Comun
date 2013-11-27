object Form1: TForm1
  Left = 292
  Top = 174
  Width = 690
  Height = 438
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 144
    Top = 32
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 50
    Width = 682
    Height = 361
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object VTIndexCombo1: TVTIndexCombo
    Left = 232
    Top = 26
    Width = 145
    Height = 21
    DataSource = DataSource1
    UseIndexDescription = False
    Items.Strings = (
      ''
      ''
      'ix_NombresApellidos'
      'ix_ApellidosNombres'
      'ix_TablaNombreApellido'
      'ix_GrupoNombreApellido')
  end
  object BitBtn1: TBitBtn
    Left = 208
    Top = 0
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 360
  end
  object Table1: TTable
    Active = True
    AutoCalcFields = False
    DatabaseName = 'dbSIT'
    IndexName = 'ix_ApellidosNombres'
    TableName = 'Hijos.DB'
    Left = 328
  end
end
