unit vtMiniCache;

interface

Uses
  classes;

type

  TVTMiniCache = class( tList)
    Limite : Cardinal;
    constructor create( ALimite : Cardinal);
    function fnAdicionar( ADato : Pointer) : Integer;
    function fnBuscar( ADato : Pointer) : Integer;
    function fnDato( AIndex : Integer) : Pointer;
    function fnEncolar( ADato : Pointer) : Integer;
    procedure prBorrar( AIndex : Integer);
    function fnCompare( ADatoLista, ADatoNuevo :  Pointer) : Boolean; Virtual; Abstract;
    procedure prLimpiarCache;
    procedure BeforeDestruction; override;
  end;


implementation

{ TVTMiniCache }

constructor TVTMiniCache.create(ALimite: Cardinal);
begin
  inherited create;
  Limite := ALimite;
end;

function TVTMiniCache.fnAdicionar(ADato: Pointer): Integer;
// Adiciona una entrada la cache
begin
  // si esta no existe en el cache adicionelo
  If ( fnBuscar( ADato ) < 0) Then
    Result := Add( ADato)
  Else
  // Si ya esta en el chache encolelo
    Result := fnEncolar( ADato);
end;

function TVTMiniCache.fnBuscar(ADato: Pointer): Integer;
// busca una entrada en el cache y retorna la posicion, si
// no existe retorna -1
Var
  mCount : Integer;
begin
  Result := -1;
  // ciclo hasta que recorra todo el chache o encuentra el dato
  for  mCount := 0 to Count - 1 do
  begin
    // llama a comparar
    If fnCompare( Items[mCount], ADato) Then
    begin
      Result := mCount;
      break;
    end;
  end;
end;

function TVTMiniCache.fnDato(AIndex: Integer): Pointer;
// Retorna el puntero de los datos almacenados en el item
begin
  Result := Nil;
  If AIndex <= Count - 1 Then
    Result := Items[AIndex];
end;

function TVTMiniCache.fnEncolar(ADato: Pointer): Integer;
// Saca el dato de la lista y lo coloca como ultimo ingresado
Var
  mIndex : Integer;
begin
  // busca el dato en la lista
  mIndex := fnBuscar( ADato);

  If mIndex >= 0 Then
  Begin
    // almacena el dato que ya existe
    ADato := fnDato( mIndex);

    // borra la entrada de la lista
    Delete( mIndex);
  End
  Else
    // borra la entrada mas vieja en la cola (el primero de la lista)
    if Limite = (Count - 1) then
      prBorrar( 0);

  // Adiciona el dato en la ultima posicion de la cola
  if Limite > 0 Then
    Result := FnAdicionar( ADato)
  else
    Result := -1;
end;

procedure TVTMiniCache.BeforeDestruction;
begin
  prLimpiarCache;
  inherited;
end;

procedure TVTMiniCache.prBorrar(AIndex: Integer);
// Borra el item del cache y libera la memoria utilizada por los datos
Var
  mDato : Pointer;
begin
  mDato := FnDato( AIndex);
  Dispose( mDato);
  Delete( AIndex);
end;

procedure TVTMiniCache.prLimpiarCache;
var
  i        : Integer;
  mCount   : Integer;
  mDato : Pointer;
begin
  mCount := Count;
  for i := 0 to mCount - 1  do
  Begin
    mDato := FnDato( i);
    If mDato <> Nil Then
      Dispose( mDato);
  End;
  Clear;
end;

end.
