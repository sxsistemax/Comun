unit uUtilidades;

interface

uses
  Dialogs, Controls,
  ExtCtrls, uDatos, SysUtils, Classes, Graphics, Menus;

function Confirmar( AMensaje : WideString) : Boolean;

implementation


function Confirmar( AMensaje : WideString) : Boolean;
begin
  result := MessageDlg(AMensaje, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

end.
