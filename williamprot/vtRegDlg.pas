unit vtRegDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, vtProt, vtReg;

type
  TfmRegistro = class(TForm)
    edSerial: TMaskEdit;
    edClave: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    lbMachineID: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    Label8: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    Datos : TDatosProteccion;
  public
    { Public declarations }
    class function Registrar( ADatos : TDatosProteccion ) : TModalResult;
  end;

var
  fmRegistro: TfmRegistro;

implementation

 Uses Registry;

{$R *.DFM}

{ TfmRegistro }

class function TfmRegistro.Registrar( ADatos: TDatosProteccion): TModalResult;
begin
 with Create( Application ) do
      try
         lbMachineID.Caption := MachineIDStr;
         Datos               := ADatos;
         Result              := ShowModal;
         
         if Result = mrOk then
         begin
            with TRegistry.Create do
            begin
                 RootKey := HKEY_LOCAL_MACHINE;
                 OpenKey( '\SOFTWARE\Vision Tecnologica\' + Datos.HKEY, True );
                 WriteString( 'Serial', edSerial.Text );
                 WriteString( 'Clave',  edClave.Text );

                 Free;
            end;
         end;
      finally
         Free;
      end;
end;

procedure TfmRegistro.BitBtn1Click(Sender: TObject);
begin
 if ClaveCorrecta( Datos, edSerial.Text, edClave.Text ) then
    ModalResult := mrOk
 else
    ShowMessage( 'La Clave de Activacion suministrada no es correcta, por favor ' +
                 'verifiquela e intente de nuevo.' );
end;

end.
