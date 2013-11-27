{ ********************************************************************* }
{                                                                       }
{ Vision Tecnologica S.A.                                               }
{                                                                       }
{ Unidad      : InfoApl                                            }
{ Sistema     : InfoPresupuesto                                           }
{ Fecha       : 07/02/2001                                                }
{ Hora        : 03:47:42 p.m.                                                }
{                                                                       }
{ ********************************************************************* }

(* Descripcion :
*)

Unit InfoApl;

{MMWIN:ENDEXPAND}

interface

uses
  SysUtils, Windows, Messages, Classes, ComObj, VTCache;

type
  TAplicacionInfo = class (TAutoObject, IServerExceptionHandler)
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  private
    FCache: TVTCache;
    function GetLogFile: string;
  protected
    function GetClave: string; virtual; abstract;
    function GetFabricante: string; virtual; abstract;
    function GetNombre: string; virtual; abstract;
  public
    procedure OnException( const ServerClass, ExceptionClass, ErrorMessage: WideString;   
        ExceptAddr: Integer; const ErrorIID, ProgID: WideString; var Handled: Integer; 
        var Result: HResult);
    procedure Recalcular; safecall;
    function Seleccionar: OLEVariant; safecall;
    function TraerNombre(Archivo: String; Compania: OleVariant; Codigo: OleVariant): 
        OLEVariant; safecall;
    property Cache: TVTCache read FCache;
    property Clave: string read GetClave;
    property Fabricante: string read GetFabricante;
    property LogFile: string read GetLogFile;
    property Nombre: string read GetNombre;
  end;
  

procedure Register;

implementation

 Uses LMDClass, LMDProcs, Info, Explorador, Companias;

procedure Register;
begin
end;

procedure InfoEscribirLog( const Msg : String);
begin
  LMDApplication.LogWrite( Msg );
end;

{
************************************ TAplicacionInfo *************************************
}
procedure TAplicacionInfo.AfterConstruction;
begin
  inherited AfterConstruction;
  ServerExceptionHandler := Self;
  FCache := TVTCache.Create;
  
  with LMDApplication do
  begin
       LogPrefix := ppFixed;
       LogName   := Self.LogFile;
       Options   := [aoLogAlwaysClear, aoLogException, aoLogHeader, aoLogTime, aoLogDate, aoLogNr];
  end;
  
  Info.LogWriter := InfoEscribirLog;
end;

procedure TAplicacionInfo.BeforeDestruction;
begin
  inherited BeforeDestruction;
  FCache.Free;
end;

function TAplicacionInfo.GetLogFile: string;
var
  Buff: Array[0..MAX_PATH] of char;
begin
  SetString( Result, Buff, GetModuleFileName(HInstance,Buff,SizeOf(Buff)) );
  Result := ChangeFileExt(Result, '.log');
end;

procedure TAplicacionInfo.OnException( const ServerClass, ExceptionClass, ErrorMessage: 
    WideString;   ExceptAddr: Integer; const ErrorIID, ProgID: WideString; var Handled: 
    Integer; var Result: HResult);
begin
  LMDApplication.LogWrite( '[EXCP] ' + ExceptionClass + ' in ' + ProgID + ': ' + ErrorMessage );
end;

procedure TAplicacionInfo.Recalcular;
begin
  FCache.Clear;
end;

function TAplicacionInfo.Seleccionar: OLEVariant;
begin
  Result := TExplorador.Instance.Seleccionar;
end;

function TAplicacionInfo.TraerNombre(Archivo: String; Compania: OleVariant; Codigo: 
    OleVariant): OLEVariant;
var
  Condicion: TCondicionNombre;
  Dato: TDatoNombre;
  Cia: TCompania;
begin
  Result := '';
  
  Condicion := TCondicionNombre.Create( Archivo, Compania, Codigo );
  
  Dato := TDatoNombre( FCache.Find( Condicion ) );
  
  if Dato = nil then
  begin
     Cia := TCompanias.Instance.Buscar(Compania);
     if Cia <> nil then
     begin
        Dato := TDatoNombre(Cia.GetNombre(Condicion));
        FCache.ToQueue(Dato);
     end;
  end;
  Condicion.Free;
  
  if Assigned(Dato) then
     Result := Dato.Nombre;
end;

initialization
end.
