//
//  Extentions.swift
//  Blog App
//
//  Created by Alexander on 31.01.2024.
//

import Foundation
import UIKit

extension UIView{
    var with: CGFloat{
        frame.size.width
    }
    
    var height: CGFloat{
        frame.size.height
    }
    
    var left: CGFloat{
        frame.origin.x
    }
    
    var right: CGFloat{
        left + with
    }
    
    var top: CGFloat{
        frame.origin.y
    }
    
    var bottom: CGFloat{
        top + height
    }
}
