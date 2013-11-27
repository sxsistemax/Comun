unit Config;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, ComCtrls, Info, InfoApl, StdCtrls, Grids;

type
  TfmInfoConfig = class(TForm)
    tvCompanias: TTreeView;
    Splitter1: TSplitter;
    pnParametros: TPanel;
    Panel2: TPanel;
    btNuevo: TSpeedButton;
    btAceptar: TSpeedButton;
    btCancelar: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Bevel1: TBevel;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    sgParametros: TStringGrid;
    edCodigo: TEdit;
    edNombre: TEdit;
    cbModulo: TComboBox;
    btBorrar: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Bevel2: TBevel;
    btLogSQL: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure tvCompaniasChange(Sender: TObject; Node: TTreeNode);
    procedure sgParametrosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgParametrosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SpeedButton4Click(Sender: TObject);
    procedure edCodigoChange(Sender: TObject);
    procedure sgParametrosSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure btNuevoClick(Sender: TObject);
    procedure btAceptarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btBorrarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    FEditando: Boolean;
    FNuevo   : Boolean;
    procedure SetEditando(const Value: Boolean);
    procedure SetNuevo(const Value: Boolean);
    procedure InicioCambio;
    procedure FinCambio;
  private
    { Private declarations }
    FParticular : TNotifyEvent;
    FAplicacion : TAplicacionInfo;
    procedure CargarCompanias;
    procedure MostrarCompania;
    procedure GrabarCompania;
    property Editando : Boolean read FEditando write SetEditando;
    property Nuevo : Boolean read FNuevo write SetNuevo;
  public
    { Public declarations }
    class procedure Mostrar( Aplicacion: TAplicacionInfo; AParticular : TNotifyEvent );
  end;

var
  fmInfoConfig: TfmInfoConfig;

implementation

{$R *.DFM}

 Uses Companias, Modulos;

{ TForm1 }

procedure TfmInfoConfig.CargarCompanias;
var
 i : Integer;
 M : TModulo;

 procedure InsertarCia( Cia : TCompania );
 var
  j : Integer;
 begin
  with tvCompanias do
      for j := 0 to Items.Count - 1  do
      begin
          if Items[j].Data = Cia.Modulo then
             Items.AddChildObject(Items[j],Cia.Codigo,Cia); 
      end;

 end;

begin
 with tvCompanias do
 begin
     Items.Clear;
     for i := 0 to TModulos.Instance.Count - 1 do
     begin
         M := TModulo(TModulos.Instance.Objects[i]);
         Items.AddChildObject(nil,M.Nombre,M);
     end;

     for i := 0 to TCompanias.Instance.Count - 1 do
         InsertarCia(TCompania(TCompanias.Instance.Objects[i]));
 end;

 cbModulo.Items.Clear;
 TModulos.Instance.GetNames( cbModulo.Items );
end;

procedure TfmInfoConfig.FormCreate(Sender: TObject);
begin
 CargarCompanias;
 btLogSQL.Down := Info.LogSQL;
end;

class procedure TfmInfoConfig.Mostrar(Aplicacion: TAplicacionInfo; AParticular: TNotifyEvent);
begin
 with Create(Application) do
 begin
      FParticular := AParticular;
      FAplicacion := Aplicacion;
      ShowModal;
      Info.LogSQL := btLogSQL.Down;
      Free;
 end;
end;

procedure TfmInfoConfig.MostrarCompania;
var
 i : Integer;
begin
 InicioCambio;
 pnParametros.Visible := True;

 with TCompania(tvCompanias.Selected.Data) do
 begin
      edCodigo.Text := Codigo;
      edNombre.Text := Nombre;
//      cbModulo.Text := Modulo.Nombre;
      for i := 0 to cbModulo.Items.Count - 1 do
          if cbModulo.Items[i] = Modulo.Nombre then
          begin
             cbModulo.ItemIndex := i;
             break;
          end;

//      sgParametros.Clear;
      sgParametros.RowCount := Parametros.Count + 1;
      sgParametros.Cells[0,0] := 'Parámetro';
      sgParametros.Cells[1,0] := 'Valor';
      for i := 0 to Parametros.Count - 1 do
      begin
          sgParametros.Cells[0,i+1] := Parametros.Names[i];
          sgParametros.Cells[1,i+1] := Parametros.Values[Parametros.Names[i]];
      end;
      sgParametros.Row := 1;
      sgParametros.Col := 1;
 end;
 FinCambio;
end;

procedure TfmInfoConfig.tvCompaniasChange(Sender: TObject;
  Node: TTreeNode);
begin
 if Assigned(tvCompanias.Selected.Parent) then
 begin
    MostrarCompania;
    btBorrar.Enabled := True;
 end
 else
 begin
    pnParametros.Visible := False;
    btBorrar.Enabled     := False;
 end;
end;

procedure TfmInfoConfig.sgParametrosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
 CanSelect := ACol <> 0;
end;

procedure TfmInfoConfig.sgParametrosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with Sender as TStringGrid do
  begin
    if (ACol = 0) and (ARow<>0) then
    begin
       Canvas.Font.Style := [fsBold];
       Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, Cells[ACol, ARow]);
    end;
  end;
end;

procedure TfmInfoConfig.SpeedButton4Click(Sender: TObject);
begin
 if Assigned(FParticular) then
    FParticular(FAplicacion);
end;

procedure TfmInfoConfig.SetEditando(const Value: Boolean);
begin
  FEditando := Value;
  btAceptar.Enabled := Value;
  btCancelar.Enabled := Value;
  if Not Value then
     Nuevo := False;
end;

procedure TfmInfoConfig.GrabarCompania;
var
 i   : Integer;
 Cia : TCompania;
begin
// Cia := TCompania(tvCompanias.Selected.Data);
 if not Nuevo then
    TCompanias.Instance.DeleteObject( tvCompanias.Selected.Text );

 Cia := TCompania.Create( cbModulo.Text, edCodigo.Text, edNombre.Text,
                          'db'+edCodigo.Text );
 for i := 1 to sgParametros.RowCount do
 begin
     Cia.Parametros.Values[sgParametros.Cells[0,i]] := sgParametros.Cells[1,i];
 end;
 TCompanias.Instance.Insertar(Cia);
 TCompanias.Instance.Grabar;
 CargarCompanias;
end;

procedure TfmInfoConfig.edCodigoChange(Sender: TObject);
begin
 Editando := True;
end;

procedure TfmInfoConfig.sgParametrosSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
 Editando := True;
end;

procedure TfmInfoConfig.SetNuevo(const Value: Boolean);
begin
 FNuevo           := Value;
 cbModulo.Enabled := Value;
 btNuevo.Down     := Value;

 InicioCambio;
 
 pnParametros.Visible := True;
  sgParametros.RowCount := 5;
  sgParametros.Cells[0,0] := 'Parámetro';
  sgParametros.Cells[1,0] := 'Valor';

      sgParametros.Cells[0,1] := 'SERVER NAME';
      sgParametros.Cells[0,2] := 'DATABASE NAME';
      sgParametros.Cells[0,3] := 'USER NAME';
      sgParametros.Cells[0,4] := 'PASSWORD';

  sgParametros.Row := 1;
  sgParametros.Col := 1;
 FinCambio;
end;

procedure TfmInfoConfig.btNuevoClick(Sender: TObject);
begin
  edCodigo.Text := '';
  edNombre.Text := '';
//  cbModulo.ItemIndex := -1;

 Editando := True;
 Nuevo    := True;
end;

procedure TfmInfoConfig.btAceptarClick(Sender: TObject);
begin
 GrabarCompania;
 Editando := False;
end;

procedure TfmInfoConfig.btCancelarClick(Sender: TObject);
begin
 Editando := False;
 CargarCompanias;
end;

procedure TfmInfoConfig.FinCambio;
begin
  edCodigo.OnChange := edCodigoChange;
  edNombre.OnChange := edCodigoChange;
  sgParametros.OnSetEditText := sgParametrosSetEditText;
end;

procedure TfmInfoConfig.InicioCambio;
begin
  edCodigo.OnChange := nil;
  edNombre.OnChange := nil;
  sgParametros.OnSetEditText := nil;
end;

procedure TfmInfoConfig.btBorrarClick(Sender: TObject);
begin
 if MessageDlg('¿Está seguro de eliminar la Compañía '+tvCompanias.Selected.Text + '?',
               mtConfirmation, [mbYes,mbNo],0) = mrYes then
 begin
    TCompanias.Instance.Eliminar(tvCompanias.Selected.Text);
    TCompanias.Instance.Grabar;
    CargarCompanias;
 end;
end;

procedure TfmInfoConfig.SpeedButton1Click(Sender: TObject);
var
 Buff : Array[0..MAX_PATH] of char;
begin
// TfmLogView.Mostrar( FAplicacion.LogFile );
  if FileExists( FAplicacion.LogFile ) then
  begin
    StrPCopy(Buff, 'notepad.exe '+FAplicacion.LogFile);
    WinExec(Buff, SW_SHOW);
  end
  else
    ShowMessage('El Registro de Errores está vacio');
end;

end.
