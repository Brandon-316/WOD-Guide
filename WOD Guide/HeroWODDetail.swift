//
//  HeroWODDetail.swift
//  WOD Guide
//
//  Created by William Mahoney on 6/27/16.
//  Copyright © 2016 William Mahoney. All rights reserved.
//

import Foundation
import UIKit

struct HeroWOD {
    
//    var image: UIImage?
    var image: String?
    var name: String?
    var exercise: String?
    var description: String?
    var about: String?
    
    init(dictionary: [String: String]) {
        
        image = dictionary["image"]
        name = dictionary["name"]
        exercise = dictionary["exercises"]
        description = dictionary["description"]
        about = dictionary["about"]
        
        
        
    }
    
}
