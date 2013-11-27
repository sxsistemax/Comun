unit vtProt;

interface

 Uses SysUtils, OgUtil, OnGuard;

 function CodificarExpiracion( ASubtipo, AVendedor : Byte ) : TDatetime;
 procedure GenerarSerial( const AKey : TKey; AConsecutivo : Longint;
                          ASubTipo, AVendedor : Byte; var ASerial : TCode );
 procedure GenerarClave( AKey : TKey; const ASerial : TCode;
                         AMachineID : Longint; var AClave : TCode );
 function VerificarClave( const AKey : TKey; const ASerial : TCode;
                          AMachineID : Longint; const AClave : TCode ) : Boolean;
 procedure DecodificarSerial( const AKey : TKey; const ASerial : TCode;
                              Var AConsecutivo : Longint;
                              Var ASubTipo : Byte; Var AVendedor : Byte );
                              
 procedure DecodificarSerialStr( const AKey : TKey; const ASerial : String;
                                Var AConsecutivo : Longint;
                                Var ASubTipo : Byte; Var AVendedor : Byte );

 function SerialValido( const AKey : String; const ASerial : String ) : Boolean;

 function MachineID    : Longint;
 function MachineIDStr : String;
 function StrToMachineID( S : String ) : Longint;
 procedure StrToCode( const S : String; var ACode : TCode );
 function CodeToStr( const ACode : TCode ) : String;
 procedure StrToKey( const S : String; var AKey : TKey );

implementation

// une los parámetros de Subtipo y Vendedor en un TDateTime
function CodificarExpiracion( ASubtipo, AVendedor : Byte ) : TDatetime;
begin
 Result := ExpandDate( ASubtipo OR ( AVendedor SHL 8 ) );
end;

// Crea un numero serial para ser entregado por el Vendedor al Cliente
procedure GenerarSerial( const AKey : TKey; AConsecutivo : Longint;
                         ASubTipo, AVendedor : Byte; var ASerial : TCode );
begin
 InitSerialNumberCode( AKey, AConsecutivo, CodificarExpiracion( ASubtipo, AVendedor), ASerial );
end;

// Crea la clave de activación que corresponde al numero serial y MachineID del Cliente
procedure GenerarClave( AKey : TKey; const ASerial : TCode;
                        AMachineID : Longint; var AClave : TCode );
begin
 ApplyModifierToKeyPrim( AMachineID, AKey, sizeof( AKey ) );
 InitRegCode( AKey, BufferToHex(ASerial,Sizeof(ASerial)), 0, AClave );
end;

// Verifica la clave de activación que corresponde al numero serial y MachineID del Cliente
function VerificarClave( const AKey : TKey; const ASerial : TCode;
                         AMachineID : Longint; const AClave : TCode ) : Boolean;
var
 Temp : TCode;
begin
 GenerarClave( AKey, ASerial, AMachineID, Temp );
 Result := CompareMem( @AClave, @Temp, sizeof(TCode) );
end;


// Interpreta los componentes de un numero serial
procedure DecodificarSerial( const AKey : TKey; const ASerial : TCode;
                             Var AConsecutivo : Longint;
                             Var ASubTipo : Byte; Var AVendedor : Byte );
var
 D : TDateTime;
 W : Word;
begin
 D            := GetExpirationDate( AKey, ASerial );
 W            := ShrinkDate(D);
 ASubTipo     := Lo(W);
 AVendedor    := Hi(W);
 AConsecutivo := GetSerialNumberCodeValue( AKey, ASerial );
end;

// Interpreta los componentes de un numero serial
procedure DecodificarSerialStr( const AKey : TKey; const ASerial : String;
                                Var AConsecutivo : Longint;
                                Var ASubTipo : Byte; Var AVendedor : Byte );
var
 S : TCode;
begin
 StrToCode( ASerial, S );
 DecodificarSerial( AKey, S, AConsecutivo, ASubTipo, AVendedor );
end;

// Determina su el numero Serial corresponde al Key de la aplicacion
function SerialValido( const AKey : String; const ASerial : String ) : Boolean;
var
 K : TKey;
 S : TCode;
begin
 StrToKey( AKey, K );
 StrToCode( ASerial, S );
 Result := IsSerialNumberCodeValid( K, S );
end;

// Retorna el MachineID del equipo en que se ejecute
function MachineID : Longint;
begin
 Result := GenerateMachineModifierPrim;
end;

// Retorna el MachineID del equipo en que se ejecute como cadena
function MachineIDStr : String;
var
 ID : Longint;
begin
 ID     := MachineID;
 Result := BufferToHex( ID, SizeOf( ID ) );
end;

// Convierte una cadena en MachineID
function StrToMachineID( S : String ) : Longint;
begin
 HexToBuffer( S, Result, SizeOf( Result ) );
end;

// Convierte una cadena en un Serial o Clave de Activación
procedure StrToCode( const S : String; var ACode : TCode );
begin
 HexToBuffer( S, ACode, SizeOf( ACode ) );
end;

// Convierte un Serial o Clave de Activación en una cadena
function CodeToStr( const ACode : TCode ) : String;
begin
 Result := BufferToHex( ACode, SizeOf( ACode ) );
end;

procedure StrToKey( const S : String; var AKey : TKey );
begin
 HexToBuffer( S, AKey, sizeof(AKey) );
end;

end.

