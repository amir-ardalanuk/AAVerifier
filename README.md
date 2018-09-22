# AAVerifier
add Simple Verify Code in your project ! 
### Requirements

   - iOS 9.0+ 
   - Xcode 8.1+
   - Swift 3.0+

## Install

you can use in cocoapods
```swift
pod 'AAVerifier'
```
## init
such as gif(very simple) add UIStackView then -> Custom Class -> AAVerifier 
![](https://github.com/amir-ardalanuk/AAVerifier/blob/master/setup_AAVerifier.gif)


#### next : 
set delegate :
```swift
    @IBOutlet weak var  verifier : AAVerifier! {
        didSet{
            verifier.codeDelegate = self
        }
    }
```
and implementation the delegate from ``AAVriferDelegate`` :
```swift
extension ViewController : AAVriferDelegate {
    func codeChanged(code: String) {
        print(code)
    }
}
```
## get Code :


## options 
 
![](https://github.com/amir-ardalanuk/AAVerifier/blob/master/Screen%20Shot%202018-09-22%20at%2012.18.27%20PM.png)

## Done !
![](https://github.com/amir-ardalanuk/AAVerifier/blob/master/sample_AAVerifier.gif)

#### if you need more option or i have bug please let me know ! thanks

## License

AAVerifier is available under the MIT license. See the LICENSE file for more information.
