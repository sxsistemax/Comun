unit Explorar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, Grids, DBGrids, ComCtrls, Registry, StdCtrls,
  Buttons, ImgList, lmdcompo, lmdclass, lmdnwgui, lmdctrl, lmdsplt,
  lmdcctrl, lmdformA, lmdnonvS, syncobjs, clipbrd, lmdstdcS,
  Mask, rsEdit;

type
  TfmExplorar = class(TForm)
    pnArchivos: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    edBuscar: TrsEdit;
    Panel1: TPanel;
    ImageList1: TImageList;
    LMDGlobalHotKey1: TLMDGlobalHotKey;
    Panel2: TPanel;
    btCancelar: TBitBtn;
    btSeleccionar: TBitBtn;
    LMDSplitterPane1: TLMDSplitterPane;
    LMDSplitterPane2: TLMDSplitterPane;
    LMDSplitterPanel1: TLMDSplitterPanel;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    Panel5: TPanel;
    tvCias: TTreeView;
    LMDIniCtrl1: TLMDIniCtrl;
    LMDForm1: TLMDForm;
    btSelTodos: TSpeedButton;
    dsDataSource: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btSeleccionarClick(Sender: TObject);
    procedure LMDGlobalHotKey1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCerrarClick(Sender: TObject);
    procedure edBuscarExit(Sender: TObject);
    procedure DBGrid4TitleClick(Column: TColumn);
    procedure tvCiasChange(Sender: TObject; Node: TTreeNode);
    procedure DBGrid4CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    mColumna : Integer;
    Seleccion : OleVariant;
    Codigo    : string;
    Procedure prSeleccionar;
    procedure SalvarControles( pNodo : TTreeNode);
    procedure RestaurarControles;
    procedure SeleccionarColumna;
    procedure ArmarLista;
  end;

var
  fmExplorar: TfmExplorar;

Function fnExplorar( AClave : string) : OleVariant;

implementation

{$R *.DFM}

  Uses Companias, Explorador;

var
  Clave     : string;

// Ejecuta el explorador
Function fnExplorar ( AClave : string) : OleVariant;
Begin
  Clave := AClave;
  fmExplorar  := TfmExplorar.Create( Application );
  with fmExplorar do
  begin
     // Crea la forma y la muestra
     ShowModal;
     Result := Seleccion;
     free;
  End;
End;

procedure TfmExplorar.FormCreate(Sender: TObject);
begin
  // carga los datos del registro de windows
  LMDIniCtrl1.RegPath := Clave;
  ArmarLista;
  RestaurarControles;
end;


procedure TfmExplorar.btSeleccionarClick(Sender: TObject);
begin
  // si presiona el boton de seleccionar
  prSeleccionar;
End;

procedure TfmExplorar.LMDGlobalHotKey1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  // si presiona la tecla F10
  prSeleccionar;
end;

procedure TfmExplorar.prSeleccionar;
var
  i     : integer;
begin
  // si hay algo seleccionado en el arbol
  If tvCias.Selected <> Nil Then
  Begin
    With tvCias.Selected Do
    Begin
      // si no tiene mas hijos en el arbol es un archivo y tiene archivos.
      If Not HasChildren And Assigned(Parent) and ( Data <> Nil) Then
      Begin
        if ( pnArchivos.Enabled And ( DBGrid4.SelectedRows.Count > 1)) or
           ( pnArchivos.Enabled And btSelTodos.Down) then
        begin
          if btSelTodos.Down then
          begin

            Seleccion := VarArrayCreate([1,dsDataSource.Dataset.RecordCount],varVariant);
            i := 1;
            dsDataSource.Dataset.First;
            while Not dsDataSource.Dataset.EOF do
            begin
              Seleccion[i] := dsDataSource.Dataset.Fields[0].Value;
              dsDataSource.Dataset.Next;
              Inc(i);
            end;
          end
          else
          begin
            Seleccion := VarArrayCreate([1,DBGrid4.SelectedRows.Count],varVariant);
            for i := 0 to DBGrid4.SelectedRows.Count - 1 do
            begin
              dsDataSource.Dataset.GotoBookmark(pointer(DBGrid4.SelectedRows.Items[i]));
              Seleccion[i+1] := DBGrid4.Columns[0].Field.Value;
            end;
          end;
          DBGrid4.SelectedRows.Clear;
        end
        else
          Try
            Seleccion := dsDataSource.Dataset.FieldByName( dsDataSource.Dataset.FieldDefs[0].Name).Value;
          Except
            Seleccion := '';
          End;
      End
      Else
        // si esta seleccionada la compañía retorne solo el código
        Seleccion := TCompania(Data).Codigo;
    End;
  End;

  ModalResult := mrOk;
  Close;
end;

procedure TfmExplorar.btCancelarClick(Sender: TObject);
begin
  Seleccion := '';
end;

procedure TfmExplorar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    SalvarControles( tvCias.Selected);
  except
  end;
  
 // Cierra el archivo que esta siendo usado
   Action := caFree;
end;

procedure TfmExplorar.btCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfmExplorar.edBuscarExit(Sender: TObject);
begin
  If Trim( edBuscar.Text) <> '' Then
    dsDataSource.Dataset.Locate( DBGrid4.Columns[mColumna].FieldName, edBuscar.Text, [loCaseInsensitive, loPartialKey]);
end;

procedure TfmExplorar.DBGrid4TitleClick(Column: TColumn);
Var
  mCampo : String;
  Compania : TCompania;
begin
  mCampo   := Column.FieldName;
  mColumna := Column.Index;

  try
    Compania := TCompania(tvCias.Selected.Data);
    dsDataSource.Dataset := Compania.GetDataset( tvCias.Selected.Text, mCampo);
  except
  end;

  SeleccionarColumna;
end;

procedure TfmExplorar.SalvarControles( pNodo : TTreeNode);
var
  mNodo    : String;
  mArchivo : String;
  mCodigo  : string;
begin
  mNodo    := '';
  mArchivo := '';
  mCodigo  := '';
  with LMDIniCtrl1 do
  begin
    If ( pNodo.Parent <> nil) And pnArchivos.Enabled then
    begin
      try
         mNodo    := pNodo.Parent.Text;
         mArchivo := pNodo.Text;
         try
           mCodigo  := dsDataSource.Dataset.Fields[0].Value;
         except
         end;
      except
      end;
    end
    else
      mNodo    := pNodo.Text;
    WriteString('Explorador', 'Nodo', mNodo);
    WriteString('Explorador', 'Archivo', mArchivo);
    WriteString('Explorador', 'Codigo', mCodigo);
  end;
end;

procedure TfmExplorar.RestaurarControles;
Var
  mNodo    : String;
  mArchivo : String;
  mCodigo  : String;
  NodoRaiz, NodoHijo   : TTreeNode;
begin
  with LMDIniCtrl1 do
  begin
    // Cargo los valores guardados en el archivo
    mNodo    := ReadString('Explorador', 'Nodo', '');
    mArchivo := ReadString('Explorador', 'Archivo', '');
    mCOdigo  := ReadString('Explorador', 'Codigo', '');

    // cargo el primer nodo del arbol
    NodoRaiz := tvCias.TopItem;

    // recorro el arbol hasta que encuentro el nodo o termino la lista
    while ( NodoRaiz <> nil) And ( NodoRaiz.Text <> mNodo) do
      NodoRaiz := NodoRaiz.GetNext;

    // si no es nil, lo encotro
    if NodoRaiz <> nil then
    begin
      // expando el nodo
      NodoRaiz.Expand( true);
      if trim( mArchivo) <> '' then
      begin
        // Cargo el primer hijo
        NodoHijo := NodoRaiz.getFirstChild;

        // recorro el arbol hasta que encuentro el nodo o termino la lista
        while ( NodoHijo <> nil) And ( NodoHijo.Text <> mArchivo) do
          NodoHijo := NodoHijo.GetNextChild( NodoHijo);

        // si no es nil, lo encotro
        if NodoHijo <> nil then
        begin
          tvCias.Selected := NodoHijo;
        end;
      end
      else
        tvCias.Selected := NodoRaiz;
    end;
  end;
end;

procedure TfmExplorar.SeleccionarColumna;
begin
  DBGrid3.Columns.RestoreDefaults;
  DBGrid4.Columns.RestoreDefaults;
  DBGrid3.Columns[ mColumna].Title.Color := clNavy;
  DBGrid4.Columns[ mColumna].Title.Color := clNavy;
  DBGrid3.Columns[ mColumna].Title.Font.Color := clWhite;
  DBGrid4.Columns[ mColumna].Title.Font.Color := clWhite;
  
  DBGrid4.Columns[ mColumna].Color := clAqua;
  DBGrid4.Columns[ mColumna].Title.Font.Color := clWhite;
end;

procedure TfmExplorar.ArmarLista;
var
 i, j     : Integer;
 Nodo     : TTreeNode;
 Hijo     : TTreeNode;
 Compania : TCompania;
 Archivos : TStringList;
begin
 Archivos := TStringList.Create;

 for i := 0 to TCompanias.Instance.Count - 1 do
 begin
     Compania := TCompania( TCompanias.Instance.Objects[i] );
     Nodo := tvCias.Items.AddChildObject( nil, Compania.Nombre, Compania );
     Nodo.ImageIndex := 1;
     Compania.GetArchivos(Archivos);
     for j := 0 to Archivos.Count-1 do
     begin
       Hijo := tvCias.Items.AddChildObject( Nodo, Archivos[j], Compania );
       Hijo.ImageIndex := 2;
     end;  
 end;

 Archivos.Free;
end;

procedure TfmExplorar.tvCiasChange(Sender: TObject; Node: TTreeNode);
var
 Compania : TCompania;
begin
 COdigo := '';
 if not Node.HasChildren and Assigned(Node.Parent) then
 begin
    Compania := TCompania(Node.Data);
    dsDataSource.DataSet := Compania.GetDataset(Node.Text, '');
    pnArchivos.Visible   := True;
    btSelTodos.Visible   := True;
    mColumna := 0;
    if Assigned(dsDataSource.DataSet) then
       SeleccionarColumna;
 end
 else
 begin
    dsDataSource.DataSet := nil;
    pnArchivos.Visible   := False;
    btSelTodos.Visible   := False;
 end;
end;

procedure TfmExplorar.DBGrid4CellClick(Column: TColumn);
var
  i : short;
  CodigoFinal : string;
begin
  i := GetAsyncKeyState( VK_SHIFT);
  if i <> 0 then
  begin
    CodigoFinal := dsDataSource.Dataset.Fields[0].Value;

    dsDataSource.Dataset.DisableControls;
    dsDataSource.Dataset.Locate( dsDataSource.Dataset.Fields[0].FieldName, Codigo, [loCaseInsensitive]);
    while {(Codigo = dsDataSource.Dataset.Fields[0].Value) and}
          (Codigo <= CodigoFinal) and not dsDataSource.Dataset.EOF do
    begin
      // Adicionar BookMark
      DBGrid4.SelectedRows.CurrentRowSelected := True;
      dsDataSource.Dataset.Next;
      Codigo := dsDataSource.Dataset.Fields[0].Value;
    end;
    dsDataSource.Dataset.Prior;
    dsDataSource.Dataset.EnableControls;
    Codigo := '';
  end
  else
    Codigo := dsDataSource.Dataset.Fields[0].Value;

end;

initialization
  fmExplorar := nil;
end.

