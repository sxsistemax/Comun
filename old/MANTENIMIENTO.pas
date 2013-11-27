unit Mantenimiento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, Grids, DBGrids, StdCtrls, Buttons, DBCtrls, ComCtrls, Mask, DbTables,
  JvComponent, JvEnterTab, JvDBIndex;

type
  TfmBaseMantenimiento = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btCerrar: TBitBtn;
    PageControl1: TPageControl;
    tsListado: TTabSheet;
    tsRegistro: TTabSheet;
    dgGrid: TDBGrid;
    DBNavigator1: TDBNavigator;
    dsDataSource: TDataSource;
    btCancelar: TBitBtn;
    btAceptar: TBitBtn;
    Panel3: TPanel;
    Label13: TLabel;
    JvEnterAsTab1: TJvEnterAsTab;
    Panel4: TPanel;
    procedure btCerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBNavigator1BeforeAction(Sender: TObject;
      Button: TNavigateBtn);
    procedure btAceptarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure eBuscarExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PonerFiltro; virtual;
    procedure ConectarMaestroDetalle; virtual;
  private
    { Private declarations }
  public
    { Public declarations }
    FFiltro : string;
    procedure PrProcesarBoton(mBoton: TNavigateBtn);
    Class Procedure prMantenimiento( ATabla : tDataSet);
    Class Procedure prMantenimientoConFiltro( ATabla : tDataSet; AFiltro : string);
    Class Procedure prMantenimientoMDI( ATabla : tDataSet);
    Procedure prAplicarCambios( ADataSet: TDataSet; AAplicar: Boolean);
  end;

implementation



{$R *.DFM}

procedure TfmBaseMantenimiento.btCerrarClick(Sender: TObject);
begin
  PrProcesarBoton( nbCancel);
  Close;
end;

procedure TfmBaseMantenimiento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // quitar filtro
  dsDataSource.DataSet.Filter := '';
  dsDataSource.DataSet.Filtered := False;
  dsDataSource.DataSet.Close;
  Action := caFree;
end;

procedure TfmBaseMantenimiento.DBNavigator1BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
  If (Button In [nbEdit, nbInsert]) Then
  Begin
    PageControl1.ActivePage := tsRegistro;
    tsListado.TabVisible    := False;
    btAceptar.Enabled       := True;
    btCancelar.Enabled      := True;
    btCerrar.Enabled        := False;
    DBNavigator1.Enabled    := False;
    if ActiveControl <> Nil then
      ActiveControl.SetFocus;
  End;
end;

Procedure TfmBaseMantenimiento.PrProcesarBoton( mBoton : TNavigateBtn);
Begin
  Case MBoton Of
    nbPost   : Begin
                 prAplicarCambios( dsDataSource.DataSet, True );
               End;  
    nbCancel : Begin
                 PrAplicarCambios( dsDataSource.DataSet, False );
               End;
  End;
  btAceptar.Enabled       := False;
  btCancelar.Enabled      := False;
  btCerrar.Enabled        := True;
  PageControl1.ActivePage := tsListado;
  tsListado.TabVisible    := True;
  DBNavigator1.Enabled    := True;
End;


procedure TfmBaseMantenimiento.btAceptarClick(Sender: TObject);
begin
  PrProcesarBoton( nbPost);
end;

procedure TfmBaseMantenimiento.btCancelarClick(Sender: TObject);
begin
  PrProcesarBoton( nbCancel);
end;

procedure TfmBaseMantenimiento.eBuscarExit(Sender: TObject);
begin
//  dsDataSource.DataSet.FindNearest([ Trim( eBuscar.Text)]);
end;

class procedure TfmBaseMantenimiento.prMantenimiento(ATabla: tDataSet);
begin
  With Create( application) Do
  Begin
    dsDataSource.DataSet := ATabla;
    PonerFiltro;
    dsDataSource.DataSet.Open;
    ConectarMaestroDetalle;
    dsDataSource.DataSet.Open;
    ShowModal;
  End;
end;

procedure TfmBaseMantenimiento.prAplicarCambios(ADataSet: TDataSet;
  AAplicar: Boolean);
begin
  with TTable( ADataSet) do
  begin
    if (State in dsEditModes) or UpdatesPending then
    begin
      if AAplicar then
      try
        Post
      except
        ShowMessage( 'No se pudo actualizar la informción en el archivo.');
      end
      else
        Cancel;
    end;
  end;
end;

procedure TfmBaseMantenimiento.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := tsListado;
end;

class procedure TfmBaseMantenimiento.prMantenimientoMDI(ATabla: tDataSet);
begin
  With Create( application) Do
  Begin
	  FormStyle := fsMDIChild;
    dsDataSource.DataSet := ATabla;
    Show;
  End;
end;


class procedure TfmBaseMantenimiento.prMantenimientoConFiltro(
  ATabla: tDataSet; AFiltro: string);
begin
  With Create( application) Do
  Begin
    dsDataSource.DataSet := ATabla;
    PonerFiltro;
    dsDataSource.DataSet.Open;
    ConectarMaestroDetalle;
    ShowModal;
  End;
end;

procedure TfmBaseMantenimiento.PonerFiltro;
begin
  if FFiltro <> '' then
  begin
    dsDataSource.DataSet.Filter := FFiltro;
    dsDataSource.DataSet.Filtered := True;
  end;  
end;

procedure TfmBaseMantenimiento.ConectarMaestroDetalle;
begin
  // Utilizado para conectar encabezado detalle
end;

end.
