unit IndexCombo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TIndexCombo = class(TComboBox)
  private
    { Private declarations }
    FDataLink: TDataSourceLink;
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure prCargarIndices;
  published
    { Published declarations }
    property DataSource: TDataSource  read GetDataSource  write SetDataSource;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Vision', [TIndexCombo]);
end;

{ TIndexCombo }

function TIndexCombo.GetDataSource: TDataSource;
begin
//
end;

procedure TIndexCombo.SetDataSource(Value: TDataSource);
begin
//
end;

procedure TIndexCombo.prCargarIndices;
begin
//Carga los indeces de la tabla en el combo box
  If DataSource <> Nil Then
  Begin
    Items.Add('')
  End
  Else
    Enabled := False;
end;

constructor TIndexCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TIndexCombo.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

end.
