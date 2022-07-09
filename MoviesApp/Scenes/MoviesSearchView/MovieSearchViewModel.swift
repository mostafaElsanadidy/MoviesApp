//
//  MovieSearchViewModel.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 07.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation

final class MovieSearchViewModel{
    
    var movies:Observable<[Movie_VM]> = Observable([])
     var api_Key = Constants.ProductionServer.api_key
    var error:Observable<String?> = Observable(nil)

    var availableMovies:[Movie_VM] = []
    
    func searchMovies(with seacrchText:String = ""){
//              self.loading()
        
        guard !seacrchText.isEmpty else {
            self.movies.value = availableMovies
            return
        }
               APIClient.searchMovies(query: seacrchText, api_key: api_Key, completionHandler: { [weak self]
                   movies_Data in
                   guard let strongSelf = self else{
                       return
                   }
                   
                guard let movies_Data = movies_Data else{
                    strongSelf.error.value = "no data"
                    return
                }
                   
                   strongSelf.movies.value = movies_Data.compactMap{Movie_VM.init(movieDetails: $0)}
               
               }, completionFaliure: {
                   error in
                   self.error.value = error?.localizedDescription
               })
    }
    
}
