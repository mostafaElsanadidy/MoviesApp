//
//  Coordinator.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 07.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator:AnyObject {
    var childCoordinators : [Coordinator] {get set}
    var navigationController : UINavigationController {get set}
    func start()
}




