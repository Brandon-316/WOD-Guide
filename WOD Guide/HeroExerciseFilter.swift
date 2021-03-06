//
//  HeroExerciseFilter.swift
//  WOD Guide
//
//  Created by Brandon Mahoney on 2/3/17.
//  Copyright © 2017 William Mahoney. All rights reserved.
//

import Foundation


import UIKit

protocol UserHeaderTableViewCellDelegate {
    func didSelectUserHeaderTableViewCell(Selected: Bool, UserHeader: UserHeaderTableViewCell)
}

class UserHeaderTableViewCell: UITableViewCell {
    var delegate : UserHeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func selectedHeader(sender: AnyObject) {
        delegate?.didSelectUserHeaderTableViewCell(Selected: true, UserHeader: self)
        
    }
    
}
