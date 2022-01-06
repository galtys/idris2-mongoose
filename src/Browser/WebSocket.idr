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

{-
export
%foreign "browser:lambda: (event, callback, node) => node.addEventListener(event, x=>callback(x)())"
prim__addEventListener' : String -> (AnyPtr -> IO ()) -> AnyPtr -> PrimIO ()
-}

%foreign "browser:lambda:(event,h,node) => node.addEventListener(event, x=>h(x)() )"
prim__addEventListener' : String -> (AnyPtr -> IO () ) -> AnyPtr   ->PrimIO ()

export
addEventListener' : HasIO io => String -> WsSocket   -> (WsSocket -> BrowserEvent  -> JSIO ()) -> io ()
addEventListener' event ws@(MkWsSocket n) run =
     primIO $ prim__addEventListener' event (\dt => runJS (run ws $ MkEvent dt)   ) n


{-
export
ws_on_message : HasIO io => WsSocket -> (WsSocket -> BrowserEvent -> JSIO ()) -> io (IO ())
ws_on_message ws@(MkWsSocket n) run = do
     --ref <- newIORef (the Bits32 0)
     --primIO $ prim__on_message s (\dt => runJS (run dt))
     --primIO $ prim__addEventListener "message" s (\dt => runJS (run dt)) 
     primIO $ prim__on_open s (\dt => runJS (run dt)   )
     --primIO $ prim__addEventListener' "message" (\ptr => runJS $ (run ws) $ MkEvent ptr) n
  -}   
     --pure (writeIORef ref 1)
{-
export
addEventListener' : HasIO io => String -> WsSocket -> (WsSocket -> BrowserEvent -> JSIO ()) -> io ()
addEventListener' event ws callback =
  addEventListener event (\e => runJS (callback ws e) )
  --primIO $ prim__addEventListener event (\ptr => toPrim $ (callback ws) $ MkEvent ptr) n
-}
