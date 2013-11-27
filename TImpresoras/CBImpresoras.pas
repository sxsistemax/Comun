unit CBImpresoras;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Printers;

type
  TCBImpresoras = class(TComboBox)
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

constructor TCBImpresoras.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Items := Printer.Printers;
end;


procedure Register;
begin
  RegisterComponents('Paxar', [TCBImpresoras]);
end;

end.
