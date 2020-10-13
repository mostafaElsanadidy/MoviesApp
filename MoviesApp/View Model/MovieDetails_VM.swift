//
//  MovieDetails_VM.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import Foundation
import UIKit

class MovieDetails_VM{
   
    private var movieDetails:MovieDetails_M?
    
    public var title:String?
    public var movieBackgroundUrlStr:String?
    public var movieImage:UIImage?
    public var movieGenre:String?
    public var moviePosterUrlStr:String?
    public var movieOverview:String?
    public var movieRating_Review:String?
    public var movieRuntime:String?
    public var movieReleaseDate:String?
    public var production_companies:[ProductionCompany_VM]?
    
    
    init(movieDetails:MovieDetails_M) {
        
        configureSubViews(with: movieDetails)
    }
    
    func configureSubViews(with movieDetails:MovieDetails_M){
        
        title = movieDetails.title ?? ""
        moviePosterUrlStr = "http://image.tmdb.org/t/p/original\(movieDetails.poster_path!)"
        var genres:[String] = []
        for genre in movieDetails.genres!{
            genres.append(genre.name!)
        }
        movieGenre = genres.map { String($0) }.joined(separator: ",")
        movieBackgroundUrlStr = "http://image.tmdb.org/t/p/original\(movieDetails.backdrop_path ?? "")"
        movieOverview = movieDetails.overview
        movieRating_Review = String(movieDetails.vote_average!)
        let hours = String(movieDetails.runtime!/60)
        let minutes = String(movieDetails.runtime!%60)
        movieRuntime = "\(hours) hours, \(minutes) minutes"
        movieReleaseDate = movieDetails.release_date!
        production_companies = []
        for company in movieDetails.production_companies{
            production_companies?.append( ProductionCompany_VM.init(productionCompany: company))
        }
    }
}
