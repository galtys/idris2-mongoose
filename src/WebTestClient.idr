module WebTestClient

--import Data.IORef
import Browser.WebSocket
import Browser.WS2
import JS
%default total

handle_open : WsSocket -> BrowserEvent -> JSIO ()
handle_open ws e = do
  consoleLog "LOG: on Open"
  ws_send ws "Hello back"
  
  
handle_message : WsSocket -> BrowserEvent -> JSIO ()
handle_message ws e = do
  consoleLog "LOG: msg received"
  info <- wsInfo e
  
  consoleLog ("log: msgda: "++msg info)
  consoleLog ("log: origin: "++origin info)
  consoleLog ("log: source: "++source info)
  
  ws_close ws

test_main : HasIO io => io ()
test_main = do
   ws <- ws_new "ws://localhost:8000/websocket"
   addEventListener' "open" ws handle_open
   addEventListener' "message" ws handle_message   
   pure ()
   
covering
main : IO ()
main = do
   console_log "start"
   test_main   
   pure ()
