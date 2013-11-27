unit vtRegDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, vtProt, vtReg, lmdctrl, lmdstdcS, ComCtrls,
  ExtCtrls;

type
  TfmRegistro = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    tsRegistro: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    lbMachineID: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    LMDSimpleLabel1: TLMDSimpleLabel;
    edSerial: TMaskEdit;
    edClave: TMaskEdit;
    nbEstado: TNotebook;
    Label14: TLabel;
    lbAplicacion: TLabel;
    lbEstado: TLabel;
    Label8: TLabel;
    lbSerial: TLabel;
    Label12: TLabel;
    lbClave: TLabel;
    pbDias: TProgressBar;
    lbExpira: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Panel1: TPanel;
    Label13: TLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    Label11: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure edSerialChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    Datos : TDatosProteccion;
    Estado : TEstadoProteccion;
    procedure CargarEstado;
  public
    { Public declarations }
    class function Registrar( ADatos : TDatosProteccion ) : TModalResult;
    class function MostrarEstado( ADatos : TDatosProteccion ) : TDatosRegistro;
  end;

var
  fmRegistro: TfmRegistro;

implementation

 Uses Registry;

{$R *.DFM}

const
 VTRG_URL = 'http://www.visiontecnologica.com/cgi-bin/vtregcgi.exe';

{ TfmRegistro }

class function TfmRegistro.Registrar( ADatos: TDatosProteccion): TModalResult;
begin
 with Create( Application ) do
      try
         lbMachineID.Caption  := MachineIDStr;
         LMDSimpleLabel1.Jump := VTRG_URL + '?MachineID=' + lbMachineID.Caption;
         Datos                := ADatos;
         Result               := ShowModal;

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
 If PageControl1.ActivePage = tsRegistro Then
 begin
   if ClaveCorrecta( Datos, edSerial.Text, edClave.Text ) then
      ModalResult := mrOk
   else
      ShowMessage( 'La Clave de Activacion suministrada no es correcta, por favor ' +
                   'verifiquela e intente de nuevo.' );
 end
 Else
   PageControl1.ActivePage := tsRegistro;
end;

procedure TfmRegistro.edSerialChange(Sender: TObject);
begin
 LMDSimpleLabel1.Jump := VTRG_URL + '?MachineID=' + lbMachineID.Caption +
                         '&Serial=' + edSerial.Text;
end;

class function TfmRegistro.MostrarEstado( ADatos: TDatosProteccion): TDatosRegistro;
begin
 with Create( Application ) do
      try
         lbMachineID.Caption  := MachineIDStr;
         LMDSimpleLabel1.Jump := VTRG_URL + '?MachineID=' + lbMachineID.Caption;
         Datos                := ADatos;

         CargarEstado;

         if ShowModal = mrOk then
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
         Result := RevisarProteccion( Datos );
      finally
         Free;
      end;
end;

procedure TfmRegistro.CargarEstado;
var
 DatosRegistro : TDatosRegistro;
begin
 DatosRegistro := RevisarProteccion( Datos );
 Estado := DatosRegistro.Estado;
 case Estado of
      epRegistrado : begin
                      lbSerial.Caption    := DatosRegistro.Serial;
                      lbClave.Caption     := DatosRegistro.Clave;
                      nbEstado.ActivePage := 'Registrado';
                     end;
      epEvaluacion : begin
                      nbEstado.ActivePage := 'Trial';
                      lbEstado.Caption    := 'NO REGISTRADO';
                      lbExpira.Caption    := 'Expira ' + FormatDateTime( 'mmmm d,yyyy',
                                                         Date + DatosRegistro.Falta );
                      pbDias.Position     := ((Datos.Tiempo - DatosRegistro.Falta)
                                              * 100) Div Datos.Tiempo;
                     end;
      epVencido    : begin
                      nbEstado.ActivePage := 'Trial';
                      lbEstado.Caption    := 'NO REGISTRADO';
                      pbDias.Position     := 100;
                      lbExpira.Caption    := 'Período de Evaluación Finalizado';
                     end;
      epViolado    : begin
                      nbEstado.ActivePage := 'Trial';
                      lbEstado.Caption    := 'NO REGISTRADO';
                      pbDias.Position     := 100;
                      lbExpira.Caption    := 'Alterado Inescrupulosamente';
                     end;
 end;
 lbAplicacion.Caption := Datos.Nombre;
end;

procedure TfmRegistro.Button1Click(Sender: TObject);
begin
 PageControl1.ActivePage := tsRegistro;
end;

end.
