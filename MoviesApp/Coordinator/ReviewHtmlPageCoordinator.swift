//
//  File.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 09.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import UIKit

class ReviewHtmlPageCoordinator:Coordinator{
   
    weak var parentCoordinator : MovieReviewsCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var data:AnyObject?{
        didSet{
            start()
        }
    }
    
    init (navigationController: UINavigationController) {
    self.navigationController = navigationController
    }
    
    
    func start(){
        let vc = ReviewHtmlPageVC.instantiate()
        //movies
        vc.coordinator = self
        let viewModel = ReviewHtmlPageViewModel()
        viewModel.contentUrlStr.value = data as? String
        vc.initialState(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
//    func childShowMovieDetails(with selectedMovieID:Int){
//        let child = MovieDetailsCoordinator.init(navigationController: navigationController)
//        //movies
//        child.data = selectedMovieID as AnyObject
//        child.parentCoordinator = self
//        childCoordinators.append(child)
////        child.start()
//    }
}
