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
    // applications, as it defeats all stand2
ard cross-origin protection
    // facilities built into the protocol and the browser.  You should
    // *always* verify the connection's origin and decide whether or not
    // to accept it.
    autoAcceptConnections: false
});

function originIsAllowed(origin) {
    // put logic here to detect whether the specified origin is allowed.
    return true;
}

wsServer.on('request', function(request) {
    if (!originIsAllowed(request.origin)) {
        // Make sure we only accept requests from an allowed origin
        request.reject();
        console.log((new Date()) + ' Connection from origin ' + request.origin + ' rejected.');
        return;
    }

    var connectionChat = request.accept('room-chat', request.origin);
    console.log((new Date()) + ' Connection accepted.');
    if (connectionChat.connected){
        var number = "Hi I'm server";
        connection.sendUTF(number);
    }
    connectionChat.on('message', function(message) {
        if (message.type === 'utf8') {
            console.log('Received Message: ' + message.utf8Data);
            connectionChat.sendUTF(message.utf8Data);
        }
        else if (message.type === 'binary') {
            console.log('Received Binary Message of ' + message.binaryData.length + ' bytes');
            connectionChat.sendBytes(message.binaryData);
        }
    });
    connectionChat.on('close', function(reasonCode, description) {
        console.log((new Date()) + ' Peer ' + connectionChat.remoteAddress + ' disconnected.');
    });

    // var test = request.accept('test', request.origin);
    // console.log((new Date()) + ' Connection accepted.');
    // test.on('message', function(message) {
    //     if (message.type === 'utf8') {
    //         console.log('Received Message: ' + message.utf8Data);
    //         test.sendUTF(message.utf8Data);
    //     }
    //     else if (message.type === 'binary') {
    //         console.log('Received Binary Message of ' + message.binaryData.length + ' bytes');
    //         test.sendBytes(message.binaryData);
    //     }
    // });
    // test.on('close', function(reasonCode, description) {
    //     console.log((new Date()) + ' Peer ' + test.remoteAddress + ' disconnected.');
    // });
});
