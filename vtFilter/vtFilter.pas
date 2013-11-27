unit vtFilter;


interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, DB, BDE, Dsgnintf, Mask, DBCtrls, lmdctrl,
  lmdstdcA;

type
  TVTFilter = class(TComponent)
  private
    { Private declarations }
    FFilter: string;
    FFiltered: Boolean;
    FFilterOptions: TFilterOptions;
    FTitle: string;

    FDataLink : TFieldDataLink;
    FDataset: TDataset;
    
    procedure DoApplyFilter;
    procedure OnActiveChange(AOwner: TObject);
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
  published
    property Filter: string read FFilter write FFilter;
    property Filtered: Boolean read FFiltered write FFiltered;
    property FilterOptions: TFilterOptions read FFilterOptions write FFilterOptions;
    property Title: string read FTitle write FTitle;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TFFilterDialog = class(TForm)
    ApplyBtn: TBitBtn;
    gbCondition: TGroupBox;
    gbListCondition: TGroupBox;
    lbColName: TLabel;
    cbColNames: TComboBox;
    cbOperators: TComboBox;
    Label1: TLabel;
    lbValue: TLabel;
    SuppressBtn: TBitBtn;
    chkCaseSensitive: TCheckBox;
    chkPartialCompare: TCheckBox;
    edValue: TEdit;
    lbCondicion: TLMDListBox;
    Panel1: TPanel;
    btInsertar: TBitBtn;
    btEditar: TBitBtn;
    btBorrar: TBitBtn;
    btCancelar: TBitBtn;
    btBorrarTodos: TBitBtn;
    sbtAnd: TSpeedButton;
    sbtOr: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApplyBtnClick(Sender: TObject);
    procedure SuppressBtnClick(Sender: TObject);
    procedure lbCondicionClick(Sender: TObject);
    procedure btBorrarTodosClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
  private
    { Private declarations }
    FActive: Boolean;
    FBookmark: TBookmark;

    procedure EnableControls(Sender: TObject);
    procedure ClearControls(Sender: TObject);
  public
    { Public declarations }
    FFilter: string;
    FFiltered: Boolean;
    FFilterOptions: TFilterOptions;
    FDataset: TDataset;
  end;

var
  FFilterDialog: TFFilterDialog;

procedure Register;

implementation

{$R *.DFM}

procedure Register;
begin
  RegisterComponents('Vision', [TVTFilter]);
end;

{ TVTFilter }

constructor TVTFilter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFilterDialog := TFFilterDialog.Create(Self);
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnActiveChange := OnActiveChange;
end;

destructor TVTFilter.Destroy;
begin
  FFilterDialog.Free;
  FFilterDialog := nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TVTFilter.DoApplyFilter;
begin
  FDataset.Filter := FFilter;
  FDataset.FilterOptions := FFilterOptions;
  FDataset.Filtered := FFiltered;
end;

function TVTFilter.Execute: Boolean;
begin
  if Not FDataset.Active then 
    raise Exception.Create('Debe abrir la tabla. ');

  if FTitle <> '' then 
    FFilterDialog.Caption := FTitle;
    
  FFilterDialog.FDataset := FDataset;
  FFilterDialog.FFilter := FFilter;
  FFilterDialog.FFilterOptions := FFilterOptions;
  FFilterDialog.FFiltered := FFiltered;
  Result := (FFilterDialog.ShowModal = mrOk);
  if Result then
  begin
    FFilter := FFilterDialog.FFilter;
    FFilterOptions := FFilterDialog.FFilterOptions;
    FFiltered := FFilterDialog.FFiltered;
    DoApplyFilter;
  end;
end;

procedure TVTFilter.OnActiveChange(AOwner: TObject);
begin
  FFilterOptions := [];
  FFilter := '';
  FFiltered := False;
  FFilterDialog.lbCondicion.Clear;
  DoApplyFilter;
//  FFilterDialog.ClearControls( Self);
//  FFilterDialog.EnableControls( Self);
end;

function TVTFilter.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TVTFilter.SetDataSource(const Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  FDataset := FDataLink.Dataset;
  FFilter := FDataset.Filter;
  FFilterOptions := FDataset.FilterOptions;
  FFiltered := FDataset.Filtered;
end;

{ TFFilterDialog }

procedure TFFilterDialog.FormShow(Sender: TObject);
var
  I: Integer;
begin
  with FDataset do
  begin
    FActive := Active;
    if FActive then 
      FBookmark := GetBookmark
    else 
      Open;
    DisableControls;
    cbColNames.Items.Clear;
    for I := 0 to FieldCount-1 do 
      cbColNames.Items.Add(Fields[I].FieldName);
  end;
  chkCaseSensitive.Checked := not (foCaseInsensitive in FFilterOptions);
  chkPartialCompare.Checked := not (foNoPartialCompare in FFilterOptions);
  EnableControls(Self);
  ClearControls(Self);
end;

procedure TFFilterDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with FDataset do
  begin
    if FActive then
    begin
      GotoBookmark(FBookmark);
      FreeBookmark(FBookmark);
    end
    else 
      Close;
    EnableControls;
  end;
end;

procedure TFFilterDialog.ClearControls(Sender: TObject);
begin
  cbColNames.ItemIndex := -1;
  cbOperators.ItemIndex := -1;
  edValue.Text := '';
  cbColNames.SetFocus;
end;

procedure TFFilterDialog.EnableControls(Sender: TObject);
begin
  sbtAnd.Enabled   := (lbCondicion.Items.Count > 0);
  sbtOR.Enabled    := (lbCondicion.Items.Count > 0);
  sbtAnd.Visible   := (lbCondicion.Items.Count > 0);
  sbtOR.Visible    := (lbCondicion.Items.Count > 0);
  ApplyBtn.Enabled := (lbCondicion.Items.Count > 0);
  SuppressBtn.Enabled := FFiltered and (lbCondicion.Items.Count > 0);
  btBorrar.Enabled := (lbCondicion.Items.Count > 0) And (lbCondicion.ItemIndex >= 0);
  btEditar.Enabled := (lbCondicion.ItemIndex >= 0);
  btBorrarTodos.Enabled := (lbCondicion.Items.Count > 0);
end;

procedure TFFilterDialog.BtnAddClick(Sender: TObject);
begin
  if (cbColNames.ItemIndex = -1) or
     (cbColNames.ItemIndex = -1) or
     (edValue.Text = '') then 
    Exit;

  if (lbCondicion.Items.Count > 0) then
    with lbCondicion do
    begin
      if sbtAND.Down then 
        SetItemPart( Items.Count-1, 3, 'Y') 
      else 
        SetItemPart( Items.Count-1, 3, 'O') 
    end;

  lbCondicion.Items.Add( cbColNames.Text + ';' + cbOperators.Text + ';' + edValue.Text) ;

  EnableControls(Self);
  ClearControls(Self);
end;

procedure TFFilterDialog.DeleteBtnClick(Sender: TObject);
begin
  with lbCondicion do
  begin
    if ItemIndex = -1 then 
      Exit;

    if Items.Count >= 2 then
    begin
      case ItemIndex of
        0 : SetItemPart( ItemIndex + 1, 3, '');
        1 : SetItemPart( ItemIndex - 1, 3, '');
      end;
    end;
    Items.Delete( ItemIndex) ;
  end;
  EnableControls(Self);
end;

procedure TFFilterDialog.ApplyBtnClick(Sender: TObject);
var
  I : Integer;

  function Operador( AOperador : string ) : string ;
  begin
    Result := ' ' + Copy( AOperador, 1, Pos( ' ', AOperador));
  end;

  function Valor( ACampo, AValor : string) : string ;
  var
    Separador : string;
  begin
    case FDataset.FieldByName( ACampo).DataType of
      ftString:       Separador := ''''; (*Champ caractère ou chaîne.*)
      ftSmallint,                        (*Champ entier sur 16 bits.*)
      ftInteger,                         (*Champ entier sur 32 bits.*)
      ftWord,	                         (*Champ entier non signé sur 16 bits.*)
      ftBoolean,                         (*Champ booléen.*)
      ftFloat,	                         (*Champ numérique à virgule flottante.*)
      ftCurrency,                        (*Champ monétaire.*)
      ftBCD:	    Separador := '';     (*Champ décimal codé binaire.*)
      ftDate,	                         (*Champ date.*)
      ftTime,	                         (*Champ heure.*)
      ftDateTime:     Separador := ''''; (*Champ date et heure.*)
      ftAutoInc:      Separador := '';   (*Champ compteur auto-incrémenté entier sur 32 bits.*)
      ftBytes,	                         (*Nombre fixe d'octets (stockage binaire).*)
      ftVarBytes,                        (*Nombre variable d'octets (stockage binaire).*)
      ftBlob,                            (*Champ objet binaire volumineux (BLOB).*)
      ftMemo,	                         (*Champ mémo texte.*)
      ftGraphic,	                 (*Champ bitmap.*)
      ftFmtMemo,	                 (*Champ mémo texte formaté.*)
      ftParadoxOle,	                 (*Champ OLE Paradox.*)
      ftDBaseOle,	                 (*Champ OLE dBASE.*)
      ftTypedBinary,	                 (*Champ binaire typé.*)
      ftCursor:	      Exit;              (*Ne s'applique pas aux composants champ.*)
    end;
    Result := Separador + AValor + Separador;
  end;
  
  function OperadorLogico( ALogico : string) : string ;
  begin
    if ALogico = 'Y' then
      Result := ' And '
    else
      if ALogico = 'O' then
        Result := ' Or '
      else
        Result := ' ';
  end;
  
  
begin
  with lbCondicion do
  begin
    FFilter := '';
    for I := 0 to Items.Count - 1 do
    begin
      FFilter := FFilter + ItemPart( I, 0) + 
                           Operador( ItemPart( I, 1)) + 
                           Valor( ItemPart( I, 0), ItemPart( I, 2)) + 
                           OperadorLogico( ItemPart( I, 3));
    end;  
  end;
  
  FFilterOptions := [];
  if not chkCaseSensitive.Checked then 
    Include(FFilterOptions,foCaseInsensitive);
  if not chkPartialCompare.Checked then 
    Include(FFilterOptions,foNoPartialCompare);
  FFiltered := True;
end;

procedure TFFilterDialog.SuppressBtnClick(Sender: TObject);
begin
  FFilterOptions := [];
  FFilter := '';
  FFiltered := False;
end;

procedure TFFilterDialog.lbCondicionClick(Sender: TObject);
var
  mAndOr : string;
begin
  with lbCondicion do
  begin
    cbColNames.ItemIndex  := cbColNames.Items.IndexOf( ItemPart( ItemIndex, 0));
    cbOperators.ItemIndex := cbOperators.Items.IndexOf( ItemPart( ItemIndex, 1));
    edValue.Text          := ItemPart( ItemIndex, 2);
    mAndOr                := ItemPart( ItemIndex, 3);
    if ( ItemIndex > 0 ) then
      if ( mAndOr = 'o') then
        sbtOR.Down := true
      else
        sbtAND.Down := true
  end;
  EnableControls( Self);
end;

procedure TFFilterDialog.btBorrarTodosClick(Sender: TObject);
begin
  lbCondicion.Clear;
  EnableControls( Self);
  ClearControls( Self);
end;

procedure TFFilterDialog.btEditarClick(Sender: TObject);
begin
  if (cbColNames.ItemIndex = -1) or
     (cbColNames.ItemIndex = -1) or
     (edValue.Text = '') then 
    Exit;

  with lbCondicion do
  begin
    if (ItemIndex > 0) then
    begin
      if sbtAND.Down then 
        SetItemPart( ItemIndex -1, 3, 'Y') 
      else 
        SetItemPart( ItemIndex -1, 3, 'O') 
    end;
    SetItemPart( ItemIndex, 0, cbColNames.Text); 
    SetItemPart( ItemIndex, 1, cbOperators.Text); 
    SetItemPart( ItemIndex, 2, edValue.Text); 
  end;

  EnableControls(Self);
  ClearControls(Self);
end;

end.
