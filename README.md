# IOSComponent

## *Tutorial*

- WebCam: 

- WebSocket:
> - Connect Socket
> - Transmission Data(Swift Client) <-> Binary(node.js Server), String(Swift Client) <-> String(node.js Srever)
> - Import MOS Dictionary: https://gist.github.com/mosluce/4b41cd7f601943558be0800230aa17d1#file-da-swift-L41


## *Playground*

- GCD: 
>    qos（優先權限）: UserInterActive > UserInitiated > Default > Utility > Background > Unspecified
> 
> ``` swift
> let queueDefault = DispatchQueue(label: "queue.Default", qos: .default)
> queueDefault.async{
> //Do Something
> }
> ```
>    from:[Swift 3學習指南：重新認識GCD應用](https://www.appcoda.com.tw/grand-central-dispatch/)    


