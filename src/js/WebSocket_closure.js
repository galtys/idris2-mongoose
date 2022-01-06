
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
	    
	},
	
        ws_on_open : function ( h ) {
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

        ws_send : function ( msg ) {
            ocas['ws'].send(msg);
	},
        ws_close : function () {
            ocas['ws'].close();
	},	
    }
    
} () );


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
