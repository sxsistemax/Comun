unit MantenimientoSPA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, Grids, DBGrids, StdCtrls, Buttons, DBCtrls, ComCtrls, Mask, DbTables,
  JvComponent, JvEnterTab,  dbisamtb, JvExControls, JvComponentBase,
  JvExStdCtrls, JvEdit, JvDBSearchEdit;

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
    pBusqueda: TPanel;
    Label13: TLabel;
    JvEnterAsTab1: TJvEnterAsTab;
    Panel4: TPanel;
    cbCampoBusqueda: TComboBox;
    cbFiltroConsulta: TComboBox;
    btSeleccionar: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    eBuscar: TJvDBSearchEdit;
    procedure btCerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBNavigator1BeforeAction(Sender: TObject;
      Button: TNavigateBtn);
    procedure btAceptarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PonerFiltro; virtual;
    procedure AbrirOtrosArchivos; virtual;
    procedure CerrarOtrosArchivos; virtual;
    procedure ConectarMaestroDetalle; virtual;
    procedure CargarCamposBusqueda; virtual;
    procedure CargarCamposFiltro; virtual;
    function  ValorFiltro : string; virtual;
    procedure OcultarCamposGrid; virtual;
    function Validar : boolean; virtual;
    procedure cbCampoBusquedaChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure cbFiltroConsultaChange(Sender: TObject);
    procedure dgGridDblClick(Sender: TObject);
    procedure btSeleccionarClick(Sender: TObject);
    procedure dgGridCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    FFiltro : string;
    FdsConsulta   : TDataSource;
    FConsulta     : TDBISAMQuery;
    FCampoClave   : string;
    FCampoFiltro  : string;
    FFiltroString : boolean;
    FSeleccionar  : boolean;
    FValorSeleccionado : string;
    FDejarAbierto : boolean;
    procedure PrProcesarBoton(mBoton: TNavigateBtn);
    class Procedure prMantenimiento( ATabla : tDataSet; ACampoClave : string);
    class Procedure prMantenimientoMDI( ATabla : tDataSet);
    class function Seleccionar( ATabla : TDataSet; ADejarAbierto : boolean; ACampoClave : string) : string;
    function prAplicarCambios( ADataSet: TDataSet; AAplicar: Boolean): Boolean;
    procedure EjecutarConsulta;
    procedure LocalizarRegistro;
    procedure EjecutarSeleccion;
  end;

implementation



{$R *.DFM}

procedure TfmBaseMantenimiento.btCerrarClick(Sender: TObject);
begin
  dsDataSource.DataSet.Filtered := false;
  dsDataSource.DataSet.Filter := '';
  PrProcesarBoton( nbCancel);
  Close;
end;

procedure TfmBaseMantenimiento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // quitar filtro
  if FDejarAbierto then
  begin
    CerrarOtrosArchivos;
    dsDataSource.DataSet.Filter := '';
    dsDataSource.DataSet.Filtered := False;
    dsDataSource.DataSet.Close;
  end;
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
var
  lRegresarAConsulta : boolean;
Begin
  lRegresarAConsulta := false;
  Case MBoton Of
    nbPost   : Begin
                 if Validar then
                 begin
                   lRegresarAConsulta := prAplicarCambios( dsDataSource.DataSet, True );
                   if lRegresarAConsulta then
                      EjecutarConsulta;
                 End
                 else
                   lRegresarAConsulta := false;
               End;
    nbCancel : Begin
                 lRegresarAConsulta := PrAplicarCambios( dsDataSource.DataSet, False );
               End;
  End;
  if lRegresarAConsulta then
  begin
    btAceptar.Enabled       := False;
    btCancelar.Enabled      := False;
    btCerrar.Enabled        := True;
    PageControl1.ActivePage := tsListado;
    tsListado.TabVisible    := True;
    DBNavigator1.Enabled    := True;
  end;
End;


procedure TfmBaseMantenimiento.btAceptarClick(Sender: TObject);
begin
  PrProcesarBoton( nbPost);
end;

procedure TfmBaseMantenimiento.btCancelarClick(Sender: TObject);
begin
  PrProcesarBoton( nbCancel);
end;

class procedure TfmBaseMantenimiento.prMantenimiento(ATabla: tDataSet; ACampoClave : string);
begin
  With Create( application) Do
  Begin
    FSeleccionar  := false;
    FCampoClave := ACampoClave;
    dsDataSource.DataSet := ATabla;
    PonerFiltro;
    ConectarMaestroDetalle;
    if not dsDataSource.DataSet.Active then
      dsDataSource.DataSet.Open;
    CargarCamposFiltro;
    CargarCamposBusqueda;
    EjecutarConsulta;
    AbrirOtrosArchivos;
    OcultarCamposGrid;
    ShowModal;
  End;
end;

class function TfmBaseMantenimiento.Seleccionar(ATabla: TDataSet; ADejarAbierto : boolean; ACampoClave : string): string;
begin
  With Create( application) Do
  Begin
    FDejarAbierto := False;
    FSeleccionar  := True;
    FCampoClave   := ACampoClave;
    btSeleccionar.Visible := True;
    dsDataSource.DataSet := ATabla;
    PonerFiltro;
    ConectarMaestroDetalle;
    dsDataSource.DataSet.Open;
    CargarCamposFiltro;
    CargarCamposBusqueda;
    EjecutarConsulta;
    AbrirOtrosArchivos;
    ShowModal;
    Result := FValorSeleccionado;
  End;
end;

function TfmBaseMantenimiento.prAplicarCambios(ADataSet: TDataSet;
  AAplicar: Boolean) : Boolean;
begin
  Result := False;
  with TTable( ADataSet) do
  begin
    if (State in dsEditModes) or UpdatesPending then
    begin
      if AAplicar then
        try
          Post;
          Result := True
        except on E: Exception do
          ShowMessage( 'No se pudo actualizar la informción en el archivo. ' + E.Message);
        end
      else
      begin
        Cancel;
        Result := true;
      end;
    end;
  end;
end;

procedure TfmBaseMantenimiento.FormCreate(Sender: TObject);
begin
  FValorSeleccionado := '';
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

procedure TfmBaseMantenimiento.PonerFiltro;
begin
  if FFiltro <> '' then
  begin
    dsDataSource.DataSet.Filtered := false;
    dsDataSource.DataSet.Filter := FFiltro;
    dsDataSource.DataSet.Filtered := True;
  end;
end;

procedure TfmBaseMantenimiento.ConectarMaestroDetalle;
begin
  // Utilizado para conectar encabezado detalle
end;

function TfmBaseMantenimiento.Validar: boolean;
begin
  Result := true;
end;

procedure TfmBaseMantenimiento.CargarCamposBusqueda;
begin
  // Sirve para cargar los campos que se utilizaran en la busqueda
  // en el mantenimiento se debe llenar el combo box con la lista de los campos
  // y en la propiedad text se debe poner el campo por defecto
  // luego busca si tiene algun item y muestra el panel de busqueda
  if cbCampoBusqueda.Items.Count > 0 then
  begin
    pBusqueda.Visible := true;
    DBNavigator1.VisibleButtons := [nbInsert, nbEdit, nbDelete];
  end
  else
    pBusqueda.Visible := false;
end;


procedure TfmBaseMantenimiento.EjecutarConsulta;
var
  s : string;
  i : integer;
begin
  if cbCampoBusqueda.Items.Count > 0 then
  begin
    if cbCampoBusqueda.ItemIndex > 0 then
      eBuscar.DataField := cbCampoBusqueda.Items[cbCampoBusqueda.ItemIndex]
    else
      eBuscar.DataField := FCampoClave;
  end;
end;


procedure TfmBaseMantenimiento.cbCampoBusquedaChange(Sender: TObject);
begin
  EjecutarConsulta;
  eBuscar.SetFocus;
end;

procedure TfmBaseMantenimiento.PageControl1Change(Sender: TObject);
begin
  LocalizarRegistro;
end;

procedure TfmBaseMantenimiento.LocalizarRegistro;
begin
  if cbCampoBusqueda.Items.Count > 0 then
  begin
    if PageControl1.ActivePage = tsRegistro then
    begin
      TTable( dsDataSource.DataSet).Locate(FCampoClave, FConsulta.FieldValues[FCampoClave], []);
    end;
  end;
end;

procedure TfmBaseMantenimiento.OcultarCamposGrid;
begin
// Implementar en el desendente para ocultar los campos en el grid
end;

procedure TfmBaseMantenimiento.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button in [nbEdit, nbDelete] then
  begin
    LocalizarRegistro;
    if Button in [nbEdit] then
     dsDataSource.DataSet.Edit;
  end;  
end;

procedure TfmBaseMantenimiento.CargarCamposFiltro;
begin
  //escribir este procedimiento para cargar los valores del combobox del filtro
  cbFiltroConsulta.Visible := cbFiltroConsulta.Items.Count > 0;
end;

procedure TfmBaseMantenimiento.cbFiltroConsultaChange(Sender: TObject);
begin
  EjecutarConsulta;
end;

function TfmBaseMantenimiento.ValorFiltro: string;
begin
  Result := '';
end;

procedure TfmBaseMantenimiento.dgGridDblClick(Sender: TObject);
begin
  EjecutarSeleccion;
end;

procedure TfmBaseMantenimiento.EjecutarSeleccion;
begin
  if FSeleccionar then
  begin
    FValorSeleccionado := dgGrid.DataSource.DataSet.FieldValues[ FCampoClave];
    dsDataSource.DataSet.Locate(FCampoClave, FValorSeleccionado, []);
    Close;
    ModalResult := mrOk;
  end
  else
  begin
    PageControl1.ActivePage := tsRegistro;
  end;
end;

procedure TfmBaseMantenimiento.btSeleccionarClick(Sender: TObject);
begin
  EjecutarSeleccion;
end;

procedure TfmBaseMantenimiento.dgGridCellClick(Column: TColumn);
begin
  LocalizarRegistro;
end;

procedure TfmBaseMantenimiento.AbrirOtrosArchivos;
begin
  // Se debe definir para abrir otros archivos que tengan que utilizar en el 
  // mantenimiento
end;

procedure TfmBaseMantenimiento.CerrarOtrosArchivos;
begin
  // Se debe escribir para cerrar los archivos abiertos en abrir otros archivos
end;

end.
