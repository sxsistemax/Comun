unit uCapturaDevolucion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, JvComponent, JvEnterTab, Mask,
  DBCtrls, DB;

type
  TfmCapturaDevolucion = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    Label1: TLabel;
    Label2: TLabel;
    Cantidad: TEdit;
    DataSource1: TDataSource;
    Localidad: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FIdMovimiento : integer;
    procedure CargarLocalidad;
  end;

var
  fmCapturaDevolucion: TfmCapturaDevolucion;

  procedure CapturaDevolucion( AIdMovimiento : integer);

implementation

uses uDatos;

{$R *.dfm}

procedure CapturaDevolucion( AIdMovimiento : integer);
begin
  with TfmCapturaDevolucion.Create(Application) do
  begin
    FIdMovimiento := AIdMovimiento;
    CargarLocalidad;
    ShowModal;
    Free;
  end;
end;

procedure TfmCapturaDevolucion.FormCreate(Sender: TObject);
begin
  with dmEstadio do
  begin
    tbMovimientoBoletasD.Open;
    tbInventarioBoletas.Open;
    tbLocalidades.Open;
  end;
end;

procedure TfmCapturaDevolucion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dmEstadio do
  begin
    tbMovimientoBoletasD.Close;
    tbInventarioBoletas.Close;
    tbLocalidades.Close;
  end;
end;

procedure TfmCapturaDevolucion.BitBtn1Click(Sender: TObject);
begin
  with dmEstadio do
  begin
    if (Trim( Cantidad.Text) <> '') then
    begin
      if StrToInt(Trim( Cantidad.Text)) <= tbMovimientoBoletasDBoletasEntregadas.Value then
      begin
        try
          tbMovimientoBoletasD.Edit;
          tbMovimientoBoletasDBoletasDevueltas.Value := StrToInt( Trim( Cantidad.Text));
          tbMovimientoBoletasD.Post;
        except
        end;
        Close;
        ModalResult := mrOk;
      end
      else
      begin
        ShowMessage( 'La cantidad a devolver no puede ser mayor a ' +
          tbMovimientoBoletasDBoletasEntregadas.AsString +
          ' que fué la cantidad entregada en esta planilla');  
      end;
    end;
  end;
end;

procedure TfmCapturaDevolucion.CargarLocalidad;
begin
  try
    with dmEstadio do
    begin
      if tbMovimientoBoletasD.Locate('IdMovimientoBoletasD', IntToStr( FIdMovimiento), []) then
      begin
        Cantidad.Text  := tbMovimientoBoletasDBoletasDevueltas.AsString;
      end;
    end;
  except
  end;
end;

end.
