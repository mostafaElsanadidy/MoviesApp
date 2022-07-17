//
//  MovieDetailsVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 04.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MovieDetailsVC: UIViewController, Storyboarded {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var release_dateLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var rating_reviewLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var prodCompCollctionView: UICollectionView!
    @IBOutlet weak var recommendCollctionView: UICollectionView!
    
    @IBOutlet weak var movVideosCollctionView: UICollectionView!
    @IBOutlet weak var navBarView: NavBarView!
    
    @IBOutlet weak var activityView: NVActivityIndicatorView!
    private var movieDetailsViewModel = MovieDetailsList_VM()
    
     weak var coordinator : MovieDetailsCoordinator?
    func initialState(viewModel:MovieDetailsList_VM) {
        self.movieDetailsViewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBinder()
        
       
        view.bringSubviewToFront(activityView)
//        activityView.startAnimating()
       
        DispatchQueue.main.asyncAfter(deadline: .now()+0.001, execute: {
//            self.view.viewWithTag(200)?.isHidden = true
            self.loading()
            self.movieDetailsViewModel.viewDidLoad()
        })
//        self.loading()
        
        view.viewWithTag(200)?.isHidden = true
        navBarView.backBttn.isHidden = false
        navBarView.backBttn.addTarget(self, action: Selector(("popVCFromNav")) , for: .touchUpInside)
        print("8 *******************************************************")
    }
    
    override func viewWillAppear(_ animated: Bool) {
                 super.viewWillAppear(animated)
                 
                 navigationController?.setNavigationBarHidden(true, animated: animated)
           
             }
    
    func setupBinder(){
        
        movieDetailsViewModel.movieDetails.bind{
            [weak self] movieDetails in
            guard let strongSelf = self, let movieDetails = movieDetails else {return}
                      DispatchQueue.main.async{
                          strongSelf.view.viewWithTag(200)?.isHidden = false
                          strongSelf.killLoading()
                          strongSelf.configureSubViews(with: movieDetails)
                              }
        }
        
        movieDetailsViewModel.error.bind{
            [weak self] error in
            guard let strongSelf = self, let error = error else {return}
                                     strongSelf.killLoading()
                                     print(error)
                                     strongSelf.showAlert(title: "ERROR!", message:
                                     NSLocalizedString(error, comment: "this is my mssag"))
        }
        
        movieDetailsViewModel.recommendationsMovies.bind{
            [weak self] movies in
            
            guard let strongSelf = self else {return}
                    DispatchQueue.main.async{
                        strongSelf.killLoading()
                        strongSelf.recommendCollctionView.reloadData()
                            }
        }
        
        movieDetailsViewModel.movieVideos.bind{
            [weak self] videos in
            guard let strongSelf = self else{ return }
            DispatchQueue.main.async{
                strongSelf.killLoading()
                strongSelf.movVideosCollctionView.reloadData()
                    }
        }
        
        movieDetailsViewModel.castUsers.bind{
            [weak self] castUsers in
            guard let strongSelf = self else{ return }
            DispatchQueue.main.async{
                strongSelf.killLoading()
                strongSelf.prodCompCollctionView.reloadData()
                    }
        }
    }
    
    func configureSubViews(with movieDetails:MovieDetails_VM){
        
        movieNameLabel.text = movieDetails.title!
        movieImageView.DownloadImage(withUrl: movieDetails.moviePosterUrlStr!)
        movieGenresLabel.text = movieDetails.movieGenre!
        backgroundImageView.DownloadImage(withUrl: movieDetails.movieBackgroundUrlStr!)
        overviewLabel.text = movieDetails.movieOverview!
        rating_reviewLabel.text = movieDetails.movieRating_Review!
        
        runtimeLabel.text = movieDetails.movieRuntime!
        release_dateLabel.text = movieDetails.movieReleaseDate!
    }
    
    
    @IBAction func readMore(_ sender: UIButton) {
        if sender.currentTitle == "Read more"{
            overviewLabel.numberOfLines = 0
            sender.setTitle("Read less", for: .normal)
        }else{
            overviewLabel.numberOfLines = 2
            sender.setTitle("Read more", for: .normal)
        }
    }
    
    @IBAction func watchReviews(_ sender: UIButton) {
        
        self.coordinator?.childShowMovieReviews(with: (movieName: self.movieDetailsViewModel.movieDetails.value?.title,
                                                       movieID: self.movieDetailsViewModel.movieID.value))
    }
    
}

extension MovieDetailsVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(collectionView.tag)
        
      // var movies = [Movie_M]()
        
        switch collectionView.tag {
        case 201:
            return movieDetailsViewModel.castUsers.value.count
        case 203:
            return movieDetailsViewModel.movieVideos.value.count
        default:
            return movieDetailsViewModel.recommendationsMovies.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        guard collectionView.tag == 202 else{
            var imgUrlStr = ""
            var name = ""
            
            switch collectionView.tag {
            case 201:
                
                let castUser = movieDetailsViewModel.castUsers.value[indexPath.row]
                imgUrlStr = castUser.profile_path ?? ""
                name = castUser.name ?? ""
            default:
                let movieVideo = movieDetailsViewModel.movieVideos.value[indexPath.row]
                imgUrlStr = movieVideo.videoImagUrlStr ?? ""
                name = movieVideo.videoName ?? ""
            }
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastDetailsCell", for: indexPath)
            if let cell = cell as? CastDetailsCell{
                cell.castImage.DownloadImage(withUrl: imgUrlStr)
                cell.nameLabel.text = name
            }
              return cell
        }
        
         cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovImageCell", for: indexPath)
        
        if let cell = cell as? movImageCell{
            
            cell.movImage.DownloadImage(withUrl: movieDetailsViewModel.recommendationsMovies.value[indexPath.row].moviePosterUrlStr!)
            cell.updateSelectedCell_ID = {
                selectedID in
                self.coordinator?.data = selectedID  as AnyObject
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? movImageCell{
            cell.updateSelectedCell_ID(movieDetailsViewModel.recommendationsMovies.value[indexPath.row].id!)
        }
        else if collectionView.tag == 203{
            self.coordinator?.childShowYoutubeVideo(with: movieDetailsViewModel.movieVideos.value[indexPath.row])
        }
    }
    
}

extension MovieDetailsVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    switch collectionView.tag {
           case 201:
               return CGSize(width: 80 , height: 95)
            case 203:
                return CGSize(width: 100 , height: 140)
           default:
               return CGSize(width: 145 , height: 200)
           }

  }



  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    
          return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
  }


  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
  }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
               return 10
    }
}

extension MovieDetailsVC{
    
  
    
}


