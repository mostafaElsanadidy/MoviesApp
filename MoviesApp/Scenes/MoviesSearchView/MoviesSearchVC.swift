//
//  MoviesSearchVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 06.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import UIKit

class MoviesSearchVC: UIViewController ,Storyboarded{

    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collctionView: UICollectionView!
    
    weak var coordinator : MovieSearchCoordinator?

    private var moviewSearchViewModel = MovieSearchViewModel()
    
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
        navBarView.searchBttn.addTarget(self, action: #selector(self.findMov) , for: .touchUpInside)
        navBarView.searchBttn.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.001, execute: {
            self.loading()
            self.moviewSearchViewModel.searchMovies()
        })
       
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
    
        
         edgeInset = 20
         numberOfItemsInRow = 2
   
    
    let paddingSpace = edgeInset*(numberOfItemsInRow+1)
    let availableWidth = collectionView.frame.size.width-paddingSpace
    let widthPerItem = availableWidth/numberOfItemsInRow
   
    return CGSize(width: widthPerItem,height: 250)
  }



  func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {

          return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }


  func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
  }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

               return 20
    }
}
