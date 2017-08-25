# SpeechKit
---
## Speech to Text
* Setting Info.plist
> `Privacy - Microphone Usage Description`
> `Privacy - Speech Recognition Usage Description`

* Setting Language & Start
> ```  swift
> override func viewDidLoad() {
>  	super.viewDidLoad()
> 
> 	//Setting Language 
>     Module.languageTW()
> 	//or
>     Module.languageEN()
> 	//or
> 	Module.language(code: “Language Code”)
> }
> 
> @IBAction func ButtonAction(_ sender: UIButton) { 
> 	//Start & Stop
> 	recording.start()
> }
> ```

* get text protocol
> ``` swift 
> override func viewDidLoad() {
>  	super.viewDidLoad()
> 	recording.delegate = self
> }
> ```
> ``` swift
> extension ViewController: RecordingProtocol{
>     func Recognition(Text: String) {
>         textLabel.text = Text
>     }
> }
> ```
---
## Text to Speech
* Setting Language
> ```  swift
> override func viewDidLoad() {
>  	super.viewDidLoad()
> 
> 	//Setting Language 
>     Module.languageTW()
> 	//or
>     Module.languageEN()
> 	//or
> 	Module.language(code: “Language Code”)
> }
> ```

* Start speech
> `mySpeech.talk(text: textLabel.text as! String)`