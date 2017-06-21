# IOSComponent

## *Tutorial*

- WebCam: 

- WebSocket:



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


