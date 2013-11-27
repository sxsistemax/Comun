unit VAccessLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.130  $
// File generated on 09/07/2002 23:48:35 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\PVSW\Bin\ACBtr732.ocx (1)
// LIBID: {47E7B6C9-8256-11CF-AB56-0000C04D1EB9}
// LCID: 0
// Helpfile: C:\PVSW\Bin\prog_ocx.HLP
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\System32\STDVCL40.DLL)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}

interface

uses ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants, 
Windows;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  VAccessLibMajorVersion = 7;
  VAccessLibMinorVersion = 0;

  LIBID_VAccessLib: TGUID = '{47E7B6C9-8256-11CF-AB56-0000C04D1EB9}';

  DIID__DVAccess: TGUID = '{47E7B6C7-8256-11CF-AB56-0000C04D1EB9}';
  DIID__DVAccessEvents: TGUID = '{47E7B6C8-8256-11CF-AB56-0000C04D1EB9}';
  IID_ISWData: TGUID = '{47E7B6C4-8256-11CF-AB56-0000C04D1EB6}';
  IID_IVAccessDual: TGUID = '{A04F9C40-5051-11D1-AB57-0000C04D1EB6}';
  CLASS_VAccess: TGUID = '{47E7B6C6-8256-11CF-AB56-0000C04D1EB9}';
  DIID_IBuffer: TGUID = '{12BFF8D1-889C-11CE-AEB1-524153480000}';
  DIID_IColumn: TGUID = '{B9A4A790-C549-11CE-AF3C-524153480003}';
  CLASS_CColumn: TGUID = '{B9A4A791-C549-11CE-AF3C-524153480003}';
  DIID_IColumns: TGUID = '{4F328460-CA9F-11CE-AF46-524153480003}';
  CLASS_CColumns: TGUID = '{4F328461-CA9F-11CE-AF46-524153480003}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum enumOpenMode
type
  enumOpenMode = TOleEnum;
const
  Normal = $00000000;
  Accelerated = $00000001;
  ReadOnly = $00000002;
  Verify = $00000003;
  Exclusive = $00000004;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DVAccess = dispinterface;
  _DVAccessEvents = dispinterface;
  ISWData = interface;
  IVAccessDual = interface;
  IVAccessDualDisp = dispinterface;
  IBuffer = dispinterface;
  IColumn = dispinterface;
  IColumns = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  VAccess = IVAccessDual;
  CColumn = IColumn;
  CColumns = IColumns;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}
  PSmallint1 = ^Smallint; {*}
  PWordBool1 = ^WordBool; {*}
  PWideString1 = ^WideString; {*}


// *********************************************************************//
// DispIntf:  _DVAccess
// Flags:     (4112) Hidden Dispatchable
// GUID:      {47E7B6C7-8256-11CF-AB56-0000C04D1EB9}
// *********************************************************************//
  _DVAccess = dispinterface
    ['{47E7B6C7-8256-11CF-AB56-0000C04D1EB9}']
    property FireEvents: WordBool dispid 39;
    property DataLength: Integer dispid 41;
    property DdfPath: WideString dispid 42;
    property SelectedRecords: WideString dispid 17;
    property TotalRecords: Integer dispid 23;
    property Rows: Smallint dispid 15;
    property SelectedFields: WideString dispid 16;
    property FileVersion: Single dispid 36;
    property CacheRows: Smallint dispid 5;
    property CancelDialog: WordBool dispid 6;
    property _VAccessName: WideString dispid 0;
    property AutoMode: WordBool dispid 4;
    property VADebugMode: WordBool dispid 37;
    property ExtendedOps: WordBool dispid 38;
    property RowPosition: Integer dispid 14;
    property FieldList: OleVariant dispid 124;
    property IndexList: OleVariant dispid 125;
    function  GetGreater(vLockBias: OleVariant): Smallint; dispid 112;
    function  GetPrevious(vLockBias: OleVariant): Smallint; dispid 111;
    function  GetNext(vLockBias: OleVariant): Smallint; dispid 110;
    function  GetGreaterOrEqual(vLockBias: OleVariant): Smallint; dispid 113;
    function  StepLast(vLockBias: OleVariant): Smallint; dispid 121;
    property CacheRejectMax: Integer dispid 19;
    property PageSize: Smallint dispid 22;
    function  StepPrevious(vLockBias: OleVariant): Smallint; dispid 122;
    function  GetTableList: OleVariant; dispid 123;
    function  StepFirst(vLockBias: OleVariant): Smallint; dispid 120;
    function  StepNext(vLockBias: OleVariant): Smallint; dispid 119;
    property TableName: WideString dispid 53;
    property CompressData: WordBool dispid 70;
    property Port: Smallint dispid 69;
    property OpenMode: enumOpenMode dispid 58;
    property Join: WideString dispid 56;
    property Location: WideString dispid 57;
    property OwnerName: WideString dispid 59;
    property AutoDialog: WordBool dispid 71;
    property FileID: Smallint dispid 52;
    property HostConnect: WordBool dispid 67;
    property HostAddress: WideString dispid 66;
    property Fields: Smallint dispid 51;
    property DatabaseName: WideString dispid 73;
    property AutoLogon: WordBool dispid 72;
    property TimeOutVal: Smallint dispid 68;
    property Row: Smallint dispid 13;
    property Column: Smallint dispid 7;
    property Columns: Smallint dispid 8;
    property MaxBufferSize: Integer dispid 12;
    property RefreshLocations: WordBool dispid 2;
    property OemString: Smallint dispid 3;
    property IncludeCurrent: WordBool dispid 11;
    property ColumnName: WideString dispid 10;
    property DdfTransactionMode: Smallint dispid 64;
    property Percentage: Smallint dispid 60;
    property IndexNumber: Smallint dispid 55;
    property DdfKeyUseIndexDDFOnly: WordBool dispid 65;
    property AutoOpen: WordBool dispid 62;
    property Position: Integer dispid 61;
    property Status: Smallint dispid 63;
    function  GetLess(vLockBias: OleVariant): Smallint; dispid 114;
    function  StatusDialog(Status: Smallint): Smallint; dispid 80;
    function  Delete: Smallint; dispid 79;
    procedure ShowSelectedRecordsDlg; dispid 82;
    function  StepPreviousExtended: Smallint; dispid 92;
    function  SetOwner(const OwnerName: WideString; nSecurityLevel: Smallint): Smallint; dispid 102;
    function  Unlock(nLockType: Smallint): Smallint; dispid 105;
    function  Transaction(nOpCode: Smallint): Smallint; dispid 104;
    procedure ShowSelectedFieldsDlg; dispid 81;
    function  Close: Smallint; dispid 76;
    function  GetNextExtended: Smallint; dispid 89;
    function  VAUDIndexData(var vIndexData: OleVariant): WordBool; dispid 88;
    function  Insert: Smallint; dispid 77;
    function  Update: Smallint; dispid 78;
    function  Open: Smallint; dispid 75;
    property SessionID: Smallint dispid 74;
    function  VAUDFieldFulList(var vFieldList: OleVariant): WordBool; dispid 97;
    function  Init: Smallint; dispid 94;
    function  RowColumnValue(Row: Smallint; Column: Smallint): OleVariant; dispid 93;
    function  SetFileFlag(nFlagIndex: Smallint; bSet: WordBool): Smallint; dispid 100;
    function  GetFileFlag(nFlagIndex: Smallint): WordBool; dispid 99;
    function  GetTotalSegments(nKeyNum: Smallint): Smallint; dispid 98;
    function  Create(bVer6: WordBool): Smallint; dispid 101;
    function  VAUDFieldList(var vFieldList: OleVariant): WordBool; dispid 96;
    function  Btrv(nOpCode: Smallint): Smallint; dispid 108;
    function  FormatFieldValue(const FieldName: WideString; const Format: WideString): WideString; dispid 106;
    function  Stat: Smallint; dispid 103;
    function  GetEqual(vLockBias: OleVariant): Smallint; dispid 109;
    procedure Clear; dispid 95;
    property FieldValue[vFieldID: OleVariant]: OleVariant dispid 107;
    procedure Refresh; dispid -550;
    function  DdfSetOwner(const newOwnerName: WideString; nSecurityLevel: Smallint): Smallint; dispid 140;
    function  DdfAddTableName(const newTableName: WideString): Smallint; dispid 137;
    procedure AboutBox; dispid -552;
    function  DdfTestOwnerName(const newOwnerName: WideString): Smallint; dispid 129;
    property Buffer[alignment: Smallint]: OleVariant dispid 141;
    function  DdfCreateDictionary(bOverWrite: WordBool): Smallint; dispid 136;
    function  GetLessOrEqual(vLockBias: OleVariant): Smallint; dispid 115;
    function  GetDirect(vLockBias: OleVariant): Smallint; dispid 118;
    function  GetLast(vLockBias: OleVariant): Smallint; dispid 117;
    function  GetFirst(vLockBias: OleVariant): Smallint; dispid 116;
    function  DdfClearFields: Smallint; dispid 139;
    function  DdfClearIndexes: Smallint; dispid 138;
    function  DdfModifyTableName(const newTableName: WideString): Smallint; dispid 126;
    function  OpCode(OpCode: Smallint): Smallint; dispid 83;
    function  VAUDIndexList(var vIndexList: OleVariant): WordBool; dispid 86;
    function  VAUDLocation(var csaLocation: OleVariant): WordBool; dispid 85;
    function  VAUDTableNames(var csaTableNames: OleVariant): WordBool; dispid 84;
    function  StepNextExtended: Smallint; dispid 91;
    function  GetPreviousExtended: Smallint; dispid 90;
    function  VAUDControlNames(var csaControlNames: OleVariant): WordBool; dispid 87;
    function  DdfDropIndex(keyNum: Smallint): Smallint; dispid 133;
    function  DdfGetFieldComments: Smallint; dispid 128;
    function  DdfModifyLocation(const newLocation: WideString): Smallint; dispid 127;
    function  DdfAddTable(bOverWrite: WordBool): Smallint; dispid 130;
    function  DdfDropTable: Smallint; dispid 131;
    function  DdfAddIndex(vIndexList: OleVariant): Smallint; dispid 132;
    function  DdfCreateTable(bOverWrite: WordBool): Smallint; dispid 135;
    function  DdfDropIndexMaintain(keyNum: Smallint): Smallint; dispid 134;
    property ACSName: WideString dispid 28;
    property PreallocatedPages: Smallint dispid 26;
    property TotalKeys: Smallint dispid 24;
    property FieldFormat: WideString dispid 44;
    property FieldId: Smallint dispid 45;
    property ReservedDupPointers: Smallint dispid 27;
    property PercentFreeSpace: Smallint dispid 25;
    property KeyType: Smallint dispid 32;
    property KeyPos: Smallint dispid 30;
    property KeyLen: Smallint dispid 31;
    property CollatingSequence: WideString dispid 29;
    property SegmentNumber: Smallint dispid 33;
    property KeyNumber: Smallint dispid 34;
    property FieldIndex: Smallint dispid 46;
    property Value: WideString dispid 18;
    property VAUDDDFLength: Integer dispid 20;
    property FieldType: Smallint dispid 50;
    property BlankChar: Smallint dispid 1;
    property ColumnFormat: WideString dispid 9;
    property VAccessName: WideString dispid 21;
    property FieldSize: Smallint dispid 49;
    property FieldDec: Smallint dispid 43;
    property FieldName: WideString dispid 47;
    property FieldPosition: Smallint dispid 48;
    property Queries: WideString dispid 40;
    property KeyDescription: WideString dispid 35;
    property FileName: WideString dispid 54;
  end;

// *********************************************************************//
// DispIntf:  _DVAccessEvents
// Flags:     (4096) Dispatchable
// GUID:      {47E7B6C8-8256-11CF-AB56-0000C04D1EB9}
// *********************************************************************//
  _DVAccessEvents = dispinterface
    ['{47E7B6C8-8256-11CF-AB56-0000C04D1EB9}']
    procedure Reposition; dispid 1;
    procedure GotData(numRows: Integer; numCols: Smallint); dispid 2;
    procedure Validate(var OpCode: Smallint; var insertRecord: Smallint; var updateRecord: Smallint); dispid 3;
    procedure CommError(canRecover: WordBool; wsErrCode: Smallint; const errorString: WideString; 
                        var tryAgain: WordBool); dispid 4;
    procedure Logon(var user: WideString; var password: WideString; var databaseSet: WideString); dispid 5;
    procedure OnRemote(var goRemote: WordBool; var newLocation: WideString); dispid 6;
  end;

// *********************************************************************//
// Interface: ISWData
// Flags:     (0)
// GUID:      {47E7B6C4-8256-11CF-AB56-0000C04D1EB6}
// *********************************************************************//
  ISWData = interface
    ['{47E7B6C4-8256-11CF-AB56-0000C04D1EB6}']
  end;

// *********************************************************************//
// Interface: IVAccessDual
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A04F9C40-5051-11D1-AB57-0000C04D1EB6}
// *********************************************************************//
  IVAccessDual = interface(IDispatch)
    ['{A04F9C40-5051-11D1-AB57-0000C04D1EB6}']
    procedure Set__VAccessName(const newText: WideString); safecall;
    function  Get__VAccessName: WideString; safecall;
    procedure Set_BlankChar(newVal: Smallint); safecall;
    function  Get_BlankChar: Smallint; safecall;
    procedure Set_RefreshLocations(newVal: WordBool); safecall;
    function  Get_RefreshLocations: WordBool; safecall;
    procedure Set_OemString(newVal: Smallint); safecall;
    function  Get_OemString: Smallint; safecall;
    procedure Set_AutoMode(newVal: WordBool); safecall;
    function  Get_AutoMode: WordBool; safecall;
    procedure Set_CacheRows(newVal: Smallint); safecall;
    function  Get_CacheRows: Smallint; safecall;
    procedure Set_CancelDialog(newVal: WordBool); safecall;
    function  Get_CancelDialog: WordBool; safecall;
    procedure Set_Column(newVal: Smallint); safecall;
    function  Get_Column: Smallint; safecall;
    procedure Set_Columns(newVal: Smallint); safecall;
    function  Get_Columns: Smallint; safecall;
    procedure Set_ColumnFormat(const newVal: WideString); safecall;
    function  Get_ColumnFormat: WideString; safecall;
    procedure Set_ColumnName(const newVal: WideString); safecall;
    function  Get_ColumnName: WideString; safecall;
    procedure Set_IncludeCurrent(newVal: WordBool); safecall;
    function  Get_IncludeCurrent: WordBool; safecall;
    procedure Set_MaxBufferSize(newVal: Integer); safecall;
    function  Get_MaxBufferSize: Integer; safecall;
    procedure Set_Row(newVal: Smallint); safecall;
    function  Get_Row: Smallint; safecall;
    procedure Set_RowPosition(newVal: Integer); safecall;
    function  Get_RowPosition: Integer; safecall;
    procedure Set_Rows(newVal: Smallint); safecall;
    function  Get_Rows: Smallint; safecall;
    procedure Set_SelectedFields(const newVal: WideString); safecall;
    function  Get_SelectedFields: WideString; safecall;
    procedure Set_SelectedRecords(const newVal: WideString); safecall;
    function  Get_SelectedRecords: WideString; safecall;
    procedure Set_Value(const newVal: WideString); safecall;
    function  Get_Value: WideString; safecall;
    procedure Set_CacheRejectMax(newVal: Integer); safecall;
    function  Get_CacheRejectMax: Integer; safecall;
    procedure Set_VAUDDDFLength(newVal: Integer); safecall;
    function  Get_VAUDDDFLength: Integer; safecall;
    procedure Set_VAccessName(const newVal: WideString); safecall;
    function  Get_VAccessName: WideString; safecall;
    procedure Set_PageSize(newVal: Smallint); safecall;
    function  Get_PageSize: Smallint; safecall;
    procedure Set_TotalRecords(newVal: Integer); safecall;
    function  Get_TotalRecords: Integer; safecall;
    procedure Set_TotalKeys(newVal: Smallint); safecall;
    function  Get_TotalKeys: Smallint; safecall;
    procedure Set_PercentFreeSpace(newVal: Smallint); safecall;
    function  Get_PercentFreeSpace: Smallint; safecall;
    procedure Set_PreallocatedPages(newVal: Smallint); safecall;
    function  Get_PreallocatedPages: Smallint; safecall;
    procedure Set_ReservedDupPointers(newVal: Smallint); safecall;
    function  Get_ReservedDupPointers: Smallint; safecall;
    procedure Set_ACSName(const newVal: WideString); safecall;
    function  Get_ACSName: WideString; safecall;
    procedure Set_CollatingSequence(const newVal: WideString); safecall;
    function  Get_CollatingSequence: WideString; safecall;
    procedure Set_KeyPos(newVal: Smallint); safecall;
    function  Get_KeyPos: Smallint; safecall;
    procedure Set_KeyLen(newVal: Smallint); safecall;
    function  Get_KeyLen: Smallint; safecall;
    procedure Set_KeyType(newVal: Smallint); safecall;
    function  Get_KeyType: Smallint; safecall;
    procedure Set_SegmentNumber(newVal: Smallint); safecall;
    function  Get_SegmentNumber: Smallint; safecall;
    procedure Set_KeyNumber(newVal: Smallint); safecall;
    function  Get_KeyNumber: Smallint; safecall;
    procedure Set_KeyDescription(const newVal: WideString); safecall;
    function  Get_KeyDescription: WideString; safecall;
    procedure Set_FileVersion(newVal: Single); safecall;
    function  Get_FileVersion: Single; safecall;
    procedure Set_VADebugMode(newVal: WordBool); safecall;
    function  Get_VADebugMode: WordBool; safecall;
    procedure Set_ExtendedOps(newVal: WordBool); safecall;
    function  Get_ExtendedOps: WordBool; safecall;
    procedure Set_FireEvents(newVal: WordBool); safecall;
    function  Get_FireEvents: WordBool; safecall;
    procedure Set_Queries(const newVal: WideString); safecall;
    function  Get_Queries: WideString; safecall;
    procedure Set_DataLength(newVal: Integer); safecall;
    function  Get_DataLength: Integer; safecall;
    procedure Set_DdfPath(const newVal: WideString); safecall;
    function  Get_DdfPath: WideString; safecall;
    procedure Set_FieldDec(newVal: Smallint); safecall;
    function  Get_FieldDec: Smallint; safecall;
    procedure Set_FieldFormat(const newVal: WideString); safecall;
    function  Get_FieldFormat: WideString; safecall;
    procedure Set_FieldId(newVal: Smallint); safecall;
    function  Get_FieldId: Smallint; safecall;
    procedure Set_FieldIndex(newVal: Smallint); safecall;
    function  Get_FieldIndex: Smallint; safecall;
    procedure Set_FieldName(const newVal: WideString); safecall;
    function  Get_FieldName: WideString; safecall;
    procedure Set_FieldPosition(newVal: Smallint); safecall;
    function  Get_FieldPosition: Smallint; safecall;
    procedure Set_FieldSize(newVal: Smallint); safecall;
    function  Get_FieldSize: Smallint; safecall;
    procedure Set_FieldType(newVal: Smallint); safecall;
    function  Get_FieldType: Smallint; safecall;
    procedure Set_Fields(newVal: Smallint); safecall;
    function  Get_Fields: Smallint; safecall;
    procedure Set_FileID(newVal: Smallint); safecall;
    function  Get_FileID: Smallint; safecall;
    procedure Set_TableName(const newVal: WideString); safecall;
    function  Get_TableName: WideString; safecall;
    procedure Set_FileName(const newVal: WideString); safecall;
    function  Get_FileName: WideString; safecall;
    procedure Set_IndexNumber(newVal: Smallint); safecall;
    function  Get_IndexNumber: Smallint; safecall;
    procedure Set_Join(const newVal: WideString); safecall;
    function  Get_Join: WideString; safecall;
    procedure Set_Location(const newVal: WideString); safecall;
    function  Get_Location: WideString; safecall;
    procedure Set_OpenMode(newVal: enumOpenMode); safecall;
    function  Get_OpenMode: enumOpenMode; safecall;
    procedure Set_OwnerName(const newVal: WideString); safecall;
    function  Get_OwnerName: WideString; safecall;
    procedure Set_Percentage(newVal: Smallint); safecall;
    function  Get_Percentage: Smallint; safecall;
    procedure Set_Position(newVal: Integer); safecall;
    function  Get_Position: Integer; safecall;
    procedure Set_AutoOpen(newVal: WordBool); safecall;
    function  Get_AutoOpen: WordBool; safecall;
    procedure Set_Status(newVal: Smallint); safecall;
    function  Get_Status: Smallint; safecall;
    procedure Set_DdfTransactionMode(newVal: WordBool); safecall;
    function  Get_DdfTransactionMode: WordBool; safecall;
    procedure Set_DdfKeyUseIndexDDFOnly(newVal: WordBool); safecall;
    function  Get_DdfKeyUseIndexDDFOnly: WordBool; safecall;
    procedure Set_HostAddress(const newVal: WideString); safecall;
    function  Get_HostAddress: WideString; safecall;
    procedure Set_HostConnect(newVal: WordBool); safecall;
    function  Get_HostConnect: WordBool; safecall;
    procedure Set_TimeOutVal(newVal: Smallint); safecall;
    function  Get_TimeOutVal: Smallint; safecall;
    procedure Set_Port(newVal: Smallint); safecall;
    function  Get_Port: Smallint; safecall;
    procedure Set_CompressData(newVal: WordBool); safecall;
    function  Get_CompressData: WordBool; safecall;
    procedure Set_AutoDialog(newVal: WordBool); safecall;
    function  Get_AutoDialog: WordBool; safecall;
    procedure Set_AutoLogon(newVal: WordBool); safecall;
    function  Get_AutoLogon: WordBool; safecall;
    procedure Set_DatabaseName(const newVal: WideString); safecall;
    function  Get_DatabaseName: WideString; safecall;
    procedure Set_SessionID(newVal: Smallint); safecall;
    function  Get_SessionID: Smallint; safecall;
    function  Open: Smallint; safecall;
    function  Close: Smallint; safecall;
    function  Insert: Smallint; safecall;
    function  Update: Smallint; safecall;
    function  Delete: Smallint; safecall;
    function  StatusDialog(Status: Smallint): Smallint; safecall;
    procedure ShowSelectedFieldsDlg; safecall;
    procedure ShowSelectedRecordsDlg; safecall;
    function  OpCode(OpCode: Smallint): Smallint; safecall;
    function  VAUDTableNames(var csaTableNames: OleVariant): WordBool; safecall;
    function  VAUDLocation(var csaLocation: OleVariant): WordBool; safecall;
    function  VAUDIndexList(var vIndexList: OleVariant): WordBool; safecall;
    function  VAUDControlNames(var csaControlNames: OleVariant): WordBool; safecall;
    function  VAUDIndexData(var vIndexData: OleVariant): WordBool; safecall;
    function  GetNextExtended: Smallint; safecall;
    function  GetPreviousExtended: Smallint; safecall;
    function  StepNextExtended: Smallint; safecall;
    function  StepPreviousExtended: Smallint; safecall;
    function  RowColumnValue(Row: Smallint; Column: Smallint): OleVariant; safecall;
    function  Init: Smallint; safecall;
    procedure Clear; safecall;
    function  VAUDFieldList(var vFieldList: OleVariant): WordBool; safecall;
    function  VAUDFieldFulList(var vFieldList: OleVariant): WordBool; safecall;
    function  GetTotalSegments(nKeyNum: Smallint): Smallint; safecall;
    function  GetFileFlag(nFlagIndex: Smallint): WordBool; safecall;
    function  SetFileFlag(nFlagIndex: Smallint; bSet: WordBool): Smallint; safecall;
    function  Create(bVer6: WordBool): Smallint; safecall;
    function  SetOwner(const OwnerName: WideString; nSecurityLevel: Smallint): Smallint; safecall;
    function  Stat: Smallint; safecall;
    function  Transaction(nOpCode: Smallint): Smallint; safecall;
    function  Unlock(nLockType: Smallint): Smallint; safecall;
    function  FormatFieldValue(const FieldName: WideString; const Format: WideString): WideString; safecall;
    procedure Set_FieldValue(vFieldID: OleVariant; newVal: OleVariant); safecall;
    function  Get_FieldValue(vFieldID: OleVariant): OleVariant; safecall;
    function  Btrv(nOpCode: Smallint): Smallint; safecall;
    function  GetEqual(vLockBias: OleVariant): Smallint; safecall;
    function  GetNext(vLockBias: OleVariant): Smallint; safecall;
    function  GetPrevious(vLockBias: OleVariant): Smallint; safecall;
    function  GetGreater(vLockBias: OleVariant): Smallint; safecall;
    function  GetGreaterOrEqual(vLockBias: OleVariant): Smallint; safecall;
    function  GetLess(vLockBias: OleVariant): Smallint; safecall;
    function  GetLessOrEqual(vLockBias: OleVariant): Smallint; safecall;
    function  GetFirst(vLockBias: OleVariant): Smallint; safecall;
    function  GetLast(vLockBias: OleVariant): Smallint; safecall;
    function  GetDirect(vLockBias: OleVariant): Smallint; safecall;
    function  StepNext(vLockBias: OleVariant): Smallint; safecall;
    function  StepFirst(vLockBias: OleVariant): Smallint; safecall;
    function  StepLast(vLockBias: OleVariant): Smallint; safecall;
    function  StepPrevious(vLockBias: OleVariant): Smallint; safecall;
    function  GetTableList: OleVariant; safecall;
    procedure Set_FieldList(vFieldList: OleVariant); safecall;
    function  Get_FieldList: OleVariant; safecall;
    procedure Set_IndexList(vIndexList: OleVariant); safecall;
    function  Get_IndexList: OleVariant; safecall;
    function  DdfModifyTableName(const newTableName: WideString): Smallint; safecall;
    function  DdfModifyLocation(const newLocation: WideString): Smallint; safecall;
    function  DdfGetFieldComments: Smallint; safecall;
    function  DdfTestOwnerName(const newOwnerName: WideString): Smallint; safecall;
    function  DdfAddTable(bOverWrite: WordBool): Smallint; safecall;
    function  DdfDropTable: Smallint; safecall;
    function  DdfAddIndex(vIndexList: OleVariant): Smallint; safecall;
    function  DdfDropIndex(keyNum: Smallint): Smallint; safecall;
    function  DdfDropIndexMaintain(keyNum: Smallint): Smallint; safecall;
    function  DdfCreateTable(bOverWrite: WordBool): Smallint; safecall;
    function  DdfCreateDictionary(bOverWrite: WordBool): Smallint; safecall;
    function  DdfAddTableName(const newTableName: WideString): Smallint; safecall;
    function  DdfClearIndexes: Smallint; safecall;
    function  DdfClearFields: Smallint; safecall;
    function  DdfSetOwner(const newOwnerName: WideString; nSecurityLevel: Smallint): Smallint; safecall;
    procedure Set_Buffer(alignment: Smallint; bufferVal: OleVariant); safecall;
    function  Get_Buffer(alignment: Smallint): OleVariant; safecall;
    procedure Refresh; safecall;
    procedure AboutBox; safecall;
    property _VAccessName: WideString read Get__VAccessName write Set__VAccessName;
    property BlankChar: Smallint read Get_BlankChar write Set_BlankChar;
    property RefreshLocations: WordBool read Get_RefreshLocations write Set_RefreshLocations;
    property OemString: Smallint read Get_OemString write Set_OemString;
    property AutoMode: WordBool read Get_AutoMode write Set_AutoMode;
    property CacheRows: Smallint read Get_CacheRows write Set_CacheRows;
    property CancelDialog: WordBool read Get_CancelDialog write Set_CancelDialog;
    property Column: Smallint read Get_Column write Set_Column;
    property Columns: Smallint read Get_Columns write Set_Columns;
    property ColumnFormat: WideString read Get_ColumnFormat write Set_ColumnFormat;
    property ColumnName: WideString read Get_ColumnName write Set_ColumnName;
    property IncludeCurrent: WordBool read Get_IncludeCurrent write Set_IncludeCurrent;
    property MaxBufferSize: Integer read Get_MaxBufferSize write Set_MaxBufferSize;
    property Row: Smallint read Get_Row write Set_Row;
    property RowPosition: Integer read Get_RowPosition write Set_RowPosition;
    property Rows: Smallint read Get_Rows write Set_Rows;
    property SelectedFields: WideString read Get_SelectedFields write Set_SelectedFields;
    property SelectedRecords: WideString read Get_SelectedRecords write Set_SelectedRecords;
    property Value: WideString read Get_Value write Set_Value;
    property CacheRejectMax: Integer read Get_CacheRejectMax write Set_CacheRejectMax;
    property VAUDDDFLength: Integer read Get_VAUDDDFLength write Set_VAUDDDFLength;
    property VAccessName: WideString read Get_VAccessName write Set_VAccessName;
    property PageSize: Smallint read Get_PageSize write Set_PageSize;
    property TotalRecords: Integer read Get_TotalRecords write Set_TotalRecords;
    property TotalKeys: Smallint read Get_TotalKeys write Set_TotalKeys;
    property PercentFreeSpace: Smallint read Get_PercentFreeSpace write Set_PercentFreeSpace;
    property PreallocatedPages: Smallint read Get_PreallocatedPages write Set_PreallocatedPages;
    property ReservedDupPointers: Smallint read Get_ReservedDupPointers write Set_ReservedDupPointers;
    property ACSName: WideString read Get_ACSName write Set_ACSName;
    property CollatingSequence: WideString read Get_CollatingSequence write Set_CollatingSequence;
    property KeyPos: Smallint read Get_KeyPos write Set_KeyPos;
    property KeyLen: Smallint read Get_KeyLen write Set_KeyLen;
    property KeyType: Smallint read Get_KeyType write Set_KeyType;
    property SegmentNumber: Smallint read Get_SegmentNumber write Set_SegmentNumber;
    property KeyNumber: Smallint read Get_KeyNumber write Set_KeyNumber;
    property KeyDescription: WideString read Get_KeyDescription write Set_KeyDescription;
    property FileVersion: Single read Get_FileVersion write Set_FileVersion;
    property VADebugMode: WordBool read Get_VADebugMode write Set_VADebugMode;
    property ExtendedOps: WordBool read Get_ExtendedOps write Set_ExtendedOps;
    property FireEvents: WordBool read Get_FireEvents write Set_FireEvents;
    property Queries: WideString read Get_Queries write Set_Queries;
    property DataLength: Integer read Get_DataLength write Set_DataLength;
    property DdfPath: WideString read Get_DdfPath write Set_DdfPath;
    property FieldDec: Smallint read Get_FieldDec write Set_FieldDec;
    property FieldFormat: WideString read Get_FieldFormat write Set_FieldFormat;
    property FieldId: Smallint read Get_FieldId write Set_FieldId;
    property FieldIndex: Smallint read Get_FieldIndex write Set_FieldIndex;
    property FieldName: WideString read Get_FieldName write Set_FieldName;
    property FieldPosition: Smallint read Get_FieldPosition write Set_FieldPosition;
    property FieldSize: Smallint read Get_FieldSize write Set_FieldSize;
    property FieldType: Smallint read Get_FieldType write Set_FieldType;
    property Fields: Smallint read Get_Fields write Set_Fields;
    property FileID: Smallint read Get_FileID write Set_FileID;
    property TableName: WideString read Get_TableName write Set_TableName;
    property FileName: WideString read Get_FileName write Set_FileName;
    property IndexNumber: Smallint read Get_IndexNumber write Set_IndexNumber;
    property Join: WideString read Get_Join write Set_Join;
    property Location: WideString read Get_Location write Set_Location;
    property OpenMode: enumOpenMode read Get_OpenMode write Set_OpenMode;
    property OwnerName: WideString read Get_OwnerName write Set_OwnerName;
    property Percentage: Smallint read Get_Percentage write Set_Percentage;
    property Position: Integer read Get_Position write Set_Position;
    property AutoOpen: WordBool read Get_AutoOpen write Set_AutoOpen;
    property Status: Smallint read Get_Status write Set_Status;
    property DdfTransactionMode: WordBool read Get_DdfTransactionMode write Set_DdfTransactionMode;
    property DdfKeyUseIndexDDFOnly: WordBool read Get_DdfKeyUseIndexDDFOnly write Set_DdfKeyUseIndexDDFOnly;
    property HostAddress: WideString read Get_HostAddress write Set_HostAddress;
    property HostConnect: WordBool read Get_HostConnect write Set_HostConnect;
    property TimeOutVal: Smallint read Get_TimeOutVal write Set_TimeOutVal;
    property Port: Smallint read Get_Port write Set_Port;
    property CompressData: WordBool read Get_CompressData write Set_CompressData;
    property AutoDialog: WordBool read Get_AutoDialog write Set_AutoDialog;
    property AutoLogon: WordBool read Get_AutoLogon write Set_AutoLogon;
    property DatabaseName: WideString read Get_DatabaseName write Set_DatabaseName;
    property SessionID: Smallint read Get_SessionID write Set_SessionID;
    property FieldValue[vFieldID: OleVariant]: OleVariant read Get_FieldValue write Set_FieldValue;
    property FieldList: OleVariant read Get_FieldList write Set_FieldList;
    property IndexList: OleVariant read Get_IndexList write Set_IndexList;
    property Buffer[alignment: Smallint]: OleVariant read Get_Buffer write Set_Buffer;
  end;

// *********************************************************************//
// DispIntf:  IVAccessDualDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A04F9C40-5051-11D1-AB57-0000C04D1EB6}
// *********************************************************************//
  IVAccessDualDisp = dispinterface
    ['{A04F9C40-5051-11D1-AB57-0000C04D1EB6}']
    property _VAccessName: WideString dispid 0;
    property BlankChar: Smallint dispid 1;
    property RefreshLocations: WordBool dispid 2;
    property OemString: Smallint dispid 3;
    property AutoMode: WordBool dispid 4;
    property CacheRows: Smallint dispid 5;
    property CancelDialog: WordBool dispid 6;
    property Column: Smallint dispid 7;
    property Columns: Smallint dispid 8;
    property ColumnFormat: WideString dispid 9;
    property ColumnName: WideString dispid 10;
    property IncludeCurrent: WordBool dispid 11;
    property MaxBufferSize: Integer dispid 12;
    property Row: Smallint dispid 13;
    property RowPosition: Integer dispid 14;
    property Rows: Smallint dispid 15;
    property SelectedFields: WideString dispid 16;
    property SelectedRecords: WideString dispid 17;
    property Value: WideString dispid 18;
    property CacheRejectMax: Integer dispid 19;
    property VAUDDDFLength: Integer dispid 20;
    property VAccessName: WideString dispid 21;
    property PageSize: Smallint dispid 22;
    property TotalRecords: Integer dispid 23;
    property TotalKeys: Smallint dispid 24;
    property PercentFreeSpace: Smallint dispid 25;
    property PreallocatedPages: Smallint dispid 26;
    property ReservedDupPointers: Smallint dispid 27;
    property ACSName: WideString dispid 28;
    property CollatingSequence: WideString dispid 29;
    property KeyPos: Smallint dispid 30;
    property KeyLen: Smallint dispid 31;
    property KeyType: Smallint dispid 32;
    property SegmentNumber: Smallint dispid 33;
    property KeyNumber: Smallint dispid 34;
    property KeyDescription: WideString dispid 35;
    property FileVersion: Single dispid 36;
    property VADebugMode: WordBool dispid 37;
    property ExtendedOps: WordBool dispid 38;
    property FireEvents: WordBool dispid 39;
    property Queries: WideString dispid 40;
    property DataLength: Integer dispid 41;
    property DdfPath: WideString dispid 42;
    property FieldDec: Smallint dispid 43;
    property FieldFormat: WideString dispid 44;
    property FieldId: Smallint dispid 45;
    property FieldIndex: Smallint dispid 46;
    property FieldName: WideString dispid 47;
    property FieldPosition: Smallint dispid 48;
    property FieldSize: Smallint dispid 49;
    property FieldType: Smallint dispid 50;
    property Fields: Smallint dispid 51;
    property FileID: Smallint dispid 52;
    property TableName: WideString dispid 53;
    property FileName: WideString dispid 54;
    property IndexNumber: Smallint dispid 55;
    property Join: WideString dispid 56;
    property Location: WideString dispid 57;
    property OpenMode: enumOpenMode dispid 58;
    property OwnerName: WideString dispid 59;
    property Percentage: Smallint dispid 60;
    property Position: Integer dispid 61;
    property AutoOpen: WordBool dispid 62;
    property Status: Smallint dispid 63;
    property DdfTransactionMode: WordBool dispid 64;
    property DdfKeyUseIndexDDFOnly: WordBool dispid 65;
    property HostAddress: WideString dispid 66;
    property HostConnect: WordBool dispid 67;
    property TimeOutVal: Smallint dispid 68;
    property Port: Smallint dispid 69;
    property CompressData: WordBool dispid 70;
    property AutoDialog: WordBool dispid 71;
    property AutoLogon: WordBool dispid 72;
    property DatabaseName: WideString dispid 73;
    property SessionID: Smallint dispid 74;
    function  Open: Smallint; dispid 75;
    function  Close: Smallint; dispid 76;
    function  Insert: Smallint; dispid 77;
    function  Update: Smallint; dispid 78;
    function  Delete: Smallint; dispid 79;
    function  StatusDialog(Status: Smallint): Smallint; dispid 80;
    procedure ShowSelectedFieldsDlg; dispid 81;
    procedure ShowSelectedRecordsDlg; dispid 82;
    function  OpCode(OpCode: Smallint): Smallint; dispid 83;
    function  VAUDTableNames(var csaTableNames: OleVariant): WordBool; dispid 84;
    function  VAUDLocation(var csaLocation: OleVariant): WordBool; dispid 85;
    function  VAUDIndexList(var vIndexList: OleVariant): WordBool; dispid 86;
    function  VAUDControlNames(var csaControlNames: OleVariant): WordBool; dispid 87;
    function  VAUDIndexData(var vIndexData: OleVariant): WordBool; dispid 88;
    function  GetNextExtended: Smallint; dispid 89;
    function  GetPreviousExtended: Smallint; dispid 90;
    function  StepNextExtended: Smallint; dispid 91;
    function  StepPreviousExtended: Smallint; dispid 92;
    function  RowColumnValue(Row: Smallint; Column: Smallint): OleVariant; dispid 93;
    function  Init: Smallint; dispid 94;
    procedure Clear; dispid 95;
    function  VAUDFieldList(var vFieldList: OleVariant): WordBool; dispid 96;
    function  VAUDFieldFulList(var vFieldList: OleVariant): WordBool; dispid 97;
    function  GetTotalSegments(nKeyNum: Smallint): Smallint; dispid 98;
    function  GetFileFlag(nFlagIndex: Smallint): WordBool; dispid 99;
    function  SetFileFlag(nFlagIndex: Smallint; bSet: WordBool): Smallint; dispid 100;
    function  Create(bVer6: WordBool): Smallint; dispid 101;
    function  SetOwner(const OwnerName: WideString; nSecurityLevel: Smallint): Smallint; dispid 102;
    function  Stat: Smallint; dispid 103;
    function  Transaction(nOpCode: Smallint): Smallint; dispid 104;
    function  Unlock(nLockType: Smallint): Smallint; dispid 105;
    function  FormatFieldValue(const FieldName: WideString; const Format: WideString): WideString; dispid 106;
    property FieldValue[vFieldID: OleVariant]: OleVariant dispid 107;
    function  Btrv(nOpCode: Smallint): Smallint; dispid 108;
    function  GetEqual(vLockBias: OleVariant): Smallint; dispid 109;
    function  GetNext(vLockBias: OleVariant): Smallint; dispid 110;
    function  GetPrevious(vLockBias: OleVariant): Smallint; dispid 111;
    function  GetGreater(vLockBias: OleVariant): Smallint; dispid 112;
    function  GetGreaterOrEqual(vLockBias: OleVariant): Smallint; dispid 113;
    function  GetLess(vLockBias: OleVariant): Smallint; dispid 114;
    function  GetLessOrEqual(vLockBias: OleVariant): Smallint; dispid 115;
    function  GetFirst(vLockBias: OleVariant): Smallint; dispid 116;
    function  GetLast(vLockBias: OleVariant): Smallint; dispid 117;
    function  GetDirect(vLockBias: OleVariant): Smallint; dispid 118;
    function  StepNext(vLockBias: OleVariant): Smallint; dispid 119;
    function  StepFirst(vLockBias: OleVariant): Smallint; dispid 120;
    function  StepLast(vLockBias: OleVariant): Smallint; dispid 121;
    function  StepPrevious(vLockBias: OleVariant): Smallint; dispid 122;
    function  GetTableList: OleVariant; dispid 123;
    property FieldList: OleVariant dispid 124;
    property IndexList: OleVariant dispid 125;
    function  DdfModifyTableName(const newTableName: WideString): Smallint; dispid 126;
    function  DdfModifyLocation(const newLocation: WideString): Smallint; dispid 127;
    function  DdfGetFieldComments: Smallint; dispid 128;
    function  DdfTestOwnerName(const newOwnerName: WideString): Smallint; dispid 129;
    function  DdfAddTable(bOverWrite: WordBool): Smallint; dispid 130;
    function  DdfDropTable: Smallint; dispid 131;
    function  DdfAddIndex(vIndexList: OleVariant): Smallint; dispid 132;
    function  DdfDropIndex(keyNum: Smallint): Smallint; dispid 133;
    function  DdfDropIndexMaintain(keyNum: Smallint): Smallint; dispid 134;
    function  DdfCreateTable(bOverWrite: WordBool): Smallint; dispid 135;
    function  DdfCreateDictionary(bOverWrite: WordBool): Smallint; dispid 136;
    function  DdfAddTableName(const newTableName: WideString): Smallint; dispid 137;
    function  DdfClearIndexes: Smallint; dispid 138;
    function  DdfClearFields: Smallint; dispid 139;
    function  DdfSetOwner(const newOwnerName: WideString; nSecurityLevel: Smallint): Smallint; dispid 140;
    property Buffer[alignment: Smallint]: OleVariant dispid 141;
    procedure Refresh; dispid -550;
    procedure AboutBox; dispid -552;
  end;

// *********************************************************************//
// DispIntf:  IBuffer
// Flags:     (4112) Hidden Dispatchable
// GUID:      {12BFF8D1-889C-11CE-AEB1-524153480000}
// *********************************************************************//
  IBuffer = dispinterface
    ['{12BFF8D1-889C-11CE-AEB1-524153480000}']
    property RowCount: Integer dispid 1;
    property Bookmark[nRow: Integer]: OleVariant dispid 4;
    property Value[nRow: Integer; nColumn: Integer]: OleVariant dispid 6;
    property ColumnCount: Integer readonly dispid 2;
  end;

// *********************************************************************//
// DispIntf:  IColumn
// Flags:     (4112) Hidden Dispatchable
// GUID:      {B9A4A790-C549-11CE-AF3C-524153480003}
// *********************************************************************//
  IColumn = dispinterface
    ['{B9A4A790-C549-11CE-AF3C-524153480003}']
    property DataType: Integer dispid 1;
    property MaxLength: Integer dispid 2;
    property Updatable: WordBool dispid 3;
    property ColumnName: WideString dispid 4;
  end;

// *********************************************************************//
// DispIntf:  IColumns
// Flags:     (4112) Hidden Dispatchable
// GUID:      {4F328460-CA9F-11CE-AF46-524153480003}
// *********************************************************************//
  IColumns = dispinterface
    ['{4F328460-CA9F-11CE-AF46-524153480003}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Count: Integer readonly dispid 1;
    procedure Remove(index: OleVariant); dispid 2;
    procedure RemoveAll; dispid 3;
    property Item[index: OleVariant]: IDispatch readonly dispid 4;
    procedure Add(index: OleVariant); dispid 5;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TVAccess
// Help String      : Pervasive ActiveX Data Source
// Default Interface: IVAccessDual
// Def. Intf. DISP? : No
// Event   Interface: _DVAccessEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TVAccessGotData = procedure(Sender: TObject; numRows: Integer; numCols: Smallint) of object;
  TVAccessValidate = procedure(Sender: TObject; var OpCode: Smallint; var insertRecord: Smallint; 
                                                var updateRecord: Smallint) of object;
  TVAccessCommError = procedure(Sender: TObject; canRecover: WordBool; wsErrCode: Smallint; 
                                                 const errorString: WideString; 
                                                 var tryAgain: WordBool) of object;
  TVAccessLogon = procedure(Sender: TObject; var user: WideString; var password: WideString; 
                                             var databaseSet: WideString) of object;
  TVAccessOnRemote = procedure(Sender: TObject; var goRemote: WordBool; var newLocation: WideString) of object;

  TVAccess = class(TOleControl)
  private
    FOnReposition: TNotifyEvent;
    FOnGotData: TVAccessGotData;
    FOnValidate: TVAccessValidate;
    FOnCommError: TVAccessCommError;
    FOnLogon: TVAccessLogon;
    FOnRemote: TVAccessOnRemote;
    FIntf: IVAccessDual;
    function  GetControlInterface: IVAccessDual;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    procedure Set_FieldValue(vFieldID: OleVariant; newVal: OleVariant);
    function  Get_FieldValue(vFieldID: OleVariant): OleVariant;
    procedure Set_FieldList(vFieldList: OleVariant);
    function  Get_FieldList: OleVariant;
    procedure Set_IndexList(vIndexList: OleVariant);
    function  Get_IndexList: OleVariant;
    procedure Set_Buffer(alignment: Smallint; bufferVal: OleVariant);
    function  Get_Buffer(alignment: Smallint): OleVariant;
  public
    function  Open: Smallint;
    function  Close: Smallint;
    function  Insert: Smallint;
    function  Update: Smallint;
    function  Delete: Smallint;
    function  StatusDialog(Status: Smallint): Smallint;
    procedure ShowSelectedFieldsDlg;
    procedure ShowSelectedRecordsDlg;
    function  OpCode(OpCode: Smallint): Smallint;
    function  VAUDTableNames(var csaTableNames: OleVariant): WordBool;
    function  VAUDLocation(var csaLocation: OleVariant): WordBool;
    function  VAUDIndexList(var vIndexList: OleVariant): WordBool;
    function  VAUDControlNames(var csaControlNames: OleVariant): WordBool;
    function  VAUDIndexData(var vIndexData: OleVariant): WordBool;
    function  GetNextExtended: Smallint;
    function  GetPreviousExtended: Smallint;
    function  StepNextExtended: Smallint;
    function  StepPreviousExtended: Smallint;
    function  RowColumnValue(Row: Smallint; Column: Smallint): OleVariant;
    function  Init: Smallint;
    procedure Clear;
    function  VAUDFieldList(var vFieldList: OleVariant): WordBool;
    function  VAUDFieldFulList(var vFieldList: OleVariant): WordBool;
    function  GetTotalSegments(nKeyNum: Smallint): Smallint;
    function  GetFileFlag(nFlagIndex: Smallint): WordBool;
    function  SetFileFlag(nFlagIndex: Smallint; bSet: WordBool): Smallint;
    function  Create(bVer6: WordBool): Smallint;
    function  SetOwner(const OwnerName: WideString; nSecurityLevel: Smallint): Smallint;
    function  Stat: Smallint;
    function  Transaction(nOpCode: Smallint): Smallint;
    function  Unlock(nLockType: Smallint): Smallint;
    function  FormatFieldValue(const FieldName: WideString; const Format: WideString): WideString;
    function  Btrv(nOpCode: Smallint): Smallint;
    function  GetEqual: Smallint; overload;
    function  GetEqual(vLockBias: OleVariant): Smallint; overload;
    function  GetNext: Smallint; overload;
    function  GetNext(vLockBias: OleVariant): Smallint; overload;
    function  GetPrevious: Smallint; overload;
    function  GetPrevious(vLockBias: OleVariant): Smallint; overload;
    function  GetGreater: Smallint; overload;
    function  GetGreater(vLockBias: OleVariant): Smallint; overload;
    function  GetGreaterOrEqual: Smallint; overload;
    function  GetGreaterOrEqual(vLockBias: OleVariant): Smallint; overload;
    function  GetLess: Smallint; overload;
    function  GetLess(vLockBias: OleVariant): Smallint; overload;
    function  GetLessOrEqual: Smallint; overload;
    function  GetLessOrEqual(vLockBias: OleVariant): Smallint; overload;
    function  GetFirst: Smallint; overload;
    function  GetFirst(vLockBias: OleVariant): Smallint; overload;
    function  GetLast: Smallint; overload;
    function  GetLast(vLockBias: OleVariant): Smallint; overload;
    function  GetDirect: Smallint; overload;
    function  GetDirect(vLockBias: OleVariant): Smallint; overload;
    function  StepNext: Smallint; overload;
    function  StepNext(vLockBias: OleVariant): Smallint; overload;
    function  StepFirst: Smallint; overload;
    function  StepFirst(vLockBias: OleVariant): Smallint; overload;
    function  StepLast: Smallint; overload;
    function  StepLast(vLockBias: OleVariant): Smallint; overload;
    function  StepPrevious: Smallint; overload;
    function  StepPrevious(vLockBias: OleVariant): Smallint; overload;
    function  GetTableList: OleVariant;
    function  DdfModifyTableName(const newTableName: WideString): Smallint;
    function  DdfModifyLocation(const newLocation: WideString): Smallint;
    function  DdfGetFieldComments: Smallint;
    function  DdfTestOwnerName(const newOwnerName: WideString): Smallint;
    function  DdfAddTable(bOverWrite: WordBool): Smallint;
    function  DdfDropTable: Smallint;
    function  DdfAddIndex(vIndexList: OleVariant): Smallint;
    function  DdfDropIndex(keyNum: Smallint): Smallint;
    function  DdfDropIndexMaintain(keyNum: Smallint): Smallint;
    function  DdfCreateTable(bOverWrite: WordBool): Smallint;
    function  DdfCreateDictionary(bOverWrite: WordBool): Smallint;
    function  DdfAddTableName(const newTableName: WideString): Smallint;
    function  DdfClearIndexes: Smallint;
    function  DdfClearFields: Smallint;
    function  DdfSetOwner(const newOwnerName: WideString; nSecurityLevel: Smallint): Smallint;
    procedure Refresh;
    procedure AboutBox;
    property  ControlInterface: IVAccessDual read GetControlInterface;
    property  DefaultInterface: IVAccessDual read GetControlInterface;
    property BlankChar: Smallint index 1 read GetSmallintProp write SetSmallintProp;
    property ColumnFormat: WideString index 9 read GetWideStringProp write SetWideStringProp;
    property Value: WideString index 18 read GetWideStringProp write SetWideStringProp;
    property VAUDDDFLength: Integer index 20 read GetIntegerProp write SetIntegerProp;
    property VAccessName: WideString index 21 read GetWideStringProp write SetWideStringProp;
    property TotalKeys: Smallint index 24 read GetSmallintProp write SetSmallintProp;
    property PercentFreeSpace: Smallint index 25 read GetSmallintProp write SetSmallintProp;
    property PreallocatedPages: Smallint index 26 read GetSmallintProp write SetSmallintProp;
    property ReservedDupPointers: Smallint index 27 read GetSmallintProp write SetSmallintProp;
    property ACSName: WideString index 28 read GetWideStringProp write SetWideStringProp;
    property CollatingSequence: WideString index 29 read GetWideStringProp write SetWideStringProp;
    property KeyPos: Smallint index 30 read GetSmallintProp write SetSmallintProp;
    property KeyLen: Smallint index 31 read GetSmallintProp write SetSmallintProp;
    property KeyType: Smallint index 32 read GetSmallintProp write SetSmallintProp;
    property SegmentNumber: Smallint index 33 read GetSmallintProp write SetSmallintProp;
    property KeyNumber: Smallint index 34 read GetSmallintProp write SetSmallintProp;
    property KeyDescription: WideString index 35 read GetWideStringProp write SetWideStringProp;
    property Queries: WideString index 40 read GetWideStringProp write SetWideStringProp;
    property FieldDec: Smallint index 43 read GetSmallintProp write SetSmallintProp;
    property FieldFormat: WideString index 44 read GetWideStringProp write SetWideStringProp;
    property FieldId: Smallint index 45 read GetSmallintProp write SetSmallintProp;
    property FieldIndex: Smallint index 46 read GetSmallintProp write SetSmallintProp;
    property FieldName: WideString index 47 read GetWideStringProp write SetWideStringProp;
    property FieldPosition: Smallint index 48 read GetSmallintProp write SetSmallintProp;
    property FieldSize: Smallint index 49 read GetSmallintProp write SetSmallintProp;
    property FieldType: Smallint index 50 read GetSmallintProp write SetSmallintProp;
    property FileName: WideString index 54 read GetWideStringProp write SetWideStringProp;
    property FieldValue[vFieldID: OleVariant]: OleVariant read Get_FieldValue write Set_FieldValue;
    property FieldList: OleVariant index 124 read GetOleVariantProp write SetOleVariantProp;
    property IndexList: OleVariant index 125 read GetOleVariantProp write SetOleVariantProp;
    property Buffer[alignment: Smallint]: OleVariant read Get_Buffer write Set_Buffer;
  published
    property _VAccessName: WideString index 0 read GetWideStringProp write SetWideStringProp stored False;
    property RefreshLocations: WordBool index 2 read GetWordBoolProp write SetWordBoolProp stored False;
    property OemString: Smallint index 3 read GetSmallintProp write SetSmallintProp stored False;
    property AutoMode: WordBool index 4 read GetWordBoolProp write SetWordBoolProp stored False;
    property CacheRows: Smallint index 5 read GetSmallintProp write SetSmallintProp stored False;
    property CancelDialog: WordBool index 6 read GetWordBoolProp write SetWordBoolProp stored False;
    property Column: Smallint index 7 read GetSmallintProp write SetSmallintProp stored False;
    property Columns: Smallint index 8 read GetSmallintProp write SetSmallintProp stored False;
    property ColumnName: WideString index 10 read GetWideStringProp write SetWideStringProp stored False;
    property IncludeCurrent: WordBool index 11 read GetWordBoolProp write SetWordBoolProp stored False;
    property MaxBufferSize: Integer index 12 read GetIntegerProp write SetIntegerProp stored False;
    property Row: Smallint index 13 read GetSmallintProp write SetSmallintProp stored False;
    property RowPosition: Integer index 14 read GetIntegerProp write SetIntegerProp stored False;
    property Rows: Smallint index 15 read GetSmallintProp write SetSmallintProp stored False;
    property SelectedFields: WideString index 16 read GetWideStringProp write SetWideStringProp stored False;
    property SelectedRecords: WideString index 17 read GetWideStringProp write SetWideStringProp stored False;
    property CacheRejectMax: Integer index 19 read GetIntegerProp write SetIntegerProp stored False;
    property PageSize: Smallint index 22 read GetSmallintProp write SetSmallintProp stored False;
    property TotalRecords: Integer index 23 read GetIntegerProp write SetIntegerProp stored False;
    property FileVersion: Single index 36 read GetSingleProp write SetSingleProp stored False;
    property VADebugMode: WordBool index 37 read GetWordBoolProp write SetWordBoolProp stored False;
    property ExtendedOps: WordBool index 38 read GetWordBoolProp write SetWordBoolProp stored False;
    property FireEvents: WordBool index 39 read GetWordBoolProp write SetWordBoolProp stored False;
    property DataLength: Integer index 41 read GetIntegerProp write SetIntegerProp stored False;
    property DdfPath: WideString index 42 read GetWideStringProp write SetWideStringProp stored False;
    property Fields: Smallint index 51 read GetSmallintProp write SetSmallintProp stored False;
    property FileID: Smallint index 52 read GetSmallintProp write SetSmallintProp stored False;
    property TableName: WideString index 53 read GetWideStringProp write SetWideStringProp stored False;
    property IndexNumber: Smallint index 55 read GetSmallintProp write SetSmallintProp stored False;
    property Join: WideString index 56 read GetWideStringProp write SetWideStringProp stored False;
    property Location: WideString index 57 read GetWideStringProp write SetWideStringProp stored False;
    property OpenMode: TOleEnum index 58 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OwnerName: WideString index 59 read GetWideStringProp write SetWideStringProp stored False;
    property Percentage: Smallint index 60 read GetSmallintProp write SetSmallintProp stored False;
    property Position: Integer index 61 read GetIntegerProp write SetIntegerProp stored False;
    property AutoOpen: WordBool index 62 read GetWordBoolProp write SetWordBoolProp stored False;
    property Status: Smallint index 63 read GetSmallintProp write SetSmallintProp stored False;
    property DdfTransactionMode: WordBool index 64 read GetWordBoolProp write SetWordBoolProp stored False;
    property DdfKeyUseIndexDDFOnly: WordBool index 65 read GetWordBoolProp write SetWordBoolProp stored False;
    property HostAddress: WideString index 66 read GetWideStringProp write SetWideStringProp stored False;
    property HostConnect: WordBool index 67 read GetWordBoolProp write SetWordBoolProp stored False;
    property TimeOutVal: Smallint index 68 read GetSmallintProp write SetSmallintProp stored False;
    property Port: Smallint index 69 read GetSmallintProp write SetSmallintProp stored False;
    property CompressData: WordBool index 70 read GetWordBoolProp write SetWordBoolProp stored False;
    property AutoDialog: WordBool index 71 read GetWordBoolProp write SetWordBoolProp stored False;
    property AutoLogon: WordBool index 72 read GetWordBoolProp write SetWordBoolProp stored False;
    property DatabaseName: WideString index 73 read GetWideStringProp write SetWideStringProp stored False;
    property SessionID: Smallint index 74 read GetSmallintProp write SetSmallintProp stored False;
    property OnReposition: TNotifyEvent read FOnReposition write FOnReposition;
    property OnGotData: TVAccessGotData read FOnGotData write FOnGotData;
    property OnValidate: TVAccessValidate read FOnValidate write FOnValidate;
    property OnCommError: TVAccessCommError read FOnCommError write FOnCommError;
    property OnLogon: TVAccessLogon read FOnLogon write FOnLogon;
    property OnRemote: TVAccessOnRemote read FOnRemote write FOnRemote;
  end;

// *********************************************************************//
// The Class CoCColumn provides a Create and CreateRemote method to          
// create instances of the default interface IColumn exposed by              
// the CoClass CColumn. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCColumn = class
    class function Create: IColumn;
    class function CreateRemote(const MachineName: string): IColumn;
  end;

// *********************************************************************//
// The Class CoCColumns provides a Create and CreateRemote method to          
// create instances of the default interface IColumns exposed by              
// the CoClass CColumns. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCColumns = class
    class function Create: IColumns;
    class function CreateRemote(const MachineName: string): IColumns;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

procedure TVAccess.InitControlData;
const
  CEventDispIDs: array [0..5] of DWORD = (
    $00000001, $00000002, $00000003, $00000004, $00000005, $00000006);
  CLicenseKey: array[0..23] of Word = ( $0056, $0041, $0023, $0034, $0020, $0043, $006F, $0070, $0079, $0072, $0069
    , $0067, $0068, $0074, $0020, $0028, $0063, $0029, $0020, $0031, $0039
    , $0039, $0038, $0000);
  CControlData: TControlData2 = (
    ClassID: '{47E7B6C6-8256-11CF-AB56-0000C04D1EB9}';
    EventIID: '{47E7B6C8-8256-11CF-AB56-0000C04D1EB9}';
    EventCount: 6;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnReposition) - Cardinal(Self);
end;

procedure TVAccess.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IVAccessDual;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TVAccess.GetControlInterface: IVAccessDual;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TVAccess.Set_FieldValue(vFieldID: OleVariant; newVal: OleVariant);
begin
  DefaultInterface.FieldValue[vFieldID] := newVal;
end;

function  TVAccess.Get_FieldValue(vFieldID: OleVariant): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.FieldValue[vFieldID];
end;

procedure TVAccess.Set_FieldList(vFieldList: OleVariant);
begin
  DefaultInterface.FieldList := vFieldList;
end;

function  TVAccess.Get_FieldList: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.FieldList;
end;

procedure TVAccess.Set_IndexList(vIndexList: OleVariant);
begin
  DefaultInterface.IndexList := vIndexList;
end;

function  TVAccess.Get_IndexList: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.IndexList;
end;

procedure TVAccess.Set_Buffer(alignment: Smallint; bufferVal: OleVariant);
begin
  DefaultInterface.Buffer[alignment] := bufferVal;
end;

function  TVAccess.Get_Buffer(alignment: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.Buffer[alignment];
end;

function  TVAccess.Open: Smallint;
begin
  Result := DefaultInterface.Open;
end;

function  TVAccess.Close: Smallint;
begin
  Result := DefaultInterface.Close;
end;

function  TVAccess.Insert: Smallint;
begin
  Result := DefaultInterface.Insert;
end;

function  TVAccess.Update: Smallint;
begin
  Result := DefaultInterface.Update;
end;

function  TVAccess.Delete: Smallint;
begin
  Result := DefaultInterface.Delete;
end;

function  TVAccess.StatusDialog(Status: Smallint): Smallint;
begin
  Result := DefaultInterface.StatusDialog(Status);
end;

procedure TVAccess.ShowSelectedFieldsDlg;
begin
  DefaultInterface.ShowSelectedFieldsDlg;
end;

procedure TVAccess.ShowSelectedRecordsDlg;
begin
  DefaultInterface.ShowSelectedRecordsDlg;
end;

function  TVAccess.OpCode(OpCode: Smallint): Smallint;
begin
  Result := DefaultInterface.OpCode(OpCode);
end;

function  TVAccess.VAUDTableNames(var csaTableNames: OleVariant): WordBool;
begin
  Result := DefaultInterface.VAUDTableNames(csaTableNames);
end;

function  TVAccess.VAUDLocation(var csaLocation: OleVariant): WordBool;
begin
  Result := DefaultInterface.VAUDLocation(csaLocation);
end;

function  TVAccess.VAUDIndexList(var vIndexList: OleVariant): WordBool;
begin
  Result := DefaultInterface.VAUDIndexList(vIndexList);
end;

function  TVAccess.VAUDControlNames(var csaControlNames: OleVariant): WordBool;
begin
  Result := DefaultInterface.VAUDControlNames(csaControlNames);
end;

function  TVAccess.VAUDIndexData(var vIndexData: OleVariant): WordBool;
begin
  Result := DefaultInterface.VAUDIndexData(vIndexData);
end;

function  TVAccess.GetNextExtended: Smallint;
begin
  Result := DefaultInterface.GetNextExtended;
end;

function  TVAccess.GetPreviousExtended: Smallint;
begin
  Result := DefaultInterface.GetPreviousExtended;
end;

function  TVAccess.StepNextExtended: Smallint;
begin
  Result := DefaultInterface.StepNextExtended;
end;

function  TVAccess.StepPreviousExtended: Smallint;
begin
  Result := DefaultInterface.StepPreviousExtended;
end;

function  TVAccess.RowColumnValue(Row: Smallint; Column: Smallint): OleVariant;
begin
  Result := DefaultInterface.RowColumnValue(Row, Column);
end;

function  TVAccess.Init: Smallint;
begin
  Result := DefaultInterface.Init;
end;

procedure TVAccess.Clear;
begin
  DefaultInterface.Clear;
end;

function  TVAccess.VAUDFieldList(var vFieldList: OleVariant): WordBool;
begin
  Result := DefaultInterface.VAUDFieldList(vFieldList);
end;

function  TVAccess.VAUDFieldFulList(var vFieldList: OleVariant): WordBool;
begin
  Result := DefaultInterface.VAUDFieldFulList(vFieldList);
end;

function  TVAccess.GetTotalSegments(nKeyNum: Smallint): Smallint;
begin
  Result := DefaultInterface.GetTotalSegments(nKeyNum);
end;

function  TVAccess.GetFileFlag(nFlagIndex: Smallint): WordBool;
begin
  Result := DefaultInterface.GetFileFlag(nFlagIndex);
end;

function  TVAccess.SetFileFlag(nFlagIndex: Smallint; bSet: WordBool): Smallint;
begin
  Result := DefaultInterface.SetFileFlag(nFlagIndex, bSet);
end;

function  TVAccess.Create(bVer6: WordBool): Smallint;
begin
  Result := DefaultInterface.Create(bVer6);
end;

function  TVAccess.SetOwner(const OwnerName: WideString; nSecurityLevel: Smallint): Smallint;
begin
  Result := DefaultInterface.SetOwner(OwnerName, nSecurityLevel);
end;

function  TVAccess.Stat: Smallint;
begin
  Result := DefaultInterface.Stat;
end;

function  TVAccess.Transaction(nOpCode: Smallint): Smallint;
begin
  Result := DefaultInterface.Transaction(nOpCode);
end;

function  TVAccess.Unlock(nLockType: Smallint): Smallint;
begin
  Result := DefaultInterface.Unlock(nLockType);
end;

function  TVAccess.FormatFieldValue(const FieldName: WideString; const Format: WideString): WideString;
begin
  Result := DefaultInterface.FormatFieldValue(FieldName, Format);
end;

function  TVAccess.Btrv(nOpCode: Smallint): Smallint;
begin
  Result := DefaultInterface.Btrv(nOpCode);
end;

function  TVAccess.GetEqual: Smallint;
begin
  Result := DefaultInterface.GetEqual(EmptyParam);
end;

function  TVAccess.GetEqual(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetEqual(vLockBias);
end;

function  TVAccess.GetNext: Smallint;
begin
  Result := DefaultInterface.GetNext(EmptyParam);
end;

function  TVAccess.GetNext(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetNext(vLockBias);
end;

function  TVAccess.GetPrevious: Smallint;
begin
  Result := DefaultInterface.GetPrevious(EmptyParam);
end;

function  TVAccess.GetPrevious(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetPrevious(vLockBias);
end;

function  TVAccess.GetGreater: Smallint;
begin
  Result := DefaultInterface.GetGreater(EmptyParam);
end;

function  TVAccess.GetGreater(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetGreater(vLockBias);
end;

function  TVAccess.GetGreaterOrEqual: Smallint;
begin
  Result := DefaultInterface.GetGreaterOrEqual(EmptyParam);
end;

function  TVAccess.GetGreaterOrEqual(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetGreaterOrEqual(vLockBias);
end;

function  TVAccess.GetLess: Smallint;
begin
  Result := DefaultInterface.GetLess(EmptyParam);
end;

function  TVAccess.GetLess(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetLess(vLockBias);
end;

function  TVAccess.GetLessOrEqual: Smallint;
begin
  Result := DefaultInterface.GetLessOrEqual(EmptyParam);
end;

function  TVAccess.GetLessOrEqual(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetLessOrEqual(vLockBias);
end;

function  TVAccess.GetFirst: Smallint;
begin
  Result := DefaultInterface.GetFirst(EmptyParam);
end;

function  TVAccess.GetFirst(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetFirst(vLockBias);
end;

function  TVAccess.GetLast: Smallint;
begin
  Result := DefaultInterface.GetLast(EmptyParam);
end;

function  TVAccess.GetLast(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetLast(vLockBias);
end;

function  TVAccess.GetDirect: Smallint;
begin
  Result := DefaultInterface.GetDirect(EmptyParam);
end;

function  TVAccess.GetDirect(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetDirect(vLockBias);
end;

function  TVAccess.StepNext: Smallint;
begin
  Result := DefaultInterface.StepNext(EmptyParam);
end;

function  TVAccess.StepNext(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.StepNext(vLockBias);
end;

function  TVAccess.StepFirst: Smallint;
begin
  Result := DefaultInterface.StepFirst(EmptyParam);
end;

function  TVAccess.StepFirst(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.StepFirst(vLockBias);
end;

function  TVAccess.StepLast: Smallint;
begin
  Result := DefaultInterface.StepLast(EmptyParam);
end;

function  TVAccess.StepLast(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.StepLast(vLockBias);
end;

function  TVAccess.StepPrevious: Smallint;
begin
  Result := DefaultInterface.StepPrevious(EmptyParam);
end;

function  TVAccess.StepPrevious(vLockBias: OleVariant): Smallint;
begin
  Result := DefaultInterface.StepPrevious(vLockBias);
end;

function  TVAccess.GetTableList: OleVariant;
begin
  Result := DefaultInterface.GetTableList;
end;

function  TVAccess.DdfModifyTableName(const newTableName: WideString): Smallint;
begin
  Result := DefaultInterface.DdfModifyTableName(newTableName);
end;

function  TVAccess.DdfModifyLocation(const newLocation: WideString): Smallint;
begin
  Result := DefaultInterface.DdfModifyLocation(newLocation);
end;

function  TVAccess.DdfGetFieldComments: Smallint;
begin
  Result := DefaultInterface.DdfGetFieldComments;
end;

function  TVAccess.DdfTestOwnerName(const newOwnerName: WideString): Smallint;
begin
  Result := DefaultInterface.DdfTestOwnerName(newOwnerName);
end;

function  TVAccess.DdfAddTable(bOverWrite: WordBool): Smallint;
begin
  Result := DefaultInterface.DdfAddTable(bOverWrite);
end;

function  TVAccess.DdfDropTable: Smallint;
begin
  Result := DefaultInterface.DdfDropTable;
end;

function  TVAccess.DdfAddIndex(vIndexList: OleVariant): Smallint;
begin
  Result := DefaultInterface.DdfAddIndex(vIndexList);
end;

function  TVAccess.DdfDropIndex(keyNum: Smallint): Smallint;
begin
  Result := DefaultInterface.DdfDropIndex(keyNum);
end;

function  TVAccess.DdfDropIndexMaintain(keyNum: Smallint): Smallint;
begin
  Result := DefaultInterface.DdfDropIndexMaintain(keyNum);
end;

function  TVAccess.DdfCreateTable(bOverWrite: WordBool): Smallint;
begin
  Result := DefaultInterface.DdfCreateTable(bOverWrite);
end;

function  TVAccess.DdfCreateDictionary(bOverWrite: WordBool): Smallint;
begin
  Result := DefaultInterface.DdfCreateDictionary(bOverWrite);
end;

function  TVAccess.DdfAddTableName(const newTableName: WideString): Smallint;
begin
  Result := DefaultInterface.DdfAddTableName(newTableName);
end;

function  TVAccess.DdfClearIndexes: Smallint;
begin
  Result := DefaultInterface.DdfClearIndexes;
end;

function  TVAccess.DdfClearFields: Smallint;
begin
  Result := DefaultInterface.DdfClearFields;
end;

function  TVAccess.DdfSetOwner(const newOwnerName: WideString; nSecurityLevel: Smallint): Smallint;
begin
  Result := DefaultInterface.DdfSetOwner(newOwnerName, nSecurityLevel);
end;

procedure TVAccess.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TVAccess.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

class function CoCColumn.Create: IColumn;
begin
  Result := CreateComObject(CLASS_CColumn) as IColumn;
end;

class function CoCColumn.CreateRemote(const MachineName: string): IColumn;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CColumn) as IColumn;
end;

class function CoCColumns.Create: IColumns;
begin
  Result := CreateComObject(CLASS_CColumns) as IColumns;
end;

class function CoCColumns.CreateRemote(const MachineName: string): IColumns;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CColumns) as IColumns;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TVAccess]);
end;

end.
