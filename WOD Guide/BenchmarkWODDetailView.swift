//
//  BenchmarkWODDetailView.swift
//  WOD Guide
//
//  Created by William Mahoney on 6/27/16.
//  Copyright © 2016 William Mahoney. All rights reserved.
//

import Foundation
import UIKit

class BenchmarkWODDetailView: ViewController {
    

    @IBAction func backButton(sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var wodName: UILabel!
    var nameText = ""
    
    
    @IBOutlet weak var wodExercises: UILabel!
    var exerciseText = ""
    
    
    @IBOutlet weak var wodDescription: UILabel!
    var descriptionText = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wodName.text = nameText
        wodExercises.text = exerciseText
        wodDescription.text = descriptionText
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    
}
