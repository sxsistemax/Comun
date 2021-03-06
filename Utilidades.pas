unit Utilidades;

interface

//Retorna la ruta de la carpeta temporal
function RutaTemporal : String;

// Envia un correo usando outlook
function EnviarConOutLook( ADireccionDestino, AAsunto, ACuerpo, AArchivos : WideString) : boolean;


procedure Esperar(SleepSecs : Integer);

implementation

uses SysUtils, Windows, ComObj, Variants, Forms ;

function RutaTemporal : String;
Var
  mRuta : Array [0..255] Of Char;
begin
  GetTempPath( 255, mRuta );
  Result := StrPas( mRuta);
end;  

// Envia un correo usando outlook
function EnviarConOutLook( ADireccionDestino, AAsunto, ACuerpo, AArchivos : WideString) : boolean;
const 
  olMailItem = 0;
var 
  Outlook: OLEVariant;
  MailItem: Variant;
  i, p : Integer;
  lDireccion : string;
  lArchivo : string;
begin
  try
    // Busca el OutLook si esta activo
    Outlook := GetActiveOleObject('Outlook.Application');
  except
    // si no esta activo crea una instancia 
    Outlook := CreateOleObject('Outlook.Application');
  end;
   
  // Crea un tipo de documento de correo en OutLook 
  MailItem := Outlook.CreateItem(olMailItem);

  // Adicionar las diferentes direcciones de destino que se deben pasar separadas
  // por coma
   
  while (Pos( ',', ADireccionDestino) > 0) or (Length( ADireccionDestino) > 0) do
  begin
    P := Pos( ',', ADireccionDestino);
    if P = 0 then
      P := Length( ADireccionDestino) + 1;
     
    lDireccion := Copy( ADireccionDestino, 1, P - 1);
    Delete( ADireccionDestino, 1, P);
    MailItem.Recipients.Add( lDireccion);
  end;  
 
  MailItem.Subject := AAsunto;
  MailItem.Body    := ACuerpo;

  while (Pos( ',', AArchivos) > 0) or (Length( AArchivos) > 0) do
  begin
    P := Pos( ',', AArchivos);
    if P = 0 then
      P := Length( AArchivos) + 1;
    
    lArchivo := Copy( AArchivos, 1, P - 1);
    Delete( AArchivos, 1, P);
    MailItem.Attachments.Add( lArchivo);
  end;  
  MailItem.Display( False);
  Outlook := Unassigned;
end;


procedure Esperar(SleepSecs : Integer);
 var
  StartValue : LongInt;
begin
 StartValue    := GetTickCount;
 While ((GetTickCount - StartValue) <=
       (SleepSecs * 1000)) do
  Application.ProcessMessages;
end;



end.
