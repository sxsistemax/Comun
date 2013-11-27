unit vtProt;

interface

 Uses SysUtils, OgUtil, OnGuard, Registry, Windows;

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
 function MachineID    : Longint;
 function MachineIDStr : String;
 function StrToMachineID( S : String ) : Longint;
 procedure StrToCode( const S : String; var ACode : TCode );
 function CodeToStr( const ACode : TCode ) : String;

 function LeerDatosRegistro(  HKEY   : String) : TCode;

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

function LeerDatosRegistro(  HKEY   : String) : TCode;
Var
  ACode : TCode;
Begin
 with TRegistry.Create do
 begin
      StrToCode( '', ACode);
      RootKey := HKEY_LOCAL_MACHINE;
      If OpenKey( '\SOFTWARE\Vision Tecnologica\' + HKEY, True ) Then
      Begin
        StrToCode( ReadString( 'Serial' ), ACode);
        CloseKey;
      End;
      Free;
      Result := ACode;
 end;
End;

end.

