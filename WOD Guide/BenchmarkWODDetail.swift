//
//  BenchmarkWODDetail.swift
//  WOD Guide
//
//  Created by William Mahoney on 12/7/15.
//  Copyright © 2015 William Mahoney. All rights reserved.
//

import Foundation
import UIKit



struct WOD {
    
    var name: String?
    var exercise: String?
    var description: String?
    var typeOfGirl: String?
    
    
    init(dictionary: [String: String]) {
        
        name = dictionary["name"]
        exercise = dictionary["exercises"]
        description = dictionary["description"]
        typeOfGirl = dictionary["typeOfGirl"]
        
        
    }
    
}






