module WebTestClientRaw

import Browser.WS2
%default total

handle_open : WsSocket -> BrowserEvent -> IO ()
handle_open ws e = do
  console_log "on Open"
  ws_send ws "Hello back"
  
  
handle_message : WsSocket -> BrowserEvent -> IO ()
handle_message ws e = do
  console_log "msg received"

  msg <- get_data e
  console_log ("msgda: "++msg)
  o <- get_origin e
  console_log ("origin: "++o)
  s <- get_field "source" e
  console_log ("source: "++s)
  
  ws_close ws

test_main : HasIO io => io ()
test_main = do
   ws <- ws_new "ws://localhost:8000/websocket"
   addEventListener "open" ws handle_open
   addEventListener "message" ws handle_message   
   pure ()
   
covering
main : IO ()
main = do
   console_log "start"
   test_main   
   pure ()
