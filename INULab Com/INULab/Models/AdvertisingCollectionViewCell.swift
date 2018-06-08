//
//  AdvertisingCollectionViewCell.swift
//  INULab
//
//  Created by 이준상 on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation
import UIKit

class AdvertisingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collegeImageView: UIImageView!
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var collegeType: UILabel!
    
    override func awakeFromNib() {
        //cell cornering and shadowing
        self.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
