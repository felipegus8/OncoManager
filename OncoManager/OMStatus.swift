//
//  OMStatus.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/15/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class OMStatus: UIView {
    
    var path: UIBezierPath!
    var colorStatus = UIColor(red:0.00, green:0.73, blue:0.38, alpha:1.0)

    override func drawRect(rect: CGRect) {
        path = UIBezierPath(ovalInRect: rect)
        colorStatus.setFill()
        path.fill()
        print("initialized")
    }
    
}

//        override func drawRect(rect: CGRect)
//        {
//            drawRingFittingInsideView()
//        }
//        
//        internal func drawRingFittingInsideView()->()
//        {
//            let halfSize:CGFloat = min(bounds.size.width/2, bounds.size.height/2)
//            let desiredLineWidth: CGFloat = 1    // your desired value
//            
//            let circlePath = UIBezierPath(
//                arcCenter: CGPoint(x:halfSize,y:halfSize),
//                radius: CGFloat( halfSize - (desiredLineWidth/2) ),
//                startAngle: CGFloat(0),
//                endAngle:CGFloat(M_PI * 2),
//                clockwise: true)
//            
//            let shapeLayer = CAShapeLayer()
//            shapeLayer.path = circlePath.CGPath
//            
//            shapeLayer.fillColor = UIColor.greenColor().CGColor
//            shapeLayer.strokeColor = UIColor.clearColor().CGColor
//            shapeLayer.lineWidth = desiredLineWidth
//            
//            layer.addSublayer(shapeLayer)
//        }

