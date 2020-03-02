//
//  VideoViewController.swift
//  HomeWork
//
//  Created by Mehedi on 2/24/20.
//  Copyright © 2020 MatrixSolution. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Video Gallery"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.21, green: 0.70, blue: 0.75, alpha: 1)
    }

    @IBAction func clickedOnButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShowImageAndVideoViewController") as! ShowImageAndVideoViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
