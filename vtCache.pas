{ ********************************************************************* }
{                                                                       }
{ Vision Tecnologica S.A.                                               }
{                                                                       }
{ Unidad      : VTCache                                            }
{ Sistema     : InfoPresupuesto                                           }
{ Fecha       : 30/01/2001                                                }
{ Hora        : 07:39:43 p.m.                                                }
{                                                                       }
{ ********************************************************************* }

(* Descripcion :
*)

Unit VTCache;

{MMWIN:ENDEXPAND}

interface

uses
  SysUtils, Windows, Messages, Classes;

type

  TVTCondition = class (TObject)
  public
    function CreateCopy: TVTCondition; virtual; abstract;
    function IsEqual(ACondition : TVTCondition): Boolean; virtual; abstract;
    function IsValid: Boolean; virtual;
  end;
  
  IComparable = interface (IUnknown)
    ['{99BE99ED-12D6-42D6-AF76-0E1EE8A7126C}']
    function AsObject: TObject; safecall;
    function IsEqual(ACondition : TVTCondition): Boolean;
  end;
  
  TVTCache = class (TList)
    constructor Create;
  private
    FLimit: Integer;
  protected
    procedure DeleteItem(Index: Integer);
    procedure SetLimit(Value: Integer);
  public
    procedure Clear; override;
    function Find(ACondition : TVTCondition): TObject;
    procedure ToQueue(const AItem : IComparable);
    property Limit: Integer read FLimit write SetLimit;
  end;
  


procedure Register;

implementation

procedure Register;
begin
end;

procedure WriteNTLog( const AMsg : String );
var
  hEventLog : THandle;   // Handle to the event log.
  Msg : PChar;
begin
  // write directly to the log file, w/o any registry
  // verification.
  Msg := PChar(AMsg);   // A simple message.
// Server name where message dll resides
  // nil indicates local machine.
// ??? is application registry key.
  hEventLog := RegisterEventSource(nil, 'VTCache');

  if (hEventLog <= 0) then begin
    raise Exception.Create(
      'RegisterEventSource call failed!');
    Exit;
  end;

  if not ReportEvent(hEventLog, 0, 0, 0,
                     nil, 1, 0, @Msg, nil) then begin
    DeregisterEventSource(hEventLog);
    raise Exception.Create('Failure in Report Event');
  end;

  // Return event log handle retrieved by
// RegisterEventSource.
  DeregisterEventSource(hEventLog);
end;

{
************************************** TVTCondition **************************************
}
function TVTCondition.IsValid: Boolean;
begin
  Result := True;
end;

{
**************************************** TVTCache ****************************************
}
constructor TVTCache.Create;
begin
  inherited Create;
  FLimit := 10000;
end;

procedure TVTCache.Clear;
begin
  while Count > 0 do
        DeleteItem(Count-1);
end;

procedure TVTCache.DeleteItem(Index: Integer);
var
  Temp: IComparable;
begin
  Temp := IComparable(Items[Index]);
  Delete(Index);
  Temp._Release;
end;

function TVTCache.Find(ACondition : TVTCondition): TObject;
var
  i: Integer;
  Temp: IComparable;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
      Temp := IComparable(Items[i]);
      if Temp.IsEqual(ACondition) then
      begin
         Move(i,0);
  //         Temp._AddRef;
         Result := Temp.AsObject;
         break;
      end;
  end;
end;

procedure TVTCache.SetLimit(Value: Integer);
begin
  FLimit := Value;
end;

procedure TVTCache.ToQueue(const AItem : IComparable);
const
 Reported : Boolean = False;
begin
  if not Assigned(AItem) then
     Exit;

  AItem._AddRef;
  if (Count = Limit) and (Limit > 0) then
  begin
     try
       if not Reported then
       begin
          WriteNTLog('InfoPresupuesto: Cache Lleno' );
          Reported := True;
       end;
     except
     end;

     DeleteItem( Limit-1 );
  end;
  
  Insert(0,Pointer(AItem));
end;

initialization
end.
