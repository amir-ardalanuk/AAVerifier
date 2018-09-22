//
//  Animatable.swift
//  AAVerifier
//
//  Created by Amir Ardalan on 9/22/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import Foundation
import UIKit

protocol Animatable {
    func animating()
}

extension Animatable where Self : CodeTextField  {
    
    func animating(){
        let gp = CAAnimationGroup()
        gp.duration = 1
        gp.speed = 16
        gp.repeatCount = 5
        gp.animations = [ vibrateAnimation() , colorAnimation()]
        
        //let vibration = vibrateAnimation()
        self.layer.add(gp, forKey: "gp")
    }
    
    func vibrateAnimation() -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "position.x")
        
        anim.fromValue = self.layer.position.x - CGFloat(8)
        anim.toValue = self.layer.position.x + CGFloat(8)
       // anim.duration  = 1
      //  anim.speed = 100
      //  anim.fillMode = kCAFillModeRemoved
        anim.autoreverses = true
        anim.repeatCount = 5
        
        return anim
        
    }
    func colorAnimation() -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "borderColor")
        
        anim.fromValue = UIColor.red.cgColor
        anim.toValue = self.layer.borderColor
       // anim.duration  = 1
       // anim.speed = 100
      //  anim.fillMode = kCAFillModeRemoved
        anim.autoreverses = true
        anim.repeatCount = 5
        
        return anim
        
    }
}
