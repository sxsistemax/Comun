unit VisionTecnologicaLogo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShapedForm, ExtCtrls, StdCtrls, Buttons, jpeg;

type
  TFmVisionTecnologicaLogo = class(TForm)
    dxfShapedForm1: TdxfShapedForm;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmVisionTecnologicaLogo: TFmVisionTecnologicaLogo;

implementation

{$R *.DFM}

procedure TFmVisionTecnologicaLogo.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

end.
