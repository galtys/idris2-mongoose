module Browser.WebSocket

import Data.IORef
--import Data.MSF
import JS
import Browser.WS2

public export
JSType BrowserEvent where
  parents =  [ JS.Object.Object ]
  mixins =  []


||| Web.Internal.WebSocketPrim
namespace BrowserEvent
export
wsInfo : BrowserEvent -> JSIO WsMessageInfo
wsInfo e =
  [| MkWsMI
     (get_data e)
     (get_origin e)
     (get_source e)
   |]

%foreign "browser:lambda:(event,h,node) => node.addEventListener(event, x=>h(x)() )"
prim__addEventListener' : String -> (AnyPtr -> IO () ) -> AnyPtr   ->PrimIO ()

export
addEventListener' : HasIO io => String -> WsSocket   -> (WsSocket -> BrowserEvent  -> JSIO ()) -> io ()
addEventListener' event ws@(MkWsSocket n) run =
     primIO $ prim__addEventListener' event (\dt => runJS (run ws $ MkEvent dt)   ) n

export
addEventListenerBE : HasIO io => String -> WsSocket   -> (BrowserEvent  -> JSIO ()) -> io ()
addEventListenerBE event ws@(MkWsSocket n) run =
     primIO $ prim__addEventListener' event (\dt => runJS (run $ MkEvent dt)   ) n
