unit VTIndexCombo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, db, dbtables, dbctrls, ADOdb, IBTable;

type
  TVTIndexCombo = class(TCustomComboBox)
  private
    { Private declarations }
    FDataLink : TFieldDataLink;
    FReloadIndexName : Boolean;
    FUseIndexDescription : Boolean;
    FIndexNames : TStringList;
    function GetDataSource: TDataSource;
    procedure SetDataSource( Value: TDataSource);
    function GetUseIndexDescription: Boolean;
    procedure SetUseIndexDescription(const Value: Boolean);
    function GetIndexName( pIndex : Integer) : string;
    procedure vtActiveChangeDL( AOwner: TObject);
    procedure vtChange( AOwner: TObject);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create( AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property UseIndexDescription : Boolean read GetUseIndexDescription write SetUseIndexDescription;
    property Items;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Vision', [TVTIndexCombo]);
end;

{ TVTIndexCombo }

constructor TVTIndexCombo.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnActiveChange := vtActiveChangeDL;
  FReloadIndexName := True;
  FIndexNames := TStringList.Create;
  OnChange := vtChange;
end;

procedure TVTIndexCombo.vtActiveChangeDL(AOwner: TObject);
Var
  mIndexNumber : Integer;

  procedure AddIndexName( pIndexDefsName, pIndexName : string; pIndex : integer);
  begin
    // Insert IndexName in the position indicate for pIndex
    FIndexNames.Insert( pIndex, pIndexDefsName);
    
    // set mIndexNumber with number of index in the definition order 
    if pIndexName = pIndexDefsName then
      mIndexNumber := pIndex;
        
  end;  

  // load IndexName into FIndexNames and if FUseIndexDescription = false or
  // not descriptions (property Items) IndexDescriptions is equal to FIndexNames
  procedure LoadIndex( pIndexDefs: TIndexDefs; pIndexName : string);
  var
    i : Integer;
  begin
    pIndexDefs.Update;
    for i := 0 to pIndexDefs.Count - 1 do
      AddIndexName( pIndexDefs.Items[I].Name, pIndexName, FIndexNames.Count);

    if FDataLink.DataSource.DataSet is TTable then
      AddIndexName( '', pIndexName, 0);
      
    if not FUseIndexDescription Or ( Items.Count = 0) then
      for i := 0 to FIndexNames.Count - 1 do
        Items.Add( FIndexNames[I]);

  end;  
  
begin
  // initialize this, only on activate table 
  if FReloadIndexName then
  begin
    if not FUseIndexDescription then
      Items.Clear;
    FIndexNames.Clear;
    Text := '';
    mIndexNumber := 0;
  end;  

  // load index names only on activate table and not 
  // when is call from event OnChange of IndexCombo
  if FDataLink.DataSource.DataSet.Active And FReloadIndexName then
  begin
    // is TTable
    if FDataLink.DataSource.DataSet is TTable then
      with TTable( FDataLink.DataSource.DataSet) do
      begin
        LoadIndex( IndexDefs, IndexName);
        Text := GetIndexName( mIndexNumber) ;
      end
    else
      // is TADOTable
      if FDataLink.DataSource.DataSet is TADOTable then
        with TADOTable( FDataLink.DataSource.DataSet) do
        begin
          LoadIndex( IndexDefs, IndexName);
          Text := GetIndexName( mIndexNumber) ;
        end
    else
      // is TIBTable
      if FDataLink.DataSource.DataSet is TIBTable then
        with TIBTable( FDataLink.DataSource.DataSet) do
        begin
          LoadIndex( IndexDefs, IndexName);
          Text := GetIndexName( mIndexNumber) ;
        end
  end;  
end;

destructor TVTIndexCombo.Destroy;
begin
  OnChange := nil;
  FDataLink.OnActiveChange := nil;
  FDataLink.Free;
  FIndexNames.Free;
  inherited;
end;

function TVTIndexCombo.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TVTIndexCombo.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

procedure TVTIndexCombo.vtChange(AOwner: TObject);
var
  mText : string;
begin
  // do not load indes names 
  FReloadIndexName := False;

  mText := FIndexNames[ ItemIndex];
  
  Enabled := False;
  if FDataLink.DataSource.DataSet is TTable then
    with TTable( FDataLink.DataSource.DataSet) do
    begin
      if IndexName <> mText then
        IndexName := mText;
    end
  else
    if FDataLink.DataSource.DataSet is TADOTable then
    with TADOTable( FDataLink.DataSource.DataSet) do
    begin
      if IndexName <> mText then
      begin
        Active := False;
        IndexName := mText;
        Active := True;
      end;
    end
  else
    if FDataLink.DataSource.DataSet is TIBTable then
    with TIBTable( FDataLink.DataSource.DataSet) do
    begin
      if IndexName <> mText then
        IndexName := mText;
    end;
  Enabled := True;
  FReloadIndexName := True;
end;

function TVTIndexCombo.GetUseIndexDescription: Boolean;
begin
  Result := FUseIndexDescription;
end;

procedure TVTIndexCombo.SetUseIndexDescription(const Value: Boolean);
begin
  FUseIndexDescription := Value;
end;

function TVTIndexCombo.GetIndexName(pIndex: Integer): string;
begin
  // secure pIndex is in range
  if (pIndex >= 0) and ( pIndex < Items.Count) then
    result := items[ pIndex]
  else
    result := '';
end;

end.
