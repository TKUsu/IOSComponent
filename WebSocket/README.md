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
//Json(json) -> string
guard JSONSerialization.isValidJSONObject(json) else {
    return
}
do {
    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
    //Encode: UTF8
    let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
    socket.write(string: jsonString!)
} catch let error {
    print("[ERROR_JsonToString]: \(error)")
}

//String(jsonString) -> Json
var json: [Dictionary<String, Any>] = []

guard let data = jsonString.data(using: .utf16),
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
                let jsonDict = jsonData as? [String: Any] else {
            return []
        }
        
json.append(jsonDict)

//Data(data) -> Json
var json: [Dictionary<String, Any>] = []
        
guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonDict = jsonData as? [String: Any] else {
            return []
        }
json.append(jsonDict)

//Json(json) -> Data
do{
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        socket.write(data: data)
} catch let error {
        print("[ERROR]: \(error)")
}
```
