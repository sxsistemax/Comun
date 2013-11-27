unit uDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, VTFilter,
  DBTables, Provider, DBClient, Grids, DBGrids, Db, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    Query1: TQuery;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FilterDlg : TVTFilter;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FilterDlg := TVTFilter.Create( Application);
  FilterDlg.DataSource := DataSource1;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  DataSource1.DataSet.Active := True;
  FilterDlg.Execute;
end;

end.
