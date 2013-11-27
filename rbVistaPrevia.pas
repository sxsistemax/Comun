unit rbVistaPrevia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RBPRVDLG, ppViewr, StdCtrls, Mask, Buttons, ExtCtrls, ppReport, TXtraDev;

type
  TrbPrintPreview1 = class(TrbPrintPreview)
    Panel1: TPanel;
    sbBMP: TSpeedButton;
    sbJPG: TSpeedButton;
    sbRTF: TSpeedButton;
    sbExcel: TSpeedButton;
    sbHTML: TSpeedButton;
    sbPDF: TSpeedButton;
    procedure sbPDFClick(Sender: TObject);
    procedure sbHTMLClick(Sender: TObject);
    procedure sbExcelClick(Sender: TObject);
    procedure sbRTFClick(Sender: TObject);
    procedure sbJPGClick(Sender: TObject);
    procedure sbBMPClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rbPrintPreview1: TrbPrintPreview1;

procedure PresentacionPreliminar( AReporte : TppReport;
                                  ARuta : string;
                                  AExportar : Boolean;
                                  APlantilla : string);

implementation

{$R *.DFM}

uses
   Utilidades;

var
  FRuta : string;
  FExportar : Boolean;
  FPlantilla  : string;
  FImpreso    : Boolean;

procedure PresentacionPreliminar( AReporte : TppReport;
                                  ARuta : string;
                                  AExportar : Boolean;
                                  APlantilla : string);
begin
  with TrbPrintPreview1.Create( Application) do
  begin
    FImpreso := False;
    FExportar := AExportar;
    if Trim( ARuta) = '' then
      FRuta := RutaTemporal
    else
      FRuta := IncludeTrailingBackslash( ARuta);
    if Trim( APlantilla) = '' then
      FPlantilla := 'RPT'
    else
      FPlantilla := Trim( APlantilla);
    ppViewer1.Report := AReporte;
    ppViewer1.Report.Print;
    Free;
  end;

end;


procedure TrbPrintPreview1.sbPDFClick(Sender: TObject);
begin
  inherited;
  ppViewer1.Report.ShowPrintDialog := False;
  ppViewer1.Report.DeviceType   := 'PDFFile';
  ppViewer1.Report.TextFileName := FRuta + FPlantilla + '.PDF';
  ppViewer1.Report.Print;
end;

procedure TrbPrintPreview1.sbHTMLClick(Sender: TObject);
begin
  inherited;
  ppViewer1.Report.ShowPrintDialog := False;
  ppViewer1.Report.DeviceType   := 'HTMLFile';
  ppViewer1.Report.TextFileName := FRuta + FPlantilla + '.HTM';
  ppViewer1.Report.Print;
end;

procedure TrbPrintPreview1.sbExcelClick(Sender: TObject);
begin
  inherited;
  ppViewer1.Report.ShowPrintDialog := False;
  ppViewer1.Report.DeviceType   := 'ExcelFile';
  ppViewer1.Report.TextFileName := FRuta + FPlantilla + '.XLS';
  ppViewer1.Report.Print;
end;

procedure TrbPrintPreview1.sbRTFClick(Sender: TObject);
begin
  inherited;
  ppViewer1.Report.ShowPrintDialog := False;
  ppViewer1.Report.DeviceType   := 'RTFFile';
  ppViewer1.Report.TextFileName := FRuta + FPlantilla + '.RTF';
  ppViewer1.Report.Print;
end;

procedure TrbPrintPreview1.sbJPGClick(Sender: TObject);
begin
  inherited;
  ppViewer1.Report.ShowPrintDialog := False;
  ppViewer1.Report.DeviceType   := 'GraphicFile';
  ppViewer1.Report.TextFileName := FRuta + FPlantilla + '.JPG';
  ppViewer1.Report.Print;
end;

procedure TrbPrintPreview1.sbBMPClick(Sender: TObject);
begin
  inherited;
  ppViewer1.Report.ShowPrintDialog := False;
  ppViewer1.Report.DeviceType   := 'GraphicFile';
  ppViewer1.Report.TextFileName := FRuta + FPlantilla + '.BMP';
  ppViewer1.Report.Print;
end;

procedure TrbPrintPreview1.FormCreate(Sender: TObject);
begin
  inherited;
  ExtraDevices.HTML.UseTextFileName    := True;
  ExtraDevices.CSS2.UseTextFileName    := True;
  ExtraDevices.Graphic.UseTextFileName := True;

  sbPDF.Visible  := FExportar;
  sbHTML.Visible := FExportar;
  sbExcel.Visible:= FExportar;
  sbRTF.Visible  := FExportar;
  sbJPG.Visible  := FExportar;
  sbBMP.Visible  := FExportar;
end;

procedure TrbPrintPreview1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TrbPrintPreview1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    // si presiono esc
    27 : if FImpreso or
           ( not FImpreso and
            ( MessageDlg('No se ha impreso el documento. ¿ Desea salir ?', mtConfirmation,
              [mbYes, mbNo], 0) = mrYes)) then
           spbPreviewCloseClick( Sender);
  end;
end;

end.
