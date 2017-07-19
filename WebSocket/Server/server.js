var WebSocketServer = require('websocket').server;
var http = require('http');
var port = 3000;

var server = http.createServer(function(request, response) {
    console.log((new Date()) + ' Received request for ' + request.url);
    response.writeHead(404);
    response.end();
});
server.listen(port, function() {
    console.log((new Date()) + ' Server is listening on port ' + port);
});

wsServer = new WebSocketServer({
    httpServer: server,
    // You should not use autoAcceptConnections for production
    // applications, as it defeats all standard cross-origin protection
    // facilities built into the protocol and the browser.  You should
    // *always* verify the connection's origin and decide whether or not
    // to accept it.
    autoAcceptConnections: false
});

function originIsAllowed(origin) {
    // put logic here to detect whether the specified origin is allowed.
    return true;
}

var json = {
    "type": "message",
    "data":
    {
        "time": 1472513071731, "text": ":]", "author": "iPhone Simulator", "color": "orange"
    }
};

var binaryJson;

wsServer.on('request', function(request) {
    if (!originIsAllowed(request.origin)) {
        // Make sure we only accept requests from an allowed origin
        request.reject();
        console.log((new Date()) + ' Connection from origin ' + request.origin + ' rejected.');
        return;
    }

    //protocol[room-chat]
    var connection = request.accept('room-chat', request.origin);
    console.log((new Date()) + ' Connection accepted.');

    console.log("*****[Outside]*****");
    connection.sendUTF(JSON.stringify(json));

    /*//problem: change Buffer
    var jsonBuf = new Buffer.from(JSON.stringify(json));
    if (Buffer.isBuffer(jsonBuf)) {
        WebSocketConnection.prototype.sendBytes(json);
    }else {
        console.log("[ERROR_BUFFER]: send data isn't buffer");
    }
    */

    connection.on('message', function(message) {
        //String
        console.log("*****[Intside]*****");
        if (message.type === 'utf8') {
            console.log("*****[Intside-1]*****");
            console.log('Received Message: ' + message.utf8Data);
            connection.sendUTF(JSON.stringify(json));
        }//JSON
        else if (message.type === 'binary') {
            console.log("*****[Intside-2]*****");
            console.log('Received Binary Message of ' + message.binaryData.length + ' bytes');
            connection.sendBytes(message.binaryData);

            //Binary to Json
            binaryJson = JSON.parse(message.binaryData);
            console.log(binaryJson);
        }
    });
    connection.on('close', function(reasonCode, description) {
        console.log((new Date()) + ' Peer ' + connection.remoteAddress + ' disconnected.');
    });
});