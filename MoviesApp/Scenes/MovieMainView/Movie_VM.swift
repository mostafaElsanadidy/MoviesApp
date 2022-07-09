//
//  Movie_VM.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import Foundation

class Movie_VM{
   
    private var movieDetails:Movie_M?
    
    public var title:String?
    public var movieBackgroundUrlStr:String?
    public var moviePosterUrlStr:String?
    public var id:Int?
    
    init(movieDetails:Movie_M) {
        
        configureSubViews(with: movieDetails)
    }
    
    func configureSubViews(with movieDetails:Movie_M){
        
        title = movieDetails.title!
        moviePosterUrlStr = "http://image.tmdb.org/t/p/w185\(movieDetails.poster_path ?? "")"
       
        movieBackgroundUrlStr = "http://image.tmdb.org/t/p/original\(movieDetails.backdrop_path ?? "")"
        id = movieDetails.id!
    }
}

class MovieList_VM{
    
  //  var movies:Observable<[Movie_VM]> = Observable([])
    
    var api_Key = Constants.ProductionServer.api_key
    var topRatedMovies:Observable<[Movie_VM]> = Observable([])
    
    var popularMovies:Observable<[Movie_VM]> = Observable([])
    var comingSoonMovies:Observable<[Movie_VM]> = Observable([])
    var NowPlayingMoviea:Observable<[Movie_VM]> = Observable([])
    
    var selectedMovies:Observable<[Movie_VM]> = Observable([])
    var error:Observable<String?> = Observable(nil)
    
    func getTop_RatedMovies(){
            //  self.loading()
               APIClient.getTop_RatedMovies(api_key: api_Key, completionHandler: { [weak self]
                   movies_Data in
                   guard let strongSelf = self else{
                       return
                   }
                   
                guard let movies_Data = movies_Data else{
                    strongSelf.error.value = "no data"
                    return
                }
                   strongSelf.topRatedMovies.value = movies_Data.compactMap{Movie_VM.init(movieDetails: $0)}
               
               }, completionFaliure: {
                   error in
                   self.error.value = error?.localizedDescription
               })
    }

    
    func getPopularMovies(){
//              self.loading()
               APIClient.getPopularMovies(api_key: api_Key, completionHandler: { [weak self]
                   movies_Data in
                   guard let strongSelf = self else{
                       return
                   }
                   
                guard let movies_Data = movies_Data else{
                    strongSelf.error.value = "no data"
                    return
                }
                   strongSelf.popularMovies.value = movies_Data.compactMap{Movie_VM.init(movieDetails: $0)}
               }, completionFaliure: {
                   error in
                   self.error.value = error?.localizedDescription
               })
    }
    
    
    func getUpComingMovies(){
//                  self.loading()
                   APIClient.getUpcomingMovies(api_key: api_Key, completionHandler: { [weak self]
                       movies_Data in
                       guard let strongSelf = self else{
                           return
                       }
                       
                    guard let movies_Data = movies_Data else{
                        strongSelf.error.value = "no data"
                        return
                    }
                       strongSelf.comingSoonMovies.value = movies_Data.compactMap{
                           Movie_VM.init(movieDetails:$0)
                       }
                       
                   }, completionFaliure: {
                       error in
                       self.error.value = error?.localizedDescription
                   })
        }
   
    func getNowPlayingMovies(){
//                  self.loading()
                   APIClient.getPlayingNowMovies(api_key: api_Key, completionHandler: { [weak self]
                       movies_Data in
                       guard let strongSelf = self else{
                           return
                       }
                       
                    guard let movies_Data = movies_Data else{
                        strongSelf.error.value = "no data"
                        return
                    }
                       strongSelf.NowPlayingMoviea.value = movies_Data.compactMap{
                           Movie_VM.init(movieDetails: $0)
                       }
                   }, completionFaliure: {
                       error in
                       self.error.value = error?.localizedDescription
                   })
        }
  
}

class Observable<T>{
    var value: T{
        didSet{
            listener.forEach{
                $0(value)
            }
        }
    }
       private var listener:[((T)->Void)] = []
    init(_ value:T) {
        self.value = value
    }
    
    //we create a function that allows other View controller to be able to listen to or subscribe to any changes in data
    //parameter (listener: @escaping (T?)->Void) in func bind : is like as sending data using closure .. the caller of listener:(T?)->Void is the object which send data/values (in shape of notification and put it in parameter T in listener:(T?)->Void) and the code of closure put in the object(view controller) which listen to this notification
    func bind(_ listener:@escaping (T)->Void) {
        listener(value)
        self.listener.append(listener)
    }
    
            
        
}
