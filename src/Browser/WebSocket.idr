module Browser.WebSocket

import Data.IORef
--import Data.MSF
import JS


public export

data WebsocketID : Type where [external]
-------------------------------------------------

||| Web.Internal.UIEventsTypes
export data WebSocketEvent: Type where [external]

-- Web.Internal.Types
public export
JSType WebSocketEvent where
  parents =  [ JS.Object.Object ]
  mixins =  []


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
  
  
  
public export
record WsMessageInfo where
  constructor MkWsMI
  msg : String
  origin : String
  source : String
  
export
wsInfo : WebSocketEvent -> JSIO WsMessageInfo
wsInfo e =
  [| MkWsMI
     (getData e)
     (origin e)
     (source e)
   |]

%foreign """
         browser:lambda:(s)=>{
           const socket = new WebSocket(s);
           return socket;
         }
         """
prim__new_ws : (s:String) -> PrimIO ( (WebsocketID))


%foreign "browser:lambda:(xs,h) => xs.addEventListener('open', h)"
prim__on_open : WebsocketID -> (WebSocketEvent -> IO () ) -> PrimIO ()


%foreign """
         browser:lambda:(socket,h)=>{
            socket.addEventListener('message', h);            
         }
         """
prim__on_message : WebsocketID -> (WebSocketEvent -> IO Bits32 ) -> PrimIO ()


%foreign "browser:lambda:(xs,msg) => xs.send(msg)"
prim__send : WebsocketID -> String -> PrimIO ()

export
ws_send : HasIO io => WebsocketID -> (s:String) -> io ()
ws_send ws s = do
   --ref <- newIORef WebsocketID
   primIO $ prim__send ws s
   

export
ws_new : HasIO io => (s:String) -> io (WebsocketID)
ws_new s = do
   ref <- newIORef WebsocketID
   primIO $ prim__new_ws s
   pure (writeIORef ref WebsocketID)
   

export
ws_on_open : HasIO io => (WebsocketID) -> (WebSocketEvent -> JSIO ()) -> io ()
ws_on_open s run = do
     --ref <- newIORef WebsocketID --(the Bits32 0) >> (readIORef ref)
     primIO $ prim__on_open s (\dt => runJS (run dt)   )
     pure () --(writeIORef ref 1)


export
ws_on_message : HasIO io => WebsocketID -> (WebSocketEvent -> JSIO ()) -> io (IO ())
ws_on_message s run = do
     ref <- newIORef (the Bits32 0)
     primIO $ prim__on_message s (\dt => runJS (run dt) >> readIORef ref)
     pure (writeIORef ref 1)

