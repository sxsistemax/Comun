{ ********************************************************************* }
{                                                                       }
{ Vision Tecnologica S.A.                                               }
{                                                                       }
{ Unidad      : Info                                            }
{ Sistema     : InfoPresupuesto                                           }
{ Fecha       : 31/01/2001                                                }
{ Hora        : 12:40:59 p.m.                                                }
{                                                                       }
{ ********************************************************************* }

(* Descripcion :
*)

Unit Info;

{MMWIN:ENDEXPAND}

interface

uses
  SysUtils, Windows, Messages, Classes, VTCache;


type
  TFormatoFecha = ( ffInvalido, ffAAAAMMDD, ffAAAAMM, ffAAAA );

  TCondicionNombre = class (TVTCondition)
  private
    FArchivo: OLEVariant;
    FCodigo: OLEVariant;
    FCompania: OLEVariant;
  public
    constructor Create(AArchivo: String; ACompania:String; ACodigo: String);
    function CreateCopy: TVTCondition; override;
    function IsEqual(ACondition : TVTCondition): Boolean; override;
    property Archivo: OLEVariant read FArchivo;
    property Codigo: OLEVariant read FCodigo;
    property Compania: OLEVariant read FCompania;
  end;
  
  TDato = class (TInterfacedObject, IComparable)
    destructor Destroy; override;
  private
    FCondicion: TVTCondition;
  public
    constructor Create(ACondicion: TVTCondition);
    function AsObject: TObject; safecall;
    function IsEqual(ACondition : TVTCondition): Boolean; virtual;
    property Condicion: TVTCondition read FCondicion write FCondicion;
  end;
  
  TDatoNombre = class (TDato, IComparable)
  private
    FNombre: string;
  public
    function GetCondicion: TCondicionNombre;
    property Nombre: string read FNombre write FNombre;
  end;


  TLogWriter = procedure ( const Msg : String );

const
  LogWriter : TLogWriter = nil;
  LogSQL    : Boolean = False;

procedure Register;

procedure SeparaPeriodo(Periodo: Variant; var Ano, Mes: Integer);
function ArmarPeriodo(Ano, Mes: Integer): Integer;
function NumPeriodos( PeriodoInicial, PeriodoFinal : Integer): Integer;

// Separa una fecha en sus componentes y determina su formato
function SeparaFecha( AFecha : Variant; Var Ano, Mes, Dia : Integer ) : TFormatoFecha;
procedure EscribirLog( const Msg : String);

implementation

procedure Register;
begin
end;

procedure SeparaPeriodo(Periodo: Variant; var Ano, Mes: Integer);
begin
  Ano := StrToInt( Copy( Periodo, 1, 4 ) );
  Mes := StrToInt( Copy( Periodo, 5, 2 ) );
end;

function ArmarPeriodo(Ano, Mes: Integer): Integer;
begin
  Result := StrToInt( Format('%.4d%.2d',[Ano,Mes]) );
end;

function NumPeriodos( PeriodoInicial, PeriodoFinal : Integer): Integer;
var
 AnoIni, AnoFin, MesIni, MesFin : Integer;
begin
 SeparaPeriodo( PeriodoInicial, AnoIni, MesIni );
 SeparaPeriodo( PeriodoFinal, AnoFin, MesFin );

 Result := (MesFin-MesIni) + (AnoFin-AnoIni) * 12 + 1;
end;

function SeparaFecha( AFecha : Variant; Var Ano, Mes, Dia : Integer ) : TFormatoFecha;
var
 TempStr : String;
 A, M, D : Word;

 function NumChars( S : String; Ch : Char ) : Integer;
 var
  i : Integer;
 begin
  Result := 0;
  for i := 1 to Length(S) do
      if S[i] = Ch then
         Inc(Result);
 end;

 function SeparaSlash: TFormatoFecha;
 begin
   case NumChars(AFecha, '/') of
        1 : begin // Año y Mes
             TempStr := '01/' + AFecha;
             DecodeDate( StrToDate(TempStr), A, M, D );
             Ano := A; Mes := M; Dia := D;
             Result := ffAAAAMM;
            end;
        2 : begin // Año, mes y dia
             TempStr := AFecha;
             DecodeDate( StrToDate(TempStr), A, M, D );
             Ano := A; Mes := M; Dia := D;
             Result := ffAAAAMMDD;
            end;
   else
    Result := ffInvalido;
   end;
 end;

 function Separa: TFormatoFecha;
 begin
   Mes := 1;
   Dia := 1;
   Ano := 1;
   case Length(AFecha) of
        2 : begin // Solo Año dos digitos
             Ano := StrToInt(AFecha);
             if Ano > 50 then
                Ano := Ano + 1900
             else
                Ano := Ano + 2000;
             Result := ffAAAA;
            end;
        4 : begin // Solo Año cuatro digitos
             Ano := StrToInt(AFecha);
             Result := ffAAAA;
            end;
        6 : begin // Año y mes
             Ano := StrToInt(Copy(AFecha,1,4));
             Mes := StrToInt(Copy(AFecha,5,2));
             Result := ffAAAAMM;
            end;
        8 : begin // Año mes y dia
             Ano := StrToInt(Copy(AFecha,1,4));
             Mes := StrToInt(Copy(AFecha,5,2));
             Dia := StrToInt(Copy(AFecha,7,2));
             Result := ffAAAAMMDD;
            end;
   else
    Result := ffInvalido;
   end;
 end;

begin
 if Pos('/', AFecha ) > 0 then
    Result := SeparaSlash
 else
    Result := Separa;
end;

procedure EscribirLog( const Msg : String);
begin
 if Assigned(LogWriter) then
    LogWriter(Msg);
end;


{
************************************ TCondicionNombre ************************************
}
constructor TCondicionNombre.Create(AArchivo: String; ACompania:String; ACodigo: String);
begin
  inherited Create;
  FArchivo  := AArchivo;
  FCompania := ACompania;
  FCodigo   := ACodigo;
end;

function TCondicionNombre.CreateCopy: TVTCondition;
begin
  Result := TCondicionNombre.Create( FArchivo, FCompania, FCodigo);
end;

function TCondicionNombre.IsEqual(ACondition : TVTCondition): Boolean;
begin
  Result := False;
  if ACondition is TCondicionNombre then
     with ACondition as TCondicionNombre do
     begin
          Result :=
          ( CompareText(Self.FArchivo, Archivo) = 0 ) and
          ( CompareText(Self.FCompania, Compania) = 0 ) and
          ( CompareText(Self.FCodigo, Codigo) = 0 );
     end;
end;

{
***************************************** TDato ******************************************
}
constructor TDato.Create(ACondicion: TVTCondition);
begin
  inherited Create;
  FCondicion := ACondicion.CreateCopy;
end;

destructor TDato.Destroy;
begin
  inherited Destroy;
  FCondicion.Free;
end;

function TDato.AsObject: TObject;
begin
  Result := Self;
end;

function TDato.IsEqual(ACondition : TVTCondition): Boolean;
begin
  Result := Condicion.IsEqual(ACondition);
end;

{
************************************** TDatoNombre ***************************************
}
function TDatoNombre.GetCondicion: TCondicionNombre;
begin
  Result := TCondicionNombre(Condicion);
end;


initialization
 LogWriter := nil;
end.
