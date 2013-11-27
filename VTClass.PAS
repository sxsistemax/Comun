unit VTClass;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type

  TEstado = Integer;
  TEstadoProceso = ( epEjecucion, epExitoso, epError );

  TClassEntry = class (TCollectionItem)
  private
    FClassObject: TClass;
    FID: Variant;
  public
    function IsEqual(AID:Variant): Boolean;
    property ClassObject: TClass read FClassObject write FClassObject;
    property ID: Variant read FID write FID;
  end;
  
  TClassFinder = class (TCollection)
  protected
    function GetClasses(Index: Integer): TClass;
  public
    constructor Create;
    procedure AddClassEntry(AID : Variant; AClass : TClass);
    function FindClass(AID : Variant): TClass;
    property Classes[Index: Integer]: TClass read GetClasses; default;
  end;
  
  TObjectEntry = class (TCollectionItem)
  private
    FID: Variant;
    FObjectItem: TObject;
  public
    function IsEqual(AID:Variant): Boolean;
    property ID: Variant read FID write FID;
    property ObjectItem: TObject read FObjectItem write FObjectItem;
  end;
  
  TObjectFinder = class (TCollection)
  protected
    function GetObjects(Index: Integer): TObject;
  public
    constructor Create;
    procedure AddObjectEntry(AID : Variant; AObject : TObject);
    procedure DeleteObject(AID : Variant);
    function FindObject(AID : Variant): TObject;
    procedure GetNames(AStrings: TStrings);
    property Objects[Index: Integer]: TObject read GetObjects; default;
  end;
  

procedure Register;

implementation

procedure Register;
begin
end;


{
************************************** TClassEntry ***************************************
}
function TClassEntry.IsEqual(AID:Variant): Boolean;
begin
  Result := AID = FID;
end;

{
************************************** TClassFinder **************************************
}
constructor TClassFinder.Create;
begin
  inherited Create( TClassEntry );
end;

procedure TClassFinder.AddClassEntry(AID : Variant; AClass : TClass);
begin
  if FindClass(AID) = nil then
    with TClassEntry(Add) do
    begin
         ID := AID;
         ClassObject := AClass;
    end;
end;

function TClassFinder.FindClass(AID : Variant): TClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
      if TClassEntry(Items[i]).IsEqual(AID) then
      begin
         Result := Classes[i];
         Exit;
      end;
  end;
end;

function TClassFinder.GetClasses(Index: Integer): TClass;
begin
  Result := TClassEntry(Items[Index]).ClassObject;
end;

{
************************************** TObjectEntry **************************************
}
function TObjectEntry.IsEqual(AID:Variant): Boolean;
begin
  Result := AID = FID;
end;

{
************************************* TObjectFinder **************************************
}
constructor TObjectFinder.Create;
begin
  inherited Create( TObjectEntry );
end;

procedure TObjectFinder.AddObjectEntry(AID : Variant; AObject : TObject);
begin
  if FindObject(AID) = nil then
    with TObjectEntry(Add) do
    begin
         ID := AID;
         ObjectItem := AObject;
    end;
end;

procedure TObjectFinder.DeleteObject(AID : Variant);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
      if TObjectEntry(Items[i]).IsEqual(AID) then
      begin
         Delete(i);
      end;
  end;
end;

function TObjectFinder.FindObject(AID : Variant): TObject;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
      if TObjectEntry(Items[i]).IsEqual(AID) then
      begin
         Result := Objects[i];
         Exit;
      end;
  end;
end;

procedure TObjectFinder.GetNames(AStrings: TStrings);
var
  i: Integer;
begin
  AStrings.Clear;
  
  for i := 0 to Count - 1 do
  begin
      AStrings.Add( TObjectEntry(Items[i]).ID );
  end;
end;

function TObjectFinder.GetObjects(Index: Integer): TObject;
begin
  Result := TObjectEntry(Items[Index]).ObjectItem;
end;


initialization
end.
