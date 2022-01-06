
var ws_State = (function () {
    var state = {};
    //var ws = new WebSocket('ws://localhost:8000/websocket');
    var ocas = {};
    
    return {
	get_x : function () {
	    return ocas['ws'];
	},
	new_ws : function ( s) {
            //let closed_state.ws = new WebSocket(s);
	    ocas['ws'] = new WebSocket(s);

	    /*
            ocas['ws'].addEventListener('open', function (event) {
		console.log('Message from server/open2 ')
		console.log(event);
            });
            ocas['ws'].addEventListener('message', function (event) {
		console.log('Message from server/message ');
		console.log(event);		
            });
            ocas['ws'].addEventListener('close', function (event) {
		console.log('Message from server/close ');
		console.log(event);		
            });
	    */
	},
	
        ws_on_open : function ( h ) {
	    //console.log(h);
	    //h ("dfasd") ;
	    
            ocas['ws'].addEventListener('open',h );
	},
        ws_on_close : function ( h ) {
            ocas['ws'].addEventListener('close',h );
	},
        ws_on_error : function ( h ) {
            ocas['ws'].addEventListener('error',h );
	},
        ws_on_message : function ( h ) {
            ocas['ws'].addEventListener('message',h );	    	    
        },

        send : function ( msg ) {
            ocas['ws'].send(msg);
	},
        close : function () {
            ocas['ws'].close();
	},	
    }
    
} () );


/*
Message from server/open2 WebSocket_closure.js:17:11
open { target: WebSocket, isTrusted: true, srcElement: WebSocket, currentTarget: WebSocket, eventPhase: 2, bubbles: false, cancelable: false, returnValue: true, defaultPrevented: false, composed: false, … }
WebSocket_closure.js:18:11
ws_State.send('test send')
undefined
Message from server/message WebSocket_closure.js:21:11
message { target: WebSocket, isTrusted: true, data: "test send", origin: "ws://localhost:8000", lastEventId: "", ports: Restricted, srcElement: WebSocket, currentTarget: WebSocket, eventPhase: 2, bubbles: false, … }
WebSocket_closure.js:22:11
ws_State.close()
undefined
Message from server/close WebSocket_closure.js:25:11
close { target: WebSocket, isTrusted: true, wasClean: false, code: 1006, reason: "", srcElement: WebSocket, currentTarget: WebSocket, eventPhase: 2, bubbles: false, cancelable: false, … }
WebSocket_closure.js:26:11

​






*/


/*

// Create WebSocket connection.
const socket = new WebSocket('ws://localhost:8000/websocket');

// Connection opened
socket.addEventListener('open', function (event) {
    socket.send('Hello Server!');
});

// Listen for messages
socket.addEventListener('message', function (event) {
    console.log('Message from server ', event.data);
});


*/
