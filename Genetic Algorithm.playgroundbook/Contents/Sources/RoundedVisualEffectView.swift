// 
//  RoundedVisualEffectView.swift
//
//  Taken from Blink playground
//  Copyright © 2016-2018 Apple Inc. All rights reserved.
//

import UIKit

public class RoundedVisualEffectView: UIVisualEffectView {
    
    var cornerRadius: CGFloat = 22
    
    public init() {
        super.init(effect: UIBlurEffect(style: .light))
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
