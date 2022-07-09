//
//  MovieReviews_VM.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import Foundation

class MovieReviews_VM{
   
    private var MovieReviews_M:MovieReviews_M?
    
    public var author:String!
    public var content:String!
    public var id:String!
    public var url:String!
    
    
    init(movieReviews_M:MovieReviews_M) {
        
        configureSubViews(with: movieReviews_M)
    }
    
    func configureSubViews(with movieReviews:MovieReviews_M){
        
        author = movieReviews.author!
        content = movieReviews.content!
        id = movieReviews.id!
        url = movieReviews.url!
        
    }
}


class MovieReviewsList_VM{
    
    var movieReviews:Observable<[MovieReviews_VM]> = Observable([])
    
    var movieID:Observable<Int?> = Observable(nil)
    var movieName:Observable<String?> = Observable(nil)
    var error:Observable<String?> = Observable(nil)
    var api_Key = Constants.ProductionServer.api_key
    
    func updateMovieInfo(movieName:String,movieID:Int){
        self.movieName.value = movieName
        self.movieID.value = movieID
    }
    
    func getMovieReviews(){
            //          self.loading()
        guard let movieID = movieID.value else { return }
            APIClient.getMovieReviews(movieID: movieID,
                                      api_key: api_Key,
                                      completionHandler: { [weak self]
                           movieReviews in
                           guard let strongSelf = self else{
                               return
                           }
                           
                        guard let movieReviews = movieReviews else{
                     //    strongSelf.killLoading()
                            strongSelf.error.value = "no data"
                            return
                        }
                        strongSelf.movieReviews.value = movieReviews.compactMap{
                            MovieReviews_VM.init(movieReviews_M: $0)
                        }
                       }, completionFaliure: {
                           error in
                           self.error.value = error?.localizedDescription
                       })
            }
    
}
