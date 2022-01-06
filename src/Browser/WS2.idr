module Browser.WS2

--import Data.IORef
--import Data.MSF
--import JS

public export
data BrowserEvent = MkEvent AnyPtr
public export
data WsSocket = MkWsSocket AnyPtr

--export data BrowserEvent: Type where [external]
{-
public export
JSType BrowserEvent where
  parents =  [ JS.Object.Object ]
  mixins =  []
-}
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
  
  {-
  %foreign "browser:lambda:x=>x.data"
  prim__data : BrowserEvent -> PrimIO String

  export
  %foreign "browser:lambda:x=>x.origin"
  prim__origin : BrowserEvent -> PrimIO String
    
  export
  %foreign "browser:lambda:x=>x.lastEventId"
  prim__lastEventId : BrowserEvent -> PrimIO String
  
  export
  %foreign "browser:lambda:x=>x.source"
  prim__source : BrowserEvent -> PrimIO String
  
  export
  %foreign "browser:lambda:x=>x.ports"
  prim__ports : BrowserEvent -> PrimIO String

  -- close
  export
  %foreign "browser:lambda:x=>x.code"
  prim__code : BrowserEvent -> PrimIO String
  
  export
  %foreign "browser:lambda:x=>x.reason"
  prim__reason : BrowserEvent -> PrimIO String

  export
  %foreign "browser:lambda:x=>x.wasClean"
  prim__wasClean : BrowserEvent -> PrimIO String
  -}
  %foreign "browser:lambda:x=>x.data"
  prim__data : BrowserEvent -> PrimIO String
  
  export
  get_data : HasIO io => BrowserEvent -> io String
  get_data e = primIO $ prim__data e
  

%foreign "browser:lambda: () => ws_State.get_socket()"
prim__ws_socket : () -> PrimIO AnyPtr

%foreign "browser:lambda: (event, callback, node) => node.addEventListener(event, x=>callback(x)())"
prim__addEventListener : String -> (AnyPtr -> PrimIO ()) -> AnyPtr -> PrimIO ()

-- Methods
%foreign "browser:lambda:(s)=> console.log(s)"
prim__console_log: String -> PrimIO () 

%foreign "browser:lambda:(s)=> ws_State.new_ws(s)"
prim__new_ws : (s:String) -> PrimIO ()

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


ws_socket : HasIO io => io WsSocket
ws_socket = map MkWsSocket $ primIO $ prim__ws_socket ()

export
addEventListener : HasIO io => String -> WsSocket -> (WsSocket -> BrowserEvent -> IO ()) -> io ()
addEventListener event ws@(MkWsSocket n) callback =
  primIO $ prim__addEventListener event (\ptr => toPrim $ (callback ws) $ MkEvent ptr) n

export
ws_new : HasIO io => (s:String) -> io WsSocket
ws_new s =do
   primIO $ prim__new_ws s
   ret <- ws_socket
   pure ret
   
