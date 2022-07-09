//
//  MovieReviewCell.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

class MovieReviewCell: UITableViewCell {

    @IBOutlet weak var reviewAuthor: UILabel!
    @IBOutlet weak var reviewContent: UILabel!
    @IBOutlet weak var reviewUrlBttn: UIButton!
    @IBOutlet weak var numOfReviewLabel: UILabel!
    var goToReviewHtmlPage : ((_ urlStr:String) -> ())!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func showReviewContent(_ sender: UIButton) {
        goToReviewHtmlPage(sender.titleLabel!.text!)
    }
    
}
