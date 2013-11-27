unit vtProgreso;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TfmvtProgreso = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pBar: TProgressBar;
    btCancelar: TBitBtn;
    lMensaje: TLabel;
    btAyuda: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmvtProgreso: TfmvtProgreso;

  procedure prProgreso( pTotal, pActual : Real; pMensaje : string);

implementation

{$R *.DFM}

procedure prProgreso( pTotal, pActual : Real; pMensaje : string);
begin
  if pTotal > 0 then
    pActual := pActual * 100 / pTotal
  else
    exit;
  try
    fmvtProgreso.Show; 
    fmvtProgreso.lMensaje.Caption := pMensaje;
  except
    fmvtProgreso := TfmvtProgreso.Create( Application);
    fmvtProgreso.lMensaje.Caption := pMensaje;
    fmvtProgreso.Show;
  end;
  if pActual >= 100 then
    fmvtProgreso.Close
  else
  begin
    fmvtProgreso.pBar.Position := Round( pActual);
    fmvtProgreso.Refresh;
  end;  
end;  
                      

end.
