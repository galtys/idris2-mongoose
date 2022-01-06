module Browser.WS2

--import Data.IORef
--import Data.MSF
import JS

export data WebSocketEvent: Type where [external]

public export
JSType WebSocketEvent where
  parents =  [ JS.Object.Object ]
  mixins =  []

public export
record WsMessageInfo where
  constructor MkWsMI
  msg : String
  origin : String
  source : String

||| Web.Internal.WebSocketPrim
namespace WebSocketEvent
  -- message
  export
  %foreign "browser:lambda:x=>x.data"
  prim__data : WebSocketEvent -> PrimIO String

  export
  %foreign "browser:lambda:x=>x.origin"
  prim__origin : WebSocketEvent -> PrimIO String
    
  export
  %foreign "browser:lambda:x=>x.lastEventId"
  prim__lastEventId : WebSocketEvent -> PrimIO String
  
  export
  %foreign "browser:lambda:x=>x.source"
  prim__source : WebSocketEvent -> PrimIO String
  
  export
  %foreign "browser:lambda:x=>x.ports"
  prim__ports : WebSocketEvent -> PrimIO String

  -- close
  export
  %foreign "browser:lambda:x=>x.code"
  prim__code : WebSocketEvent -> PrimIO String
  
  export
  %foreign "browser:lambda:x=>x.reason"
  prim__reason : WebSocketEvent -> PrimIO String

  export
  %foreign "browser:lambda:x=>x.wasClean"
  prim__wasClean : WebSocketEvent -> PrimIO String

  -- error is using a generic event
  -- open is using a generic event


  --
  export
  getData : (0 _ : JSType t1)
         => {auto 0 _ : Elem WebSocketEvent (Types t1)}
         -> (obj : t1)
         -> JSIO String
  getData a = primJS $  WebSocketEvent.prim__data (up a)
          
  export
  origin : (0 _ : JSType t1)
         => {auto 0 _ : Elem WebSocketEvent (Types t1)}
         -> (obj : t1)
         -> JSIO String
  origin a = primJS $  WebSocketEvent.prim__origin (up a)
         
  export
  source : (0 _ : JSType t1)
         => {auto 0 _ : Elem WebSocketEvent (Types t1)}
         -> (obj : t1)
         -> JSIO String
  source a = primJS $  WebSocketEvent.prim__source (up a)
  
  export
  wsInfo : WebSocketEvent -> JSIO WsMessageInfo
  wsInfo e =
    [| MkWsMI
       (getData e)
       (origin e)
       (source e)
     |]

--Prim Handlers

%foreign "browser:lambda:(h) => ws_State.ws_on_open(h)"
prim__on_open : (String -> IO () ) -> PrimIO ()

%foreign "browser:lambda:(h) => ws_State.ws_on_close(h)"
prim__on_close : (WebSocketEvent -> IO () ) -> PrimIO ()

%foreign "browser:lambda:(h) => ws_State.ws_on_error(h)"
prim__on_error : (WebSocketEvent -> IO () ) -> PrimIO ()

%foreign "browser:lambda:(h) => ws_State.ws_on_message(h)"
prim__on_message : (WebSocketEvent -> IO () ) -> PrimIO ()


-- Methods
%foreign "browser:lambda:(s)=> ws_State.new_ws(s)"
prim__new_ws : (s:String) -> PrimIO ()

%foreign "browser:lambda:(msg) => ws_State.send(msg)"
prim__send : String -> PrimIO ()
%foreign "browser:lambda:() => ws_State.close()"
prim__close : PrimIO ()

export
ws_send : HasIO io => (msg:String) -> io ()
ws_send msg = primIO $ prim__send msg
export
ws_close : HasIO io => (msg:String) -> io ()
ws_close msg = primIO $ prim__close

export
ws_new : HasIO io => (s:String) -> io ()
ws_new s =primIO $ prim__new_ws s

-- Handlers

export
ws_on_open : HasIO io => (String -> JSIO ()) -> io ()
ws_on_open run = primIO $ prim__on_open (\dt => runJS (run dt)   )


export
ws_on_close : HasIO io => (WebSocketEvent -> JSIO ()) -> io ()
ws_on_close run = primIO $ prim__on_close (\dt => runJS (run dt)   )

export
ws_on_error : HasIO io => (WebSocketEvent -> JSIO ()) -> io ()
ws_on_error run = primIO $ prim__on_error (\dt => runJS (run dt)   )

export
ws_on_message : HasIO io => (WebSocketEvent -> JSIO ()) -> io ()
ws_on_message run = primIO $ prim__on_message (\dt => runJS (run dt)   )
