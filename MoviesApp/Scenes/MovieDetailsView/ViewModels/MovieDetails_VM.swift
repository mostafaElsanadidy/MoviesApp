//
//  MovieDetails_VM.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 06.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
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
        moviePosterUrlStr = ""
        if let poster_path = movieDetails.poster_path {
            moviePosterUrlStr = "http://image.tmdb.org/t/p/original\(poster_path)"
        }
        
        var movieDetailsGenres:[String] = []
        if let genres = movieDetails.genres{
        for genre in genres{
            movieDetailsGenres.append(genre.name ?? "")
        }}
        movieGenre = movieDetailsGenres.filter{ $0 != ""
          }.map{String($0)}.joined(separator: ",")
        movieBackgroundUrlStr = ""
        if let backdrop_path = movieDetails.backdrop_path {
            movieBackgroundUrlStr = "http://image.tmdb.org/t/p/original\(backdrop_path)"
        }
        movieOverview = movieDetails.overview
        if let vote_average = movieDetails.vote_average {
            movieRating_Review = String(vote_average)
        }
        if let runtime = movieDetails.runtime {
            let hours = String(runtime/60)
            let minutes = String(runtime%60)
            movieRuntime = "\(hours) hours, \(minutes) minutes"
        }
        if let release_date = movieDetails.release_date {
            movieReleaseDate = release_date
        }
        production_companies = []
        production_companies = movieDetails.production_companies.map{ProductionCompany_VM(productionCompany: $0)}
//        for company in movieDetails.production_companies{
//            production_companies?.append( ProductionCompany_VM.init(productionCompany: company))
//        }
    }
}

