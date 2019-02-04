//
//  BackwardTextField.swift
//  AAVerifier
//
//  Created by Amir Ardalan on 2/4/19.
//  Copyright © 2019 golrang. All rights reserved.
//

import Foundation
public class BackwardTextField: UITextField {
    
    // MARK: Life cycle
    var onBackTap:(()->Void)?
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    
    override public func deleteBackward() {
        super.deleteBackward()
        onBackTap?()
       // print("deleteBackward")
    }
    
}
