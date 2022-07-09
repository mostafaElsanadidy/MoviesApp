//
//  MoviesSearchVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

class MoviesSearchVC: UIViewController ,Storyboarded{

    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collctionView: UICollectionView!
    
    weak var coordinator : MovieSearchCoordinator?
  //  var availableMovies:[Movie_VM] = []
    private var moviewSearchViewModel = MovieSearchViewModel()
    
  //  var fetchAvailableMovies:((_ movies:[Movie_VM])->Void)!
    
//    init(viewModel:MovieSearchViewModel,availableMovies:[Movie_VM]) {
//        self.moviewSearchViewModel = viewModel
//        self.moviewSearchViewModel.availableMovies = availableMovies
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func initialState(viewModel:MovieSearchViewModel) {
        self.moviewSearchViewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBinder()
        collctionView.dataSource = self
        collctionView.delegate = self
        
        searchBar.delegate = self
        navBarView.backBttn.isHidden = false
               navBarView.backBttn.addTarget(self, action: Selector(("popVCFromNav")) , for: .touchUpInside)
        navBarView.searchBttn.addTarget(self, action: Selector(("findMov")) , for: .touchUpInside)
        navBarView.searchBttn.isHidden = false
        
//        fetchAvailableMovies = {
//            [weak self] movies in
//            guard let strongSelf = self else{return}
//            strongSelf.loading()
//            strongSelf.moviewSearchViewModel.fetchAvailableMovies(with: movies)
//        }
        self.loading()
        moviewSearchViewModel.searchMovies()
       // collctionView.reloadData()
    }
    

    func setupBinder(){
        moviewSearchViewModel.movies.bind{
            [weak self] movies in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                strongSelf.killLoading()
                strongSelf.collctionView.reloadData()
            }
        }
    }
    
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        coordinator?.didFinishSearching()
//    }
    
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
        
        moviewSearchViewModel.searchMovies(with: searchBar.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navBarView.isHidden = false
        searchBar.isHidden = true
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
        return moviewSearchViewModel.movies.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movImageCell", for: indexPath)
        if let cell = cell as? movImageCell{
            let movieDetails = moviewSearchViewModel.movies.value[indexPath.row]
            cell.movImage.DownloadImage(withUrl: movieDetails.moviePosterUrlStr ?? "" )
                   cell.updateSelectedCell_ID = {
                       selectedID in
                       self.coordinator?.childShowMovieDetails(with: selectedID)
                   }
               }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collctionView.cellForItem(at: indexPath),
            let cell2 = cell as? movImageCell{
            let movieDetails = moviewSearchViewModel.movies.value[indexPath.row]
            cell2.updateSelectedCell_ID(movieDetails.id!)
        }
        
    }
}

extension MoviesSearchVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    
    var numberOfItemsInRow,edgeInset:CGFloat
    
        
         edgeInset = 10
         numberOfItemsInRow = 2
   
    
    let paddingSpace = edgeInset*(numberOfItemsInRow+1)
    let availableWidth = collectionView.frame.size.width-paddingSpace
    let widthPerItem = availableWidth/numberOfItemsInRow
   
    return CGSize(width: widthPerItem,height: 180)
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
