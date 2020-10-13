//
//  MoviesSearchVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

class MoviesSearchVC: UIViewController {

    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collctionView: UICollectionView!
    
    var movies_Details:[Movie_VM] = []
     var api_Key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collctionView.dataSource = self
        collctionView.delegate = self
        
        searchBar.delegate = self
        navBarView.backBttn.isHidden = false
               navBarView.backBttn.addTarget(self, action: Selector(("popVCFromNav")) , for: .touchUpInside)
        navBarView.searchBttn.addTarget(self, action: Selector(("findMov")) , for: .touchUpInside)
        navBarView.searchBttn.isHidden = false
        collctionView.reloadData()
    
        api_Key = Constants.ProductionServer.api_key
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesSearchVC:UISearchBarDelegate{
    
    @objc func findMov(){
        navBarView.isHidden = true
        searchBar.isHidden = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        navBarView.isHidden = false
        searchBar.isHidden = true
        
        searchMovies(with: searchBar.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navBarView.isHidden = false
        searchBar.isHidden = true
    }
    
    func searchMovies(with seacrchText:String){
              self.loading()
               APIClient.searchMovies(query: seacrchText, api_key: api_Key, completionHandler: { [weak self]
                   movies_Data in
                   guard let strongSelf = self else{
                       return
                   }
                   
                guard let movies_Data = movies_Data else{
                 strongSelf.killLoading()
                    return
                }
                DispatchQueue.main.async{
                    
                    print(movies_Data)
                    strongSelf.killLoading()
                    var movies = [Movie_VM]()
                    for movie in movies_Data{
                        movies.append(Movie_VM(movieDetails: movie))
                    }
                    strongSelf.movies_Details = movies
                    strongSelf.collctionView.reloadData()
                   
                        }
               }, completionFaliure: {
                   error in
                   self.killLoading()
                   print(error!.localizedDescription)
                   self.showAlert(title: "ERROR!", message:
                   NSLocalizedString(error!.localizedDescription, comment: "this is my mssag"))
               })
    }
//    funciTunesURL(searchText: String)-> URL{
//    letescapedSearchText = searchText.addingPercentEncoding(
//    withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//    leturlString = String(format:
//    "https://itunes.apple.com/search?term=%@", escapedSearchText)
//    leturl = URL(string: urlString)
//    returnurl!
//    }
}
extension MoviesSearchVC:UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies_Details.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movImageCell", for: indexPath)
        if let cell = cell as? movImageCell{
            cell.movImage.DownloadImage(withUrl: movies_Details[indexPath.row].moviePosterUrlStr ?? "" )
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collctionView.cellForItem(at: indexPath),
            let cell2 = cell as? movImageCell{
            cell2.updateSelectedCell_ID(movies_Details[
                indexPath.row].id!)
        }
        
    }
}

extension MoviesSearchVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {


    let height:CGFloat = 200
    let paddingSpace:CGFloat = 10*2
          
          let availableWidth = collectionView.frame.size.width - paddingSpace
          let widthPerItem = availableWidth / 2
    
    return CGSize(width: widthPerItem,height: height)
  }



  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    
          return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
  }


  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
  }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
               return 20
    }
}
