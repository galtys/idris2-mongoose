module Browser.WS2

--import Data.IORef
--import Data.MSF
--import JS

public export
data BrowserEvent = MkEvent AnyPtr
public export
data WsSocket = MkWsSocket AnyPtr

public export
record WsMessageInfo where
  constructor MkWsMI
  msg : String
  origin : String
  source : String

||| Web.Internal.WebSocketPrim
namespace BrowserEvent
  -- message
  export
  
  
  %foreign "browser:lambda:(f,x)=>x[f]"
  prim__get_field : String -> BrowserEvent -> PrimIO String
  
  export
  get_field : HasIO io => String -> BrowserEvent -> io String
  get_field f e= primIO $ prim__get_field f e
  
  export
  get_data : HasIO io =>BrowserEvent -> io String
  get_data = get_field "data"
  export
  get_origin : HasIO io =>BrowserEvent -> io String
  get_origin = get_field "origin"
  export
  get_source : HasIO io =>BrowserEvent -> io String
  get_source = get_field "source"
   

%foreign "browser:lambda: (event, callback, node) => node.addEventListener(event, x=>callback(x)())"
prim__addEventListener : String -> (AnyPtr -> PrimIO ()) -> AnyPtr -> PrimIO ()

-- Methods
%foreign "browser:lambda:(s)=> console.log(s)"
prim__console_log: String -> PrimIO () 

%foreign "browser:lambda:(s)=> new WebSocket(s)"
prim__new_ws : (s:String) -> PrimIO AnyPtr

%foreign "browser:lambda:(ws,msg) => ws.send(msg)"
prim__send : WsSocket -> String -> PrimIO ()
%foreign "browser:lambda:(ws) => ws.close()"
prim__close : WsSocket -> PrimIO ()

export
console_log : HasIO io => String -> io ()
console_log x = primIO $ prim__console_log x

export
ws_send : HasIO io => WsSocket -> (msg:String) -> io ()
ws_send ws msg = primIO $ prim__send ws msg
export
ws_close : HasIO io => WsSocket -> io ()
ws_close ws = primIO $ (prim__close ws)


export
addEventListener : HasIO io => String -> WsSocket -> (WsSocket -> BrowserEvent -> IO ()) -> io ()
addEventListener event ws@(MkWsSocket n) callback =
  primIO $ prim__addEventListener event (\ptr => toPrim $ (callback ws) $ MkEvent ptr) n

export
ws_new : HasIO io => (s:String) -> io WsSocket
ws_new s = map MkWsSocket $ primIO $ prim__new_ws s
   
{-

Message from server/open2 WebSocket_closure.js:17:11
open { target: WebSocket, isTrusted: true, srcElement: WebSocket, currentTarget: WebSocket, eventPhase: 2, bubbles: false, cancelable: false, returnValue: true, defaultPrevented: false, composed: false, ??? }
WebSocket_closure.js:18:11
ws_State.send('test send')
undefined
Message from server/message WebSocket_closure.js:21:11
message { target: WebSocket, isTrusted: true, data: "test send", origin: "ws://localhost:8000", lastEventId: "", ports: Restricted, srcElement: WebSocket, currentTarget: WebSocket, eventPhase: 2, bubbles: false, ??? }
WebSocket_closure.js:22:11
ws_State.close()
undefined
Message from server/close WebSocket_closure.js:25:11
close { target: WebSocket, isTrusted: true, wasClean: false, code: 1006, reason: "", srcElement: WebSocket, currentTarget: WebSocket, eventPhase: 2, bubbles: false, cancelable: false, ??? }
WebSocket_closure.js:26:11

var ws_State = (function () {
    var state = {};
    
    return {
	get_socket : function () {
	    return state['ws'];
	},
	new_ws : function ( s) {
	    state['ws'] = new WebSocket(s);
	},
	
    }
    
} () );



-}
