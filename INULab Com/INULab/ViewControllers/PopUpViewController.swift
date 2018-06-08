//
//  PopUpViewController.swift
//  INULab
//
//  Created by 이준상 on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation
import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var innerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.innerView.layer.cornerRadius = 3
        self.innerView.clipsToBounds = true
    }
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func openLink(_ sender: Any) {
        if let url = URL(string: "http://naver.me/5P5POMr9") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
