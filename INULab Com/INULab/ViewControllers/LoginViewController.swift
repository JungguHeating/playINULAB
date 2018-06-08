//
//  LoginViewController.swift
//  INULab
//
//  Created by Cho on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    @IBOutlet weak var labLoginButton: UIButton!
    @IBOutlet weak var guestLoginButton: UIButton!
    
    private let labIds = ["marvel", "cv", "ECL"]
    private let passwd = "00"
    
    var myLabId = ""
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewInit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.idTextField.text = ""
        self.passwdTextField.text = ""
    }
    
    @IBAction func labLoginClicked(_ sender: Any) {
        self.appDelegate.isGuest = false
        for id in labIds {
            if id == idTextField.text && passwd == passwdTextField.text {
                myLabId = id
                self.view.makeToast("로그인 중...", duration: 2, position: .bottom)
                let model = NetworkModel(self)
                model.getLabInfo()
                print(self.myLabId)
                model.getLabCal(labName: self.myLabId)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar")
                let time = DispatchTime.now() + .seconds(2)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func guestLoginClicked(_ sender: Any) {
        self.appDelegate.isGuest = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar")
        let timeOne = DispatchTime.now() + .seconds(2)
        self.view.makeToast("로그인 중...", duration: 2, position: .bottom)
        DispatchQueue.main.asyncAfter(deadline: timeOne) {
            self.present(vc!, animated: true, completion: nil)
        }
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

//Network
extension LoginViewController: NetworkCallback {
    func networkSuc(resultdata: Any, code: String, tag: Int) {
        if code == "LAB" {
            var temp: [LabCalendar] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let labName = item["labName"] as? String ?? ""
                    let eventName = item["eventName"] as? String ?? ""
                    let stdate = item["date"] as? String ?? ""
                    let startTime = item["startTime"] as? String ?? ""
                    let content = item["content"] as? String ?? ""
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from: stdate)
                    
                    let obj = LabCalendar.init(labName: labName, eventName: eventName, date: date!, startTime: startTime, content: content)
                    //                    num += 1
                    temp.append(obj)
                }
            }
            self.appDelegate.labCal = temp
            print(self.appDelegate.labCal)
        }
        if code == "INFO" {
            
            var temp: [LabInfo] = []
            
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let labId = item["labId"] as? String ?? ""
                    let labName = item["labName"] as? String ?? ""
                    let depName = item["depName"] as? String ?? ""
                    let professorName = item["professorName"] as? String ?? ""
                    let studentNames = item["studentName"] as? String ?? ""
                    let location = item["location"] as? String ?? ""
                    let call = item["call"] as? String ?? ""
                    let isRecruiting = item["isRecruiting"] as? Bool ?? false
                    
                    let obj = LabInfo.init(labId: labId, labName: labName, depName: depName, professorName: professorName, studentNames: studentNames, location: location, call: call, isRecruiting: isRecruiting)
                    temp.append(obj)
                }
            }
            self.appDelegate.labInfos = temp
            print(self.appDelegate.labInfos)
            findMyLab()
        }
    }
    
    func networkFail(code: String) {
        print("error")
    }
    
    
}

//Functions
extension LoginViewController {
    func viewInit() {
        self.labLoginButton.layer.cornerRadius = 57 * 0.5
        self.guestLoginButton.layer.cornerRadius = 57 * 0.5
    }
    
    func findMyLab() {
        for item in self.appDelegate.labInfos {
            if myLabId == item.labId {
                self.appDelegate.myLab = item
            }
        }
    }
}
