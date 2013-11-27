unit uInformacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JvComputerInfoEx, JvComponentBase, JvSerialMaker,
  Buttons, JvCipher;

type
  TfrInformacion = class(TForm)
    Panel1: TPanel;
    JvComputerInfoEx1: TJvComputerInfoEx;
    Label1: TLabel;
    eCodigoActivacion: TEdit;
    Label2: TLabel;
    eUsuario: TEdit;
    mInstrucciones: TMemo;
    bCerrar: TBitBtn;
    NumeroSerial: TJvSerialMaker;
    Cifrar: TJvVigenereCipher;
    Label3: TLabel;
    procedure bCerrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FIdApliacion : integer;
    FRegistrado  : boolean;
    FMensaje     : String;
    Function CalcularSerial : Integer;
    Procedure CargarRegistro;
  end;

var
  frInformacion: TfrInformacion;

function Informacion( AIdAplicacion : integer; AMensaje : widestring) : Boolean;
Function ConsultarActivado( AIdAplicacion : integer) : Boolean;

implementation

{$R *.dfm}

Function ConsultarActivado( AIdAplicacion : integer) : Boolean;
begin
  With TfrInformacion.Create( Application) do
  begin
    FIdApliacion := AIdAplicacion;
    eCodigoActivacion.Text := IntToStr( CalcularSerial);
    CargarRegistro;
    Result := FRegistrado;
    Free;
  end;
end;

function Informacion( AIdAplicacion : integer; AMensaje : widestring) : Boolean;
begin
  With TfrInformacion.Create( Application) do
  begin
    FIdApliacion := AIdAplicacion;
    eCodigoActivacion.Text := IntToStr( CalcularSerial);
    FMensaje := AMensaje;
    mInstrucciones.Lines.Add(FMensaje);
    CargarRegistro;
    if Not FRegistrado then
    begin
      mInstrucciones.Visible := True;
    end;
    ShowModal;
    Result := FRegistrado;
    Free;
  end;
end;

procedure TfrInformacion.bCerrarClick(Sender: TObject);
begin
  Close;
end;

Function TfrInformacion.CalcularSerial : Integer;
var
  S : string;
  i : integer;
  c : char;
  serial : integer;
begin
  serial := 0;
  S := JvComputerInfoEx1.Misc.HardwareProfile.GUID;
  for I := 1 to Length( S) do
  begin
    c := S[i];
    serial := serial + ((serial + FIdApliacion) * Ord(C));
  end;
  Result := Abs(Serial);
end;

procedure TfrInformacion.CargarRegistro;
var
  F : TextFile;
  S : string;
begin
  eCodigoActivacion.Text := IntToStr( CalcularSerial);
  if FileExists( ExtractFilePath(ParamStr(0)) + '\' + eCodigoActivacion.Text +  '.clv') then
  begin
    AssignFile( F, ExtractFilePath(ParamStr(0)) + '\' + eCodigoActivacion.Text +  '.clv');
    Reset( f);
    ReadLn( F, S);
    if S <> eCodigoActivacion.Text then
    begin
      ShowMessage('Esta es una copia no autorizada.');
      exit;
    end;

    ReadLn( F, S);
    eUsuario.Text := S;

    ReadLn( F, S);
    NumeroSerial.UserName := eUsuario.Text;
    NumeroSerial.Base     := StrToInt(eCodigoActivacion.Text);
    Cifrar.Key            := eCodigoActivacion.Text;
    Cifrar.Encoded        := S;

    if NumeroSerial.Serial = Cifrar.Decoded then
    Begin
      FRegistrado := true;
    End;
  end
  else
    FRegistrado := False;
end;

end.
