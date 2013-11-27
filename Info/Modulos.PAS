{ ********************************************************************* }
{                                                                       }
{ Vision Tecnologica S.A.                                               }
{                                                                       }
{ Unidad      : Modulos                                                 }
{ Sistema     : InfoContable                                            }
{ Fecha       : 30/01/2001                                              }
{ Hora        : 07:39:41 p.m.                                           }
{                                                                       }
{ ********************************************************************* }

(* Descripcion :
*)

Unit Modulos;

{MMWIN:ENDEXPAND}

interface

uses
  SysUtils, Windows, Messages, Classes, ComObj, Db, Info, VTCache, VTClass;

type

  TConexionClass = class of TConexion;

  TConexion = class (TObject)
    constructor Create(ANombreDB : String); virtual;
    destructor Destroy; override;
  protected
    FNombreDB: string;
    FParametros: TStringList;
  public
    procedure Conectar; virtual; abstract;
    function EjecutarSQL(SQL: String): TDataset; virtual; abstract;
    class procedure NombreParametros(AList: TStrings); virtual; abstract;
    property NombreDB: string read FNombreDB;
    property Parametros: TStringList read FParametros;
  end;
  
  TDefArchivo = class (TObject)
    constructor Create(ANombre:String; ASQL, ACampoCodigo, ACampoNombre: String);
  private
    FCampoCodigo: string;
    FCampoNombre: string;
    FNombre: string;
    FSQL: string;
  public
    function GetDataset(AConexion: TConexion; AOrden: String): TDataset;
    function GetNombre(AConexion: TConexion; ACodigo: String): string;
    property CampoCodigo: string read FCampoCodigo;
    property CampoNombre: string read FCampoNombre;
    property Nombre: string read FNombre;
    property SQL: string read FSQL;
  end;
  
  TDefArchivos = class (TObjectFinder)
  public
    function Buscar(ANombre: String): TDefArchivo;
    procedure Insertar(ADefArchivo: TDefArchivo);
  end;
  
  TModulo = class (TObject)
    constructor Create;
    destructor Destroy; override;
  private
    FDefArchivos: TDefArchivos;
  protected
    FNombre: string;
    function GetClaseConexion: TConexionClass; virtual; abstract;
    property DefArchivos: TDefArchivos read FDefArchivos;
  public
    procedure GetArchivos(AConexion: TConexion; AStrings: TStrings); virtual;
    function GetDataset(AConexion: TConexion; AArchivo, AOrden : string): TDataset; 
        virtual;
    function GetDato(AConexion: TConexion; ACondicion : TVTCondition): TDato; virtual; 
        abstract;
    function GetNombre(AConexion: TConexion; ACondicion : TCondicionNombre): TDatoNombre; 
        virtual;
    procedure NombreParametros(AList: TStrings); virtual;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    property ClaseConexion: TConexionClass read GetClaseConexion;
    property Nombre: string read FNombre;
  end;
  
  TModulos = class (TObjectFinder)
  protected
    constructor CreateInstance;
    class function AccessInstance(Request: Integer): TModulos;
    procedure Cargar;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    function Buscar(ANombre : string): TModulo;
    procedure Eliminar(ANombre: String);
    function GetPath: string;
    procedure Insertar(AModulo: TModulo);
    class function Instance: TModulos;
    class procedure ReleaseInstance;
  end;
  

procedure Register;

implementation

uses Dialogs;

procedure Register;
begin
end;

{
************************************** TDefArchivo ***************************************
}
constructor TDefArchivo.Create(ANombre:String; ASQL, ACampoCodigo, ACampoNombre: String);
begin
  inherited Create;
  FNombre       := ANombre;
  FSQL          := ASQL;
  FCampoCodigo  := ACampoCodigo;
  FCampoNombre  := ACampoNombre;
end;

function TDefArchivo.GetDataset(AConexion: TConexion; AOrden: String): TDataset;
var
  Query: string;
begin
  if AOrden = '' then
     Query := FSQL + ' ORDER BY ' + FCampoCodigo
  else
     Query := FSQL + ' ORDER BY ' + AOrden;
  
  Result := AConexion.EjecutarSQL(Query);
end;

function TDefArchivo.GetNombre(AConexion: TConexion; ACodigo: String): string;
var
  Query: string;
  Dataset: TDataset;
begin
  Query := FSQL + ' WHERE ' + CampoCodigo + ' = ' + QuotedStr(ACodigo);
  
  Dataset := AConexion.EjecutarSQL(Query);
  
  if Dataset.FieldByName(CampoNombre).IsNull then
     Result := ''
  else
     Result := Dataset[CampoNombre];
     
end;

{
************************************** TDefArchivos **************************************
}
function TDefArchivos.Buscar(ANombre: String): TDefArchivo;
begin
  Result := TDefArchivo( FindObject(ANombre) );
end;

procedure TDefArchivos.Insertar(ADefArchivo: TDefArchivo);
begin
  AddObjectEntry( ADefArchivo.Nombre, ADefArchivo );
end;

{
**************************************** TModulo *****************************************
}
constructor TModulo.Create;
begin
  inherited Create;
  FDefArchivos := TDefArchivos.Create;
end;

destructor TModulo.Destroy;
begin
  FDefArchivos.Free;
  inherited Destroy;
end;

procedure TModulo.GetArchivos(AConexion: TConexion; AStrings: TStrings);
begin
  FDefArchivos.GetNames(AStrings);
end;

function TModulo.GetDataset(AConexion: TConexion; AArchivo, AOrden : string): TDataset;
var
  DefArchivo: TDefArchivo;
begin
  Result := nil;
  DefArchivo := DefArchivos.Buscar(AArchivo);
  if DefArchivo <> nil then
     Result := DefArchivo.GetDataset(AConexion, AOrden);
end;

function TModulo.GetNombre(AConexion: TConexion; ACondicion : TCondicionNombre): 
    TDatoNombre;
var
  DefArchivo: TDefArchivo;
begin
  Result := nil;
  DefArchivo := DefArchivos.Buscar(ACondicion.Archivo);
  if DefArchivo <> nil then
  begin
     Result := TDatoNombre.Create(ACondicion);
     Result.Nombre := DefArchivo.GetNombre(AConexion, ACondicion.Codigo);
  end;
end;

procedure TModulo.NombreParametros(AList: TStrings);
begin
  ClaseConexion.NombreParametros(AList);
end;

function TModulo.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK else Result := E_NOINTERFACE;
end;

function TModulo._AddRef: Integer;
begin
  Result := -1;
  // non-refcounted memorymanagement
end;

function TModulo._Release: Integer;
begin
  Result := -1;
  // non-refcounted memorymanagement
end;

{
**************************************** TModulos ****************************************
}
constructor TModulos.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TModulos.CreateInstance;
begin
  inherited Create;
end;

destructor TModulos.Destroy;
begin
  if AccessInstance(0) = Self then AccessInstance(2);
  inherited Destroy;
end;

class function TModulos.AccessInstance(Request: Integer): TModulos;
  
  const FInstance: TModulos = nil;
  
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

procedure TModulos.AfterConstruction;
var
  RutaDLL: string;
  sr: TSearchRec;
  i : integer;
  
  {$IFDEF USEDLL}
  type
   TGetModulo = function : TModulo; safecall;
  var
   Lib : THandle;
   GetModulo : TGetModulo;
  {$ENDIF}
  
begin
  inherited;
  {$IFDEF USEDLL}
  RutaDLL := GetPath + '\DLL\';
  i := FindFirst(RutaDLL + '\*.dll', faAnyFile, sr);
  while  i = 0 do
  begin
    Lib := LoadLibrary( PChar( RutaDLL + sr.Name) );
    if Lib <> 0 then
    begin
       @GetModulo := GetProcAddress(Lib,'GetModulo');
       Insertar( GetModulo );
    end;
    i := FindNext(sr);
  end;
  
  {$ENDIF}
end;

function TModulos.Buscar(ANombre : string): TModulo;
begin
  Result := TModulo( FindObject(ANombre) );
end;

procedure TModulos.Cargar;
begin
end;

procedure TModulos.Eliminar(ANombre: String);
begin
  DeleteObject(ANombre);
end;

function TModulos.GetPath: string;
var
  Buff: Array[0..MAX_PATH] of char ;
begin
  SetString( Result, Buff, GetModuleFileName(HInstance,Buff,SizeOf(Buff)) );
  Result := ExtractFileDir( Result);
end;

procedure TModulos.Insertar(AModulo: TModulo);
begin
  AddObjectEntry( AModulo.Nombre, AModulo );
end;

class function TModulos.Instance: TModulos;
begin
  Result := AccessInstance(1);
end;

class procedure TModulos.ReleaseInstance;
begin
  AccessInstance(0).Free;
end;

{
*************************************** TConexion ****************************************
}
constructor TConexion.Create(ANombreDB : String);
begin
  inherited Create;
  FParametros := TStringList.Create;
  FNombreDB := ANombreDB;
end;

destructor TConexion.Destroy;
begin
  FParametros.Free;
  inherited Destroy;
end;


initialization
end.
