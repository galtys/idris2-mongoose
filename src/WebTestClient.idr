module WebTestClient

import Data.IORef
import Browser.WS2
import Rhone.JS
%default total


handle_open : WebSocketEvent -> JSIO ()
handle_open e = do
  consoleLog "Open"
  ws_send "Hello!"
  
handle_message : WebSocketEvent -> JSIO ()
handle_message e = do
  ws_i <- wsInfo e
  consoleLog "Msg               fgdsfdgfd"
  consoleLog (msg ws_i)

covering
main : IO ()
main = do
   consoleLog "Start"
   ws_new "ws://localhost:8000/websocket"
   ws_on_open handle_open 
   --ws_on_message handle_message
   
   pure ()
