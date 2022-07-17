//
//  MainCoordinator.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 08.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import UIKit


class MainCoordinator:NSObject,Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init (navigationController: UINavigationController) {
    self.navigationController = navigationController
    }
    
    
    func start() {
        navigationController.delegate = self
        let vc = MainDiscoveryVC.instantiate()
//        let vc = ViewController. instantiate( )
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)}
    
    func childShowMoreMovies(with movies:[Movie_VM]){
        let child = MovieSearchCoordinator.init(navigationController: navigationController)
        //movies
        child.data = movies as AnyObject
        child.parentCoordinator = self
        childCoordinators.append(child)
//        child.start()
    }
    
    func childShowMovieDetails(with selectedMovieID:Int){
        let child = MovieDetailsCoordinator.init(navigationController: navigationController)
        //movies
        child.data = selectedMovieID as AnyObject
        child.parentCoordinator = self
        childCoordinators.append(child)
//        child.start()
    }
    
    
    func childDidFinish( child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove (at: index)
                break}
            }
        }
    }


extension MainCoordinator : UINavigationControllerDelegate {
    
    func navigationController (_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool){
        guard let fromViewController = navigationController.transitionCoordinator?.viewController( forKey:.from) else{return}
        if navigationController.viewControllers.contains(fromViewController)
            {return}
        if let moviesSearchVC = fromViewController as? MoviesSearchVC{
            childDidFinish(child: moviesSearchVC.coordinator)}
    }
    
    
    
}
