//
//  YoutubeVideoCoordinator.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 09.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import UIKit

class YoutubeVideoCoordinator:Coordinator {
    
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
        let vc = VideoYoutubeLinkVC.instantiate()
        //movies
        vc.coordinator = self
        let viewModel = YoutubeVideoViewModel()
       // guard let movieNameIDTuple:(movieName:String,movieID:Int) = data as? (movieName:String,movieID:Int) else{ return }
        viewModel.movieVideo.value = data as? MovieVideos_VM
        vc.initialState(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
