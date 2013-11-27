object Form1: TForm1
  Left = 363
  Top = 151
  Width = 544
  Height = 375
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 25
    Width = 536
    Height = 323
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object BitBtn1: TBitBtn
    Left = 208
    Top = 0
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object VTIndexCombo1: TVTIndexCombo
    Left = 3
    Top = 1
    Width = 145
    Height = 21
    DataSource = DataSource1
    UseIndexDescription = False
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 288
  end
  object Table2: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    IndexName = 'PartNo'
    TableDirect = True
    TableName = 'items'
    Left = 248
    Top = 80
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Password="";User ID=Admin;Data ' +
      'Source=C:\Archivos de programa\Archivos comunes\Borland Shared\D' +
      'ata\DBDEMOS.mdb;Mode=Read;Extended Properties="";Jet OLEDB:Syste' +
      'm database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Pass' +
      'word="";Jet OLEDB:Engine Type=4;Jet OLEDB:Database Locking Mode=' +
      '0;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Tran' +
      'sactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create S' +
      'ystem Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:' +
      'Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Without Rep' +
      'lica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmRead
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 248
    Top = 40
  end
  object Table1: TTable
    DatabaseName = 'dbSIT'
    TableName = 'Hijos.DB'
    Left = 288
    Top = 80
  end
  object IBTable1: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    CachedUpdates = False
    TableName = 'CNTMOV'
    Left = 328
    Top = 80
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = 'C:\Dat\InfoContable\Roman\IbCntMul2000.gdb'
    Params.Strings = (
      'user_name=sysdba')
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 328
    Top = 40
  end
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = IBDatabase1
    Left = 360
    Top = 40
  end
end
