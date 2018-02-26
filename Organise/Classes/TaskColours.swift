//
//  TaskColours.swift
//  Organise
//
//  Created by Thomas Houghton on 03/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import Foundation
import UIKit

// Turn this into class and make reuseable pull color function!!!!

class TaskColours {
    var red = [
        UIColor.init(red: 155/255, green: 15/255, blue: 15/255, alpha: 1), // Background, Boxes
        UIColor.init(red: 255, green: 130/255, blue: 130/255, alpha: 1), // Sub View
        UIColor.init(red: 255/255, green: 0, blue: 0, alpha: 1) // Button Text
    ]
    
    var turquise = [
        UIColor.init(red: 16/255, green: 156/255, blue: 146/255, alpha: 1),
        UIColor.init(red: 193/255, green: 251/255, blue: 232/255, alpha: 1),
        UIColor.init(red: 145/255, green: 253/255, blue: 220/255, alpha: 1)
    ]
    
    var blue = [
        UIColor.init(red: 18/255, green: 14/255, blue: 91/255, alpha: 1), // Background, Boxes
        UIColor.init(red: 158/255, green: 154/255, blue: 234/255, alpha: 1), // Sub View
        UIColor.init(red: 0, green: 0, blue: 255/255, alpha: 1) // Button Text
    ]
    
    var green = [
        UIColor.init(red: 14/255, green: 112/255, blue: 12/255, alpha: 1), // Background, Boxes
        UIColor.init(red: 187/255, green: 239/255, blue: 186/255, alpha: 1), // Sub View
        UIColor.init(red: 0, green: 255/255, blue: 0, alpha: 1) // Button Text
    ]
    
    var purple = [
        UIColor.init(red: 56/255, green: 5/255, blue: 79/255, alpha: 1), // Background, Boxes
        UIColor.init(red: 244/255, green: 176/255, blue: 244/255, alpha: 1), // Sub View
        UIColor.init(red: 178/255, green: 255/255, blue: 255/255, alpha: 1) // Button Text
    ]
    
    func colorToNumber(color: String) -> Int {
        var rtnVal = 0
        if (color == "red") {
            rtnVal = 1
        }else if (color == "turquise") {
            rtnVal = 0
        }else if (color == "blue") {
            rtnVal = 2
        }else if (color == "green") {
            rtnVal = 3
        }else if (color == "purple") {
            rtnVal = 4
        }
        
        return rtnVal
    }
    
    func pullColour(selectedColour: Int, shade: Int) -> UIColor {
        var returnVal = UIColor()
        let colourPallet = TaskColours()
        
        if (selectedColour == 0) {
            if (shade == 1) {
                returnVal = colourPallet.turquise[0]
            }else if (shade == 2) {
                returnVal = colourPallet.turquise[1]
            }else if (shade == 3) {
                returnVal = colourPallet.turquise[2]
            }
        }else if (selectedColour == 1) {
            if (shade == 1) {
                returnVal = colourPallet.red[0]
            }else if (shade == 2) {
                returnVal = colourPallet.red[1]
            }else if (shade == 3) {
                returnVal = colourPallet.red[2]
            }
        }else if (selectedColour == 2) {
            if (shade == 1) {
                returnVal = colourPallet.blue[0]
            }else if (shade == 2) {
                returnVal = colourPallet.blue[1]
            }else if (shade == 3) {
                returnVal = colourPallet.blue[2]
            }
        }else if (selectedColour == 3) {
            if (shade == 1) {
                returnVal = colourPallet.green[0]
            }else if (shade == 2) {
                returnVal = colourPallet.green[1]
            }else if (shade == 3) {
                returnVal = colourPallet.green[2]
            }
        }else if (selectedColour == 4) {
            if (shade == 1) {
                returnVal = colourPallet.purple[0]
            }else if (shade == 2) {
                returnVal = colourPallet.purple[1]
            }else if (shade == 3) {
                returnVal = colourPallet.purple[2]
            }
        }
        return returnVal
    }
    
    
    /*
     Color values:
     "Default",
     "Red",
     "Blue",
     "Green",
     "Purple"
    */
    func pullColorFromString(selectedColor: String, shade: Int) -> UIColor{
        var returnVal = UIColor()
        
        if (selectedColor == "Default") {
            if (shade == 1) {
                returnVal = turquise[0]
            }else if (shade == 2) {
                returnVal = turquise[1]
            }else if (shade == 3) {
                returnVal = turquise[2]
            }
        }else if (selectedColor == "Red") {
            if (shade == 1) {
                returnVal = red[0]
            }else if (shade == 2) {
                returnVal = red[1]
            }else if (shade == 3) {
                returnVal = red[2]
            }
        }else if (selectedColor == "Blue") {
            if (shade == 1) {
                returnVal = blue[0]
            }else if (shade == 2) {
                returnVal = blue[1]
            }else if (shade == 3) {
                returnVal = blue[2]
            }
        }else if (selectedColor == "Green") {
            if (shade == 1) {
                returnVal = green[0]
            }else if (shade == 2) {
                returnVal = green[1]
            }else if (shade == 3) {
                returnVal = green[2]
            }
        }else if (selectedColor == "Purple") {
            if (shade == 1) {
                returnVal = purple[0]
            }else if (shade == 2) {
                returnVal = purple[1]
            }else if (shade == 3) {
                returnVal = purple[2]
            }
        }
        return returnVal
    }
}
