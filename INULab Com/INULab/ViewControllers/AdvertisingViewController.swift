
//
//  AdvertisingViewController.swift
//  INULab
//
//  Created by 이준상 on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation
import UIKit

class AdvertisingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var advertisingCollectionView: UICollectionView!
    
    @IBOutlet weak var titleNav: UINavigationItem!
    let collegeName: [String] = ["정보기술대학", "인문대학", "자연과학대학", "사회과학대학", "글로벌법정경대학", "공과대학", "경영대학", "동북아국제통상학부", "예술체육대학", "사범대학", "도시과학대학", "생명과학기술대학"]
    
    let images: [UIImage] = [#imageLiteral(resourceName: "infor"), #imageLiteral(resourceName: "inmun"), #imageLiteral(resourceName: "jagua"), #imageLiteral(resourceName: "safe"), #imageLiteral(resourceName: "yesul"), #imageLiteral(resourceName: "dosi")]
    
    let collegeType: [String] = ["Information Technology", "Humanities", "Natural Science", "Social Science", "College of Law, Politics \n& Public Affairs", "Engineering", "Business Administration", "School of Northeast \nAsian Studies", "Arts & Physical \nEducation", "College of Education", "Urban Science", "Life Science & \nBioengineering"]
    
    
    override func viewDidLoad() {
        self.initializing()
        self.navigationItem.backBarButtonItem?.title = "  "
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collegeName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = advertisingCollectionView.dequeueReusableCell(withReuseIdentifier: "AdvertisingCollectionViewCell", for: indexPath) as! AdvertisingCollectionViewCell
        cell.collegeName.text = self.collegeName[indexPath.row]
        cell.collegeType.text = self.collegeType[indexPath.row]
        if indexPath.row < 6 {
            cell.collegeImageView.image = images[indexPath.row]
        }
        else {
            cell.collegeImageView.image = #imageLiteral(resourceName: "oval2Copy8")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Advertising", bundle: nil)
        if let collegeVC = storyboard.instantiateViewController(withIdentifier: "collegeViewController") as? CollegeViewController {
            collegeVC.setData(name: self.collegeName[indexPath.row], engName: self.collegeType[indexPath.row])
            collegeVC.setType(type: .College)
            self.navigationController?.pushViewController(collegeVC, animated: true)
            
        }
        
    }
    
}

extension AdvertisingViewController {
    func initializing() {
        //topView initializing
        //        topView.layer.shadowColor = UIColor.init(red: 129/255, green: 132/255, blue: 243/255, alpha: 1.0).cgColor
        //        topView.layer.shadowOffset = CGSize.zero
        //        topView.layer.shadowRadius = 15
        //        topView.layer.shadowOpacity = 0.7
        //
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.init(red: 129/255, green: 132/255, blue: 243/255, alpha: 1.0).cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.7
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
        self.navigationController?.navigationBar.layer.shadowRadius = 15
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        
        self.advertisingCollectionView.dataSource = self
        self.advertisingCollectionView.delegate = self
        self.advertisingCollectionView.register(UINib(nibName:"AdvertisingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdvertisingCollectionViewCell")
        
    }
}
