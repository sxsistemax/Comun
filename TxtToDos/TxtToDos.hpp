// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TxtToDos.pas' rev: 5.00

#ifndef TxtToDosHPP
#define TxtToDosHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Txttodos
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TTxtToDos;
class PASCALIMPLEMENTATION TTxtToDos : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TextFile FInputFile;
	AnsiString FInputFileName;
	Byte FLineSeparator;
	TextFile FOutputFile;
	AnsiString FOutputFileName;
	bool FRenameFiles;
	void __fastcall CloseFiles(void);
	bool __fastcall OpenFiles(void);
	
public:
	bool __fastcall Execute(void);
	
__published:
	__property AnsiString InputFileName = {read=FInputFileName, write=FInputFileName};
	__property Byte LineSeparator = {read=FLineSeparator, write=FLineSeparator, nodefault};
	__property AnsiString OutputFileName = {read=FOutputFileName, write=FOutputFileName};
	__property bool RenameFiles = {read=FRenameFiles, write=FRenameFiles, nodefault};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TTxtToDos(Classes::TComponent* AOwner) : Classes::TComponent(
		AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TTxtToDos(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Txttodos */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Txttodos;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TxtToDos
