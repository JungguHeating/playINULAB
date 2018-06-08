//
//  CalendarViewController.swift
//  INU_Lab
//
//  Created by 동균 on 2018. 6. 7..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var schDate:[SchCalendar] = [] {
        didSet {
            if self.calendarTable != nil {
                self.calendarTable.reloadData()
            }
        }
    }
    var labDate:[LabCalendar] = []{
        didSet{
            if self.calendarTable != nil{
                self.calendarTable.reloadData()
            }
        }
    }
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarTable: UITableView!
    
    @IBOutlet weak var addEventButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.clipsToBounds = true
        self.calendar.appearance.eventDefaultColor = UIColor(red: 147/255.0, green: 154/255.0, blue: 246/255, alpha: 1.0)
        calendarTable.tableFooterView = UIView()
        
        schDate.removeAll()
        labDate.removeAll()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        for item in self.appDelegate.schCal {
            let itemDate = formatter.string(from: item.date!)
            let calDate = formatter.string(from: Date())
            if itemDate == calDate {
                schDate.append(item)
            }
        }
        for item in self.appDelegate.labCal {
            let itemDate = formatter.string(from: item.date!)
            let calDate = formatter.string(from: Date())
            if itemDate == calDate {
                labDate.append(item)
            }
        }
        self.calendarTable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        if calendar.selectedDate == nil {
        //            self.calendar.select(Date())
        //        }
        schDate.removeAll()
        labDate.removeAll()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        for item in self.appDelegate.schCal {
            let itemDate = formatter.string(from: item.date!)
            let calDate = formatter.string(from: Date())
            if itemDate == calDate {
                schDate.append(item)
            }
        }
        for item in self.appDelegate.labCal {
            let itemDate = formatter.string(from: item.date!)
            let calDate = formatter.string(from: Date())
            if itemDate == calDate {
                labDate.append(item)
            }
        }
        self.calendarTable.reloadData()
    }
    
    
    
    
    @IBAction func addEventButtonClicked(_ sender: Any) {
        if self.appDelegate.isGuest == false{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addEvent") as? AddEventViewController
            self.navigationController?.show(vc!, sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.schDate.count
        case 1:
            return self.labDate.count
            
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell") as! CalendarTableViewCell
        switch indexPath.section {
        case 0:
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            cell.labNameLabel.text = schDate[indexPath.row].schName
            cell.titleLabel.text = schDate[indexPath.row].eventName
            cell.timelabel.text = schDate[indexPath.row].startTime
            cell.contentLabel.text = schDate[indexPath.row].content
            return cell
        case 1:
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            cell.labNameLabel.text = labDate[indexPath.row].labName
            cell.titleLabel.text = labDate[indexPath.row].eventName
            cell.timelabel.text = labDate[indexPath.row].startTime
            cell.contentLabel.text = labDate[indexPath.row].content
            return cell
        default:
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return false
        case 1:
            return true
        default:
            return false
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //        switch indexPath.section {
        //        case 0:
        //            return nil
        //        case 1:
        //
        //        default:
        //            return nil
        //        }
        
        let favorite = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            print("favorite button tapped")
            let eventName = self.labDate[indexPath.row].eventName
            let model = NetworkModel(self)
            print(self.labDate[indexPath.row].content!)
            model.postDeleteLabCal(eventName: eventName!)
            
            
        }
        favorite.backgroundColor = UIColor(red: 255/255.0, green: 89/255.0, blue: 89/255.0, alpha: 1.0)
        
        return [favorite]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
    
}
// 화면에 일정 있을때 점 하나만 뜨게 하기
extension CalendarViewController: FSCalendarDelegate,FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        self.schDate.removeAll()
        self.labDate.removeAll()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for item in self.appDelegate.schCal {
            let itemDate = formatter.string(from: item.date!)
            let calDate = formatter.string(from: date)
            if itemDate == calDate {
                schDate.append(item)
            }
        }
        for item in self.appDelegate.labCal {
            let itemDate = formatter.string(from: item.date!)
            let calDate = formatter.string(from: date)
            if itemDate == calDate {
                labDate.append(item)
            }
        }
        if schDate.count == 0 && labDate.count == 0 {
            return 0
        }else{
            return 1
        }
    }
    //날짜를 누를 때 테이블 뷰 연동하기
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        self.schDate.removeAll()
        self.labDate.removeAll()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for item in self.appDelegate.schCal {
            let itemDate = formatter.string(from: item.date!)
            let calDate = formatter.string(from: date)
            if itemDate == calDate {
                schDate.append(item)
            }
        }
        for item in self.appDelegate.labCal {
            let itemDate = formatter.string(from: item.date!)
            let calDate = formatter.string(from: date)
            if itemDate == calDate {
                labDate.append(item)
            }
        }
        DispatchQueue.main.async {
            self.calendarTable.reloadData()
        }
    }
    
}


extension CalendarViewController: NetworkCallback {
    
    func networkSuc(resultdata: Any, code: String, tag: Int) {
        if code == "LAB" {
            var temp: [LabCalendar] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let labName = item["labName"] as? String ?? ""
                    let eventNum = item["eventNum"] as? String ?? ""
                    let stdate = item["date"] as? String ?? ""
                    let startTime = item["startTime"] as? String ?? ""
                    let content = item["content"] as? String ?? ""
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from: stdate)
                    
                    let obj = LabCalendar.init(labName: labName, eventName: eventNum, date: date!, startTime: startTime, content: content)
                    //                    num += 1
                    temp.append(obj)
                    print(obj)
                }
            }
            self.appDelegate.labCal = temp
            print(self.appDelegate.labCal)
        }
        if code == "DELETE" {
            print("11")
            let model = NetworkModel(self)
            model.getLabCal(labName: "marvel")
            
            self.calendarTable.reloadData()
        }
    }
    func networkFail(code: String) {
        print("error")
    }
    
    
}

