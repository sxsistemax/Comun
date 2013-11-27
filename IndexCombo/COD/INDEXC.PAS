unit indexc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, VTIndexCombo, Grids, DBGrids, Db, DBTables, Buttons, ExtCtrls,
  DBCtrls, ADODB, IBDatabase, IBCustomDataSet, IBTable;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    Table2: TADOTable;
    ADOConnection1: TADOConnection;
    Table1: TTable;
    VTIndexCombo1: TVTIndexCombo;
    IBTable1: TIBTable;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  DataSource1.DataSet.Active := Not DataSource1.DataSet.Active;
end;

end.
