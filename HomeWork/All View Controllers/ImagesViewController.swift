//
//  ImagesViewController.swift
//  HomeWork
//
//  Created by Mehedi on 2/24/20.
//  Copyright © 2020 MatrixSolution. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, UITabBarDelegate{
    
   // let imageDictionaryPath = Bundle.main.path(forResource: "ImagesData", ofType: "plist")
   // let allImages =
    override func viewDidLoad() {
        print("1")
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = .white
        self.tabBarController?.tabBar.barTintColor = .red
        self.title = "Photo Gallery"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.21, green: 0.70, blue: 0.75, alpha: 1)
    }
    
    @IBAction func clickedOnButton(_ sender: UIButton) {
       let vc = storyboard?.instantiateViewController(withIdentifier: "ShowImageAndVideoViewController") as! ShowImageAndVideoViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

