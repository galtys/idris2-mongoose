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
	    console.log("new");
	    ocas['ws'].addEventListener('message', event => function (event) {
                 console.log('Message from server ', event.data);
            } );
	},
        ws_on_open : function ( h ) {
	    console.log("register on open")	    
            ocas['ws'].addEventListener('open',h );
	},
        ws_on_close : function ( h ) {
            ocas['ws'].addEventListener('close',h );
	},

        ws_on_error : function ( h ) {
            ocas['ws'].addEventListener('error',h );
	},
        ws_on_message : function ( h ) {
	    console.log("register on message")	    
            ocas['ws'].addEventListener('message',h );
	},
	
        ws_send : function ( msg ) {
            ocas['ws'].send(msg);
	    //return ws;
	},
        ws_close : function () {
            ocas['ws'].close();
	},	
    }
} () );
