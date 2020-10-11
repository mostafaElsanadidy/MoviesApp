//
//  NavBarView.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/10/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit

class NavBarView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

       @IBOutlet var view:UIView!
       @IBOutlet weak var notiLabelView: UIView!
       @IBOutlet weak var notiLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
   override func awakeFromNib() {
    
         super.awakeFromNib()
         setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){

        self.view = Bundle.init(for: NavBarView.self).loadNibNamed("\(NavBarView.self)", owner: self)![0] as? UIView
        
//        notiLabel.text = "9"
////        notiLabel.frame.size.width = 14
////        notiLabelView.frame.size.width = notiLabel.frame.size.width
////        let max_ = max(notiLabel.frame.size.height,notiLabel.frame.size.width)
////        print(max_)
//        notiLabel.frame.size.height = 20
//        notiLabel.frame.size.width = 20
        
        notiLabelView
            .layer.cornerRadius = 11
        
        view.frame = bounds
        view.frame.size.width = UIScreen.main.bounds.width

        self.addSubview(self.view)
    }
    
    
    @IBAction func showOrdersCarPage(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCarItems"), object: nil)
    }
    
    @IBAction func showSideMenu(_ sender: UIButton) {
            print("bghbghbhgbhgghb")
    //        if let enuBttn = sender as? SSMenuButton {
    //            enuBttn.sideMenuButtonTapped()
    //        }
           NotificationCenter.default.post(name: Notification.Name(rawValue: "OpenOrCloseSideMenu"), object: nil)
           //   SSSideMenuControls.openOrCloseSideMenu()
        }
    
    
    
}
