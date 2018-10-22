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
    
    @IBInspectable public var space : CGFloat = 8 {
        didSet{
            setUITextField()
        }
    }
    
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
    
    func commit(){
     //   generate()
   //     setUITextField()
    }
    
    func generate(){
        for i in 1...Int(CodeCount) {
            let tf = CodeTextField()
            tf.layer.borderColor = UIColor.black.cgColor
            tf.layer.cornerRadius = 8
            tf.tag = i
            tf.keyboardType = self.keyboardType
            tf.keyboardType = UIKeyboardType.numberPad
            self.addArrangedSubview(tf)
        }
    }
    
    func changedKeyboardType() {
        for i in self.subviews  {
            guard let tf = i as? CodeTextField else {return }
            tf.keyboardType = self.keyboardType
        }
    }
 
    func setUITextField(){
        self.spacing = self.space
        for i in self.subviews  {
            guard let tf = i as? CodeTextField else {return }
            tf.layer.borderWidth = self.borderWidht
            tf.layer.borderColor = self.borderColor.cgColor
            tf.layer.cornerRadius = self.radius
            tf.codeDelegate = self
            if let fontStr = self.fontString ,  let font = UIFont(name: fontStr, size: fontSize) {
                tf.font = font
            }
            tf.placeholder = self.placeholderString
            #if swift(>=4.0)
            tf.attributedPlaceholder = NSAttributedString(string: self.placeholderString ?? "●",
                                                                   attributes: [NSAttributedStringKey.foregroundColor: self.placeholderColor])
            #elseif swift(>=3.0)
            tf.attributedPlaceholder = NSAttributedString(string: self.placeholderString ?? "●",
            attributes: [NSForegroundColorAttributeName : self.placeholderColor])
            #endif
        }
    }
}

extension AAVerifier : AAVerifierTextDelegate {
    func complete() {
        for i in self.subviews  {
            guard let tf = i as? CodeTextField else {return }
            tf.animating() 
        }
    }
    
    func textChanged() {
        var str = ""
        for i in self.subviews  {
            guard let tf = i as? CodeTextField else {return }
            str += tf.text ?? ""
        }
        self.codeDelegate?.codeChanged(code: str)
    }
}


