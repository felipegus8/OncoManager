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
}

extension UIColor {
    
    class func greenOM() -> UIColor{
        return UIColor(red:0.00, green:0.47, blue:0.24, alpha:1.0)
    }
    
    class func greenOM1() -> UIColor{
        return UIColor(red:0.6, green:0.78, blue:0.7, alpha:1.0)
    }

}

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}