//
//  OMButton.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class OMButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configButton()
    }
    
    func configButton() {
        self.frame.size.height = 40
        self.frame.size.width = 288
        self.layer.cornerRadius = 15.0
        self.layer.frame.size.width = CGFloat(100.0)
        self.backgroundColor = UIColor.greenOM()
        self.tintColor = UIColor.whiteColor()
        self.setTitleColor(UIColor.whiteColor(), forState: .Selected)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
