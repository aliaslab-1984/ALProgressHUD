//
//  ALVisualEffectView.swift
//  Visual Effect View Base Classs
//
//  Created by Enrico on 16/11/2018.
//  Copyright © 2018 Enrico Bonaldo. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied warranty.
//
//  In no event will the authors be held liable for any damages arising from the use of this software.
//

import UIKit

class ALVisualEffectView: UIVisualEffectView {
    
    let label: UILabel = UILabel()
    
    var textColor: UIColor
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    /**
     - Parameter text: what to display
     - Parameter shadowing: true to have a lighter dialog (usually because there is a shadowing view under it)
     */
    required init(text: String = "", shadowing: Bool = false) {
        
        self.text = text
        textColor = shadowing ? .white : .gray
        
        let blurEffect = shadowing ? UIBlurEffect(style: .dark) : UIBlurEffect(style: .extraLight)
        super.init(effect: blurEffect)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(label)
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
