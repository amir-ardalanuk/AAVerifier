//
//  ViewController.swift
//  TextBox
//
//  Created by Amir Ardalan on 9/22/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import UIKit
import AAVerifier
class ViewController: UIViewController {

    @IBOutlet weak var  verifier : AAVerifier! {
        didSet{
            verifier.codeDelegate = self
            verifier.keyboardType = .phonePad
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        verifier.alphaTextField?.becomeFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
            self.verifier.setCode(string: "555665")
        }
    }

   

}

extension ViewController : AAVriferDelegate {
    func codeChanged(code: String) {
        print(code)
    }
}
