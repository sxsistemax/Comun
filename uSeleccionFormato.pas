unit uSeleccionFormato;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfmSeleccionFormato = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    sbPDF: TSpeedButton;
    sbHTML: TSpeedButton;
    sbExcel: TSpeedButton;
    sbRTF: TSpeedButton;
    sbJPG: TSpeedButton;
    sbBMP: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    eNombreArchivo: TEdit;
    btAceptar: TBitBtn;
    btCancelar: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
    FFormato : Integer;
  end;

const
  kPDF   = 0;
  kExcel = 1;
  kRTF   = 2;
  kHTML  = 3;
  kJPG   = 4;
  kBMP   = 5;

var
  fmSeleccionFormato: TfmSeleccionFormato;

function SeleccionFormato( var AFormato : integer; var ANombreArchivo : string) : boolean;  

implementation

{$R *.DFM}

function SeleccionFormato( var AFormato : integer; var ANombreArchivo : string) : boolean;  
begin
  with TfmSeleccionFormato.Create( Application) do
  begin
    eNombreArchivo.Text := ANombreArchivo;
    if ShowModal = mrOk then
    begin
      if sbPDF.Down then
        AFormato := kPDF
      else
      if sbHTML.Down then
        AFormato := kHTML
      else
      if sbExcel.Down then
        AFormato := kExcel
      else
      if sbRTF.Down then
        AFormato := kRTF
      else
      if sbJPG.Down then
        AFormato := kJPG
      else
      if sbBMP.Down then
          AFormato := kBMP;
      ANombreArchivo := eNombreArchivo.Text;
      Result := True;
    end
    else
      Result := False;
    Free;
  end;
end;  


end.
