//
//  showAllCell.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/10/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

class showAllCell: UITableViewCell {

    @IBOutlet weak var arrowBttn: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    var cellTitle = ""
//
    var goToMovsPages : ((_ cellTitle:String) -> ())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showAllMovs(_ sender: UIButton) {
        goToMovsPages(label1.text!)
    }
    

}
