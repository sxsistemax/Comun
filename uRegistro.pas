unit uRegistro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, OnGuard, uDatos;

type
  TfmRegistro = class(TForm)
    Label1: TLabel;
    Serial: TLabel;
    eSerial: TEdit;
    Label2: TLabel;
    eIdentificador: TEdit;
    Label3: TLabel;
    eUsuario: TEdit;
    Label4: TLabel;
    eCorreo: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label5: TLabel;
    eCodigoActivacion: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GuardarInformacion;
    procedure CargarInformacion;
  end;

var
  fmRegistro: TfmRegistro;

procedure Registro;

implementation

{$R *.dfm}

procedure Registro;
begin
  with TfmRegistro.Create(Application) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TfmRegistro.BitBtn1Click(Sender: TObject);
begin
  GuardarInformacion;
end;

procedure TfmRegistro.CargarInformacion;
var
  i : TIniFile;
begin
  i := TIniFile.Create( ExtractFilePath(ParamStr(0)) + '\Serial.INI' );
  try
    eSerial.Text := i.ReadString('ACTIVACION', 'Serial', '');
    eIdentificador.Text := format('%d',[Abs(GenerateMachineModifierPrim)]);
    eCodigoActivacion.Text := i.ReadString('ACTIVACION', 'CodigoActivacion', '');
    eUsuario.Text := i.ReadString('ACTIVACION', 'Usuario', '');
    eCorreo.Text := i.ReadString('ACTIVACION', 'Correo', '');
  except

  end;
  i.Free;
end;

procedure TfmRegistro.FormCreate(Sender: TObject);
begin
  FRegistrado := False;
  CargarInformacion;
end;

procedure TfmRegistro.GuardarInformacion;
var
  i : TIniFile;
begin
  i := TIniFile.Create( ExtractFilePath(ParamStr(0)) + '\Serial.INI' );
  try
    i.WriteString('ACTIVACION', 'Usuario', eUsuario.Text);
    i.WriteString('ACTIVACION', 'Identificador', eIdentificador.Text);
    i.WriteString('ACTIVACION', 'Correo', eCorreo.Text);
  except

  end;
  i.Free;
end;

end.
