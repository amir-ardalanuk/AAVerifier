//
//  CodeTextField.swift
//  TextBox
//
//  Created by Amir Ardalan on 9/22/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import UIKit

class CodeTextField: UITextField , Animatable {

    var codeDelegate : AAVerifierTextDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commit()
       
    }
    
    
    func commit(){
        if #available(iOS 12.0, *) {
            self.textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
        }
        self.textAlignment = .center
        self.delegate = self
       self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 2 {
         self.codeDelegate?.completeVerifier(text: textField.text ?? "")
            return
        }
        if textField.text?.count == 1 {
            findNext()
           
        }else{
            findPrevious()
        }
        codeDelegate?.textChanged()
    }
    
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 2, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 2, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
}

extension CodeTextField : UITextFieldDelegate {
    override func deleteBackward() {
        super.deleteBackward()
        if self.text?.count == 0 {
            findPrevious()
        }
    }
    
    func findNext(){
        if let nextField = self.superview?.viewWithTag(self.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            self.resignFirstResponder()
            //self.codeDelegate.complete()
        }
    }
    func findPrevious(){
        
        if let nextField = self.superview?.viewWithTag(self.tag - 1) as? UITextField { //nextField.text?.count == 0 {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            self.resignFirstResponder()
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let count = textField.text?.count
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        if (count ?? 0) > 2 {
            self.codeDelegate?.completeVerifier(text: textField.text ?? "")
            return false
        }
        if  count == 0 || (count == 1 && string == "") {
            return true
        }else {
            findNext()
            return false
        }
        return true
    }
    
    
}
