// Procedimientos para justificar textos

unit uJustificar;

interface

function Justificar( ACadena : string; ALargo : Word; ACaracter : char) : String ;
function Justificar0( ACadena : string; ALargo : Word) : String ;
function JustificarE( ACadena : string; ALargo : Word) : String ;


implementation

uses SysUtils;

function Justificar( ACadena : string; ALargo : Word; ACaracter : char) : String ;
var
   s : string;
begin
   ALargo := ALargo - Length( Trim(  ACadena));
   setLength( s, ALargo);
   fillchar( s[1], ALargo, ACaracter);
   Result := s + Trim( ACadena);
end;

function Justificar0( ACadena : string; ALargo : Word) : String ;
begin
  Result := Justificar( ACadena, ALargo, '0');
end;

function JustificarE( ACadena : string; ALargo : Word) : String ;
begin
  Result := Justificar( ACadena, ALargo, ' ');
end;

end.
 