module WebTestClient

import Data.IORef
import Browser.WS2
import Rhone.JS
%default total


handle_open : String -> JSIO ()
handle_open e = do
  --consoleLog "Open             .................."
  printLn "muf a ocas"
  ws_send "Hello!"

  
handle_message : WebSocketEvent -> JSIO ()
handle_message e = do
  consoleLog "Msg               fgdsfdgfd"
  ws_i <- wsInfo e

  consoleLog (msg ws_i)

test_main : HasIO io => io ()
test_main = do
   consoleLog "Start2"
   ws_new "ws://localhost:8000/websocket"
   ws_on_open handle_open 
   ws_on_message handle_message

covering
main : IO ()
main = do
   runJS test_main
   
   
   pure ()
