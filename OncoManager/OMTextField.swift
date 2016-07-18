//
//  OMTextField.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/13/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class OMTextField: UITextField {

    var scrollView = UIScrollView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configBorder()
    }
    
    func configBorder() {
        self.borderStyle = .None
        self.layer.cornerRadius = 15.0
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
}
