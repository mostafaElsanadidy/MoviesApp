//
//  MovieDetailsCoordinator.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 09.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsCoordinator:Coordinator{
   
    weak var parentCoordinator : Coordinator?
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
        let vc = MovieDetailsVC.instantiate()
        //movies
        vc.coordinator = self
        let viewModel = MovieDetailsList_VM()
        viewModel.movieID.value = data as? Int
        vc.initialState(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
//    
//    func childShowMovieDetails(with selectedMovieID:Int){
//        let child = MovieSearchCoordinator.init(navigationController: navigationController)
//        //movies
//        child.data = movies as AnyObject
//        child.parentCoordinator = self
//        childCoordinators.append(child)
////        child.start()
//    }
    
//    func showMoreMovies(with movies:[Movie_VM]){
//        self.data = movies as AnyObject
//    }
    
//    func didFinishSearching() {
//        parentCoordinator?.childDidFinish(child: self)
//    }
}
