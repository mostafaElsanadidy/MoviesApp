//
//  MainDiscoveryVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/10/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class MainDiscoveryVC: UIViewController,Storyboarded{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarView: NavBarView!
    
     var coordinator : MainCoordinator?
    var cellIdentifiers:[String] = []
    var indxOf_ShowAllCells:[Int] = []
    var indxOf_MovImagCells:[Int] = []
    
    var movieMainViewModel = MovieList_VM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupBinder()
        for ind in 0 ..< 4{
            cellIdentifiers.append("showAllCell")
            indxOf_ShowAllCells.append(ind)
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        
        self.loading()
        movieMainViewModel.getTop_RatedMovies()
        movieMainViewModel.getPopularMovies()
        movieMainViewModel.getUpComingMovies()
        movieMainViewModel.getNowPlayingMovies()
        
        navBarView.titleLabel.text = "THE MOVIES"
        navBarView.backBttn.isHidden = true
        navBarView.personBttn.isHidden = false
        navBarView.searchBttn.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
                 super.viewWillAppear(animated)
                 
                 navigationController?.setNavigationBarHidden(true, animated: animated)
           
             }
    
    func setupBinder(){
        
        movieMainViewModel.topRatedMovies.bind{
            [weak self] movies in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async{
                strongSelf.killLoading()
                strongSelf.tableView.reloadData()
                    }
        }
        
        movieMainViewModel.error.bind{
            [weak self] error in
            guard let strongSelf = self,
                  let error = error else {return}
            strongSelf.killLoading()
            strongSelf.showAlert(title: "ERROR!", message:
                                    NSLocalizedString(error, comment: "this is my mssag"))
        }
        
        movieMainViewModel.popularMovies.bind{
            [weak self] movies in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                strongSelf.killLoading()
                strongSelf.tableView.reloadData()
                    }
        }
        
        movieMainViewModel.comingSoonMovies.bind{
            [weak self] movies in
            guard let strongSelf = self else {return}
        DispatchQueue.main.async{
            strongSelf.killLoading()
            strongSelf.tableView.reloadData()
        }}
        
        movieMainViewModel.NowPlayingMoviea.bind{
            [weak self] movies in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async{
                strongSelf.killLoading()
                strongSelf.tableView.reloadData()
                    }
        }
        
        movieMainViewModel.selectedMovies.bind{
            [weak self] movies in
            guard let strongSelf = self
                    ,!movies.isEmpty else {return}
            DispatchQueue.main.async{
                strongSelf.coordinator?.childShowMoreMovies(with: movies ?? [])
            }
        }
    }

    
}

extension MainDiscoveryVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIdentifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath)
        
    if let cell = cell as? showAllCell{
        var idntifr = ""
        var idntifr2 = ""
        let offset = indxOf_ShowAllCells.enumerated().filter{$0.element == indexPath.row}.map{$0.offset}[0]
//        CatMovsCell
        
        switch offset {
        case 0:
            idntifr = "Top Rated"
            idntifr2 = "Movies"
        case 1:
            idntifr = "Popular"
            idntifr2 = "Movies"
        case 2:
            idntifr = "Coming"
            idntifr2 = "Soon"
        default:
            idntifr = "Now"
            idntifr2 = "Playing"
        }
        
            cell.label1.text = idntifr
            cell.label2.text = idntifr2
        
        var movis:[Movie_VM] = []
        
        cell.goToMovsPages = {
            str in
            
            switch str {
            case "Top Rated":
                movis = self.movieMainViewModel.topRatedMovies.value
            case "Popular":
                movis = self.movieMainViewModel.popularMovies.value
            case "Coming":
                movis = self.movieMainViewModel.comingSoonMovies.value
            default:
                movis = self.movieMainViewModel.NowPlayingMoviea.value
            }
            self.movieMainViewModel.selectedMovies.value = movis
        }
        }
        
        if let cell = cell as? CatMovsCell {
            let offset = indxOf_ShowAllCells.enumerated().filter{$0.element == indexPath.row-1}.map{$0.offset}[0]
            cell.collctionView.tag = offset
            print(cell.collctionView.tag)
            cell.collctionView.dataSource = self
            cell.collctionView.delegate = self
            cell.collctionView.reloadData()
        }
        return cell
    }
    
}

extension MainDiscoveryVC:UITableViewDelegate{
    
    func tableView(_tableView: UITableView,indentationLevelForRowAt indexPath: IndexPath)-> Int{
            
                let newIndexPath = IndexPath(row: 0, section: 0)
                return tableView(_tableView: tableView,indentationLevelForRowAt: newIndexPath)
            }
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return UITableView.automaticDimension
       
        }

         func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           
                return UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let identifier = tableView.cellForRow(at: indexPath)?.reuseIdentifier
                               if identifier == "showAllCell"{
                                   let nextIndx = IndexPath.init(row: indexPath.row+1, section: 0)
                                   if (tableView.cellForRow(at: nextIndx)?.reuseIdentifier) != "CatMovsCell"{
                                       self.showListOfAddress(indxPath: indexPath, insertedRowsCount: 1)
                               }else{
                                       self.hideListOfAddress(indxPath: indexPath)
                                   }
                               }
    }
    
}

extension MainDiscoveryVC{
    
func showListOfAddress(indxPath:IndexPath,insertedRowsCount:Int){
        
        var indexPathInsertedRows:[IndexPath] = []
        
        for i in 1...insertedRowsCount{
            
            indexPathInsertedRows.append(IndexPath(row: indxPath.row+i, section: indxPath.section))
            let identifier = "CatMovsCell"
                  let count = cellIdentifiers.count
                  if count > indxPath.row+i{
                  //  print(indxPath.row+i)
                    print(identifier)
                    
                      cellIdentifiers.insert(identifier, at: indxPath.row+i)
                  }else{
                      for ind in count...indxPath.row+i{
                          if ind == indxPath.row+i{
                              cellIdentifiers.append(identifier)
                          }else{
                              cellIdentifiers.append("showAllCell")
                          }
                      }
                  }
             }
    
            indxOf_ShowAllCells = cellIdentifiers.enumerated().filter{$0.element == "showAllCell"}.map{$0.offset}
            indxOf_MovImagCells = cellIdentifiers.enumerated().filter{$0.element == "CatMovsCell"}.map{$0.offset}

        
            tableView.beginUpdates()
            tableView.insertRows(at: indexPathInsertedRows, with: .fade)
            tableView.reloadRows(at: [indxPath], with: .none)
            tableView.endUpdates()
        
          }

 func hideListOfAddress(indxPath:IndexPath){

        var indexPathDeleteRows:[IndexPath] = []
        
            let indx = IndexPath(row: indxPath.row+1, section: indxPath.section)
            indexPathDeleteRows.append(indx)

        
        for indx in (indexPathDeleteRows).reversed(){
              
                    self.cellIdentifiers.remove(at: indx.row)
               }
        
    indxOf_ShowAllCells = cellIdentifiers.enumerated().filter{$0.element == "showAllCell"}.map{$0.offset}
    indxOf_MovImagCells = cellIdentifiers.enumerated().filter{$0.element == "CatMovsCell"}.map{$0.offset}
    
            tableView.beginUpdates()
            tableView.reloadRows(at: [indxPath], with: .none)
            tableView.deleteRows(at: indexPathDeleteRows, with: .fade)
            tableView.endUpdates()
    }
}

extension MainDiscoveryVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(collectionView.tag)
        
       var movies = [Movie_VM]()
        
        switch collectionView.tag {
        case 0:
            movies = movieMainViewModel.topRatedMovies.value
        case 1:
            movies = movieMainViewModel.popularMovies.value
        case 2:
            movies = movieMainViewModel.comingSoonMovies.value
        default:
            movies = movieMainViewModel.NowPlayingMoviea.value
        }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movImageCell", for: indexPath)
        
        var movies = [Movie_VM]()
        
        switch collectionView.tag {
        case 0:
            movies = movieMainViewModel.topRatedMovies.value
        case 1:
            movies = movieMainViewModel.popularMovies.value
        case 2:
            movies = movieMainViewModel.comingSoonMovies.value
        default:
            movies = movieMainViewModel.NowPlayingMoviea.value
        }
        
        if let cell = cell as? movImageCell{
            cell.movImage.DownloadImage(withUrl: movies[indexPath.row].moviePosterUrlStr!)
            cell.updateSelectedCell_ID = {
                selectedID in
                self.coordinator?.childShowMovieDetails(with: selectedID)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var movies = [Movie_VM]()
        
        switch collectionView.tag {
        case 0:
            movies = movieMainViewModel.topRatedMovies.value
        case 1:
            movies = movieMainViewModel.popularMovies.value
        case 2:
            movies = movieMainViewModel.comingSoonMovies.value
        default:
            movies = movieMainViewModel.NowPlayingMoviea.value
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? movImageCell{
            cell.updateSelectedCell_ID(movies[indexPath.row].id!)
        }
    }
    
}

extension MainDiscoveryVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 125 , height: 180)

  }



  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    
          return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
  }


  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
  }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
               return 5
    }
}
