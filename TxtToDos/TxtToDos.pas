unit TxtToDos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TTxtToDos = class (TComponent)
  private
    FInputFile: TextFile;
    FInputFileName: string;
    FLineSeparator: Byte;
    FOutputFile: TextFile;
    FOutputFileName: string;
    FRenameFiles: Boolean;
    procedure CloseFiles;
    function OpenFiles: Boolean;
  public
    function Execute: Boolean;
  published
    property InputFileName: string read FInputFileName write FInputFileName;
    property LineSeparator: Byte read FLineSeparator write FLineSeparator;
    property OutputFileName: string read FOutputFileName write FOutputFileName;
    property RenameFiles: Boolean read FRenameFiles write FRenameFiles;
  end;
  
procedure Register;

implementation
{
*************************************** TTxtToDos ****************************************
}
procedure TTxtToDos.CloseFiles;
begin
  try
    CloseFile( FInputFile);
  except
  end;
  
  try
    CloseFile( FOutputFile);
  except
  end;
  
  if FRenameFiles then
  begin
    if DeleteFile( FInputFileName) then
    begin
      RenameFile( FOutputFileName, 
                  ExtractFilePath( FOutputFileName) + ExtractFileName( FInputFileName));
    
    end;  
  end;
end;

function TTxtToDos.Execute: Boolean;
var
  Alfa: Char;
begin
  Result := False;

  if not OpenFiles then
  begin
    FRenameFiles := False;
    Exit;
  end;

  while not EOF( FInputFile) do
  begin
    Read( FInputFile, Alfa);
    try
      case Alfa of
        #13 : ;
        #10 : WriteLn( FOutputFile);
        else  Write( FOutputFile, Alfa);
      end;
    except
    end;
  end;

  Result := True;
  CloseFiles;
end;

function TTxtToDos.OpenFiles: Boolean;
begin
  Result := false;

  if ( CompareText( FOutputFileName, '') = 0) or
     ( CompareText( FOutputFileName, FInputFileName) = 0) then
    FOutputFileName := ChangeFileExt( FInputFileName, '.prn');
  
  if not FileExists( FInputFileName) then
    Exit;
  
  AssignFile( FInputFile, FInputFileName);
  AssignFile( FOutputFile, FOutputFileName);
  
  try
    Reset( FInputFile);
  except
    on E: Exception do ShowMessage(E.Message);
  end;
  
  try
    Rewrite( FOutputFile);
    Result := true;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
  
end;


procedure Register;
begin
  RegisterComponents('SX', [TTxtToDos]);
end;

end.


