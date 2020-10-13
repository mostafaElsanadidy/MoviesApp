//
//  MovieReviewsVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

class MovieReviewsVC: UIViewController {

    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var tableView: UITableView!
    var movieReviews:[MovieReviews_VM] = []
    var movieID:Int!
    var movieName:String!
    var api_Key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        api_Key = Constants.ProductionServer.api_key
        tableView.dataSource = self
        tableView.delegate = self
        getMovieReviews(movieID: movieID)
        navBarView.backBttn.isHidden = false
        navBarView.backBttn.addTarget(self, action: Selector(("popVCFromNav")) , for: .touchUpInside)
        navBarView.titleLabel.isHidden = false
        navBarView.titleLabel.text = movieName!+" Reviews"
        // Do any additional setup after loading the view.
    }
    
    func getMovieReviews(movieID:Int){
                      self.loading()
            APIClient.getMovieReviews(movieID: movieID,
                                      api_key: api_Key,
                                      completionHandler: { [weak self]
                           movieReviews in
                           guard let strongSelf = self else{
                               return
                           }
                           
                        guard let movieReviews = movieReviews else{
                         strongSelf.killLoading()
                            return
                        }
                        DispatchQueue.main.async{
                            strongSelf.killLoading()
        //                    print(movies_Data)
                            for movieReview in movieReviews{
                                strongSelf.movieReviews.append( MovieReviews_VM.init(movieReviews_M: movieReview))
                            }
                            strongSelf.tableView.reloadData()
                                }
                       }, completionFaliure: {
                           error in
                           self.killLoading()
                           print(error!.localizedDescription)
                           self.showAlert(title: "ERROR!", message:
                           NSLocalizedString(error!.localizedDescription, comment: "this is my mssag"))
                       })
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

extension MovieReviewsVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieReviewCell", for: indexPath)
        if let cell = cell as? MovieReviewCell{
            cell.reviewAuthor.text = movieReviews[indexPath.row].author!
            cell.reviewContent.text = movieReviews[indexPath.row].content!
            cell.reviewUrlBttn.setTitle(movieReviews[indexPath.row].url!, for: .normal)
            cell.numOfReviewLabel.text = "\(indexPath.row+1)"
            cell.goToReviewHtmlPage = { urlStr in
                self.goToReviewHtmlPage(with: urlStr)
            }
        }
        return cell
    }
    
    func goToReviewHtmlPage(with urlStr:String){
        
        if let reviewHtmlPage = storyboard?.instantiateViewController(identifier: "ReviewHtmlPageVC") as? ReviewHtmlPageVC{
            reviewHtmlPage.contentUrlStr = urlStr
            pushViewController(VC: reviewHtmlPage)
        }
    }
}

extension MovieReviewsVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
