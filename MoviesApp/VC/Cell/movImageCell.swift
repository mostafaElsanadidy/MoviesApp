//
//  movImageCell.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/10/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

class movImageCell: UICollectionViewCell {
    
    @IBOutlet weak var movImage: UIImageViewX!
    
    var updateSelectedCell_ID : ((_ selectedID:Int) -> ())!
}
