{*****************************************************************************
 *                                                                           *
 * Component: TDBDateTimePicker                                              *
 * Author: Brad Prendergast (bradp@bpsoftware.com)                           *
 * Date: November 07, 2000                                                  *
 * Version: 1.1                                                              *
 * Description: Data-aware descendant of native DateTimepicker control.      *
 *                                                                           *
 * New:                                                                      *
 *  - Property DataField                                                     *
 *  - Property DataSource                                                    *
 *                                                                           *
 *****************************************************************************}

unit DBDateTimePicker;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, DB, DBCtrls;

type
  TDBDateTimePicker = class(TDateTimePicker)
  private
    { Private declarations }
   fDataLink : TFieldDataLink;
   Function GetDataField: string;
   Function GetDataSource: TDataSource;
   Procedure SetDataField(const Value: string);
   Procedure SetDataSource(Value: TDataSource);
   Procedure DataChange(Sender: TObject);
   Procedure DataUpdate(Sender: TObject);
   procedure CMExit(var Message: TWMNoParams); message CM_EXIT;
  protected
    { Protected declarations }
  public
    { Public declarations }
  Constructor Create(AOwner: TComponent); override;
  Destructor Destroy; override;
  published
    { Published declarations }
    Property DataField: string read GetDataField write SetDataField;
    Property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

procedure Register;

implementation

Constructor TDBDateTimePicker.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  fDataLink := TFieldDataLink.Create;
  fDataLink.Control := Self;
  fDataLink.OnDataChange := DataChange;
  fDataLink.OnUpdateData := DataUpdate;
  OnChange := Change;
End;

Destructor TDBDateTimePicker.Destroy;
Begin
  fDataLink.OnDataChange := nil;
  fDataLink.OnUpdateData := nil;
  fDataLink.Free;
  fDataLink := nil;
  inherited Destroy;
End;

Function TDBDateTimePicker.GetDataField: string;
Begin
  Result := fDataLink.FieldName;
End;

Function TDBDateTimePicker.GetDataSource: TDataSource;
Begin
  Result := fDataLink.DataSource;
End;

Procedure TDBDateTimePicker.SetDataField(const value: string);
Begin
  fDataLink.FieldName := Value;
End;

Procedure TDBDateTimePicker.SetDataSource(Value: TDataSource);
Begin
  fDataLink.DataSource := Value;
End;

Procedure TDBDateTimePicker.DataChange(Sender: TObject);
Begin
  if (fDataLink.DataSource.State = dsBrowse) and (fDataLink.CanModify) then
    if (fDataLink.Field.AsDateTime <> null) then
      case kind of
        dtkDate: Date := fDataLink.Field.AsDateTime;
        dtkTime: if ShowCheckBox then
                   Time := fDataLink.Field.AsDateTime;
      end
    else
      begin
        Date := Null;
        Time := Null;
      end;
End;

Procedure TDBDateTimePicker.DataUpdate(Sender: TObject);
Begin
  if fDataLink.CanModify then
    case kind of
      dtkDate: fDataLink.Field.AsDateTime := Date;
      dtkTime: fDataLink.Field.AsDateTime := Time;
    end;
End;

Procedure TDBDateTimePicker.Change;
Begin
  if not(fDataLink.Editing) then
    fDataLink.Edit;
  fDatalink.Modified;
End;

procedure TDBDateTimePicker.CMExit(var Message: TWMNoParams);
begin
   try
      fDataLink.UpdateRecord;
   except
      on Exception do SetFocus;
   end;
   inherited;
end;

procedure Register;
begin
  RegisterComponents('SX', [TDBDateTimePicker]);
end;

end.
