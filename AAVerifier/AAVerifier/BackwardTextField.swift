//
//  BackwardTextField.swift
//  AAVerifier
//
//  Created by Amir Ardalan on 2/4/19.
//  Copyright © 2019 golrang. All rights reserved.
//

import Foundation
class BackwardTextField: UITextField {
    
    // MARK: Life cycle
    var onBackTap:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    
    override func deleteBackward() {
        super.deleteBackward()
        onBackTap?()
       // print("deleteBackward")
    }
    
}
