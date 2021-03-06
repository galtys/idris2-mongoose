module Web.Mongoose.Types

import Generics.Derive
import System.FFI

%language ElabReflection

||| List of Event types from `mongoose.h`
public export
data MG_EVENT_TYPE =
  ||| Error                        char *error_message
  MG_EV_ERROR |       
  
  ||| mg_mgr_poll iteration        unsigned long *millis  
  MG_EV_POLL |        
  
  ||| Host name is resolved        NULL  
  MG_EV_RESOLVE |     
  
  ||| Connection established       NULL  
  MG_EV_CONNECT |     

  ||| Connection accepted          NULL    
  MG_EV_ACCEPT |      

  ||| Data received from socket    struct mg_str *    
  MG_EV_READ |        
  
  ||| Data written to socket       long *bytes_written  
  MG_EV_WRITE |       
  
  ||| Connection closed            NULL  
  MG_EV_CLOSE |       
  
  ||| HTTP request/response        struct mg_http_message *  
  MG_EV_HTTP_MSG |    

  ||| HTTP chunk (partial msg)     struct mg_http_message *    
  MG_EV_HTTP_CHUNK |  
  
  ||| Websocket handshake done     struct mg_http_message *  
  MG_EV_WS_OPEN |     
  
  ||| Websocket msg, text or bin   struct mg_ws_message *  
  MG_EV_WS_MSG |      
  
  ||| Websocket control msg        struct mg_ws_message *  
  MG_EV_WS_CTL |      
  
  ||| MQTT low-level command       struct mg_mqtt_message *  
  MG_EV_MQTT_CMD |    
  
  ||| MQTT PUBLISH received        struct mg_mqtt_message *  
  MG_EV_MQTT_MSG |    
  
  ||| MQTT CONNACK received        int *connack_status_code  
  MG_EV_MQTT_OPEN |   
  
  ||| SNTP time received           struct timeval *  
  MG_EV_SNTP_TIME |   
  
  ||| Starting ID for user events  
  MG_EV_USER

%runElab derive "MG_EVENT_TYPE" [Generic, Meta, Eq, Ord, Show]

namespace MG_EVENT_TYPE
  public export
  toBits8 : MG_EVENT_TYPE -> Bits8
  toBits8 MG_EV_ERROR = 0
  toBits8 MG_EV_POLL = 1
  toBits8 MG_EV_RESOLVE = 2 
  toBits8 MG_EV_CONNECT = 3
  toBits8 MG_EV_ACCEPT = 4
  toBits8 MG_EV_READ = 5
  toBits8 MG_EV_WRITE = 6 
  toBits8 MG_EV_CLOSE = 7 
  toBits8 MG_EV_HTTP_MSG = 8
  toBits8 MG_EV_HTTP_CHUNK = 9
  toBits8 MG_EV_WS_OPEN = 10 
  toBits8 MG_EV_WS_MSG = 11 
  toBits8 MG_EV_WS_CTL = 12 
  toBits8 MG_EV_MQTT_CMD = 13 
  toBits8 MG_EV_MQTT_MSG = 14
  toBits8 MG_EV_MQTT_OPEN = 15
  toBits8 MG_EV_SNTP_TIME = 16
  toBits8 MG_EV_USER = 17

  public export
  fromBits8 : Int -> MG_EVENT_TYPE -- make it Bits8
  fromBits8 0 = MG_EV_ERROR
  fromBits8 1 = MG_EV_POLL
  fromBits8 2 = MG_EV_RESOLVE 
  fromBits8 3 = MG_EV_CONNECT
  fromBits8 4 = MG_EV_ACCEPT 
  fromBits8 5 = MG_EV_READ 
  fromBits8 6 = MG_EV_WRITE 
  fromBits8 7 = MG_EV_CLOSE 
  fromBits8 8 = MG_EV_HTTP_MSG 
  fromBits8 9 = MG_EV_HTTP_CHUNK 
  fromBits8 10 = MG_EV_WS_OPEN 
  fromBits8 11 = MG_EV_WS_MSG 
  fromBits8 12 = MG_EV_WS_CTL 
  fromBits8 13 = MG_EV_MQTT_CMD 
  fromBits8 14 = MG_EV_MQTT_MSG 
  fromBits8 15 = MG_EV_MQTT_OPEN 
  fromBits8 16 = MG_EV_SNTP_TIME
  fromBits8 17 = MG_EV_USER 
  fromBits8 _ = MG_EV_ERROR


namespace WEBSOCKET
  public export
  data OP = OP_CONTINUE | OP_TEXT | OP_BINARY | OP_CLOSE | OP_PING | OP_PONG

  public export
  toBits8 : WEBSOCKET.OP -> Bits8
  toBits8 OP_CONTINUE = 0
  toBits8 OP_TEXT = 1
  toBits8 OP_BINARY = 2
  toBits8 OP_CLOSE = 8
  toBits8 OP_PING = 9
  toBits8 OP_PONG = 10
  
  
{-
#define WEBSOCKET_OP_CONTINUE 0
#define WEBSOCKET_OP_TEXT 1
#define WEBSOCKET_OP_BINARY 2
#define WEBSOCKET_OP_CLOSE 8
#define WEBSOCKET_OP_PING 9
#define WEBSOCKET_OP_PONG 10
-}



public export
data MG_MGR : Type where

public export
data MG_CONNECTION : Type where


public export
data EV_DATA : Type where

public export
FN_DATA : Type
FN_DATA = Int

{-
public export
data FN_DATA : Type where 
-}

public export
data MG_HTTP_SERVE_OPTS : Type where

public export
MG_STR : Type
MG_STR
    = Struct "MG_STR"
            [("ptr", Ptr String),
             ("len", Bits64)]

public export
MG_HTTP_HEADER : Type
MG_HTTP_HEADER
    = Struct "MG_HTTP_HEADER"
            [("name", MG_STR),
             ("value", MG_STR)]

namespace MG_HTTP
  public export
  record Header where
     constructor MkH
     name : String
     value : String
     
  public export
  record Message where
     constructor MkHM
     method : String
     uri : String
     query : String     
     proto : String     
     headers : List (String,String)
     body : String
     message : String

%runElab derive "MG_HTTP.Header" [Generic, Meta, Eq, Ord, Show]
%runElab derive "MG_HTTP.Message" [Generic, Meta, Eq, Ord, Show]

public export
data MG_WS_MESSAGE : Type where

public export             
MG_HTTP_MESSAGE : Type
MG_HTTP_MESSAGE
    = Struct "MG_HTTP_MESSAGE"
           [("method", MG_STR),
            ("uri", MG_STR),
            ("query", MG_STR),
            ("proto", MG_STR),
            ("h0",MG_HTTP_HEADER),
            ("h1",MG_HTTP_HEADER),            
            ("h2",MG_HTTP_HEADER),
            ("h3",MG_HTTP_HEADER),
            ("h4",MG_HTTP_HEADER),
            ("h5",MG_HTTP_HEADER),
            ("h6",MG_HTTP_HEADER),
            ("h7",MG_HTTP_HEADER),
            ("h8",MG_HTTP_HEADER),
            ("h9",MG_HTTP_HEADER),
            ("h10",MG_HTTP_HEADER),
            ("h11",MG_HTTP_HEADER),
            ("h12",MG_HTTP_HEADER),
            ("h13",MG_HTTP_HEADER),
            ("h14",MG_HTTP_HEADER),
            ("h15",MG_HTTP_HEADER),
            ("h16",MG_HTTP_HEADER),
            ("h17",MG_HTTP_HEADER),
            ("h18",MG_HTTP_HEADER),
            ("h19",MG_HTTP_HEADER),
            ("h20",MG_HTTP_HEADER),
            ("h21",MG_HTTP_HEADER),            
            ("h22",MG_HTTP_HEADER),
            ("h23",MG_HTTP_HEADER),
            ("h24",MG_HTTP_HEADER),
            ("h25",MG_HTTP_HEADER),
            ("h26",MG_HTTP_HEADER),
            ("h27",MG_HTTP_HEADER),
            ("h28",MG_HTTP_HEADER),
            ("h29",MG_HTTP_HEADER),
            ("h30",MG_HTTP_HEADER),
            ("h31",MG_HTTP_HEADER),
            ("h32",MG_HTTP_HEADER),
            ("h33",MG_HTTP_HEADER),
            ("h34",MG_HTTP_HEADER),
            ("h35",MG_HTTP_HEADER),
            ("h36",MG_HTTP_HEADER),
            ("h37",MG_HTTP_HEADER),
            ("h38",MG_HTTP_HEADER),
            ("h39",MG_HTTP_HEADER),
            ("body", MG_STR),
            ("message", MG_STR)]




