unit VTEditSearch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dbCtrls, db, dbtables, ADOdb, IBTable;

type
  TSearchMode = (smFindKeyOnExit, smFindNearestOnExit, smLocateOnExit,
                 smFindKeyOnChange, smFindNearestOnChange, smLocateOnChange);

  TVTEditSearch = class (TCustomEdit)
  private
    FDataLink: TFieldDataLink;
    FSearchMode: TSearchMode;
    FDataField : string;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetSearchMode: TSearchMode;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetSearchMode(const Value: TSearchMode);
    procedure vtActiveChangeDL( AOwner: TObject);
    procedure vtChange( AOwner: TObject);
  public
    constructor Create( AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property SearchMode: TSearchMode read GetSearchMode write SetSearchMode;
    property Text;
  end;
  
procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Vision', [TVTEditSearch]);
end;

{ TVTEditSearch }

{
************************************* TVTEditSearch **************************************
}
constructor TVTEditSearch.Create( AOwner: TComponent);
begin
  inherited;
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnActiveChange := vtActiveChangeDL;
  Text      := '';
  OnChange  := vtChange;
  OnExit    := vtChange;
end;

destructor TVTEditSearch.Destroy;
begin
  FDataLink.Free;
  inherited;
end;

function TVTEditSearch.GetDataField: string;
begin
  Result := FDataField;
end;

procedure TVTEditSearch.SetDataField(const Value: string);
begin
  FDataField := Value;
end;

function TVTEditSearch.GetDataSource: TDataSource;
begin
  result := FDataLink.DataSource;
end;

function TVTEditSearch.GetSearchMode: TSearchMode;
begin
  result := FSearchMode;
end;

procedure TVTEditSearch.SetDataSource(const Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

procedure TVTEditSearch.SetSearchMode(const Value: TSearchMode);
begin
  FSearchMode := Value;
end;

procedure TVTEditSearch.vtActiveChangeDL( AOwner: TObject);

  // retorna los campos que componen un indice
  // return the fields of selected index
  function FieldsNames( pIndexDefs: TIndexDefs; pIndexName : string) : string;
  var
    i : Integer;
  begin
    result := '';
    pIndexDefs.Update;
    for i := 0 to pIndexDefs.Count - 1 do
      if pIndexDefs.Items[I].Name = pIndexName then
      begin
        result := pIndexDefs.Items[I].Fields;
        break;
      end;  
  end;  


begin
  if FDataLink.DataSource.DataSet.Active then
  begin
    if FDataLink.DataSource.DataSet is TTable then
    with TTable( FDataLink.DataSource.DataSet) do
      FDataField := FieldsNames( IndexDefs, IndexName);
  end;  
end;

procedure TVTEditSearch.vtChange( AOwner: TObject);
begin
  with FDataLink.DataSource do
    if DataSet.Active then
      case FSearchMode of 
        smFindNearestOnChange, 
        smFindKeyOnChange,
        smFindNearestOnExit, 
        smFindKeyOnExit     : 
          // is TTable
          if DataSet is TTable then
            with TTable( DataSet) do
            begin
              if FSearchMode in [ smFindNearestOnChange, smFindNearestOnExit] then
                FindNearest( [ Text] )
              else
                FindKey( [ Text] );
            end
          else
          // is TADOTable
          if DataSet is TADOTable then
            with TADOTable( DataSet) do
              Seek(  Text,  soFirstEQ)
          else
            // is TIBTable
            if DataSet is TIBTable then
              with TIBTable( DataSet) do
                Locate( FDataLink.FieldName, Text, []);
        smLocateOnExit,        
        smLocateOnChange      : DataSet.Locate( FDataLink.FieldName, Text, []);
      end;    
      
end;

end.
