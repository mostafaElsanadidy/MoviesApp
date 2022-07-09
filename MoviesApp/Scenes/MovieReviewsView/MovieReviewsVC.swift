//
//  MovieReviewsVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

class MovieReviewsVC: UIViewController, Storyboarded {

    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var tableView: UITableView!
    private var movieReviewsViewModel = MovieReviewsList_VM()
    
    weak var coordinator : MovieReviewsCoordinator?
   func initialState(viewModel:MovieReviewsList_VM) {
       self.movieReviewsViewModel = viewModel
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBinder()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func setupBinder() {
        
        movieReviewsViewModel.error.bind{
            [weak self] error in
            guard let strongSelf = self, let error = error else {return}
                                     strongSelf.killLoading()
                                     print(error)
                                     strongSelf.showAlert(title: "ERROR!", message:
                                     NSLocalizedString(error, comment: "this is my mssag"))
        }
        
        movieReviewsViewModel.movieReviews.bind{
            [weak self] reviews in
            
            guard let strongSelf = self else {return}
                    DispatchQueue.main.async{
                        strongSelf.killLoading()
    //                    print(movies_Data)
                        strongSelf.tableView.reloadData()
                            }
        }
        
        movieReviewsViewModel.movieName.bind{
            [weak self] movieName in
            guard let strongSelf = self, let movieName = movieName else {return}
            guard let navBarView = strongSelf.navBarView else{return}
            navBarView.backBttn.isHidden = false
            navBarView.backBttn.addTarget(self, action: Selector(("popVCFromNav")) , for: .touchUpInside)
            navBarView.titleLabel.isHidden = false
            navBarView.titleLabel.text = movieName + " Reviews"
        }
        
        movieReviewsViewModel.movieID.bind{
            
            [weak self] movieID in
            guard let strongSelf = self, movieID != nil else {return}
            strongSelf.loading()
    //        movieReviewsViewModel.updateMovieInfo(movieName: <#String#>, movieID: <#Int#>)
            strongSelf.movieReviewsViewModel.getMovieReviews()
        }
    }

}

extension MovieReviewsVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieReviewsViewModel.movieReviews.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieReviewCell", for: indexPath)
        if let cell = cell as? MovieReviewCell{
            let movieReview = movieReviewsViewModel.movieReviews.value[indexPath.row]
            cell.reviewAuthor.text = movieReview.author!
            cell.reviewContent.text = movieReview.content!
            cell.reviewUrlBttn.setTitle(movieReview.url!, for: .normal)
            cell.numOfReviewLabel.text = "\(indexPath.row+1)"
            cell.goToReviewHtmlPage = { urlStr in
                self.goToReviewHtmlPage(with: urlStr)
            }
        }
        return cell
    }
    
    func goToReviewHtmlPage(with urlStr:String){
        
        self.coordinator?.childShowReviewHtmlPage(with: urlStr)
    }
}

extension MovieReviewsVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
