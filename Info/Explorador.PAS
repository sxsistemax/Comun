{ ********************************************************************* }
{                                                                       }
{ Vision Tecnologica S.A.                                               }
{                                                                       }
{ Unidad      : Explorador                                            }
{ Sistema     : InfoPresupuesto                                           }
{ Fecha       : 30/01/2001                                                }
{ Hora        : 07:39:39 p.m.                                                }
{                                                                       }
{ ********************************************************************* }

(* Descripcion :
*)

Unit Explorador;

{MMWIN:ENDEXPAND}

interface

uses
  SysUtils, Windows, Messages, Classes;

type
  TExplorador = class (TObject)
    constructor Create;
    destructor Destroy; override;
  private
    FClave: string;
  protected
    constructor CreateInstance;
    class function AccessInstance(Request: Integer): TExplorador;
  public
    procedure ArmarLista;
    class function Instance: TExplorador;
    class procedure ReleaseInstance;
    function Seleccionar: OLEVariant;
    procedure SetClave(const Value: string);
    property Clave: string read FClave write SetClave;
  end;
  

procedure Register;

implementation

 Uses Explorar;

procedure Register;
begin
end;

{
************************************** TExplorador ***************************************
}
constructor TExplorador.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TExplorador.CreateInstance;
begin
  inherited Create;
end;

destructor TExplorador.Destroy;
begin
  if AccessInstance(0) = Self then AccessInstance(2);
  inherited Destroy;
end;

class function TExplorador.AccessInstance(Request: Integer): TExplorador;
  
  const FInstance: TExplorador = nil;
  
begin
  case Request of
    0 : ;
    1 : if not Assigned(FInstance) then FInstance := CreateInstance;
    2 : FInstance := nil;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance', [Request]);
  end;
  Result := FInstance;
end;

procedure TExplorador.ArmarLista;
begin
end;

class function TExplorador.Instance: TExplorador;
begin
  Result := AccessInstance(1);
end;

class procedure TExplorador.ReleaseInstance;
begin
  AccessInstance(0).Free;
end;

function TExplorador.Seleccionar: OLEVariant;
begin
  Result := fnExplorar( 'Software\' + FClave + '\Estado');
end;

procedure TExplorador.SetClave(const Value: string);
begin
  FClave := Value;
end;


initialization
end.
