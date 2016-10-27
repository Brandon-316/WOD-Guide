//
//  HeroWODDetailView.swift
//  WOD Guide
//
//  Created by William Mahoney on 6/27/16.
//  Copyright © 2016 William Mahoney. All rights reserved.
//

import Foundation
import UIKit

class HeroWODDetailView: ViewController {
    
    
    @IBAction func backButton(sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var heroImage: UIImageView!
        var heroWODImage = ""
    
    @IBOutlet weak var wodName: UILabel!
        var nameText = ""
    
    @IBOutlet weak var wodExercises: UILabel!
        var exerciseText = ""
    
    @IBOutlet weak var wodDescription: UILabel!
        var descriptionText = ""
    
    
    @IBOutlet weak var wodAbout: UILabel!
        var aboutText = ""
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        if UIScreen.mainScreen().bounds.size.height == 480{
//            heroImage.frame.size.height = 100
//        }else{
//            heroImage.frame.size.height = 250
//        }
//            heroImage.bounds.size.height = 100
//        }else{
//            heroImage.bounds.size.height = 250
//    }
    
        
        heroImage.image = UIImage(named: heroWODImage)
        wodName.text = nameText
        wodExercises.text = exerciseText
        wodDescription.text = descriptionText
        wodAbout.text = aboutText
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    
    
}
