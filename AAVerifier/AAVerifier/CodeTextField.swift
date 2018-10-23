//
//  CodeTextField.swift
//  TextBox
//
//  Created by Amir Ardalan on 9/22/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import UIKit

class CodeTextField: UITextField , Animatable {

    var codeDelegate : AAVerifierTextDelegate!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commit()
    }
    
    
    func commit(){
        self.textAlignment = .center
        self.delegate = self
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count == 1 {
            findNext()
           
        }else{
            findPrevious()
        }
        codeDelegate.textChanged()
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
        if  count == 0 || (count == 1 && string == "") {
            return true
        }else {
            findNext()
            return false
        }
        
    }
}
