unit vtReg;

interface

 Uses SysUtils, OgUtil, OnGuard, Dialogs;

type

 TEstadoProteccion = ( epRegistrado, epEvaluacion, epVencido, epViolado );

 TTipoProteccion = ( tpProhibir, tpTrial, tpLimitar, tpNinguna );
 TDatosProteccion = record
  Tipo   : TTipoProteccion;
  Tiempo : Integer;          // Duracion del Trial
  Nombre : String;           // Nombre de la aplicacion
  Key    : TKey;
  HKEY   : String;           // Clave del registry donde se almacena la Ix de Registro
  Hidden : String;           // Clave escondida (GUID) donde se almacena la informacion del Trial
 end;

 TDatosRegistro = record
  Estado : TEstadoProteccion;
  Serial : String;
  Clave  : String;
  Falta  : Integer;         // Numero de dias restantes del periodo de evaluacion
 end;

 function RevisarProteccion( Datos : TDatosProteccion ) : TDatosRegistro;
 function RevisarProteccionEx( Datos : TDatosProteccion ) : TDatosRegistro;
 function RegistrarAplicacion( Datos : TDatosProteccion ) : TEstadoProteccion;
 function ClaveCorrecta( Datos : TDatosProteccion; const ASerial : String;
                         const AClave : String ) : Boolean;
 procedure ActualizarUso( Datos : TDatosProteccion );
 function LeerDatosRegistro(  HKEY   : String) : TCode;
 procedure ExtenderEvaluacion( Datos : TDatosProteccion; pDias : Integer);


implementation

 Uses Registry, Windows, vtProt, vtRegDlg;

function RevisarProteccion( Datos : TDatosProteccion ) : TDatosRegistro;
Var
 UltimaVez, PrimeraVez : TDateTime;
 Uso                   : TDateTime;
begin
 Result.Estado := epVencido;
 Result.Falta  := 0;

 with TRegistry.Create do
 begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey( '\SOFTWARE\Vision Tecnologica\' + Datos.HKEY, True );
      Result.Serial := ReadString( 'Serial' );
      Result.Clave  := ReadString( 'Clave' );

      Free;
 end;

 // 1. Verificar si es valido el registro

 if ClaveCorrecta( Datos, Result.Serial, Result.Clave ) then
 begin
    Result.Estado := epRegistrado;
    Exit;
 end;

 // 2. Valor de retorno segun tipo de proteccion

 if Datos.Tipo = tpProhibir then
 begin
    Result.Estado := epVencido;
    Exit;
 end;

 if Datos.Tipo <> tpTrial then
 begin
    Result.Estado := epEvaluacion;
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
            Result.Estado := epViolado;
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
    Result.Estado := epViolado;
    Exit;
 end;

 if Uso > Datos.Tiempo then
 begin
    Result.Estado := epVencido;
 end
 else
 begin
    Result.Falta  := Datos.Tiempo - Trunc( Uso );
    Result.Estado := epEvaluacion;
 end;

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
 TfmRegistro.MostrarEstado( Datos );
 Result := RevisarProteccion( Datos ).Estado;
end;

function RevisarProteccionEx( Datos : TDatosProteccion ) : TDatosRegistro;
begin
 Result := RevisarProteccion( Datos );
 if Result.Estado <> epRegistrado then
    Result := TfmRegistro.MostrarEstado( Datos );
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

procedure ExtenderEvaluacion( Datos : TDatosProteccion; pDias : Integer );
Var
  mAumentado : Boolean;
  DatosRegistro : TDatosRegistro;
begin
 if RevisarProteccion( Datos).Estado In [ epVencido, epViolado] Then
 begin
   with TRegistry.Create do
   begin
     mAumentado := False;
     RootKey := HKEY_CLASSES_ROOT;
     if OpenKey( 'CLSID\' + Datos.Hidden, True ) then
     try
       mAumentado := ReadBool( 'Again' );
     except
     end;
     if not mAumentado Then
     begin
       WriteBool( 'Again', True );
       WriteDateTime( 'ServerFlags', Now - (Datos.Tiempo - pDias + 1) );
       WriteDateTime( 'Thunk', Now - (Datos.Tiempo - pDias + 1) );
       mAumentado := True;
     end
     else
       ShowMessage( 'El período de evaluación ya fué extendido.' + ^M +
                    'Para continuar utilizando el producto debe registrarse' );
     CloseKey;
     Free;
     If mAumentado Then
     begin
       DatosRegistro := RevisarProteccion( Datos );
       ShowMessage( 'El período de evaluación se extendió hasta : ' +
          FormatDateTime( 'mmmm d,yyyy', Date + DatosRegistro.Falta ));
     end;
   end;
 end
 else
   ShowMessage( 'El período de evaluación no se ha vencido.');
end;

end.
