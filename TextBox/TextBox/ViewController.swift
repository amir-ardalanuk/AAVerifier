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

    }

   

}

extension ViewController : AAVriferDelegate {
    func codeChanged(code: String) {
        print(code)
    }
}
