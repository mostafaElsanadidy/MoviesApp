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
