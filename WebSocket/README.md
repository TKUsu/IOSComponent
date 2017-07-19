- init & delegate
``` swift
class ViewController: WebSocketDelegate{
    let socket: WebSocket = WebSocket(url: NSURL(string: "ws://localhost:port")! as URL, protocols: ["protocol"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socket.delegate = self
    }
    
    func websocketDidConnect(socket: WebSocket) { }
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) { }
    func websocketDidReceiveData(socket: WebSocket, data: Data) { }
    func websocketDidReceiveMessage(socket: WebSocket, text: String) { }
}
```
- Dis/Connect
``` swift
socket.connect()
socket.disconnect()
```
- Json parse
```swift
//Json -> string
let sendData = try JSONSerialization.data(withJSONObject: sendJSON, options: [])
let sendString = String(data: sendData, encoding: String.Encoding.utf8)
socket.write(string: sendString!)

//String -> Json
var json: [Dictionary<String, Any>] = []

guard let data = text.data(using: .utf16),
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
                let jsonDict = jsonData as? [String: Any] else {
            return []
        }
        
json.append(jsonDict)

//Data -> Json
var json: [Dictionary<String, Any>] = []
        
guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonDict = jsonData as? [String: Any] else {
            return []
        }
json.append(jsonDict)

//Json -> Data
do{
        let sendDATA = try JSONSerialization.data(withJSONObject: sendJSON, options: [])
        socket.write(data: sendDATA)
} catch let error {
        print("[ERROR]: \(error)")
}
```
