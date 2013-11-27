unit vtReg;

interface

 Uses SysUtils, OgUtil, OnGuard;

type

 TEstadoProteccion = ( epRegistrado, epEvaluacion, epVencido, epViolado );

 TTipoProteccion = ( tpProhibir, tpTrial, tpLimitar, tpNinguna );
 TDatosProteccion = record
  Tipo   : TTipoProteccion;
  Tiempo : Integer;          // Duracion del Trial
  Nombre : String;           // Nombre de la aplicacion
  Codigo : String;           // Codigo de la aplicacion en el Sistema Web de Registro
  Key    : TKey;
  HKEY   : String;           // Clave del registry donde se almacena la Ix de Registro
  Hidden : String;           // Clave escondida (GUID) donde se almacena la informacion del Trial
 end;

 function RevisarProteccion( Datos : TDatosProteccion ) : TEstadoProteccion;
 function RegistrarAplicacion( Datos : TDatosProteccion ) : TEstadoProteccion;
 function ClaveCorrecta( Datos : TDatosProteccion; const ASerial : String;
                         const AClave : String ) : Boolean;
 procedure ActualizarUso( Datos : TDatosProteccion );

implementation

 Uses Registry, Windows, vtProt, vtRegDlg;

function RevisarProteccion( Datos : TDatosProteccion ) : TEstadoProteccion;
Var
 Serial, Clave : String;
 UltimaVez, PrimeraVez : TDateTime;
 Uso                   : TDateTime;
begin
 Result := epVencido;

 with TRegistry.Create do
 begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey( '\SOFTWARE\Vision Tecnologica\' + Datos.HKEY, True );
      Serial := ReadString( 'Serial' );
      Clave  := ReadString( 'Clave' );

      Free;
 end;

 // 1. Verificar si es valido el registro

 if ClaveCorrecta( Datos, Serial, Clave ) then
 begin
    Result := epRegistrado;
    Exit;
 end;

 // 2. Valor de retorno segun tipo de proteccion

 if Datos.Tipo = tpProhibir then
 begin
    Result := epVencido;
    Exit;
 end;

 if Datos.Tipo <> tpTrial then
 begin
    Result := epEvaluacion;
    Exit;
 end;

 // 3. Verificar si esta vigente el periodo Trial

 with TRegistry.Create do
 begin
      RootKey := HKEY_CLASSES_ROOT;
      if OpenKey( 'CLSID\' + Datos.Hidden, False ) then
      begin
         try
            PrimeraVez := ReadDateTime( 'ServerFlags' );
            UltimaVez  := ReadDateTime( 'Thunk' );
         except
            Result := epViolado;
            Exit;
         end;
      end
      else
      begin
         PrimeraVez := Now;
         UltimaVez  := PrimeraVez;
         OpenKey( 'CLSID\' + Datos.Hidden, True );
         WriteDateTime( 'ServerFlags', PrimeraVez );
         WriteDateTime( 'Thunk', UltimaVez );
      end;

      Free;
 end;

 Uso := Now - PrimeraVez;

 if (Now < UltimaVez) or (Uso < 0) then
 begin
    Result := epViolado;
    Exit;
 end;

 if Uso > Datos.Tiempo then
    Result := epVencido
 else
    Result := epEvaluacion;

 ActualizarUso( Datos );
end;

procedure ActualizarUso( Datos : TDatosProteccion );
begin
 with TRegistry.Create do
 begin
      RootKey := HKEY_CLASSES_ROOT;
      OpenKey( 'CLSID\' + Datos.Hidden, True );
      WriteDateTime( 'Thunk', Now );

      Free;
 end;
end;

function RegistrarAplicacion( Datos : TDatosProteccion ) : TEstadoProteccion;
begin
 TfmRegistro.Registrar( Datos );
 Result := RevisarProteccion( Datos );
end;

function ClaveCorrecta( Datos : TDatosProteccion; const ASerial : String;
                        const AClave : String ) : Boolean;
var
 S, K : TCode;
begin
 StrToCode(ASerial,S);
 StrToCode(AClave,K);
 Result := VerificarClave( Datos.Key, S, MachineID, K );
end;

end.
