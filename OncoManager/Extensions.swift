//
//  Extensions.swift
//  OncoManager
//
//  Created by Felipe Viberti on 7/19/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import Foundation
import UIKit

extension NSDate
{
    var localTime: String {
        return descriptionWithLocale(NSLocale.currentLocale())
    }

    func convertNsDateToString() -> String
    {
        var stringFinal:String!
        let stringAux = String(self)
        print(stringAux)
        let dataaux = stringAux.stringByReplacingOccurrencesOfString(":", withString: "-")
        let dataAux2 = dataaux.stringByReplacingOccurrencesOfString(" ", withString: "-")
        let fullNameArr = dataAux2.componentsSeparatedByString("-")
        stringFinal = fullNameArr[2] + "/" + fullNameArr[1] + "/" + fullNameArr[0] + " - " + fullNameArr[3] + ":" + fullNameArr[4]
        print(stringFinal)
        return stringFinal
    }
    
    func consertaHorarioDeVerao() -> String
    {
         var stringFinal:String!
        let stringAux = String(self)
        let dataaux = stringAux.stringByReplacingOccurrencesOfString(":", withString: "-")
        let dataAux2 = dataaux.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        let fullNameArr = dataAux2.componentsSeparatedByString("-")
        
        if fullNameArr[1] == "10" || fullNameArr[1] == "11" || fullNameArr[1] == "12" || fullNameArr[1] == "01" || fullNameArr[1] == "02"
        {
            let horaCerta = Int(fullNameArr[3])! + 1
            stringFinal = fullNameArr[2] + "/" + fullNameArr[1] + "/" + fullNameArr[0] + " - " + String(horaCerta) + ":" + fullNameArr[4]
        }
        else{
            stringFinal = fullNameArr[2] + "/" + fullNameArr[1] + "/" + fullNameArr[0] + " - " + fullNameArr[3] + ":" + fullNameArr[4]

    }
        return stringFinal
    }
    func convertNsDateToStringWithoutHour() -> String
    {
        var stringFinal:String!
        let stringAux = String(self)
        let dataaux = stringAux.stringByReplacingOccurrencesOfString(":", withString: "-")
        let dataAux2 = dataaux.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        let fullNameArr = dataAux2.componentsSeparatedByString("-")
        print(fullNameArr)
        stringFinal = fullNameArr[2] + "/" + fullNameArr[1] + "/" + fullNameArr[0]
        return stringFinal
    }
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }

}

extension UIColor {
    
    class func greenOM() -> UIColor{
        return UIColor(red:0.00, green:0.47, blue:0.24, alpha:1.0)
    }
    
    class func greenOM1() -> UIColor{
        return UIColor(red:0.6, green:0.78, blue:0.7, alpha:1.0)
    }
    
    class func yellowStatus() -> UIColor{
        return UIColor(red:0.94, green:0.84, blue:0.00, alpha:1.0)
    }
    
    class func greenStatus() -> UIColor{
        return UIColor(red:0.00, green:0.73, blue:0.38, alpha:1.0)
    }

}

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}

extension UIView {
    func currentFirstResponder() -> UIView? {
        if self.isFirstResponder() {
            return self
        }
        
        for view in self.subviews {
            if view.currentFirstResponder() != nil {
                return view
            }
        }
        
        return nil
    }
        
        func convertRectCorrectly(rect: CGRect, toView view: UIView) -> CGRect {
            if UIScreen.mainScreen().scale == 1 {
                return self.convertRect(rect, toView: view)
            }
            else if self == view {
                return rect
            }
            else {
                var rectInParent = self.convertRect(rect, toView: self.superview)
                rectInParent.origin.x /= UIScreen.mainScreen().scale
                rectInParent.origin.y /= UIScreen.mainScreen().scale
                let superViewRect = self.superview!.convertRectCorrectly(self.superview!.frame, toView: view)
                rectInParent.origin.x += superViewRect.origin.x
                rectInParent.origin.y += superViewRect.origin.y
                return rectInParent
            }
        }
}