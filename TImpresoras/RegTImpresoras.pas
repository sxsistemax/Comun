unit RegTImpresoras;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, ExtCtrls, Printers ;

type
  TImpresoras = class(TCustomComboBox)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    constructor Create(AOwner: TComponent); override;
  end;

procedure Register;

implementation


constructor TImpresoras.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  with TPrinter.Create do
  begin
    Items := Printers;
    Free;
  end;
end;

procedure Register;
begin
  RegisterComponents('Paxar', [TImpresoras]);
end;

end.
