//
//  Verifier.swift
//  TextBox
//
//  Created by Amir Ardalan on 9/22/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import UIKit

public protocol AAVriferDelegate {
    func codeChanged(code : String)
}

protocol AAVerifierTextDelegate {
    func textChanged()
    func complete()
    func completeVerifier(text : String)
}

public class AAVerifier: UIStackView {

    
    @IBInspectable public var CodeCount : CGFloat = 4 {
        didSet{
            generate()
            setUITextField()
        }
    }
    
    @IBInspectable public var borderColor : UIColor = UIColor.clear {
        didSet{
            setUITextField()
        }
    }
    @IBInspectable public var borderWidht : CGFloat = 0.0 {
        didSet{
            setUITextField()
        }
    }
    
    @IBInspectable public var placeholderColor : UIColor = UIColor.gray {
        didSet{
            setUITextField()
        }
    }
    
    @IBInspectable public var placeholderString : String? = nil {
        didSet{
            setUITextField()
        }
    }
    
    @IBInspectable public var radius : CGFloat = 0.0 {
        didSet{
            setUITextField()
        }
    }
    
    @IBInspectable public var fontString : String? = nil {
        didSet{
            setUITextField()
        }
    }
    
    @IBInspectable public var fontSize : CGFloat = 17 {
        didSet{
            setUITextField()
        }
    }
    
    @IBInspectable public var hasShakeAnimate : Bool = true {
        didSet{
            setUITextField()
        }
    }
    @IBInspectable public var space : CGFloat = 8 {
        didSet{
            setUITextField()
        }
    }
    var textFieldItems = [CodeTextField]()
    var alphaTextField :BackwardTextField?
    var currentTag : Int = 0
    public var codeDelegate : AAVriferDelegate?
    private var lastEditCode = ""
    public var keyboardType : UIKeyboardType = .numberPad {
        didSet{
            self.changedKeyboardType()
        }
    }
    
    public override  init(frame: CGRect) {
        super.init(frame: frame)
        commit()
    }
    
  
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
        commit()
       
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        alphaTextField?.frame = self.frame
    }
    
    func commit(){
         backgroundTextField()
    }
    
    
    fileprivate func backgroundTextField() {
        alphaTextField = BackwardTextField()
        alphaTextField?.textAlignment = .center
        alphaTextField?.tintColor = .clear
        alphaTextField?.delegate = self
        self.addSubview(alphaTextField!)
        alphaTextField?.onBackTap = {
            self.backWardCheck()
        }
    }
    
    
    func generate(){
        for i in 1...Int(CodeCount) {
            let tf = CodeTextField()
            tf.layer.borderColor = UIColor.black.cgColor
            tf.layer.cornerRadius = 8
            tf.tag = i
            tf.isUserInteractionEnabled = false
            tf.keyboardType = self.keyboardType
            tf.keyboardType = UIKeyboardType.numberPad
            self.addArrangedSubview(tf)
        }
        textFieldItems = self.subviews.filter{ $0 is CodeTextField } as! [CodeTextField]
    }
    
    func changedKeyboardType() {
        for i in self.subviews  {
            guard let tf = i as? CodeTextField else {return }
            self.alphaTextField?.keyboardType = self.keyboardType
            tf.keyboardType = self.keyboardType
        }
    }
 
    func setUITextField(){
        self.spacing = self.space
        for i in self.subviews  {
            guard let tf = i as? CodeTextField else {continue }
            tf.layer.borderWidth = self.borderWidht
            tf.layer.borderColor = self.borderColor.cgColor
            tf.layer.cornerRadius = self.radius
            tf.codeDelegate = self
            if let fontStr = self.fontString ,  let font = UIFont(name: fontStr, size: fontSize) {
                tf.font = font
            }
            tf.placeholder = self.placeholderString
            tf.attributedPlaceholder = NSAttributedString(string: self.placeholderString ?? "●",
                                              attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor) : self.placeholderColor]))
            }
    }
    
    /// set Code from external view
    ///
    /// - Parameter string: **make sure CodeCount and string charecter count must be equal**
    public func setCode(string : String) {
       
        let array = Array(string)
        
        guard array.count == textFieldItems.count else {return}
        for (index ,i ) in textFieldItems.enumerated()  {
                i.text = String(array[index])
        }
         self.codeDelegate?.codeChanged(code: string)
    }
    
    func textFieldAnimate(_ textfield : CodeTextField) {
        if self.hasShakeAnimate {
            textfield.shake()
        }
     
    }
    
    func backWardCheck(){
        
        if (textFieldItems[currentTag].text?.isEmpty ?? true) , currentTag > 0 {
            currentTag -= 1
            let tf = textFieldItems[currentTag]
            tf.text = nil
            self.textFieldAnimate(tf)
            
        }else{
            let tf = textFieldItems[currentTag]
            tf.text = nil
            self.textFieldAnimate(tf)
        }
        self.textChanged()
    }
    
    func insert(text : String){
        guard currentTag < self.textFieldItems.count else {
            currentTag = self.textFieldItems.count - 1
            return
        }
        if currentTag == (self.textFieldItems.count - 1) {
            self.complete()
        }
        textFieldItems[currentTag].text = text
        textChanged()
        guard currentTag < self.textFieldItems.count - 1 else {
            complete()
            return
        }
        currentTag += 1
        
    }
}
extension AAVerifier : UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch string.count {
        case 1 : insert(text: string)
        case let count where count > 1 : self.setCode(string: string)
        default:break
        }
        return false
    }
}
extension AAVerifier : AAVerifierTextDelegate {
    func completeVerifier(text: String) {
        self.setCode(string: text)
    }
    
    func complete() {
        for i in self.subviews  {
            guard let tf = i as? CodeTextField else {return }
            tf.animating() 
        }
    }
    
    func textChanged() {
        var str = ""
        for i in self.subviews  {
            guard let tf = i as? CodeTextField else {continue }
            str += tf.text ?? ""
        }
        self.codeDelegate?.codeChanged(code: str)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}
