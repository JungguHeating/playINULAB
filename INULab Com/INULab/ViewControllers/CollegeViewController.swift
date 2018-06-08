//
//  CollegeViewController.swift
//  INULab
//
//  Created by 이준상 on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation
import UIKit

enum Type {
    case College
    case Major
}

class CollegeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collegeView: UIView!
    @IBOutlet weak var collegeNameLabel: UILabel!
    @IBOutlet weak var collegeEngNameLabel: UILabel!
    @IBOutlet weak var majorCollectionView: UICollectionView!
    @IBOutlet weak var collageImage: UIImageView!
    
    let majorName = ["컴퓨터공학과", "정보통신공학과", "임베디드시스템공학"]
    let majorEngName = ["Computer Science and Engineering", "Information and Telecommunication Engineering", "Embedded-Systems Engineering"]
    let labName = ["가상 현실", "데이터 베이스", "컴퓨터 비전", "모바일 컴퓨팅", "분산 시스템", "인터넷 소프트웨어", "멀티미디어 시스템", "앱센터", "엔터테인먼트", "무선 정보", "시스템 소프트웨어", "IMPRESS", "고성능 컴퓨팅", "데이터 인텔리젼트", "데이터 마이닝"]
    
    private var name: String?
    private var engName: String?
    private var type: Type?
    
    func setData(name: String, engName: String) {
        self.name = name
        self.engName = engName
    }
    
    func setType(type: Type) {
        self.type = type
    }
    
    override func viewDidLoad() {
        self.initializing()
        self.navigationItem.title = "홍보 게시판"
        self.navigationItem.backBarButtonItem?.title = " "
        self.collageImage.image = UIImage(named: "2018060883237")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let name = self.name { collegeNameLabel.text = name }
        if let engName = self.engName { collegeEngNameLabel.text = engName }
        self.collegeNameLabel.sizeToFit()
        self.collegeEngNameLabel.sizeToFit()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == .College { return majorName.count }
        else { return labName.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = majorCollectionView.dequeueReusableCell(withReuseIdentifier: "AdvertisingCollectionViewCell", for: indexPath) as! AdvertisingCollectionViewCell
        if type == .College {
        cell.collegeName.text = majorName[indexPath.row]
        cell.collegeType.text = majorEngName[indexPath.row]
        } else {
            cell.collegeName.text = labName[indexPath.row]
            cell.collegeType.text = "laboratory"
        }
        cell.collegeName.sizeToFit()
        cell.collegeType.sizeToFit()
        cell.collegeImageView.image = UIImage(named: "oval2Copy8")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if type == .College {
            let storyboard = UIStoryboard(name: "Advertising", bundle: nil)
            if let collegeVC = storyboard.instantiateViewController(withIdentifier: "collegeViewController") as? CollegeViewController {
                collegeVC.setData(name: self.majorName[indexPath.row], engName: self.majorEngName[indexPath.row])
                collegeVC.setType(type: .Major)
                self.navigationController?.pushViewController(collegeVC, animated: true)
            }
        } else {
            let storyboard = UIStoryboard(name: "Advertising", bundle: nil)
            if let collegeVC = storyboard.instantiateViewController(withIdentifier: "popUpViewController") as? PopUpViewController {
                collegeVC.modalPresentationStyle = .overFullScreen
                self.present(collegeVC, animated: true, completion: nil)
            }
        }
    }
}

extension CollegeViewController {
    func initializing() {
        self.collegeView.backgroundColor = UIColor.white
        self.collegeView.layer.cornerRadius = 2.0
        self.collegeView.layer.borderWidth = 1.0
        self.collegeView.layer.borderColor = UIColor.clear.cgColor
        self.collegeView.layer.masksToBounds = true
        self.collegeView.layer.shadowColor = UIColor.lightGray.cgColor
        self.collegeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.collegeView.layer.shadowRadius = 2.5
        self.collegeView.layer.shadowOpacity = 0.8
        self.collegeView.layer.masksToBounds = false
        self.collegeView.layer.shadowPath = UIBezierPath(roundedRect: self.collegeView.bounds, cornerRadius: self.collegeView.layer.cornerRadius).cgPath
        
        
        self.majorCollectionView.delegate = self
        self.majorCollectionView.dataSource = self
        self.majorCollectionView.register(UINib(nibName:"AdvertisingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdvertisingCollectionViewCell")
        
        self.navigationItem.title = ""
    }
    

    
}
