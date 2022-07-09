//
//  MovieReviewsCoordinator.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 09.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import UIKit

class MovieReviewsCoordinator:Coordinator{
   
    weak var parentCoordinator : MovieDetailsCoordinator?
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
        let vc = MovieReviewsVC.instantiate()
        //movies
        vc.coordinator = self
        let viewModel = MovieReviewsList_VM()
        guard let movieNameIDTuple:(movieName:String,movieID:Int) = data as? (movieName:String,movieID:Int) else{ return }
        viewModel.updateMovieInfo(movieName: movieNameIDTuple.movieName,
                                  movieID: movieNameIDTuple.movieID)
        vc.initialState(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func childShowReviewHtmlPage(with contentUrlStr:String){
        let child = ReviewHtmlPageCoordinator.init(navigationController: navigationController)
        //movies
        child.data = contentUrlStr as AnyObject
        child.parentCoordinator = self
        childCoordinators.append(child)
//        child.start()
    }
}
