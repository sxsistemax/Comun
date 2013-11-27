{ ********************************************************************* }
{                                                                       }
{ Vision Tecnologica S.A.                                               }
{                                                                       }
{ Unidad      : Companias                                            }
{ Sistema     : InfoPresupuesto                                           }
{ Fecha       : 31/01/2001                                                }
{ Hora        : 06:23:42 p.m.                                                }
{                                                                       }
{ ********************************************************************* }

(* Descripcion :
  Se encarga del manejo de las compañías instaladas en el Sistema Info
*)

Unit Companias;

{MMWIN:ENDEXPAND}

interface

uses
  SysUtils, Windows, Messages, Classes, Db, VTCache, VTClass, Info, Modulos;

type
  TCompania = class (TObject)
    destructor Destroy; override;
  private
    FCodigo: string;
    FConexion: TConexion;
    FModulo: TModulo;
    FNombre: string;
    FRuta: string;
  protected
    function GetParametros: TStringList;
  public
    constructor Create(ANombreModulo, ACodigo, ANombre, ARuta : String);
    procedure GetArchivos(AStrings : TStrings);
    function GetDataset(AArchivo, AOrden : string): TDataset;
    function GetDato(ACondicion : TVTCondition): TDato;
    function GetNombre(ACondicion : TCondicionNombre): TDatoNombre;
    property Codigo: string read FCodigo;
    property Conexion: TConexion read FConexion;
    property Modulo: TModulo read FModulo;
    property Nombre: string read FNombre;
    property Parametros: TStringList read GetParametros;
    property Ruta: string read FRuta;
  end;
  
  TCompanias = class (TObjectFinder)
    destructor Destroy; override;
  private
    FClave: string;
  protected
    constructor CreateInstance;
    class function AccessInstance(Request: Integer): TCompanias;
    procedure Cargar;
  public
    constructor Create;
    function Buscar(ACodigo : string): TCompania;
    procedure Eliminar(ACodigo: String);
    procedure Grabar;
    procedure Insertar(ACompania: TCompania);
    class function Instance: TCompanias;
    class procedure ReleaseInstance;
    procedure SetClave(const Value: string);
    property Clave: string read FClave write SetClave;
  end;
  

procedure Register;

implementation

 Uses Registry;

procedure Register;
begin
end;

{
*************************************** TCompania ****************************************
}
constructor TCompania.Create(ANombreModulo, ACodigo, ANombre, ARuta : String);
begin
  FCodigo := ACodigo;
  FNombre := ANombre;
  FRuta   := ARuta;
  
  FModulo   := TModulos.Instance.Buscar(ANombreModulo);
  FConexion := FModulo.ClaseConexion.Create(ARuta);
end;

destructor TCompania.Destroy;
begin
  FConexion.Free;
  inherited Destroy;
end;

procedure TCompania.GetArchivos(AStrings : TStrings);
begin
  FModulo.GetArchivos( FConexion, AStrings );
end;

function TCompania.GetDataset(AArchivo, AOrden : string): TDataset;
begin
  Result := FModulo.GetDataset(FConexion, AArchivo, AOrden);
end;

function TCompania.GetDato(ACondicion : TVTCondition): TDato;
begin
  Result := FModulo.GetDato(FConexion, ACondicion);
end;

function TCompania.GetNombre(ACondicion : TCondicionNombre): TDatoNombre;
begin
  Result := FModulo.GetNombre(FConexion, ACondicion);
end;

function TCompania.GetParametros: TStringList;
begin
  Result := Conexion.Parametros;
end;

{
*************************************** TCompanias ***************************************
}
constructor TCompanias.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TCompanias.CreateInstance;
begin
  inherited Create;
  if FClave <> '' then
    Cargar;
end;

destructor TCompanias.Destroy;
begin
  if AccessInstance(0) = Self then AccessInstance(2);
  inherited Destroy;
end;

class function TCompanias.AccessInstance(Request: Integer): TCompanias;
  
  const FInstance: TCompanias = nil;
  
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

function TCompanias.Buscar(ACodigo : string): TCompania;
begin
  Result := TCompania( FindObject(ACodigo) );
end;

procedure TCompanias.Cargar;
var
  S: TStringList;
  i: Integer;
  Modulo, Codigo, Nombre, Ruta: string;
  Temp: TCompania;
  Registro: TRegistry;
  
  procedure GetNamesAndValues( Reg : TRegistry; S : TStrings );
  var
   i : Integer;
   Temp : TStringList;
  begin
   S.Clear;
   Temp := TStringList.Create;
   Reg.GetValueNames(Temp);
   for i := 0 to Temp.Count - 1 do
   begin
       S.Values[Temp[i]] := Reg.ReadString(Temp[i]);
   end;
   Temp.Free;
  end;
  
begin
  S := TStringList.Create;
  
  Registro := TRegistry.Create;
  with Registro do
  begin
       RootKey := HKEY_LOCAL_MACHINE;
       OpenKey( 'Software\' + FClave + '\Compañias', False );
  
       GetKeyNames( S );
  
       for i := 0 to S.Count - 1 do
       begin
           if OpenKey( '\Software\' + FClave + '\Compañias\' + S[i], False ) then
           begin
               Modulo := ReadString( 'Modulo' );
               Codigo := S[i];
               Nombre := ReadString( 'Nombre' );
               Ruta   := ReadString( 'Ruta' );
  
               Temp := TCompania.Create( Modulo, Codigo, Nombre, Ruta );
               if OpenKey( 'Parametros', False ) then
                  GetNamesAndValues( Registro, Temp.Parametros );
               Insertar( Temp );
           end;
       end;
  
       Free;
  end;
  S.Free;
end;

procedure TCompanias.Eliminar(ACodigo: String);
begin
  DeleteObject(ACodigo);
end;

procedure TCompanias.Grabar;
var
  C: TCompania;
  i, j: Integer;
begin
  with TRegistry.Create do
  begin
       RootKey := HKEY_LOCAL_MACHINE;
       DeleteKey( '\Software\' + FClave + '\Compañias\' );
  
       for i := 0 to TCompanias.Instance.Count - 1 do
       begin
           C := TCompania(TCompanias.Instance.Objects[i]);
           if OpenKey( '\Software\' + FClave + '\Compañias\' + C.Codigo, True) then
           begin
               WriteString( 'Modulo', C.Modulo.Nombre );
               WriteString( 'Nombre', C.Nombre );
               WriteString( 'Ruta', C.Ruta );
  
               if OpenKey( 'Parametros', True ) then
                  for j := 0 to C.Parametros.Count-1 do
                  begin
                      WriteString( C.Parametros.Names[j],
                                   C.Parametros.Values[C.Parametros.Names[j]] );
                  end;
           end;
       end;
  
       Free;
  end;
end;

procedure TCompanias.Insertar(ACompania: TCompania);
begin
  AddObjectEntry( ACompania.Codigo, ACompania );
end;

class function TCompanias.Instance: TCompanias;
begin
  Result := AccessInstance(1);
end;

class procedure TCompanias.ReleaseInstance;
begin
  AccessInstance(0).Free;
end;

procedure TCompanias.SetClave(const Value: string);
begin
  FClave := Value;
  Cargar;
end;


initialization
end.
