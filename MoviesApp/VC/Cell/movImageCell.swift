//
//  movImageCell.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 04.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import UIKit

class movImageCell: UICollectionViewCell {
    
    @IBOutlet weak var movImage: UIImageViewX!
    
    var updateSelectedCell_ID : ((_ selectedID:Int) -> ())!
}
