//
//  MovieDetailsVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/10/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {

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
    
    var movie_ID:Int!
    var movieDetails_VM:MovieDetails_VM!
    var api_Key = ""
    var recommendationsMovies:[Movie_VM] = []
    var movieVideos:[MovieVideos_VM] = []
    var castUsers:[CastUser_VM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(movie_ID!)
        
        api_Key = Constants.ProductionServer.api_key
        getMovieDetails(movieID: movie_ID!)
        getMovieRecommendations(movieID: movie_ID!)
        getMovieVideos(movieID: movie_ID!)
        getMovieCasts(movieID: movie_ID!)
        
        navBarView.backBttn.isHidden = false
        navBarView.backBttn.addTarget(self, action: Selector(("popVCFromNav")) , for: .touchUpInside)
//        prodCompCollctionView.dataSource = self
//        prodCompCollctionView.delegate = self
        print("8 *******************************************************")
    }
    
    override func viewWillAppear(_ animated: Bool) {
                 super.viewWillAppear(animated)
                 
                 navigationController?.setNavigationBarHidden(true, animated: animated)
           
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
        
        if let reviewsVC = storyboard?.instantiateViewController(identifier: "MovieReviewsVC") as? MovieReviewsVC{
            reviewsVC.movieID = self.movie_ID!
            reviewsVC.movieName = self.movieDetails_VM.title!
            pushViewController(VC: reviewsVC)
        }
    }
    
}

extension MovieDetailsVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(collectionView.tag)
        
      // var movies = [Movie_M]()
        
        switch collectionView.tag {
        case 201:
            return castUsers.count
        case 203:
            return movieVideos.count
        default:
            return recommendationsMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        guard collectionView.tag == 202 else{
            var imgUrlStr = ""
            var name = ""
            
            switch collectionView.tag {
            case 201:
                
                imgUrlStr = castUsers[indexPath.row].profile_path ?? ""
                name = castUsers[indexPath.row].name!
            default:
                imgUrlStr = movieVideos[indexPath.row].videoImagUrlStr ?? ""
                name = movieVideos[indexPath.row].videoName!
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
            cell.movImage.DownloadImage(withUrl: recommendationsMovies[indexPath.row].moviePosterUrlStr!)
            cell.updateSelectedCell_ID = {
                selectedID in
                if let MovieDetailsVC = self.storyboard!.instantiateViewController(withIdentifier :"MovieDetailsVC") as? MovieDetailsVC{
                    MovieDetailsVC.movie_ID = selectedID
                    self.pushViewController(VC: MovieDetailsVC)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? movImageCell{
            cell.updateSelectedCell_ID(recommendationsMovies[indexPath.row].id!)
        }
        else if collectionView.tag == 203{
            if let VideoYoutubeLinkVC = storyboard?.instantiateViewController(identifier: "VideoYoutubeLinkVC") as? VideoYoutubeLinkVC{
                VideoYoutubeLinkVC.video_VM = movieVideos[indexPath.row]
                pushViewController(VC: VideoYoutubeLinkVC)
            }
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
    
    func getMovieDetails(movieID:Int){
                    self.loading()
          APIClient.getMovieDetails(movieID: movieID,
                                    api_key: api_Key,
                                    completionHandler: { [weak self]
                         movieDetails in
                         guard let strongSelf = self else{
                             return
                         }
                         
                      guard let movie_Data = movieDetails else{
                       strongSelf.killLoading()
                          return
                      }
                      DispatchQueue.main.async{
                          strongSelf.killLoading()
      //                    print(movies_Data)
                          strongSelf.movieDetails_VM = MovieDetails_VM.init(movieDetails: movie_Data)
                          strongSelf.configureSubViews(with: strongSelf.movieDetails_VM)
                              }
                     }, completionFaliure: {
                         error in
                         self.killLoading()
                         print(error!.localizedDescription)
                         self.showAlert(title: "ERROR!", message:
                         NSLocalizedString(error!.localizedDescription, comment: "this is my mssag"))
                     })
          }
      
      func getMovieRecommendations(movieID:Int){
                    self.loading()
          APIClient.getMovieRecommendations(movieID: movieID,
                                    api_key: api_Key,
                                    completionHandler: { [weak self]
                         movieDetails in
                         guard let strongSelf = self else{
                             return
                         }
                         
                      guard let movie_Data = movieDetails else{
                       strongSelf.killLoading()
                          return
                      }
                      DispatchQueue.main.async{
                          strongSelf.killLoading()
      //                    print(movies_Data)
                          for movie in movie_Data{
                              strongSelf.recommendationsMovies.append( Movie_VM(movieDetails: movie))
                          }
                          strongSelf.recommendCollctionView.reloadData()
                              }
                     }, completionFaliure: {
                         error in
                         self.killLoading()
                         print(error!.localizedDescription)
                         self.showAlert(title: "ERROR!", message:
                         NSLocalizedString(error!.localizedDescription, comment: "this is my mssag"))
                     })
          }
     
      
      func getMovieVideos(movieID:Int){
                       self.loading()
             APIClient.getMovieVideos(movieID: movieID,
                                       api_key: api_Key,
                                       completionHandler: { [weak self]
                            movieVideos in
                            guard let strongSelf = self else{
                                return
                            }
                            
                         guard let movieVideos = movieVideos else{
                          strongSelf.killLoading()
                             return
                         }
                         DispatchQueue.main.async{
                             strongSelf.killLoading()
         //                    print(movies_Data)
                             for movieVideo in movieVideos{
                              strongSelf.movieVideos.append( MovieVideos_VM(movieVideos_M: movieVideo))
                             }
                             strongSelf.movVideosCollctionView.reloadData()
                                 }
                        }, completionFaliure: {
                            error in
                            self.killLoading()
                            print(error!.localizedDescription)
                            self.showAlert(title: "ERROR!", message:
                            NSLocalizedString(error!.localizedDescription, comment: "this is my mssag"))
                        })
             }
     
      
      func getMovieCasts(movieID:Int){
                          self.loading()
                APIClient.getMovieCasts(movieID: movieID,
                                          api_key: api_Key,
                                          completionHandler: { [weak self]
                               movieCasts in
                               guard let strongSelf = self else{
                                   return
                               }
                               
                            guard let movieCasts = movieCasts else{
                             strongSelf.killLoading()
                                return
                            }
                            DispatchQueue.main.async{
                                strongSelf.killLoading()
            //                    print(movies_Data)
                                for movieCast in movieCasts{
                                  strongSelf.castUsers.append( CastUser_VM(castUser: movieCast))
                                }
                                strongSelf.prodCompCollctionView.reloadData()
                                    }
                           }, completionFaliure: {
                               error in
                               self.killLoading()
                               print(error!.localizedDescription)
                               self.showAlert(title: "ERROR!", message:
                               NSLocalizedString(error!.localizedDescription, comment: "this is my mssag"))
                           })
                }
    
}


