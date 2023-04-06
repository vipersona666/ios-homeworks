//
//  Palette.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 05.04.2023.
//

import Foundation
import UIKit
struct Palette{
    

    static var appButtonBackgroundColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor(dynamicProvider: { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 104/255, green: 109/255, blue: 224/255, alpha: 1)
                } else {
                    return UIColor(red: 72/255, green: 52/255, blue: 212/255, alpha: 1)
                }
            })
        } else {
            return UIColor.systemBlue
        }
        
    }()
    
 
}
