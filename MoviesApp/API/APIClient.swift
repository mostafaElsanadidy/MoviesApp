//
//  ApiClient.swift
//  MadeInKuwait
//
//  Created by mostafa elsanadidy on 1/29/22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient {

    @discardableResult
       private static func performSwiftyRequest(route:APIRouter,_ completion:@escaping (JSON)->Void,_ failure:@escaping (Error?)->Void) -> DataRequest {
        
        return AF
            .request(route)
            .responseJSON(completionHandler: { (response) in
                   switch response.result {
                   case .success :
                    guard let _ = response.value
                        else {
                           failure(response.error)
                           return
                       }
                       print(response.result , route.urlRequest as Any)
                       let json = JSON(response.value as Any)
                       print(json)
                       
                       completion(json)
                      
                   case .failure( _):
                       failure(response.error)
                   }
               })
       }

    static func cancelAllRequests(completed : @escaping ()->() ) {
        AF.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
            completed()
        }
    }

    static func getTop_RatedMovies(api_key:String, completionHandler:@escaping ([Movie_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        performSwiftyRequest(route: .top_ratedMovies(apiKey: api_key), { (jsonData) in
            
            do{
            let json_Data = try JSON(jsonData)["results"].rawData()
                let movies = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
                completionHandler(movies)}
            catch{
                completionFaliure(error)
            }
         }) { (error) in
             completionFaliure(error)
         }
     }

    static func getPopularMovies(api_key:String, completionHandler:@escaping ([Movie_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
       performSwiftyRequest(route: .popularMovies(apiKey: api_key), { (jsonData) in
           
           do{
           let json_Data = try JSON(jsonData)["results"].rawData()
               let user = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
               completionHandler(user)}
           catch{
               completionFaliure(error)
           }
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    static func getUpcomingMovies(api_key:String, completionHandler:@escaping ([Movie_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
       performSwiftyRequest(route: .upcomingMovies(apiKey: api_key), { (jsonData) in
           
           do{
           let json_Data = try JSON(jsonData)["results"].rawData()
               let user = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
               completionHandler(user)}
           catch{
               completionFaliure(error)
           }
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    static func getPlayingNowMovies(api_key:String, completionHandler:@escaping ([Movie_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
       performSwiftyRequest(route: .now_playingMovies(apiKey: api_key), { (jsonData) in
           
           do{
           let json_Data = try JSON(jsonData)["results"].rawData()
               let user = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
               completionHandler(user)}
           catch{
               completionFaliure(error)
           }
        }) { (error) in
            completionFaliure(error)
        }
    }
   
    static func getMovieRecommendations(movieID:Int,
                                        api_key:String,
                                        completionHandler:@escaping ([Movie_M]?)->Void ,
                                        completionFaliure:@escaping (_ error:Error?)->Void){
          performSwiftyRequest(route: .getMovieRecommendations(movieID: movieID, apiKey: api_key), { (jsonData) in
              
              do{
              let json_Data = try JSON(jsonData)["results"].rawData()
                  let user = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
                  completionHandler(user)}
              catch{
                  completionFaliure(error)
              }
           }) { (error) in
               completionFaliure(error)
           }
       }
    
    static func getMovieCasts(movieID:Int,
                                     api_key:String,
                                     completionHandler:@escaping ([CastUser_M]?)->Void ,
                                     completionFaliure:@escaping (_ error:Error?)->Void){
       performSwiftyRequest(route: .getMovieCasts(movieID: movieID, apiKey: api_key), { (jsonData) in
           
           do{
           let json_Data = try JSON(jsonData)["cast"].rawData()
               let user = try JSONDecoder().decode(Array<CastUser_M>.self, from: json_Data)
               completionHandler(user)}
           catch{
               completionFaliure(error)
           }
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    static func getMovieReviews(movieID:Int,
                                     api_key:String,
                                     completionHandler:@escaping ([MovieReviews_M]?)->Void ,
                                     completionFaliure:@escaping (_ error:Error?)->Void){
       performSwiftyRequest(route: .getMovieReviews(movieID: movieID, apiKey: api_key), { (jsonData) in
           
           do{
           let json_Data = try JSON(jsonData)["results"].rawData()
               let movieReviews = try JSONDecoder().decode(Array<MovieReviews_M>.self, from: json_Data)
               completionHandler(movieReviews)}
           catch{
               completionFaliure(error)
           }
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    static func getMovieVideos(movieID:Int,
                                     api_key:String,
                                     completionHandler:@escaping ([MovieVideo_M]?)->Void ,
                                     completionFaliure:@escaping (_ error:Error?)->Void){
       performSwiftyRequest(route: .getMovieVideos(movieID: movieID, apiKey: api_key), { (jsonData) in
           
           do{
           let json_Data = try JSON(jsonData)["results"].rawData()
               let movieVideos = try JSONDecoder().decode(Array<MovieVideo_M>.self, from: json_Data)
               completionHandler(movieVideos)}
           catch{
               completionFaliure(error)
           }
        }) { (error) in
            completionFaliure(error)
        }
    }
    
    
    static func getMovieDetails(movieID:Int,api_key:String, completionHandler:@escaping (MovieDetails_M?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        performSwiftyRequest(route: .getMovieDetails(movieID: movieID, apiKey: api_key), { (jsonData) in
           
           do{
           let json_Data = try JSON(jsonData).rawData()
               let MovieDetails = try JSONDecoder().decode(MovieDetails_M.self, from: json_Data)
               completionHandler(MovieDetails)}
           catch{
               completionFaliure(error)
           }
        }) { (error) in
            completionFaliure(error)
        }
    }

static func searchMovies(query:String,api_key:String, completionHandler:@escaping ([Movie_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
   performSwiftyRequest(route: .searchMovies(query: query, apiKey: api_key), { (jsonData) in
       
       do{
       let json_Data = try JSON(jsonData)["results"].rawData()
           let movies = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
           completionHandler(movies)}
       catch{
           completionFaliure(error)
       }
    }) { (error) in
        completionFaliure(error)
    }
}

}
