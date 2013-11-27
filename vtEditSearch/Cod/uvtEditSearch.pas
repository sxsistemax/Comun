unit uvtEditSearch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, VTEditSearch, Buttons,
  VTIndexCombo;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    VTIndexCombo1: TVTIndexCombo;
    Table1: TTable;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    s : TVTEditSearch;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  label1.Caption := s.DataField;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  s := TVTEditSearch.Create( Application);
  S.Left := 10;
  s.Top  := 10;
end;

end.
