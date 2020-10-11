//
//  MainDiscoveryVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/10/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

class MainDiscoveryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarView: NavBarView!
    
     var cellIdentifiers:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for ind in 0 ..< 4{
            cellIdentifiers.append("showAllCell")
        }
        tableView.dataSource = self
        tableView.delegate = self
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

extension MainDiscoveryVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIdentifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath)
        var idntifr = ""
        var idntifr2 = ""
        
        switch indexPath.row {
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
        if let cell = cell as? showAllCell{
            cell.label1.text = idntifr
            cell.label2.text = idntifr2
            cell.cellID = indexPath.row
            cell.updateSelectedCell_ID = {selected_ID in
            //                mapVieControllr.seletedRestaurantIndex = selected_ID

                            if identifier == "showAllCell"{
                                let nextIndx = IndexPath.init(row: selected_ID+1, section: indxxo.section)
                //                indexOfLastCell = dropDownIndex.firstIndex(of: indxxo.row)!
                                if (tableView.cellForRow(at: nextIndx)?.reuseIdentifier) != "CatMovsCell"{
                                showListOfAddress(indxPath: indxxo, insertedRowsCount: 1)
                            }else{
                                hideListOfAddress(indxPath: indxxo)
                                }
                            }
                
                        }
        }
        
    }
    
}

extension MainDiscoveryVC:UITableViewDelegate{
    
    
}

extension MainDiscoveryVC{
    
func showListOfAddress(indxPath:IndexPath,insertedRowsCount:Int){
        
        var indexPathInsertedRows:[IndexPath] = []
        
        for i in 1...insertedRowsCount{
            
            indexPathInsertedRows.append(IndexPath(row: indxPath.row+i, section: indxPath.section))
            let identifier = "NewInformationCell"
                  let count = cellIdentifiers.count
                  if count > indxPath.row+i{
                  //  print(indxPath.row+i)
                    print(identifier)
                    print("hoda")
                      cellIdentifiers.insert(identifier, at: indxPath.row+i)
                  }else{
                      for ind in count...indxPath.row+i{
                          if ind == indxPath.row+i{
                              cellIdentifiers.append(identifier)
                          }else{
                              cellIdentifiers.append("YourInformationCell")
                          }
                      }
                  }
             }
        
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
        
            tableView.beginUpdates()
            tableView.reloadRows(at: [indxPath], with: .none)
            tableView.deleteRows(at: indexPathDeleteRows, with: .fade)
            tableView.endUpdates()
    }
}
