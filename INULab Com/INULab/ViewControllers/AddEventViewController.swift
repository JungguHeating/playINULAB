//
//  AddEventViewController.swift
//  INULab
//
//  Created by 동균 on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//
//ddddd

import UIKit

class AddEventViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var contentTextFiled: UITextField!
    
    @IBOutlet weak var dateTextFiled: UITextField!
    
    @IBOutlet weak var eventNameTextFiled: UITextField!
    @IBOutlet weak var timeTextFiled: UITextField!
    
    let datePickerView:UIDatePicker = UIDatePicker()
    let timePickerView:UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addButton.layer.cornerRadius = 57 * 0.5
        
        timePickerView.datePickerMode = UIDatePickerMode.time
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        timePickerView.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: .valueChanged)
        dateTextFiled.inputView = datePickerView
        timeTextFiled.inputView = timePickerView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let eventName = self.eventNameTextFiled.text
        let date = "\(self.dateTextFiled.text!)"
        print(date)
        let startTime = self.timeTextFiled.text
        let content = self.contentTextFiled.text
        let model = NetworkModel(self)
        model.postEventLabCal(labName: (self.appDelegate.myLab?.labId)!, eventName: eventName!, date: date, startTime: startTime!, content: content!)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            
            if month <= 9 && day <= 9{
                dateTextFiled.text = "\(year)-0\(month)-0\(day)"
            }else if month <= 9 && day >= 10{
                dateTextFiled.text = "\(year)-0\(month)-\(day)"
            }else if month >= 10 && day <= 9{
                dateTextFiled.text = "\(year)-\(month)-0\(day)"
            }else if month >= 10 && day >= 10{
                dateTextFiled.text = "\(year)-\(month)-\(day)"
            }
        }
    }
    
    @objc func timePickerValueChanged(sender:UIDatePicker) {
        
        let componenets = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
        if let hour = componenets.hour, let minute = componenets.minute {
            if hour <= 9 && minute >= 10 {
                timeTextFiled.text = "0\(hour):\(minute)"
            }else if hour >= 10 && minute <= 9{
                timeTextFiled.text = "\(hour):0\(minute)"
            }else if hour <= 9 && minute <= 9{
                timeTextFiled.text = "0\(hour):0\(minute)"
            }else if hour >= 10 && minute >= 10 {
                timeTextFiled.text = "\(hour):\(minute)"
            }
        }
    }
    
}


extension AddEventViewController: NetworkCallback {
    
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
                    print(obj)
                }
            }
            self.appDelegate.labCal = temp
            print(self.appDelegate.labCal)
        }
        if code == "ADD" {
            print("11")
            let model = NetworkModel(self)
            model.getLabCal(labName: (self.appDelegate.myLab?.labId)!)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    func networkFail(code: String) {
        print("error")
    }
    
    
}
