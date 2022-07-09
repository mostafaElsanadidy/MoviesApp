//
//  MovieSearchCoordinator.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 08.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationPerformActionDelegate {
    func didPerformAction(with data:AnyObject)
}

class MovieSearchCoordinator:Coordinator{
   
    weak var parentCoordinator : MainCoordinator?
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
        let vc = MoviesSearchVC.instantiate()
        //movies
        vc.coordinator = self
        let viewModel = MovieSearchViewModel()
        viewModel.availableMovies = data as! [Movie_VM]
        vc.initialState(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func childShowMovieDetails(with selectedMovieID:Int){
        let child = MovieDetailsCoordinator.init(navigationController: navigationController)
        //movies
        child.data = selectedMovieID as AnyObject
        child.parentCoordinator = self
        childCoordinators.append(child)
//        child.start()
    }
    
//    func showMoreMovies(with movies:[Movie_VM]){
//        self.data = movies as AnyObject
//    }
    
//    func didFinishSearching() {
//        parentCoordinator?.childDidFinish(child: self)
//    }
}
