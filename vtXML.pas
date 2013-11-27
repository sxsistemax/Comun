unit vtXML;

interface

uses
 SysUtils, Classes, Db
{$IFNDEF AvoidBDE}
 , DbTables
{$ENDIF}
 ;

 // Writes Standard XML header in AStream 
 procedure XMLHeader( AStream : TStream );
 // Convert a Record to XML and writes it to AStream
 procedure RecordToXML( AStream : TStream; ADataset : TDataset; AIndent : Integer = 0 );
 // Writes all records in ADataset to AStream
 function DatasetToXML( AStream : TStream; ADataset : TDataset;
                      AIndent : Integer = 0  ) : Cardinal;
 // Writes to Stream just the records of ADataset not present in ALogDS
 function ExportDiff( AStream : TStream; ADataset : TDataset; ALogDS : TDataset;
                      AIndent : Integer = 0  ) : Cardinal;

 procedure WriteStr( AStream : TStream; const S : String );

implementation

const

 XML_INDENT = 3;
 XML_CRLF   = #13#10;
 TAG_RECORD = 'RECORD';

function StartTag( const Tag : String ) : String;
begin
 Result := '<' + Tag + '>';
end;

function EndTag( const Tag : String) : String;
begin
 Result := '</' + Tag + '>';
end;

procedure WriteStr( AStream : TStream; const S : String );
begin
 AStream.WriteBuffer( (PChar(S))^, Length(S) );
 AStream.WriteBuffer( (PChar(XML_CRLF))^, Length(XML_CRLF) );
end;

procedure XMLHeader( AStream : TStream );
begin
 WriteStr( AStream, '<?xml version="1.0"?>' );
end;

procedure RecordToXML( AStream : TStream; ADataset : TDataset; AIndent : Integer = 0 );
var
 i : Integer;
begin
 WriteStr( AStream, StringOfChar(' ',AIndent) + StartTag(TAG_RECORD) );

 with ADataset do
 begin
      for i := 0 to FieldCount - 1 do
      begin
          WriteStr( AStream, StringOfChar(' ',AIndent+XML_INDENT) +
                    StartTag(Fields[i].FieldName)  +
                    Fields[i].AsString +
                    EndTag(Fields[i].FieldName) );
      end;
 end;

 WriteStr( AStream, StringOfChar(' ',AIndent) + EndTag(TAG_RECORD) );
end;

function DatasetToXML( AStream : TStream; ADataset : TDataset;
                     AIndent : Integer = 0  ) : Cardinal;
var
 TagName : String;
begin
 Result := 0;

{$IFNDEF AvoidBDE}
 if ADataset is TTable then
    TagName := TTAble(ADataset).TableName
 else
{$ENDIF}
    TagName := ADataset.Name;

 with ADataset do
 begin
      WriteStr( AStream, StringOfChar(' ',AIndent) + StartTag(TagName) );

      First;
      while not Eof do
      begin
            RecordToXML( AStream, ADataset, AIndent + XML_INDENT );
            Next;
            Inc( Result );
      end;

      WriteStr( AStream, StringOfChar(' ',AIndent) + EndTag(TagName) );
 end;
end;

function ExportDiff( AStream : TStream; ADataset : TDataset; ALogDS : TDataset; 
                     AIndent : Integer = 0  ) : Cardinal;
var
 UseTable : Boolean;
 Report   : Boolean;
 TagName  : String;
begin
 Result := 0;

{$IFDEF AvoidBDE}
 UseTable := False;
{$ELSE}
 UseTable := AlogDS is TTable;
{$ENDIF}

{$IFNDEF AvoidBDE}
 if ADataset is TTable then
    TagName := TTAble(ADataset).TableName
 else
{$ENDIF}
    TagName := ADataset.Name;

 with ADataset do
 begin
      WriteStr( AStream, StringOfChar(' ',AIndent) + StartTag(TagName) );
      First;
      while not Eof do
      begin
{$IFNDEF AvoidBDE}
            if UseTable then
               Report := not TTable(ALogDS).FindKey( [Fields[0].Value] )
            else
{$ENDIF}
               Report := not ALogDS.Locate( ALogDS.Fields[0].FieldName, Fields[0].Value, [] );

            if Report then
            begin
               RecordToXML( AStream, ADataset, AIndent + XML_INDENT );
               ALogDS.Insert;
               ALogDS.Fields[0].Value := ADataset.Fields[0].Value;
               ALogDS.Post;
            end;
            Next;
            Inc(Result);
      end;
      WriteStr( AStream, StringOfChar(' ',AIndent) + EndTag(TagName) );
 end;
end;


end.
