object Form1: TForm1
  Left = 194
  Top = 106
  Width = 696
  Height = 480
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 72
    Width = 673
    Height = 377
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 144
    Top = 8
  end
  object Table1: TTable
    DatabaseName = 'Vision'
    TableName = 'Cuentas.db'
    Left = 192
    Top = 8
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    PacketRecords = 100
    Params = <>
    ProviderName = 'DataSetProvider1'
    ReadOnly = True
    Left = 248
    Top = 40
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = Query1
    Constraints = True
    Left = 248
    Top = 8
  end
  object Query1: TQuery
    DatabaseName = 'Vision'
    SQL.Strings = (
      'select * from cuentas')
    Left = 192
    Top = 40
  end
end
