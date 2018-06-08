//
//  ProfileViewController.swift
//  INULab
//
//  Created by Cho on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var depName: UILabel!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var labInfoView: UIView!
    @IBOutlet weak var nothingView: UIView!
    @IBOutlet weak var firstDate: UILabel!
    @IBOutlet weak var secondDate: UILabel!
    @IBOutlet weak var thirdDate: UILabel!
    @IBOutlet weak var firstContent: UILabel!
    @IBOutlet weak var secondContent: UILabel!
    @IBOutlet weak var thirdContent: UILabel!
    @IBOutlet weak var professorName: UILabel!
    @IBOutlet weak var studentNames: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var call: UILabel!
    @IBOutlet weak var recruitSwitch: UISwitch!
    @IBOutlet weak var guestView: UIView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var calcedCal: [LabCalendar] = []

    var myLab: LabInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.appDelegate.isGuest {
            
        }
        else {
            myLab = self.appDelegate.myLab
        }
        viewInit()
        calcCal()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "로그아웃 하시겠습니까?",message: " ", preferredStyle: UIAlertControllerStyle.alert)
        
        //UIAlertActionStye.destructive 지정 글꼴 색상 변경
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
            self.appDelegate.labInfos.removeAll()
            self.appDelegate.myLab = nil
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        self.present(alertController,animated: true,completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//Functions
extension ProfileViewController {
    func viewInit() {
        titleImage.image = UIImage(named: "profile")
        titleImage.layer.cornerRadius = titleImage.frame.height / 2
        titleImage.clipsToBounds = true
        if self.appDelegate.isGuest {
            self.dayView.isHidden = true
            self.labInfoView.isHidden = true
            self.guestView.isHidden = false
            self.guestView.layer.cornerRadius = 5
            self.guestView.clipsToBounds = true
            self.guestView.layer.borderColor = UIColor.lightGray.cgColor
            self.guestView.layer.borderWidth = 0.3
            self.labName.text = "Guest"
            self.depName.text = ""
        }
        else {
            self.dayView.isHidden = false
            self.labInfoView.isHidden = false
            self.guestView.isHidden = true
            
            self.dayView.layer.cornerRadius = 5
            self.dayView.clipsToBounds = true
            self.labInfoView.layer.cornerRadius = 5
            self.labInfoView.clipsToBounds = true
            
            self.dayView.layer.borderColor = UIColor.lightGray.cgColor
            self.dayView.layer.borderWidth = 0.3
            self.labInfoView.layer.borderColor = UIColor.lightGray.cgColor
            self.labInfoView.layer.borderWidth = 0.3
            
            self.labName.text = self.myLab?.labName
            self.depName.text = self.myLab?.depName
            self.professorName.text = self.myLab?.professorName
            self.studentNames.text = self.myLab?.studentNames
            self.location.text = self.myLab?.location
            self.call.text = self.myLab?.call
            
            //self.recruitSwitch.setOn((myLab?.isRecruiting)!, animated: true)
            //self.recruitSwitch.isOn = (self.myLab?.isRecruiting)!
        }
    }
    
    func calcCal() {
        if self.appDelegate.labCal.count == 0 {
            
        }
        else {
            var count = 0
            var min: Double = 300000
            for item in self.appDelegate.labCal {
                if Date().timeIntervalSince(item.date!) < min && count < 4{
                    min = Date().timeIntervalSince(item.date!)
                    calcedCal.append(item)
                    count += 1
                }
            }
            if calcedCal.count < 4 {
                
            }
        }
    }
}
