unit vtDebug;

interface

 procedure SendDebugMsg( const Msg : String );

implementation

 Uses Mailslot;

var
 Slot : TMailslot;

procedure SendDebugMsg( const Msg : String );
begin
// Slot.WriteMailslot( '*', 'Debugger', Pointer(Msg), Length( Msg )+1, 0 );
end;

initialization
 Slot := TMailSlot.Create( nil );
 Slot.Recipient := rSlot;
finalization
 Slot.Free;
end.
