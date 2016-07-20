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
    func convertNsDateToString() -> String
    {
        var stringFinal:String!
        let stringAux = String(self)
        let dataaux = stringAux.stringByReplacingOccurrencesOfString(":", withString: "-")
        let dataAux2 = dataaux.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        let fullNameArr = dataAux2.componentsSeparatedByString("-")
        print(fullNameArr)
        stringFinal = fullNameArr[2] + "/" + fullNameArr[1] + "/" + fullNameArr[0] + " - " + fullNameArr[3] + ":" + fullNameArr[4]
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
    
}

extension UIColor {
    
    class func greenOM() -> UIColor{
        return UIColor(red:0.00, green:0.47, blue:0.24, alpha:1.0)
    }

}