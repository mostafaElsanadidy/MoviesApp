//
//  MovieDetailsVC_ViewModel.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 06.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation


final class MovieDetailsList_VM{
    
    var movieDetails:Observable<MovieDetails_VM?> = Observable(nil)
    var error:Observable<String?> = Observable(nil)

//    var productionCompanies:Observable<[ProductionCompany_VM]> = Observable([])
//
    var recommendationsMovies:Observable<[Movie_VM]> = Observable([])
    
    var movieVideos:Observable<[MovieVideos_VM]> = Observable([])
    
    var castUsers:Observable<[CastUser_VM]> = Observable([])

    var movieID:Observable<Int?> = Observable(nil)

    var api_Key = Constants.ProductionServer.api_key
    
    
   
}

extension MovieDetailsList_VM{
    
    func getMovieDetails(){
      //              self.loading()
        guard let movieID = movieID.value else { return }
//        guard let movieID = NetworkHelper.shared.getSelectedMovieID() else { return }
        APIClient.getMovieDetails(movieID: movieID,
                                    api_key: api_Key,
                                    completionHandler: { [weak self]
                         movieDetails in
                         guard let strongSelf = self else{
                             return
                         }
                         
                      guard let movie_Data = movieDetails else{
                          strongSelf.error.value = "no data"
                          return
                      }
                      //strongSelf.error.value = nil
                      strongSelf.movieDetails.value = MovieDetails_VM.init(movieDetails: movie_Data)
            
                     }, completionFaliure: {
                         error in
                         self.error.value = error.debugDescription
                     })
          }
      
      func getMovieRecommendations(){
            //        self.loading()
          guard let movieID = movieID.value else { return }
          APIClient.getMovieRecommendations(movieID: movieID,
                                    api_key: api_Key,
                                    completionHandler: { [weak self]
                         movieDetails in
                         guard let strongSelf = self else{
                             return
                         }
                         
                      guard let movieDetails = movieDetails else{
                          strongSelf.error.value = "no data"
                          return
                      }
              strongSelf.recommendationsMovies.value = movieDetails.compactMap{Movie_VM.init(movieDetails: $0)}
              
                     }, completionFaliure: {
                         error in
                         self.error.value = error.debugDescription
                     })
          }
     
      
      func getMovieVideos(){
             //          self.loading()
          guard let movieID = movieID.value else { return }
             APIClient.getMovieVideos(movieID: movieID,
                                       api_key: api_Key,
                                       completionHandler: { [weak self]
                            movieVideos in
                            guard let strongSelf = self else{
                                return
                            }
                            
                         guard let movieVideos = movieVideos else{
                             strongSelf.error.value = "no data"
                             return
                         }
                 
                 strongSelf.movieVideos.value = movieVideos.compactMap{MovieVideos_VM.init(movieVideos_M:$0)}
                 
                 
                        }, completionFaliure: {
                            error in
                            self.error.value = error.debugDescription
                        })
             }
     
      
      func getMovieCasts(){
              //            self.loading()
          guard let movieID = movieID.value else { return }
                APIClient.getMovieCasts(movieID: movieID,
                                          api_key: api_Key,
                                          completionHandler: { [weak self]
                               movieCasts in
                               guard let strongSelf = self else{
                                   return
                               }
                               
                            guard let movieCasts = movieCasts else{
                                strongSelf.error.value = "no data"
                                return
                            }
                    
                    strongSelf.castUsers.value = movieCasts.compactMap{CastUser_VM.init(castUser: $0)}
                    
                           }, completionFaliure: {
                               error in
                               self.error.value = error?.localizedDescription
                           })
                }
    
}
