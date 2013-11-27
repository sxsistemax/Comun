unit MANTENIMIENTOCHISTOSO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, Grids, DBGrids, StdCtrls, Buttons, DBCtrls, ComCtrls, Mask, DbTables,
  rsEdit, dxfQuickTyp, PictureButton;

type
  TfmBaseMantenimientoChistoso = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    dsDataSource: TDataSource;
    dxfQuickTyper1: TdxfQuickTyper;
    btCerrar: TdxfPictureButton;
    btCancelar: TdxfPictureButton;
    btAceptar: TdxfPictureButton;
    Panel3: TPanel;
    Panel4: TPanel;
    PageControl1: TPageControl;
    tsListado: TTabSheet;
    dgGrid: TDBGrid;
    Panel5: TPanel;
    Label13: TLabel;
    eBuscar: TrsEdit;
    Panel6: TPanel;
    tsRegistro: TTabSheet;
    dxfPictureButton1: TdxfPictureButton;
    dxfPictureButton2: TdxfPictureButton;
    dxfPictureButton3: TdxfPictureButton;
    btAnterior: TdxfPictureButton;
    btSiguiente: TdxfPictureButton;
    btPrimero: TdxfPictureButton;
    btUltimo: TdxfPictureButton;
    DBNavigator1: TDBNavigator;
    procedure btCerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBNavigator1BeforeAction(Sender: TObject;
      Button: TNavigateBtn);
    procedure btAceptarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure eBuscarExit(Sender: TObject);
    procedure abcDBIndexCombo1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure PrProcesarBoton(mBoton: TNavigateBtn);
    { Private declarations }
  public
    { Public declarations }
    Class Procedure prMantenimiento( ATabla : tDataSet);
    Procedure prAplicarCambios( ADataSet: TDataSet; AAplicar: Boolean);
  end;

implementation



{$R *.DFM}

procedure TfmBaseMantenimientoChistoso.btCerrarClick(Sender: TObject);
begin
  PrProcesarBoton( nbCancel);
  Close;
end;

procedure TfmBaseMantenimientoChistoso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
//  dsDataSource.DataSet.IndexName := '';
end;

procedure TfmBaseMantenimientoChistoso.DBNavigator1BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
  If (Button In [nbEdit, nbInsert]) Then
  Begin
    PageControl1.ActivePage := tsRegistro;
    tsListado.TabVisible    := False;
    btAceptar.Enabled  := True;
    btCancelar.Enabled := True;
  End;
end;

Procedure TfmBaseMantenimientoChistoso.PrProcesarBoton( mBoton : TNavigateBtn);
Begin
  Case MBoton Of
    nbPost   : Begin
                 prAplicarCambios( dsDataSource.DataSet, True );
               End;  
    nbCancel : Begin
                 PrAplicarCambios( dsDataSource.DataSet, False );
               End;
  End;
  btAceptar.Enabled  := False;
  btCancelar.Enabled := False;
  PageControl1.ActivePage := tsListado;
  tsListado.TabVisible := True;
End;


procedure TfmBaseMantenimientoChistoso.btAceptarClick(Sender: TObject);
begin
  PrProcesarBoton( nbPost);
end;

procedure TfmBaseMantenimientoChistoso.btCancelarClick(Sender: TObject);
begin
  PrProcesarBoton( nbCancel);
end;

procedure TfmBaseMantenimientoChistoso.eBuscarExit(Sender: TObject);
begin
//  dsDataSource.DataSet.FindNearest([ Trim( eBuscar.Text)]);
end;

class procedure TfmBaseMantenimientoChistoso.prMantenimiento(ATabla: tDataSet);
begin
  With Create( application) Do
  Begin
    dsDataSource.DataSet := ATabla;
//    abcDBIndexCombo1.LoadItemsFromDataSet;
    ShowModal;
  End;
end;

procedure TfmBaseMantenimientoChistoso.prAplicarCambios(ADataSet: TDataSet;
  AAplicar: Boolean);
begin
  with TTable( ADataSet) do
  begin
    if (State in dsEditModes) or UpdatesPending then
    begin
      if AAplicar then
        Post
      else
        Cancel;
    end;
  end;
end;

procedure TfmBaseMantenimientoChistoso.abcDBIndexCombo1Change(Sender: TObject);
begin
  eBuscar.SetFocus;
end;

procedure TfmBaseMantenimientoChistoso.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := tsListado;
  btAceptar.Enabled  := False;
  btCancelar.Enabled := False;
end;

end.
