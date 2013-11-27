unit LogView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, StdCtrls, ImgList;

type
  TfmLogView = class(TForm)
    mmArchivo: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FFileName : String;
    procedure CargarArchivo;
  public
    { Public declarations }
    class procedure Mostrar( const AFileName : String ); 
  end;

var
  fmLogView: TfmLogView;

implementation

{$R *.DFM}

procedure TfmLogView.CargarArchivo;
begin
 try
    mmArchivo.Lines.LoadFromFile(FFileName);
 except
 end;
end;

class procedure TfmLogView.Mostrar(const AFileName: String);
begin
 with Create(Application) do
 begin
    FFileName := AFileName;
    Caption := Caption + ' [' + AFileName + ']';
    CargarArchivo;
    Show;
 end;
end;

procedure TfmLogView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

end.
